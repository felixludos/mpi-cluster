import sys, os
import shutil

import omnibelt as util

import omnifig as fig

from src import fmt_jobdir, GPU_NAMES, SUBMISSION_FORMAT

@fig.AutoScript('git-pull', description='Pull several git repos')
def git_update(git_repos=None):
	if git_repos is not None and isinstance(git_repos, (list, tuple)):
		for gd in git_repos:
			os.system(f'cd {gd};git pull')
	return git_repos

@fig.AutoScript('submit', description='Submit jobs to the cluster')
def create_job(
		name=None, cmd=None, cmd_path=None, bid=None,
       jobdir=None, template=None, rerun=None,
       time_limit=None, avoid=None,
       cpu=1, gpu=0, ram=1, gpu_names=None,
       git_repos=None, manifest_path=None, array_jobs=True,
       interactive=False, skip_confirm=False
               ):
	'''

	:param name: Name of job (will be set automatically if not provided)
	:param cmd: command to be submitted
	:param cmd_path: Path to script containing command/s (one per line) (lines starting with # are igorned)
	:param jobdir: Path to job records
	:param template: Template script to insert the command (which is replaced with "{}")
	:param rerun: Name or number of job to be rerun
	:param bid: Bid for the job (1 - 2000) (if provided, job will automatically be submitted)
	:param time_limit: Time in hours before forcing the job to restart
	:param avoid: Nodes that should be avoided
	:param cpu: Number of CPUs
	:param gpu: Number of GPUs
	:param ram: GB of RAM
	:param gpu_names: List of GPU names to use (see list in source file)
	:param git_dirs: Paths to git directories that should be possibly be pulled
	:param auto_pull: Pull the provided github projects before submitting the job
	:param manifest_path: Path to the manifest containing info of all past/current jobs
	:param array_jobs: Split multiple commands into separate (parallel) jobs
	:param interactive: Make job interactive
	:param skip_confirm: Ask to confirm ready to pull/submit
	:return:
	'''
	
	if not skip_confirm:
		input('Have you pushed all changes?')
	
	jobdir = fmt_jobdir(jobdir)
	
	if manifest_path is None:
		manifest_path = os.path.join(jobdir, 'manifest.txt')
	
	if not os.path.isfile(manifest_path):
		num = 0
	else:
		with open(manifest_path, 'r') as f:
			num = len(f.readlines())
	past_jobs = os.listdir(jobdir)
	
	if name is None:
		name = f'job{str(num).zfill(4)}'
	# now = util.get_now()
	
	path = os.path.join(jobdir, name)
	util.create_dir(path)
	
	job_path = None
	
	if rerun is not None:
		if rerun not in past_jobs:
			fixedrerun = f'job{str(rerun).zfill(4)}'
			if fixedrerun not in past_jobs:
				raise Exception(f'Unknown past job: {rerun}, unable to rerun')
			rerun = fixedrerun
		
		num_replicas = 0
		for fname in os.listdir(rerun):
			if '.sh' in fname:
				shutil.copy(os.path.join(rerun, fname), os.path.join(path, fname))
				num_replicas += 1
		assert num_replicas > 0, f'No jobs found in {rerun}'
	else:
		
		cmds = []
		if cmd_path is not None:
			with open(cmd_path, 'r') as f:
				cmds.extend([l for l in f.read().split('\n') if len(l) > 1 and l[0] != '#'])
		if cmd is not None:
			cmds.append(cmd)
		assert len(cmds), 'No commands to submit'
		
		job_template = '{}'
		if template is not None:
			with open(template, 'r') as f:
				job_template = f.read()
		
		if array_jobs and len(cmds) > 1:
			print('Found {num} commands, will submit {num} replicas'.format(num=len(cmds)))
			for i, cmd in enumerate(cmds):
				with open(os.path.join(path, f'job-{i}.sh'), 'w') as f:
					f.write(job_template.format(cmd))
			
			num_replicas = len(cmds)
		else:
			num_replicas = 1
			jpath = os.path.join(path, f'job-0.sh')
			with open(jpath, 'w') as f:
				f.write(job_template.format('\n'.join(cmds)))
	
	job_path = os.path.join(path, 'job-$(Process).sh')
	
	sub = []
	
	sub.append(f'environment = JOBDIR={path};JOBEXEC={job_path};PROCESS_ID=$(Process);JOB_ID=$(ID);JOB_NUM={num}')
	
	reqs = []
	
	assert ram > 0 and cpu > 0, 'That\'s not a computer.'
	sub.append(f'request_memory = {ram * 1024}')
	sub.append(f'request_cpus = {cpu}')
	if gpu > 0:
		sub.append(f'request_gpus = {gpu}')
		if gpu_names is not None:
			if isinstance(gpu_names, str):
				gpu_names = [gpu_names]
			gnames = []
			for gname in gpu_names:
				if gname in GPU_NAMES:
					gnames.append(GPU_NAMES[gname])
				else:
					print('WARNING: Failed to recognize gpu name: {gname} (see source file for list)')
			
			if len(gnames):
				reqs.append(' || '.join(f'CUDADeviceName == \"{gname}\"' for gname in gnames))
				print('Requiring GPUs: {}'.format(' or '.join(gnames)))
	
	if avoid is not None and len(avoid):
		reqs.extend(f'Target.Machine != "{node}.internal.cluster.is.localnet"' for node in avoid)
	
	if len(reqs):
		sub.append('requirements = {}'.format(' && '.join(f'({r})' for r in reqs)))
	
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
			                          procs=num_replicas))
	
	sub_path = os.path.join(path, 'submit.sub')
	with open(sub_path, 'w') as f:
		f.write('\n'.join(sub))
	
	print(f'Job prepared: {name}')
	
	git_update(git_repos)
	
	if bid is not None:
		os.system('condor_submit_bid {bid} {job}{i}'.format(bid=bid,
		                                                    job=sub_path,
		                                                    i=' -i' if interactive else ''))
		
		with open(manifest_path, 'a+') as f:
			f.write(f'{name} - {num_replicas} - {bid}\n')
		
		print(f'Job {name} submitted: {bid}')

if __name__ == '__main__':
	fig.entry('submit')
