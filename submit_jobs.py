
import sys, os

import omnifig as fig

def get_header_cmds(A):

	cmds = []

	headers = A.pull('headers', [])
	cmds.extend(headers)

	git_repos = A.pull('git-repos', [])

	for repo in git_repos:
		cmds.append(f'cd {repo}')
		cmds.append('git pull')

	working_dir = A.pull('working-dir', None)
	cmds.append(f'cd {working_dir}')

	return cmds

# @fig.Script('submit', description='Submit jobs to the cluster')
def submit_jobs(A):

	proj = fig.get_project('manager')
	root = A.push('root', proj.root, overwrite=False)

	commands = A.pull('commands', '<>command', None)
	if isinstance(commands, str):
		commands = [commands]

	if commands is None:
		cmd_path = A.pull('command-path', '<>cmd-path', '<>path', None)

		if cmd_path is not None:
			commands = []
			with open(cmd_path, 'r') as f:
				for line in f.read().split('\n'):
					if len(line) and line[0] != '#':
						commands.append(line)

	

	if not len(commands):
		raise Exception('no commands to submit')

	template = A.push('template', None)

	template_path = A.pull('template-path', None)
	if template_path is not None:
		if not os.path.isfile(template_path):
			template_path = os.path.join(root, template_path)

		with open(template_path, 'r') as f:
			template = f.read()

	if template is not None:
		headers = get_header_cmds(A)

		if len(headers):
			template = template.replace('# <header>', '\n'.join(headers))

	if template is None:
		template = '#!\n<job>\n'

	print(f'Will submit {len(commands)} jobs.')

	confirm = A.pull('confirm', True)
	if confirm:
		resp = input(f'Submit {len(commands)} to aws? [y]/n ')
		if resp.lower() in {'n', 'no'}:
			print('Nothing was submitted.')
			return
	A.push('confirm', False, silent=True)



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
