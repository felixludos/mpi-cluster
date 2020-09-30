import sys, os, shutil
import yaml
import subprocess
from datetime import datetime
from tabulate import tabulate

from omnibelt import load_yaml, load_tsv, recover_date

import omnifig as fig

from src import fmt_jobdir, collect_q_cmd
from src.cluster import COLATTRS

def process_tsv(name, root, A, cols=None):

	path = A.pull(f'{name}-path', os.path.join(root, f'{name}.tsv'))

	if not os.path.isfile(path):
		print(f'WARNING: could not find {name}: {path}')
		return None
	
	data = load_tsv(path)
	
	if cols is None:
		return data
	
	full = []
	for row in data:
		info = {}
		for col, raw in zip(cols, row):
			
			if 'date' in col:
				info['date'] = recover_date(raw)
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
			
		full.append(info)
		
	return full
		

@fig.Script('status', description='check the status of jobs submitted to the cluster')
def get_status(A):
	
	silent = A.pull('silent', False, silent=True)
	
	with A.silenced(silent):
	
		user = A.pull('user', 'fleeb') # maybe remove me as default
		
		cols = A.pull('columns', ['status', 'name', 'ID', 'host', 'start', 'run'])
		
		jobdir = fmt_jobdir(A.pull('jobdir', None))
		
		manifest_path = A.pull('manifest-path', os.path.join(jobdir, 'manifest.yaml'))
		manifest = load_yaml(manifest_path)
		
		starts = process_tsv('starts', jobdir, A, cols=['name', 'ID', 'start-date', 'host'])
		terminals = process_tsv('terminals', jobdir, A, cols=['name', 'ID', 'end-date', 'host', 'code'])
		reg = process_tsv('registry', jobdir, A, cols=['name', 'ID', 'run'])
		
		active = None if A.pull('no-active', False) else collect_q_cmd(user, silent=True)
		
		
		
		rows = []
		
		if data is not None:
			for info in data:
				rows.append([info.get(key, '--') for key in cols])
			
			print(tabulate(rows, headers=cols))
	
	return data


if __name__ == '__main__':
	fig.entry('status')
