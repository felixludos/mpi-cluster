from .imports import *

from .cluster import STATUS_CODES#, COLATTRS
from . import misc



def process_tsv(path, cols=None, include_event=None): # replaced with process_data_table
	if not path.exists():
		print(f'WARNING: could not find {path}')
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
				info['ID'] = raw.split('#')[1] if '#' in raw and 'sched' in raw else raw
				info['proc_ID'] = raw.split('#')[2] if '#' in raw and 'sched' in raw else None
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



def process_data_table(file_text: str, cols=None, include_event=None):
	if len(file_text.strip()) == 0:
		return {}

	data = pd.read_csv(io.StringIO(file_text), sep='\t', header=None)

	# data = [{k: v for k, v in zip(cols or range(len(row)), row)} for row in data.itertuples(index=False)]

	if cols is None:
		return data

	dkey = None

	full = []
	for row in data.itertuples(index=False):
		info = {}
		for col, raw in zip(cols, row):

			if 'date' in col:
				info['date'] = recover_date(raw)
				if dkey is None:
					dkey = col
			elif col == 'ID':
				info['ID'] = raw.split('#')[1] if '#' in raw and 'sched' in raw else raw
				info['proc_ID'] = raw.split('#')[2] if '#' in raw and 'sched' in raw else None
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


import humanize

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
		# info['duration'] = wall.total_seconds() / 3600
		info['duration'] = humanize.naturaldelta(wall)


def sort_jobkeys(sort_by, jobs):

	keys = list(jobs.keys())

	if sort_by is None:
		return keys

	if not isinstance(sort_by, (list, tuple)):
		sort_by = sort_by,

	return sorted(keys, key=lambda k: tuple(jobs[k].get(s, None) for s in sort_by))


def parse_jobexec(raw, info): # processes the job name/path -> remove
	if '/' in raw:
		*root, jdir, jexe = raw.split('/')

		info['name'] = jdir

	return info


def parse_remotehost(raw):
	s, g = raw.split('.')[0].split('@')
	s = s.split('_')[-1]
	return f'{s}{g}'


def parse_job_status(raw):
	info = {}
	
	if 'ClusterId' in raw:
		info['cID'] = raw['ClusterId']
	
	if 'ProcId' in raw:
		info['proc'] = raw['ProcId']
	
	if 'proc' in info and 'cID' in info:
		info['ID'] = '{cID}.{proc}'.format(**info)

	if 'JobStatus' in raw:
		info['status'] = STATUS_CODES.get(raw['JobStatus'], raw['JobStatus'])
	
	if 'Args' in raw:
		parse_jobexec(raw['Args'], info)
	
	if 'RemoteHost' in raw:
		try:
			info['host'] = parse_remotehost(raw['RemoteHost'])
		except Exception:
			info['host'] = raw['RemoteHost']
	
	return info

