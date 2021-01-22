import sys, os, shutil
import yaml
import subprocess
import pickle
from datetime import datetime
from tabulate import tabulate
from collections import OrderedDict

from omnibelt import load_json, load_tsv, recover_date, save_json, load_yaml, save_yaml

import omnifig as fig

# from IPython.core.debugger import set_trace

from cluster_src import fmt_jobdir, collect_q_cmd
# from cluster_src.cluster import COLATTRS

def process_tsv(name, root, A, cols=None, include_event=None):

	path = A.pull(f'{name}-path', os.path.join(root, f'{name}.tsv'))

	if not os.path.isfile(path):
		print(f'WARNING: could not find {name}: {path}')
		return None
	
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

def sort_jobkeys(A, jobs):
	
	sort_by = A.pull('sort-by', None)
	
	keys = list(jobs.keys())
	
	if sort_by is None:
		return keys
		
	if not isinstance(sort_by, (list, tuple)):
		sort_by = sort_by,
	
	return sorted(keys, key=lambda k: tuple(jobs[k].get(s, None) for s in sort_by))


@fig.Script('status', description='check the status of jobs submitted to the cluster')
def get_status(A):
	
	silent = A.pull('silent', False, silent=True)
	
	print_status = A.pull('print-status', True, silent=True)
	
	with A.silenced(silent):
	
		user = A.pull('user', 'fleeb') # maybe remove me as default
		
		cols = A.pull('columns', ['status', 'name', 'ID', 'host', 'start', 'duration', 'wait', 'end', 'run'])
		
		active_only = A.pull('only-active', False)
		
		active = None if A.pull('no-active', False) else collect_q_cmd(user, silent=True)
		
		now = datetime.now()
		
		jobs = {}
		failed = []
		
		if active is not None:
			for job in active:
				if 'ID' in job:
					jobs[job['ID']] = job
				else:
					failed.append(job)
		
		print('active')
		print(jobs)
		
		if not active_only or len(jobs):
			
			jobdir = fmt_jobdir(A.pull('jobdir', None))
			
			manifest_path = A.pull('manifest-path', os.path.join(jobdir, 'manifest.yaml'))
			if not os.path.isfile(manifest_path):
				save_yaml(None, manifest_path)
			manifest = load_yaml(manifest_path)
			if manifest is None:
				manifest = []
			
			for name, entry in manifest.items():
				jnum = entry['ID']
				for i, cmd in enumerate(entry.get('commands', [None]*entry['procs'])):
					ID = f'{jnum}.{i}'
					if ID not in jobs:
						if active_only:
							continue
						jobs[ID] = {'ID':ID}
					job = jobs[ID]
					if cmd is not None:
						job['command'] = cmd
					submit_date = entry.get('date', None)
					if submit_date is not None:
						job['submit'] = submit_date
					bid = entry.get('bid', None)
					if bid is not None:
						job['bid'] = bid
			
			print('after manifest')
			print(jobs)
			
			starts = process_tsv('starts', jobdir, A, cols=['name', 'ID', 'date', 'host'],
			                     include_event='start')
			if starts is None:
				starts = {}
			terminals = process_tsv('terminals', jobdir, A, cols=['name', 'ID', 'date', 'host', 'code'],
			                        include_event='end')
			if terminals is None:
				terminals = {}
			reg = process_tsv('registry', jobdir, A, cols=['name', 'ID', 'run'])
			if reg is None:
				reg = {}
			
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
				if ID not in jobs:
					info['status'] = 'missing' if not len(info['events']) \
					                              or info['events'][-1]['event'] != 'end' else 'ended'
				
				compute_durations(info, now=now)
				
				if ID in jobs:
					jobs[ID].update(info)
				else:
					jobs[ID] = info
			
			print(full)
			print()
			print(jobs)

			# set_trace()
			
			# else:
			# 	pkl_name = A.pull('pickle-status', None)
			# 	if pkl_name is not None:
			# 		if '.p' not in pkl_name:
			# 			pkl_name = f'{pkl_name}.p'
			# 		with open(pkl_name, 'w') as f:
			# 			pickle.dump({'jobs':jobs, 'failed':failed}, f)
			# 		print(f'Pickled status to: {pkl_name}')
				
			if print_status:
				
				if len(jobs):
					
					job = next(iter(jobs.values()))
				
					cols = [c for c in cols if c in job]
					
					try:
						idx = cols.index('ID')
					except ValueError:
						idx = None
					
					
					rows = []
					for ID in sort_jobkeys(A, jobs):
						info = jobs[ID]
						rows.append([info.get(key, '--') for key in cols])
					
					if idx is not None:
						for row in rows:
							row[idx] = f'*{row[idx]}'
					
					print(tabulate(rows, headers=cols))
					
				else:
					print('No jobs running.')
					
		
		elif print_status:
			print('No jobs running.')
		
		if len(failed) and not A.pull('skip-failed', False):
			print()
			print(f'Found {len(failed)} failed entries:')
			for f in failed:
				print(f)
			print()
	
	return jobs


if __name__ == '__main__':
	fig.entry('status')
