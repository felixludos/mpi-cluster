import subprocess
import sys

from .imports import *
from . import misc
from .cluster import SUBMISSION_FORMAT, GPU_NAMES
from .status_helpers import parse_job_status, compute_durations, sort_jobkeys, process_data_table
from .remote_helpers import run_command, load_file, wrap_string, write_to_file, append_to_file


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

	host = cfg.pull('host', None)
	user = cfg.pull('user')
	location = None if host is None else f'{user}@{host}'

	cols = cfg.pull('columns', ['status', 'name', 'ID', 'host', 'start', 'duration', 'wait', 'end', 'run'])

	# pkl_name = cfg.pull('pickle-status', None)

	active_only = cfg.pull('only-active', False)

	active = None
	if not cfg.pull('no-active', False):

		q_status_columns = ['ClusterId', 'ProcId', 'JobStatus', 'Args', 'RemoteHost']
		q_command = ['condor_q', user, '-af:t'] + q_status_columns
		q_command = ' '.join(q_command)
		# q_command = 'echo "Hello world"'

		raw, _ = run_command(q_command, location=location)

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
			for i, cmd in enumerate(entry.get('commands') or [None] * entry['procs']):
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
		try:
			starts_text = load_file(starts_path, location=location)
		except FileNotFoundError:
			starts_text = ''
		starts = process_data_table(starts_text, cols=['name', 'ID', 'date', 'host'], include_event='start')

		terminals_path = cfg.pull('terminals-path', jobdir / 'terminals.tsv')
		try:
			terminals_text = load_file(terminals_path, location=location)
		except FileNotFoundError:
			terminals_text = ''
		terminals = process_data_table(terminals_text, cols=['name', 'ID', 'date', 'host', 'code'], include_event='end')

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

			sort_by = cfg.pull('sort-by', None)
			color_keys = cfg.pull('color-keys', True)
			rows = []
			for ID in sort_jobkeys(sort_by, jobs):
				info = jobs[ID]
				if active_only and 'active' not in info:
					continue
				row = [info.get(key, '--') for key in cols]
				if color_keys and 'status' in cols:
					i = cols.index('status')
					status = row[i].upper()
					if status.lower() in STATUS_COLORS:
						row[i] = colorize(status, STATUS_COLORS[status.lower()])
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

	# if pkl_name is not None:
	# 	if '.p' not in pkl_name:
	# 		pkl_name = f'{pkl_name}.p'
	# 	with open(pkl_name, 'w') as f:
	# 		pickle.dump({'jobs': jobs, 'failed': failed}, f)
	# 	cfg.print(f'Pickled status to: {pkl_name}')

	return active



STATUS_COLORS = {
	'unexpanded': 'magenta',
	'idle': 'blue',
	'running': 'green',
	'removed': 'red',
	'completed': 'yellow',
	'held': 'red',
	'submission_err': 'red',
}

import pyperclip

_not_set = object()
@fig.script('submit', description='submit jobs to the cluster')
def create_jobs(cfg: fig.Configuration, commands: str = None, location: str = _not_set, skip_confirm: bool = None):
	"""
	Create and submit jobs to a cluster based on the provided configuration.

	This function generates job scripts, prepares a submission file, and submits jobs to a cluster. 
	It also maintains a manifest file to track submitted jobs.

	Args:
		cfg (fig.Configuration): 
			Configuration object containing job parameters such as root directory, working directory, 
			commands, template paths, and resource requirements.
		commands (Union[list[str], str], optional): 
			A list of commands or a single command string to execute. If not provided, commands are 
			loaded from the configuration or a specified file.

	Returns:
		str: The name of the submitted job.

	Raises:
		FileNotFoundError: If the command file or template file specified in the configuration does not exist.
		ValueError: If no commands are provided.

	Key Configuration Parameters:
		- root: Root directory for resolving relative paths.
		- working-dir: Directory where the commands will be executed.
		- commands/command: Commands to execute.
		- command-path/cmd-path/path: Path to a file containing commands.
		- template-path: Path to the job script template.
		- name: Base name for the job.
		- job-dir: Directory to store job-related files.
		- manifest-path: Path to the manifest file.
		- include-date: Whether to include the current date in the job name.
		- env-vars: Environment variables to set for the job.
		- ram/mem: Memory requirements in GB.
		- cpu: Number of CPU cores required.
		- gpu: Number of GPUs required.
		- time-limit: Maximum runtime for the job in hours.
		- bid: Batch ID for job submission.
		- include-cmds: Whether to include commands in the manifest entry.

	Notes:
		- The function uses a template to generate job scripts, which can be customized via the 
		`template-path` configuration parameter.
		- The manifest file tracks job metadata, including the job name, number, commands, and submission details.
		- If no `bid` is provided, the job will not be submitted, and a warning will be printed.
	"""

	if location is _not_set:
		host = cfg.pull('host', None)
		user = cfg.pull('user', None)
		location = None if host is None or user is None else f'{user}@{host}'

	now = datetime.now()

	# Resolve root and working directory
	root = cfg.push_pull('root', None, overwrite=False)
	if root:
		root = Path(root)

	working_dir = cfg.pull('working-dir', None)
	if working_dir:
		working_dir = Path(working_dir).resolve()
	if working_dir is None:
		working_dir = '.'

	interactive = cfg.pulls('interactive', 'i', default=False)

	update_cmds = False
	include_cmds = False

	if interactive:
		assert commands is None, f'Commands provided, but interactive mode is enabled'
		commands = []
		skip_cmds = True
		base_env = {}
	else:
		# Load commands from configuration or file
		if commands is None:
			commands = cfg.pulls('commands', 'command', default=None)
		if isinstance(commands, str):
			commands = [commands]

		if commands is None:
			cmd_path = cfg.pulls('command-path', 'cmd-path', 'path', default=None)
			

			update_cmds = cfg.pull('update-cmds', True)
			include_cmds = cfg.pull('include-cmds', False)
			if cmd_path:
				cmd_path = Path(cmd_path)
				if root:
					cmd_path = root / cmd_path
				if not cmd_path.exists():
					raise FileNotFoundError(f'Command file not found: {cmd_path}')
				commands = [line.strip() for line in cmd_path.open('r') if line.strip() and line[0] != '#']

		assert commands is not None, f'No commands provided'

		# Load template for job scripts
		template_path = cfg.pull('template-path',
								 str(misc.repo_root().joinpath('assets', 'default_template.sh')), silent=True)
		if template_path:
			template_path = Path(template_path)
			if root:
				template_path = root / template_path
			if not template_path.exists():
				raise FileNotFoundError(f'Template file not found: {template_path}')
			template = template_path.read_text()
		else:
			template = f'cd {{working_dir}}\n{{command}}' if working_dir else '{command}'

		# Prepare job name and directory
		skip_cmds = cfg.pull('skip-cmds', len(commands)>5)

		rawname = cfg.pull('name', 'job')
		jobdir = Path(cfg.pull('job-dir', str(misc.default_jobdir())))
		if location is None:
			jobdir.mkdir(exist_ok=True, parents=True)

		manifest_path = Path(cfg.pull('manifest-path', str(jobdir / 'manifest.jsonl'), silent=True))
		rawtext, _ = run_command(f'wc -l {manifest_path}', location=location)
		num = int(rawtext.split()[0]) if rawtext is not None and len(rawtext) else 0
		# num = sum(1 for _ in manifest_path.open('r')) if manifest_path.exists() else 0
		name = f"{rawname}_{str(num).zfill(3)}"
		if cfg.pull('include-date', False):
			name = f"{name}_{now.strftime('%y%m%d-%H%M%S')}"

		print(f'Setting up job: {name}{" (interactive)" if interactive else ""}')

		path = jobdir / name
		run_command(f'mkdir -p {str(path)}', location=location)

		# Generate job scripts
		jobs = [
			pformat(template, command=cmd, working_dir=working_dir, job_dir=jobdir, name=name, process=i, path=path,
					date=now)
			for i, cmd in enumerate(commands)
		]

		job_path = path / 'job-$(Process).sh'

		base_env = {
			'JOBDIR': path,
			'JOBEXEC': job_path,
			'PROCESS_ID': '$(Process)',
			'JOB_ID': '$(ID)',
			'JOB_NAME': name,
			'JOB_NUM': num,
		}

	# Prepare submission file
	sub = []
	reqs = []
	env_vars = cfg.pull("env-vars", {})
	if env_vars is not None:
		base_env.update(env_vars)
	if env_vars:
		sub.append(f'environment = {";".join(f"{k}={v}" for k, v in base_env.items())}')
	sub.append(f'request_memory = {cfg.pulls("ram", "mem", default=1) * 1024}')
	sub.append(f'request_cpus = {cfg.pull("cpu", 1)}')

	gpus = cfg.pull('gpu', int(cfg.pull('gpu-ram', 0, silent=True) > 0))
	if gpus > 0:
		sub.append(f'request_gpus = {gpus}')

		gpu_mem = cfg.pulls('gpu-mem', 'gpu-ram', 'gpu-memory', default=None)
		if gpu_mem is not None:
			reqs.append(f'CUDAGlobalMemoryMb >= {gpu_mem*1024}')

		gpu_names = cfg.pulls('gpu-names', 'gpu-name', default=None)
		if gpu_names is not None:
			if isinstance(gpu_names, dict):
				gpu_names = list(gpu_names)
			if isinstance(gpu_names, str):
				gpu_names = gpu_names.split('|')
			if not isinstance(gpu_names, (tuple, list)):
				gpu_names = gpu_names,

			gpu_names = list(map(str, gpu_names))

			gnames = []
			for gname in gpu_names:
				if gname in GPU_NAMES:
					gnames.append(GPU_NAMES[gname])
				else:
					# raise ValueError(f'Failed to recognize gpu name: {gname} (see source file for list)')
					cfg.print(f'WARNING: Failed to recognize gpu name: {gname} (see source file for list)')

			if len(gnames):
				reqs.append(' || '.join(f'CUDADeviceName == \"{gname}\"' for gname in gnames))
				cfg.print('Requiring GPUs: {}'.format(' or '.join(gnames)))

	avoid = cfg.pull('avoid', None)
	if avoid is not None and len(avoid):
		if isinstance(avoid, str):
			avoid = avoid.split('|')
		reqs.extend(f'Target.Machine != "{node}.internal.cluster.is.localnet"' for node in avoid)
		cfg.print(f'Avoiding: {avoid}')

	if len(reqs):
		sub.append('requirements = {}'.format(' && '.join(f'({r})' for r in reqs)))

	# Submit jobs
	bid = cfg.pull('bid', None)
	if not bid:
		cfg.print('WARNING: Job not submitted because no bid was included')
		return

	if interactive:
		args = ' '.join(f'-append {shlex.quote(s)}' for s in sub)
		submission_command = f'condor_submit_bid {bid} -i {args}'
		print(submission_command)
		try:
			pyperclip.copy(submission_command)
		except pyperclip.PyperclipException:
			pass

	else:
		sub.append('''on_exit_hold = (ExitCode =?= 3)
on_exit_hold_reason = "Checkpointed, will resume"
on_exit_hold_subcode = 2
periodic_release = ( (JobStatus =?= 5) && (HoldReasonCode =?= 3) && ((HoldReasonSubCode =?= 1) || (HoldReasonSubCode =?= 2)) )''')

		time_limit = cfg.pull('time-limit', None)
		if time_limit:
			sub.append(f'''MaxTime = {int(float(time_limit) * 3600)}
periodic_hold = (JobStatus =?= 2) && ((CurrentTime - JobCurrentStartDate) >= $(MaxTime))
periodic_hold_reason = "Job runtime exceeded"
periodic_hold_subcode = 1''')

		max_running_price = cfg.pull("max-running-price", None)
		if max_running_price is not None:
			running_price_exceeded_action = cfg.pull("running-price-exceeded-action", "kill")
			sub.append(f"+MaxRunningPrice = {max_running_price}")
			if running_price_exceeded_action == "kill":
				cfg.print(f"Job will be killed if running price exceeds {max_running_price}")
			elif running_price_exceeded_action == "restart":
				cfg.print(f"Job will be restarted if running price exceeds {max_running_price}")
			else:
				cfg.print(f"Unknown running price exceeded action {running_price_exceeded_action}")
				running_price_exceeded_action = "kill"
				cfg.print(f"Job will be killed if running price exceeds {max_running_price}")
			sub.append(f'+RunningPriceExceededAction = "{running_price_exceeded_action}"')

		stdout_path = path / 'stdout-$(Process).txt'
		log_path = path / 'log-$(Process).txt'
		sub.append(SUBMISSION_FORMAT.format(exec=job_path, err=stdout_path, out=stdout_path, log=log_path, procs=len(commands)))

		# Write job scripts and submission file
		for i, job in enumerate(jobs):
			write_to_file(job, path=path / f'job-{i}.sh', location=location)

		full_sub = "\n".join(sub)
		write_to_file(full_sub, path=path.joinpath("submit.sub"), location=location)

		cfg.print(tabulate(enumerate(commands), headers=['i', 'command']))

		if skip_confirm is None:
			skip_confirm = cfg.pull('skip-confirm', False, silent=True)
		if not skip_confirm:
			resp = None
			while resp is None:
				resp = input(f'Submit {len(commands)} jobs ([y]/n)? ')
				if resp.lower() in {'n', 'no'}:
					print('Nothing was submitted.')
					return
				elif resp.lower() in {'y', 'yes', ''}:
					break
				else:
					print(f'Invalid response: {resp!r}')
					resp = None

		submission_command = f'condor_submit_bid {bid} {path / "submit.sub"}'
		out, err = run_command(submission_command, location=location)

		ID = out.split('submitted to cluster ')[-1].strip().replace('.', '') if 'submitted to cluster ' in out else None

		if not ID:
			cfg.print(f'WARNING: Job {name} not submitted because no ID was returned')
			return name

		# Update manifest
		manifest_entry = {
			'name': name,
			'job-num': num,
			'procs': len(commands),
			'path': str(path),
			'date': now.strftime("%y%m%d-%H%M%S"),
			'bid': bid,
			'ID': ID,
			'commands': None if skip_cmds else commands
		}

		append_to_file(f'{json.dumps(manifest_entry)}\n', path=manifest_path, location=location)

		
		if update_cmds and cmd_path is not None:
			cmd_lines = cmd_path.read_text().split('\n')

			fixed = []
			i = 0
			for line in cmd_lines:
				cmddata = line.strip()
				if len(cmddata) and cmddata[0] != '#':
					myid = i if ID is None else f'{ID}.{i}'
					fixed.append(f'#{line} # {name} {myid}')
					i += 1
				else:
					fixed.append(line)
			fixed = '\n'.join(fixed)

			cmd_path.write_text(fixed)


		cfg.print(f'Job {name} submitted: {bid}')
		return name














