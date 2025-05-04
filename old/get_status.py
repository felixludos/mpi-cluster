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
from .cluster import COLATTRS, STATUS_CODES
from .status import process_tsv, compute_durations, sort_jobkeys, parse_job_status


class Failed_Exception(Exception):
	pass



def collect_q_cmd(user, silent=False, host=None):
	if not silent:
		print('Getting job status ... ', end='')

	try:

		# raw = subprocess.check_output(['condor_q', 'fleeb', '-af', 'ClusterId', 'ProcId', 'Args', 'JobStatus', 'RemoteHost', 'Env'])
		raw = subprocess.check_output(['condor_q', user, '-af:t'] + COLATTRS).decode()

	except FileNotFoundError:
		if not silent:
			print('FAILED')
		return None

	if len(raw) == 0:
		if not silent:
			print('No jobs running.')
		return None
	else:
		lines = raw.split('\n')
		if not silent:
			print(f'found {len(lines) - 1} jobs')

	# print(lines)

	active = [parse_job_status(dict(zip(COLATTRS, line.split('\t')))) for line in lines if len(line)]

	return active



@fig.script('old-status', description='check the status of jobs submitted to the cluster')
def get_status(cfg: fig.Configuration):
	silent = cfg.pull('silent', False, silent=True)
	cfg.silent = silent
	print_status = cfg.pull('print-status', True, silent=True)
	
	user = cfg.pull('user') # maybe remove me as default
	
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

	rows = []
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

	if print_status:
		if len(rows):
			tbl = tabulate(rows, headers=cols, floatfmt='.3g').replace('֎', '.')
			print(tbl)
		else:
			print('No jobs running.')

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
