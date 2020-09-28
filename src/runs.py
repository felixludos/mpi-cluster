
import sys, os
import socket

from omnibelt import save_yaml, load_yaml, get_now

import omnifig as fig


@fig.AutoModifier('cls-run')
class OnCluster:

	def __init__(self, A, silent=False):

		if 'JOBDIR' in os.environ: # on cluster

			jobdir = os.environ['JOBDIR']
			pid = os.environ['PROCESS_ID']
			cname = f'checkpoints{pid}.txt'

			if cname in os.listdir(jobdir):
				with open(os.path.join(jobdir, cname),'r') as f:
					name = f.read()

				print(f'[Found checkpoint from restart: {name}, resuming now]')

				A.push('resume', name)

		super().__init__(A, silent=silent)


	def startup(self):

		super().startup()

		save_dir = self.save_dir

		if save_dir is not None and 'JOBDIR' in os.environ:
			jobdir = os.environ['JOBDIR']
			pid = os.environ['PROCESS_ID']
			cname = f'checkpoints{pid}.txt'

			if cname not in os.listdir(jobdir):

				# register job
				if 'JOB_REGISTRY_PATH' in os.environ:
					rpath = os.environ['JOB_REGISTRY_PATH']
					reg = load_yaml(rpath) if os.path.isfile(rpath) else []
					reg.append({
						'timestamp': get_now(),

						'id': os.environ['JOB_ID'].split('#')[-1],
						'num': int(os.environ['JOB_NUM']),
						'proc': int(os.environ['PROCESS_ID']),

						'host': socket.gethostname(),

						'run': save_dir,
						'job': jobdir,
					})
					save_yaml(reg, rpath)

				with open(os.path.join(jobdir, cname), 'w') as f:
					f.write(os.path.basename(save_dir))
				print('[Saved checkpoint dir for restarts]')



