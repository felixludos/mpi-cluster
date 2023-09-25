import sys, os
from pathlib import Path
import time
import json

from contextlib import redirect_stdout, redirect_stderr
import io
import subprocess
from tabulate import tabulate
from datetime import datetime

from omnibelt import load_json, save_json, create_dir, load_yaml, save_yaml, load_txt, save_txt, pformat
import omnifig as fig

from . import GPU_NAMES, SUBMISSION_FORMAT
from . import misc



@fig.autoscript('git-pull', description='Pull several git repos')
def git_update(git_repos=None):
	"""
	Update git repositories by pulling the latest changes from their remote branches.

	Args:
		git_repos (list or tuple): cfg list of paths to the git repositories to update.

	Returns:
		list or tuple: The same list of paths to the git repositories that were updated.
	
	Example:
		>>> git_update(['/home/user/repo1', '/home/user/repo2'])
		['/home/user/repo1', '/home/user/repo2']
	"""
	if git_repos is not None and isinstance(git_repos, (list, tuple)):
		for gd in git_repos:
			os.system(f'git -C {gd} pull')
	return git_repos



@fig.script('submit', description='Submit jobs to the cluster')
def create_jobs(cfg: fig.Configuration):
	"""
	Create and submit jobs based on the given configuration.

	Will save job information to a manifest file (default: ~/.mpi_jobs/manifest.jsonl)

	Parameters:
		cfg (fig.Configuration): The configuration object containing the following parameters:
			- root (str): The root directory for the job files. Default is the current working directory.
			- commands (List[str]): A list of commands to execute. Default is an empty list.
			- command-path (str): The path to a file containing commands to execute. Default is None.
			- update-cmds (bool): Whether to update the commands. Default is True.
			- include-cmds (bool): Whether to include the commands. Default is False.
			- template (str): The template for the job file. Default is a simple template containing a header, and tail.
			- template-path (str): The path to the template file. Default is None.
			- header (str): The header for the job file. Default is 'cd {working_dir}'.
			- tail (str): The tail for the job file. Default is an empty string.
			- name (str): The name of the job. Default is an empty string.
			- job-dir (str): The directory to store the job files. Default is the result of calling `default_jobdir()`.
			- manifest-path (str): The path to the manifest file. Default is None.
			- include-num (bool): Whether to include the job number in the name. Default is False.
			- include-date (bool): Whether to include the date in the name. Default is False.
			- working-dir (str): The working directory for the job. Default is the result of calling `os.getcwd()`.
			- git-repos (List[str]): A list of git repositories to include. Default is an empty list.
			- bid (str): The bid for the job. Default is an empty string.
			- confirm (bool): Whether to confirm before submitting the job. Default is False.
			- ram (int): The amount of RAM to request for the job. Default is 1.
			- cpu (int): The number of CPUs to request for the job. Default is 1.
			- gpu (int): The number of GPUs to request for the job. Default is 0.
			- gpu-names (Union[str, List[str], Dict[str, str]]): The names of the GPUs to request. Default is an empty string.
			- avoid (Union[str, List[str]]): The nodes to avoid. Default is an empty list.
			- time-limit (float): The time limit for the job in hours. Default is None.
	
	Raises:
		FileNotFoundError: If the command file or template file is not found.

		ValueError: If no commands are provided.

	Returns:
		None
	
	"""
	root = cfg.push_pull('root', None, overwrite=False)
	if root is not None:
		root = Path(root)
	
	working_dir = cfg.pull('working-dir', None)
	if working_dir is not None:
		working_dir = Path(working_dir).resolve()

	commands = cfg.pulls('commands', 'command', default=None)
	if isinstance(commands, str):
		commands = [commands]
	
	cmd_path = None
	if commands is None:
		cmd_path = cfg.pulls('command-path', 'cmd-path', 'path', default=None)

		if cmd_path is not None:
			cmd_path = Path(cmd_path)
			if root is not None:
				cmd_path = root / cmd_path
			if not cmd_path.exists():
				raise FileNotFoundError(f'command file not found: {cmd_path}')
			commands = []
			with cmd_path.open('r') as f:
				for line in f.readlines():
					if len(line) and line[0] != '#':
						commands.append(line)

	if not len(commands):
		raise ValueError('No commands provided')

	update_cmds = cfg.pull('update-cmds', True)
	include_cmds = cfg.pull('include-cmds', False)

	template_path = cfg.pull('template-path',
							 str(misc.package_root() / 'data' / 'default_template.sh'), silent=True)
	if template_path is None:
		template = '\n{command}'
		if working_dir is not None:
			template = f'cd {working_dir}\n{template}'
	else:
		template_path = Path(template_path)
		if root is not None:
			template_path = root / template_path

		if not template_path.exists():
			raise FileNotFoundError(f'template file not found: {template_path}')
		template = template_path.read_text()
	
	repos = cfg.pull('git-repos', [])

	rawname = cfg.pull('name', None)
	name = rawname
	if name is None:
		name = 'job'

	jobdir = cfg.pull('job-dir', str(misc.default_jobdir()))
	jobdir = Path(jobdir)
	jobdir.mkdir(exist_ok=True, parents=True)

	manifest_path = cfg.pull('manifest-path', str(jobdir / 'manifest.jsonl'), silent=True)
	manifest_path = Path(manifest_path)

	if cfg.pull('include-num', True):
		if manifest_path.exists():
			with manifest_path.open('r') as f:
				num = sum(1 for _ in f)
		else:
			num = 0
		name = f'{name}_{str(num).zfill(3)}'
	now = datetime.now()
	if cfg.pull('include-date', False):
		name = f'{name}_{now.strftime("%y%m%d-%H%M%S")}'

	path = jobdir / name

	jobs = [
		pformat(template, command=cmd,
				working_dir=working_dir, job_dir=jobdir,
				name=name, process=i, date=now, path=path,
				# header=header, tail=tail,
				)
	for i, cmd in enumerate(commands)]

	sub = []
	
	job_path = path / 'job-$(Process).sh'
	sub.append(f'environment = JOBDIR={path};JOBEXEC={job_path};PROCESS_ID=$(Process);'
			   f'JOB_ID=$(ID);JOB_NAME={name};JOB_NUM={num}')

	reqs = []

	ram = cfg.pulls('ram', 'mem', default=1) # in gb
	cpu = cfg.pull('cpu', 1)
	sub.append(f'request_memory = {ram * 1024}')
	sub.append(f'request_cpus = {cpu}')

	gpu = cfg.pull('gpu', 0)
	if gpu > 0:
		sub.append(f'request_gpus = {gpu}')
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

	sub.append('''on_exit_hold = (ExitCode =?= 3)
on_exit_hold_reason = "Checkpointed, will resume"
on_exit_hold_subcode = 2
periodic_release = ( (JobStatus =?= 5) && (HoldReasonCode =?= 3) && ((HoldReasonSubCode =?= 1) || (HoldReasonSubCode =?= 2)) )''')

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

	time_limit = cfg.pull('time-limit', None)  # in hours
	if time_limit is not None:
		slimit = int(float(time_limit) * 3600)
		sub.append(f'''MaxTime = {slimit}
periodic_hold = (JobStatus =?= 2) && ((CurrentTime - JobCurrentStartDate) >= $(MaxTime))
periodic_hold_reason = "Job runtime exceeded"
periodic_hold_subcode = 1''')
		cfg.print(f'Will restart automatically after {time_limit} hrs')

	stdout_path = path / 'stdout-$(Process).txt'
	log_path = path / 'log-$(Process).txt'

	sub.append(SUBMISSION_FORMAT.format(exec=job_path,
										err=stdout_path,
										out=stdout_path,
										log=log_path,
										procs=len(commands)))

	sub_path = path / 'submit.sub'

	cfg.print(f'Will submit {len(jobs)} jobs.')

	bid = cfg.pull('bid', None)
	if bid is None:
		cfg.print('WARNING: job will not be submitted because there is no bid') # useful for dry runs

	cfg.print(tabulate(enumerate(commands), headers=['i', 'command']))

	confirm = cfg.pull('confirm', True, silent=True)
	if confirm:
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
	cfg.push('confirm', False, silent=True)

	path.mkdir(exist_ok=True, parents=True)
	for i, job in enumerate(jobs):
		job_path = path / f'job-{i}.sh'
		job_path.write_text(job)

	sub_path.write_text('\n'.join(sub))

	cfg.print(f'Job prepared: {name}')

	if len(repos):
		git_update(repos)
	
	ID = None
	if bid is None:
		cfg.print('WARNING: job not submitted because no bid was included')
	else:
		process = subprocess.Popen(['condor_submit_bid', f'{bid}', f'{sub_path}'],
								   stdout=subprocess.PIPE, stderr=subprocess.PIPE)
		out, err = process.communicate()
		s = out.decode()

		key = 'submitted to cluster '
		if key in s:
			idx = s.find(key) + len(key)
			if len(s) > idx:
				ID = s[idx:-2]

	if ID is None:
		cfg.print('WARNING: job not submitted because no ID was returned')
		return name

	manifest_entry = {
		'name': name,
		'job-num': num,
		'procs': len(commands),
		'path': str(path),
		'date': now.strftime("%y%m%d-%H%M%S"),
		'bid': bid,
		'ID': ID,
	}
	if rawname is not None:
		manifest_entry['rawname'] = rawname
	if include_cmds:
		manifest_entry['commands'] = commands

	with manifest_path.open('a') as f:
		f.write(f'{json.dumps(manifest_entry)}\n')

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



if __name__ == '__main__':
	fig.entry('submit')

