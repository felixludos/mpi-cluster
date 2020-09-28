
import sys, os

from contextlib import redirect_stdout, redirect_stderr
import io

from datetime import datetime
from omnibelt import load_yaml, save_yaml, create_dir

from tabulate import tabulate

import omnifig as fig

from src import fmt_jobdir, GPU_NAMES, SUBMISSION_FORMAT, write_job, is_todo

@fig.AutoScript('git-pull', description='Pull several git repos')
def git_update(git_repos=None):
	if git_repos is not None and isinstance(git_repos, (list, tuple)):
		for gd in git_repos:
			os.system(f'cd {gd};git pull')
	return git_repos


# @fig.Script('prep-jobs', description='Prepare jobs for the cluster')
@fig.Script('submit', description='Submit jobs to the cluster')
def create_jobs(A):

	root = A.push('root', os.environ['HOME'], overwrite=False)
	
	commands = A.pull('commands', '<>command', None)
	if isinstance(commands, str):
		commands = [commands]
	
	cmd_path = None
	if commands is None:
		cmd_path = A.pull('command-path', '<>cmd-path', '<>path', None)

		if cmd_path is not None:
			if not os.path.isfile(cmd_path):
				cmd_path = os.path.join(root, cmd_path)
			commands = []
			with open(cmd_path, 'r') as f:
				for line in f.read().split('\n'):
					if len(line) and line[0] != '#':
						commands.append(line)

	if not len(commands):
		raise Exception('no commands to submit')

	update_cmds = A.pull('update-cmds', True)
	include_cmds = A.pull('include-cmds', False)

	template = A.push('template', None, silent=True)

	if template is None:

		template_path = A.pull('template-path', None)
		if template_path is not None:
			if not os.path.isfile(template_path):
				template_path = os.path.join(root, template_path)
	
			with open(template_path, 'r') as f:
				template = f.read()


	print(f'Will submit {len(commands)} jobs.')

	jobdir = fmt_jobdir(A.pull('jobdir', None))

	manifest_path = os.path.join(jobdir, 'manifest.yaml')

	manifest = load_yaml(manifest_path) if os.path.isfile(manifest_path) else {}
	num = len(manifest)

	rawname = A.pull('name', None)
	name = rawname
	if name is None:
		name = 'job'

	if A.pull('include-num', True) or name in manifest:
		name = f'{name}_{str(num).zfill(3)}'

	now = datetime.now()
	if A.pull('include-date', False) or name in manifest:
		snow = now.strftime("%y%m%d-%H%M%S")
		name = f'{name}_{snow}'

	repos = A.pull('git-repos', '<>git_repos', [])

	print(tabulate(enumerate(commands), headers=['i', 'command']))
	
	bid = A.pull('bid', None)
	if bid is None:
		print('WARNING: job will not be submitted because there is no bid') # useful for dry runs

	confirm = A.pull('confirm', True)
	if confirm:
		resp = input(f'Submit {len(commands)} jobs ([y]/n)? ')
		if resp.lower() in {'n', 'no'}:
			print('Nothing was submitted.')
			return
	A.push('confirm', False, silent=True)

	path = os.path.join(jobdir, name)
	create_dir(path)
	
	working_dir = A.pull('working-dir', None)
	
	for i, cmd in enumerate(commands):
		write_job(cmd, os.path.join(path, f'job-{i}.sh'), cddir=working_dir, tmpl=template)
	
	sub = []
	
	job_path = os.path.join(path, 'job-$(Process).sh')
	sub.append(f'environment = JOBDIR={path};JOBEXEC={job_path};PROCESS_ID=$(Process);'
	           f'JOB_ID=$(ID);JOB_NAME={name};JOB_NUM={num}')

	reqs = []

	ram = A.pull('ram', '<>mem', 1) # in gb
	cpu = A.pull('cpu', 1)
	sub.append(f'request_memory = {ram * 1024}')
	sub.append(f'request_cpus = {cpu}')

	gpu = A.pull('gpu', 0)
	if gpu > 0:
		sub.append(f'request_gpus = {gpu}')
		gpu_names = A.pull('gpu-names', '<>gpu-name', '<>gpu_names', None)
		if gpu_names is not None:
			if isinstance(gpu_names, str):
				gpu_names = gpu_names,

			gnames = []
			for gname in gpu_names:
				if gname in GPU_NAMES:
					gnames.append(GPU_NAMES[gname])
				else:
					print(f'WARNING: Failed to recognize gpu name: {gname} (see source file for list)')

			if len(gnames):
				reqs.append(' || '.join(f'CUDADeviceName == \"{gname}\"' for gname in gnames))
				print('Requiring GPUs: {}'.format(' or '.join(gnames)))

	avoid = A.pull('avoid', None)
	if avoid is not None and len(avoid):
		reqs.extend(f'Target.Machine != "{node}.internal.cluster.is.localnet"' for node in avoid)
		print(f'Avoiding: {avoid}')

	if len(reqs):
		sub.append('requirements = {}'.format(' && '.join(f'({r})' for r in reqs)))

	time_limit = A.pull('time-limit', None) # in hours
	if time_limit is not None:
		slimit = int(float(time_limit) * 3600)
		sub.append(f'''MaxTime = {slimit}
periodic_hold = (JobStatus =?= 2) && ((CurrentTime - JobCurrentStartDate) >= $(MaxTime))
periodic_hold_reason = "Job runtime exceeded"
periodic_hold_subcode = 1''')
		print(f'Will restart automatically after {time_limit} hrs')

	sub.append('''on_exit_hold = (ExitCode =?= 3)
on_exit_hold_reason = "Checkpointed, will resume"
on_exit_hold_subcode = 2
periodic_release = ( (JobStatus =?= 5) && (HoldReasonCode =?= 3) && ((HoldReasonSubCode =?= 1) || (HoldReasonSubCode =?= 2)) )''')

	stdoutname = 'stdout-$(Process).txt'
	stdout_path = os.path.join(path, stdoutname)
	logname = 'log-$(Process).txt'
	log_path = os.path.join(path, logname)

	sub.append(SUBMISSION_FORMAT.format(exec=job_path,
	                                    err=stdout_path,
	                                    out=stdout_path,
	                                    log=log_path,
	                                    procs=len(commands)))

	sub_path = os.path.join(path, 'submit.sub')
	with open(sub_path, 'w') as f:
		f.write('\n'.join(sub))

	print(f'Job prepared: {name}')

	if len(repos):
		git_update(repos)
	
	ID = None
	if bid is None:
		print('WARNING: job not submitted because no bid was included')
	else:
		
		print('before')
		f = io.StringIO()
		with redirect_stdout(f):
			with redirect_stderr(f):
				os.system(f'condor_submit_bid {bid} {sub_path}')
		s = f.getvalue()
		print('after')
		
		print('s', s)
		key = 'submitted to cluster '
		if key in s:
			idx = s.find(key) + len(key)
			print(idx)
			if len(s) > idx:
				ID = s[idx:-1]

		print('out', ID)

	manifest[name] = {
		'job-num': num,
		'procs': len(commands),
		'path': path,
		'date': now,
		'bid': bid,
	}
	if rawname is not None:
		manifest[name] = rawname
	
	if ID is not None:
		manifest[name] = ID
	
	if include_cmds:
		manifest[name]['commands'] = commands
	
	save_yaml(manifest, manifest_path)
	
	if update_cmds and cmd_path is not None:
		with open(cmd_path, 'r') as f:
			raw = f.read().split('\n')

		fixed = []
		i = 0
		for line in raw:
			if is_todo(line):
				fixed.append(f'# {line} # {name} {i}')
				i += 1
			else:
				fixed.append(line)
		fixed = '\n'.join(fixed)

		with open(cmd_path, 'w') as f:
			f.write(fixed)

	print(f'Job {name} submitted: {bid}')
		
	return name

# @fig.Script('submit', description='Submit jobs to the cluster')
# def submit_jobs(A):
#
# 	name =
#
# 	pass


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
