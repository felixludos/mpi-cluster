
import sys, os
import socket
import yaml

from datetime import datetime

# from omnibelt import get_now

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

		save_dir = os.path.basename(str(self.get_path()))

		if save_dir is not None and 'JOBDIR' in os.environ:
			jobdir = os.environ['JOBDIR']
			pid = os.environ['PROCESS_ID']
			cname = f'checkpoints{pid}.txt'

			if cname not in os.listdir(jobdir):

				# register job
				# if 'JOB_REGISTRY_PATH' in os.environ:
				# 	rpath = os.environ['JOB_REGISTRY_PATH']
				# 	with open(rpath, 'a') as f:
				# 		name, ID = os.environ['JOB_NAME'], os.environ['JOB_ID']
				# 		f.write(f'{name}\t{ID}\t{save_dir}\n')

				# register job
				# if 'JOB_REGISTRY_PATH' in os.environ:
				# 	rpath = os.environ['JOB_REGISTRY_PATH']
				# 	with open(rpath, 'r+') as f:
				#
				# 		reg = yaml.safe_load(f)
				#
				# 		name = os.environ['JOB_NAME']
				#
				# 		spins = reg.get(name, [])
				#
				# 		spins.append({
				# 			'timestamp': datetime.now(),
				#
				# 			'id': os.environ['JOB_ID'].split('#')[-1],
				# 			'num': int(os.environ['JOB_NUM']),
				# 			'proc': int(os.environ['PROCESS_ID']),
				#
				# 			'host': socket.gethostname(),
				#
				# 			'run': save_dir,
				# 			'job': jobdir,
				# 		})
				#
				# 		reg[name] = {
				# 			'start'
				# 		}
				#
				# 	reg = load_yaml(rpath) if os.path.isfile(rpath) else {}
				# 	reg.append()
				# 	save_yaml(reg, rpath)

				with open(os.path.join(jobdir, cname), 'w') as f:
					f.write(save_dir)
				print('[Saved checkpoint dir for restarts]')


# # @fig.AutoModifier('cls-run')
# class OnCluster:
#
# 	def __init__(self, A, silent=False):
#
# 		if 'JOBDIR' in os.environ: # on cluster
#
# 			jobdir = os.environ['JOBDIR']
# 			pid = os.environ['PROCESS_ID']
# 			cname = f'checkpoints{pid}.txt'
#
# 			if cname in os.listdir(jobdir):
# 				with open(os.path.join(jobdir, cname),'r') as f:
# 					name = f.read()
#
# 				print(f'[Found checkpoint from restart: {name}, resuming now]')
#
# 				A.push('resume', name)
#
# 		super().__init__(A, silent=silent)
#
#
# 	def startup(self):
#
# 		super().startup()
#
# 		save_dir = os.path.basename(self.save_dir)
#
# 		if save_dir is not None and 'JOBDIR' in os.environ:
# 			jobdir = os.environ['JOBDIR']
# 			pid = os.environ['PROCESS_ID']
# 			cname = f'checkpoints{pid}.txt'
#
# 			if cname not in os.listdir(jobdir):
#
# 				# register job
# 				# if 'JOB_REGISTRY_PATH' in os.environ:
# 				# 	rpath = os.environ['JOB_REGISTRY_PATH']
# 				# 	with open(rpath, 'a') as f:
# 				# 		name, ID = os.environ['JOB_NAME'], os.environ['JOB_ID']
# 				# 		f.write(f'{name}\t{ID}\t{save_dir}\n')
#
# 				# register job
# 				# if 'JOB_REGISTRY_PATH' in os.environ:
# 				# 	rpath = os.environ['JOB_REGISTRY_PATH']
# 				# 	with open(rpath, 'r+') as f:
# 				#
# 				# 		reg = yaml.safe_load(f)
# 				#
# 				# 		name = os.environ['JOB_NAME']
# 				#
# 				# 		spins = reg.get(name, [])
# 				#
# 				# 		spins.append({
# 				# 			'timestamp': datetime.now(),
# 				#
# 				# 			'id': os.environ['JOB_ID'].split('#')[-1],
# 				# 			'num': int(os.environ['JOB_NUM']),
# 				# 			'proc': int(os.environ['PROCESS_ID']),
# 				#
# 				# 			'host': socket.gethostname(),
# 				#
# 				# 			'run': save_dir,
# 				# 			'job': jobdir,
# 				# 		})
# 				#
# 				# 		reg[name] = {
# 				# 			'start'
# 				# 		}
# 				#
# 				# 	reg = load_yaml(rpath) if os.path.isfile(rpath) else {}
# 				# 	reg.append()
# 				# 	save_yaml(reg, rpath)
#
# 				with open(os.path.join(jobdir, cname), 'w') as f:
# 					f.write(save_dir)
# 				print('[Saved checkpoint dir for restarts]')
#


