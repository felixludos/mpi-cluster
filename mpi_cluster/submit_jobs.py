import sys, os
from pathlib import Path
import time

from contextlib import redirect_stdout, redirect_stderr
import io
import subprocess
from tabulate import tabulate
from datetime import datetime

from omnibelt import load_json, save_json, create_dir, load_yaml, save_yaml, load_txt, save_txt, pformat
import omnifig as fig

from . import GPU_NAMES, SUBMISSION_FORMAT, is_todo
from . import misc



@fig.autoscript('git-pull', description='Pull several git repos')
def git_update(git_repos=None):
	if git_repos is not None and isinstance(git_repos, (list, tuple)):
		for gd in git_repos:
			os.system(f'git -C {gd} pull')
	return git_repos



@fig.script('submit', description='Submit jobs to the cluster')
def create_jobs(A: fig.Configuration):
	root = A.push('root', None, overwrite=False)
	if root is not None:
		root = Path(root)
	
	commands = A.pulls('commands', 'command', default=None)
	if isinstance(commands, str):
		commands = [commands]
	
	cmd_path = None
	if commands is None:
		cmd_path = A.pulls('command-path', 'cmd-path', 'path', default=None)

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

	update_cmds = A.pull('update-cmds', True)
	include_cmds = A.pull('include-cmds', False)

	template = A.pull('template', None, silent=True)
	if template is None:
		template_path = A.pull('template-path', None)
		if template_path is not None:
			template_path = Path(template_path)
			if root is not None:
				template_path = root / template_path

			if not template_path.exists():
				raise FileNotFoundError(f'template file not found: {template_path}')
			template = template_path.read_text()
	if template is None:
		template = ('#!'
					'\n\n# Job Info: Name={name}, Process={process}, Date={{date}.strftime("%y%m%d-%H%M%S")}'
					'\n# Header'
					'\n{header}'
					'\n\n# Job'
					'\n{command}'
					'\n\n# Tail'
					'\n{tail}')

	header = A.pull('header', 'cd {working_dir}', silent=True)
	tail = A.pull('tail', '', silent=True)

	rawname = A.pull('name', None)
	name = rawname
	if name is None:
		name = 'job'

	jobdir = A.pull('job-dir', str(Path(os.environ.get('HOME', os.getcwd())) / '.mpi_jobs'))
	jobdir = Path(jobdir)
	jobdir.mkdir(exist_ok=True, parents=True)

	manifest_path = A.pull('manifest-path', str(jobdir / 'manifest.jsonl'), silent=True)
	manifest_path = Path(manifest_path)

	if A.pull('include-num', True):
		with manifest_path.open('r') as f:
			num = sum(1 for _ in f)
		name = f'{name}_{str(num).zfill(3)}'
	now = datetime.now()
	if A.pull('include-date', False):
		name = f'{name}_{now.strftime("%y%m%d-%H%M%S")}'

	path = jobdir / name

	working_dir = A.pull('working-dir', None)
	if working_dir is not None:
		working_dir = Path(working_dir).resolve()

	jobs = [
		pformat(template,
				working_dir=working_dir,
				name=name, process=i, date=now, path=path,
				header=header, command=cmd, tail=tail)
	for i, cmd in enumerate(commands)]

	A.print(f'Will submit {len(jobs)} jobs.')

	repos = A.pull('git-repos', [])

	bid = A.pull('bid', None)
	if bid is None:
		A.print('WARNING: job will not be submitted because there is no bid') # useful for dry runs

	A.print(tabulate(enumerate(commands), headers=['i', 'command']))
	
	confirm = A.pull('confirm', True, silent=True)
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
	A.push('confirm', False, silent=True)

	path.mkdir(exist_ok=True, parents=True)
	for i, job in enumerate(jobs):
		job_path = path / f'job-{i}.sh'
		job_path.write_text(job)

	sub = []
	
	job_path = path / 'job-$(Process).sh'
	sub.append(f'environment = JOBDIR={path};JOBEXEC={job_path};PROCESS_ID=$(Process);'
			   f'JOB_ID=$(ID);JOB_NAME={name};JOB_NUM={num}')

	reqs = []

	ram = A.pulls('ram', 'mem', default=1) # in gb
	cpu = A.pull('cpu', 1)
	sub.append(f'request_memory = {ram * 1024}')
	sub.append(f'request_cpus = {cpu}')

	gpu = A.pull('gpu', 0)
	if gpu > 0:
		sub.append(f'request_gpus = {gpu}')
		gpu_names = A.pulls('gpu-names', 'gpu-name', default=None)
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
					A.print(f'WARNING: Failed to recognize gpu name: {gname} (see source file for list)')

			if len(gnames):
				reqs.append(' || '.join(f'CUDADeviceName == \"{gname}\"' for gname in gnames))
				A.print('Requiring GPUs: {}'.format(' or '.join(gnames)))

	avoid = A.pull('avoid', None)
	if avoid is not None and len(avoid):
		if isinstance(avoid, str):
			avoid = avoid.split('|')
		reqs.extend(f'Target.Machine != "{node}.internal.cluster.is.localnet"' for node in avoid)
		A.print(f'Avoiding: {avoid}')

	if len(reqs):
		sub.append('requirements = {}'.format(' && '.join(f'({r})' for r in reqs)))

	time_limit = A.pull('time-limit', None) # in hours
	if time_limit is not None:
		slimit = int(float(time_limit) * 3600)
		sub.append(f'''MaxTime = {slimit}
periodic_hold = (JobStatus =?= 2) && ((CurrentTime - JobCurrentStartDate) >= $(MaxTime))
periodic_hold_reason = "Job runtime exceeded"
periodic_hold_subcode = 1''')
		A.print(f'Will restart automatically after {time_limit} hrs')

	sub.append('''on_exit_hold = (ExitCode =?= 3)
on_exit_hold_reason = "Checkpointed, will resume"
on_exit_hold_subcode = 2
periodic_release = ( (JobStatus =?= 5) && (HoldReasonCode =?= 3) && ((HoldReasonSubCode =?= 1) || (HoldReasonSubCode =?= 2)) )''')

	max_running_price = A.pull("max-running-price", None)
	running_price_exceeded_action = A.pull("running-price-exceeded-action", "kill")
	if max_running_price is not None:
		sub.append(f"+MaxRunningPrice = {max_running_price}")
		if running_price_exceeded_action == "kill":
			A.print(f"Job will be killed if running price exceeds {max_running_price}")
		elif running_price_exceeded_action == "restart":
			A.print(f"Job will be restarted if running price exceeds {max_running_price}")
		else:
			A.print(f"Unknown running price exceeded action {running_price_exceeded_action}")
			running_price_exceeded_action = "kill"
			A.print(f"Job will be killed if running price exceeds {max_running_price}")
		sub.append(f'+RunningPriceExceededAction = "{running_price_exceeded_action}"')

	stdout_path = path / 'stdout-$(Process).txt'
	log_path = path / 'log-$(Process).txt'

	sub.append(SUBMISSION_FORMAT.format(exec=job_path,
										err=stdout_path,
										out=stdout_path,
										log=log_path,
										procs=len(commands)))

	sub_path = path / 'submit.sub'
	sub_path.write_text('\n'.join(sub))

	A.print(f'Job prepared: {name}')

	if len(repos):
		git_update(repos)
	
	ID = None
	if bid is None:
		A.print('WARNING: job not submitted because no bid was included')
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

		# print('out', ID)

	manifest_entry = {
		'name': name,
		'job-num': num,
		'procs': len(commands),
		'path': str(path),
		'date': now,
		'bid': bid,
	}
	if rawname is not None:
		manifest_entry['rawname'] = rawname
	if ID is not None:
		manifest_entry['ID'] = ID
	if include_cmds:
		manifest_entry['commands'] = commands

	with manifest_path.open('a') as f:
		f.write(f'{manifest_entry}\n')

	if update_cmds and cmd_path is not None:
		cmd_lines = cmd_path.read_text().split('\n')

		fixed = []
		i = 0
		for line in cmd_lines:
			if is_todo(line):
				myid = i if ID is None else f'{ID}.{i}'
				fixed.append(f'#{line} # {name} {myid}')
				i += 1
			else:
				fixed.append(line)
		fixed = '\n'.join(fixed)

		cmd_path.write_text(fixed)

	A.print(f'Job {name} submitted: {bid}')
		
	return name



if __name__ == '__main__':
	fig.entry('submit')


#########################

# import sys, os
# import subprocess
# import time
#
# from tabulate import tabulate
# from collections import OrderedDict
#
# import omnifig as fig
#
#
# @fig.Script('submit', description='Submit a job to AWS')
# def submit_job(A):
#
# 	proj = fig.get_project('awsmanager')
# 	root = A.push('root', proj.root, overwrite=False)
#
# 	commands = A.pull('commands', '<>command', None)
# 	if isinstance(commands, str):
# 		commands = [commands]
#
# 	cmd_path = A.pull('command-path', None, silent=commands is not None)
#
# 	if commands is None:
#
# 		if cmd_path is None:
# 			raise Exception('no commands given to submit')
#
# 		if not os.path.isfile(cmd_path):
# 			cmd_path = os.path.join(root, cmd_path)
#
# 		commands = []
# 		with open(cmd_path, 'r') as f:
# 			for line in f.read().split('\n'):
# 				if len(line) and line[0] != '#':
# 					commands.append(line)
#
# 	if not isinstance(commands, (list, tuple)):
# 		commands = [commands]
#
# 	if not len(commands):
# 		raise Exception('no commands to submit')
#
# 	template = A.push('template', None)
#
# 	template_path = A.pull('template-path', None)
# 	if template_path is not None:
# 		if not os.path.isfile(template_path):
# 			template_path = os.path.join(root, template_path)
#
# 		with open(template_path, 'r') as f:
# 			template = f.read()
#
# 	if template is not None:
# 		headers = get_header_cmds(A)
#
# 		if len(headers):
# 			template = template.replace('# <header>', '\n'.join(headers))
#
# 	if template is None:
# 		template = '#!\n<job>\n'
#
# 	print(f'Will submit {len(commands)} jobs.')
#
# 	confirm = A.pull('confirm', True)
# 	if confirm:
# 		resp = input(f'Submit {len(commands)} to aws? [y]/n ')
# 		if resp.lower() in {'n', 'no'}:
# 			print('Nothing was submitted.')
# 			return
# 	A.push('confirm', False, silent=True)
#
# 	A.push('service', 'ec2')
# 	service = get_aws_service(A)
#
# 	transfers = A.pull('transfers', None, silent=True)
# 	skip_transfers = A.pull('skip-transfer', False)
#
# 	if not skip_transfers and transfers is not None:
#
# 		manager_ip = A.pull('manager-ip', '<>IP', None)
#
# 		if manager_ip is None:
#
# 			manager_id = A.pull('manager-id', None)
# 			if manager_id is None:
# 				raise Exception('no manager found')
#
# 			raw = service.describe_instances()
# 			insts = filter_descriptions(raw)
#
# 			insts = [inst for inst in insts if inst['instance_id'] == manager_id]
#
# 			if not len(insts):
# 				raise Exception('no manager found')
#
# 			manager = insts[0]
#
# 			if 'ip_address' in manager and manager['ip_address'] is not None:
#
# 				manager_ip = manager['ip_address']
#
# 			else:
# 				raise Exception(f'manager failed: {manager}')
#
# 		A.push('ip-address', manager_ip)
# 		fig.run('aws-transfer', A)
#
# 	instances = []
#
# 	for cmd in commands:
#
# 		data = template.replace('<job>', cmd)
#
# 		A.push('user-data', data, silent=True)
#
# 		with A.silenced():
# 			instances.append(launch_instance(A, service))
#
# 	if cmd_path is not None:
#
# 		update_cmd_file = A.pull('update-cmd-file', True)
#
# 		if update_cmd_file:
#
# 			with open(cmd_path, 'r') as f:
# 				raw = f.read().split('\n')
#
# 			ID_info = ([_cmd, _i['Instances'][0]['InstanceId']]
# 			       for _cmd, _i in zip(commands, instances))
#
# 			cmd, ID = next(ID_info)
#
# 			lines = []
# 			for line in raw:
#
# 				if line == cmd:
# 					lines.append(f'#{cmd}  # ID: {ID}')
# 					try:
# 						cmd, ID = next(ID_info)
# 					except StopIteration:
# 						cmd, ID = None, None
# 				else:
# 					lines.append(line)
#
# 			with open(cmd_path, 'w') as f:
# 				f.write('\n'.join(lines))
#
# 		print(tabulate([[cmd, i['Instances'][0]['InstanceId']]
# 		               for cmd, i in zip(commands, instances)],
# 		               headers=['Command', 'ID']))
#
#
# 	return instances
