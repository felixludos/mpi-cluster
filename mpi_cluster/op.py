import sys

from .imports import *
from . import misc
from .status import parse_job_status, compute_durations, sort_jobkeys


@fig.script('_generic_run', description='run a command specified from a remote client')
def generic_run(cfg: fig.Configuration):
	"""
	Run a command on the cluster.

	Args:
		cfg (fig.Configuration): The configuration object.

	Returns:
		None
	"""
	output_prefix = cfg.pull('output-prefix', '__output_tag_code__')
	command = cfg.pull('command', None)
	result = subprocess.run(command, shell=True, capture_output=True, text=True)
	raw = result.stdout
	output = output_prefix + raw.replace('\n', f'\n{output_prefix}')
	print(output)



def run_command(command: str, location: str = None, *, output_prefix: str = '__output_tag_code__') -> str:
	if location is None:
		res = subprocess.run(
			command,
			shell=True,
			capture_output=True,
			text=True,
		)
		return res.stdout

	c = command.replace('\\', '\\\\').replace('"', '\\"')
	r = f"fig _generic_run --output-prefix \"{output_prefix}\" --command \"{c}\"".replace('\\', '\\\\').replace('"', '\\"')
	b = f"bash -ic \"{r}\""
	full = f"ssh {location} '{b}'"

	res = subprocess.run(
		full,
		shell=True,
		capture_output=True,
		text=True,
	)
	raw = res.stdout

	output = []
	for line in raw.split('\n'):
		if line.startswith(output_prefix):
			output.append(line[len(output_prefix):])

	return '\n'.join(output)


_file_cache = misc.repo_root().joinpath('assets', 'file_cache.json')
_file_cache = None
def load_file(path: Path, location: str = None) -> str:
	text = None
	cache = None
	pathcode = str(path).replace('\\', '/')
	if _file_cache is not None:
		cache = load_json(_file_cache)
		if pathcode.replace('\\', '/') in cache:
			return cache[pathcode]
	if location is None:
		if path.exists():
			text = path.read_text()
	else:
		command = f'cat {path}'.replace('\\', '/')
		text = run_command(command, location=location)

	if text is None:
		raise FileNotFoundError(f'File not found: {path}')
	if cache is not None:
		cache[pathcode] = text
		with open(_file_cache, 'w') as f:
			json.dump(cache, f)
	return text



def process_data_table(file_text: str, cols=None, include_event=None):

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



@fig.script('status', description='check the status of jobs submitted to the cluster')
def get_status(cfg: fig.Configuration):
	"""
	Get the status of jobs submitted to the cluster.

	Args:
		cfg (fig.Configuration): The configuration object.

	Returns:
		None
	"""
	print_status = cfg.pull('print-status', True, silent=True)
	silent = cfg.pull('silent', False, silent=True)
	cfg.silent = silent

	host = cfg.pull('remote-host', None)
	user = cfg.pull('user')
	location = None if host is None else f'{user}@{host}'

	cols = cfg.pull('columns', ['status', 'name', 'ID', 'host', 'start', 'duration', 'wait', 'end', 'run'])

	pkl_name = cfg.pull('pickle-status', None)

	active_only = cfg.pull('only-active', False)

	active = None
	if not cfg.pull('no-active', False):

		q_status_columns = ['ClusterId', 'ProcId', 'JobStatus', 'Args', 'RemoteHost']
		q_command = ['condor_q', user, '-af:t'] + q_status_columns
		q_command = ' '.join(q_command)
		# q_command = 'echo "Hello world"'

		raw = run_command(q_command, location=location).strip()

		lines = raw.split('\n')
		active = [parse_job_status(dict(zip(q_status_columns, line.split('\t')))) for line in lines if len(line)]

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
		if location is None:
			jobdir.mkdir(exist_ok=True, parents=True)

		manifest_path = cfg.pull('manifest-path', str(jobdir / 'manifest.jsonl'), silent=True)
		manifest_path = Path(manifest_path)

		manifest_text = load_file(manifest_path, location=location)

		manifest = [json.loads(line) for line in manifest_text.split('\n') if len(line)] \
			if manifest_text is not None and len(manifest_text) else []

		for entry in manifest:
			jnum = entry['ID']
			for i, cmd in enumerate(entry.get('commands', [None] * entry['procs'])):
				ID = f'{jnum}.{i}'
				if ID not in jobs:
					jobs[ID] = {'ID': ID}
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
		starts_text = load_file(starts_path, location=location)
		starts = process_data_table(starts_text, cols=['name', 'ID', 'date', 'host'], include_event='start')

		terminals_path = cfg.pull('terminals-path', jobdir / 'terminals.tsv')
		terminals_text = load_file(terminals_path, location=location)
		terminals = process_data_table(terminals_text, cols=['name', 'ID', 'date', 'host', 'code'], include_event='end')

		# registry_path = cfg.pull('registry-path', jobdir / 'registry.tsv')
		# registry_text = load_file(registry_path, location=location)
		# reg = process_data_table(registry_text, cols=['name', 'ID', 'info'])

		failed.extend(starts.get('failed', []))
		if 'failed' in starts:
			del starts['failed']
		# failed.extend(reg.get('failed', []))
		# if 'failed' in reg:
		# 	del reg['failed']
		failed.extend(terminals.get('failed', []))
		if 'failed' in terminals:
			del terminals['failed']

		full = {}

		for ID, entries in starts.items():
			full[ID] = {'ID': ID, 'events': entries}
		for ID, entries in terminals.items():
			if ID not in full:
				full[ID] = {'ID': ID, 'events': entries}
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
			pickle.dump({'jobs': jobs, 'failed': failed}, f)
		cfg.print(f'Pickled status to: {pkl_name}')

	return active




















