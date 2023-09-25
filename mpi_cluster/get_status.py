import sys, os, shutil
from pathlib import Path
import yaml, json
import subprocess
import pickle
from datetime import datetime
from tabulate import tabulate
from collections import OrderedDict

from omnibelt import load_json, load_tsv, recover_date, save_json, load_yaml, save_yaml

import omnifig as fig

from . import misc
from .status import collect_q_cmd



def process_tsv(path, cols=None, include_event=None):
	if not path.exists():
		print(f'WARNING: could not find {name}: {path}')
		return {}
	
	data = load_tsv(path)
	
	if not len(data[-1]) or (len(data[-1]) == 1 and not len(data[-1][0])):
		data.pop()
	
	if cols is None:
		return data
	
	dkey = None
	
	full = []
	for row in data:
		info = {}
		for col, raw in zip(cols, row):
			
			if 'date' in col:
				info['date'] = recover_date(raw)
				if dkey is None:
					dkey = col
			elif col == 'ID':
				info['ID'] = raw.split('#')[-1] if '#' in raw and 'sched' in raw else raw
			elif col == 'code':
				try:
					info['code'] = int(raw)
				except TypeError:
					print(f'failed to parse: {raw}')
					info['code'] = raw
			else:
				info[col] = raw
			
		if include_event is not None:
			info['event'] = include_event
			
		full.append(info)
		
	if 'ID' not in cols:
		return full
	
	jobs = {}
	
	for info in full:
		ID = info.get('ID', 'failed')
		if ID not in jobs:
			jobs[ID] = []
		jobs[ID].append(info)
	
	if dkey is not None:
		
		for ID, seq in jobs.items():
			jobs[ID] = sorted(seq, key=lambda x: x[dkey])
	
	return jobs



class Failed_Exception(Exception):
	pass



def compute_durations(info, sig1='start', sig2='end', now=None):
	if 'events' not in info:
		return

	submit = info.get('submit', None)
	events = info['events']
	
	wait = None
	wall = None
	
	last = None
	key = 'wait'
	for e in events:
		etype = e.get('event', None)
		date = e.get('date', None)
		if date is None:
			continue
		if key == 'wait' and etype == sig1:
			if wait is None and submit is not None:
				wait = date - submit
			elif wait is not None and last is not None:
				wait += date - last
			else:
				pass
			key = 'wall'
			last = date
		elif key == 'wall' and etype == sig2:
			if last is not None:
				wall = date - last if wall is None else wall + (date - last)
			# else:
			# 	raise Failed_Exception
			key = 'wait'
			last = date
		# else:
		# 	Failed_Exception
	
	if now is not None and key == 'wall' and last is not None:
		wall = now - last if wall is None else wall + (now - last)
	
	if wait is not None:
		info['wait'] = wait.total_seconds() / 3600
	if wall is not None:
		info['duration'] = wall.total_seconds() / 3600


def sort_jobkeys(cfg, jobs):
	
	sort_by = cfg.pull('sort-by', None)
	
	keys = list(jobs.keys())
	
	if sort_by is None:
		return keys
		
	if not isinstance(sort_by, (list, tuple)):
		sort_by = sort_by,
	
	return sorted(keys, key=lambda k: tuple(jobs[k].get(s, None) for s in sort_by))



@fig.script('status', description='check the status of jobs submitted to the cluster')
def get_status(cfg: fig.Configuration):
	silent = cfg.pull('silent', False, silent=True)
	cfg.silent = silent
	print_status = cfg.pull('print-status', True, silent=True)
	
	user = cfg.pull('user', 'fleeb') # maybe remove me as default
	
	cols = cfg.pull('columns', None)
	if cols is None:
		cols = ['status', 'name', 'ID', 'host', 'start', 'duration', 'wait', 'end', 'run']
	
	pkl_name = cfg.pull('pickle-status', None)
	
	active_only = cfg.pull('only-active', False)
	
	active = None if cfg.pull('no-active', False) else collect_q_cmd(user, silent=True)
	
	now = datetime.now()
	
	jobs = {}
	failed = []
	
	if active is not None:
		for job in active:
			if 'ID' in job:
				jobs[job['ID']] = job
				job['active'] = True
			else:
				failed.append(job)
	
	if not active_only or len(jobs):
		jobdir = cfg.pull('job-dir', str(misc.default_jobdir()))
		jobdir = Path(jobdir)
		jobdir.mkdir(exist_ok=True, parents=True)
		
		manifest_path = cfg.pull('manifest-path', str(jobdir / 'manifest.jsonl'), silent=True)
		manifest_path = Path(manifest_path)

		manifest = [json.loads(line) 
			for line in manifest_path.read_text().split('\n') if len(line)] if manifest_path.exists() else []
		
		for entry in manifest:
			jnum = entry['ID']
			for i, cmd in enumerate(entry.get('commands', [None]*entry['procs'])):
				ID = f'{jnum}.{i}'
				if ID not in jobs:
					jobs[ID] = {'ID':ID}
				job = jobs[ID]
				job['name'] = entry['name']
				if cmd is not None:
					job['command'] = cmd
				submit_date = entry.get('date', None)
				if submit_date is not None:
					job['submit'] = submit_date
				bid = entry.get('bid', None)
				if bid is not None:
					job['bid'] = bid
		
		starts_path = cfg.pull('starts-path', jobdir / 'starts.tsv')
		starts = process_tsv(starts_path, cols=['name', 'ID', 'date', 'host'], include_event='start')
		terminals_path = cfg.pull('terminals-path', jobdir / 'terminals.tsv')
		terminals = process_tsv(terminals_path, cols=['name', 'ID', 'date', 'host', 'code'], include_event='end')
		registry_path = cfg.pull('registry-path', jobdir / 'registry.tsv')
		reg = process_tsv(registry_path, cols=['name', 'ID', 'info'])
		
		failed.extend(starts.get('failed', []))
		if 'failed' in starts:
			del starts['failed']
		failed.extend(reg.get('failed', []))
		if 'failed' in reg:
			del reg['failed']
		failed.extend(terminals.get('failed', []))
		if 'failed' in terminals:
			del terminals['failed']
		
		full = {}
		
		for ID, entries in starts.items():
			full[ID] = {'ID':ID, 'events':entries}
		for ID, entries in terminals.items():
			if ID not in full:
				full[ID] = {'ID':ID, 'events':entries}
			else:
				full[ID]['events'].extend(entries)
				full[ID]['events'] = sorted(full[ID]['events'], key=lambda x: x['date'])
		
		for ID, info in full.items():
			if len(info['events']):
				info['start'] = info['events'][0]['date']
			
			compute_durations(info, now=now)
			
			if ID not in jobs:
				jobs[ID] = info
			else:
				jobs[ID].update(info)
			
			if 'status' not in jobs[ID]:
				jobs[ID]['status'] = 'missing' if not len(info['events']) \
												or info['events'][-1]['event'] != 'end' else 'ended'
			
		if print_status:
			
			if len(jobs):
				
				job = next(iter(jobs.values()))
			
				cols = [c for c in cols if c in job]
				
				try:
					idx = cols.index('ID')
				except ValueError:
					idx = None
					
				rows = []
				for ID in sort_jobkeys(cfg, jobs):
					info = jobs[ID]
					if active_only and 'active' not in info:
						continue
					row = [info.get(key, '--') for key in cols]
					row = [f'{r:.3g}' if isinstance(r, float) else r for r in row]
					
					rows.append(row)
				
				if idx is not None:
					for row in rows:
						row[idx] = row[idx].replace('.', '֎')
				
				tbl = tabulate(rows, headers=cols, floatfmt='.3g').replace('֎', '.')
				cfg.print(tbl)
				
			else:
				cfg.print('No jobs running.')
				
	elif print_status:
		cfg.print('No jobs running.')
	
	if len(failed) and not cfg.pull('skip-failed', False):
		cfg.print()
		cfg.print(f'Found {len(failed)} failed entries:')
		for f in failed:
			cfg.print(f)
		cfg.print()

	if pkl_name is not None:
		if '.p' not in pkl_name:
			pkl_name = f'{pkl_name}.p'
		with open(pkl_name, 'w') as f:
			pickle.dump({'jobs':jobs, 'failed':failed}, f)
		cfg.print(f'Pickled status to: {pkl_name}')
	
	return jobs



if __name__ == '__main__':
	fig.entry('status')
