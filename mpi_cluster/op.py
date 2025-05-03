from .imports import *
from .status import collect_q_cmd



@fig.script('_generic_run', description='run a command specified from a remote client')
def generic_run(cfg: fig.Configuration):
	"""
	Run a command on the cluster.

	Args:
		cfg (fig.Configuration): The configuration object.

	Returns:
		None
	"""

	output_prefix = cfg.pull('output-prefix', '[output-tag-code]')

	command = cfg.pull('command', None)
	# command = json.loads(command)
	if isinstance(command, str):
		command = [command]

	try:
		result = subprocess.run(command, capture_output=True, text=True)
	except FileNotFoundError:
		return None

	raw = result.stdout
	print(raw)

	output = output_prefix + raw.replace('\n', f'\n{output_prefix}')
	print(output)



def run_command(command, location=None, output_prefix='&^&') -> str:
	if location is None:
		raw = subprocess.check_output(command, shell=True).decode()
		return raw

	# gold = [
	# 		"ssh",
	# 		"fleeb@login.cluster.is.localnet",
	# 		'bash -ic "fig _generic_run --output-prefix \\\"@~@\\\" --command \\\"condor_q fleeb -af:t ClusterId ProcId JobStatus Args RemoteHost\\\""'
	# 	]
	# gold = ' '.join(gold)
	# print(gold)


	# output_prefix = f'"{output_prefix}"'.replace('\\', '\\\\').replace('"', '\\"')

	print(' '.join(command))
	command_data = ' '.join(command).replace('"', '\\"')
	run_command_lines = ['fig _generic_run',
				   rf'--output-prefix "{output_prefix}"',
				   rf'--command "{command_data}"']

	print(' '.join(run_command_lines))
	cmd = ' '.join(run_command_lines).replace('"', '\\"')

	# location = f'{user}@{host}'


	ssh_command = ['ssh', location, f"bash -ic \"{cmd}\""]

	print(' '.join(ssh_command))

	try:
		# raw = subprocess.check_output(ssh_command, shell=True).decode()
		result = subprocess.run(ssh_command, capture_output=True, text=True)
	except FileNotFoundError:
		return None

	raw = result.stdout

	print(raw)

	output = []
	for line in raw.split('\n'):
		if line.startswith(output_prefix):
			output.append(line[len(output_prefix):])

	return '\n'.join(output)



@fig.script('status', description='check the status of jobs submitted to the cluster')
def get_status(cfg: fig.Configuration):
	"""
	Get the status of jobs submitted to the cluster.

	Args:
		cfg (fig.Configuration): The configuration object.

	Returns:
		None
	"""

	# result = subprocess.run(
	# 	[
	# 		"ssh",
	# 		"fleeb@login.cluster.is.localnet",
	# 		'bash -ic "fig _generic_run --output-prefix \\\"@~@\\\" --command \\\"condor_q fleeb -af:t ClusterId ProcId JobStatus Args RemoteHost\\\""'
	# 	],
	# 	capture_output=True,
	# 	text=True  # auto-decodes to string using system default encoding (usually UTF-8)
	# )

	# # print("STDOUT:\n", result.stdout)
	# # print("STDERR:\n", result.stderr)
	# out = result.stdout
	# print(out)
	# print(repr(out))
	# return

	user = 'fleeb'
	location = "fleeb@login.cluster.is.localnet"

	q_command = ['condor_q', user, '-af:t'] + ['ClusterId', 'ProcId', 'JobStatus', 'Args', 'RemoteHost']
	q_command = ['echo', '"Hello"']

	output = run_command(q_command, location=location)

	return output

	host = cfg.pull('remote-host', None)
	user = cfg.pull('user')

	if host is None:
		location = None
	else:
		assert user is not None
		location = f'{user}@{host}'

	q_command = ['condor_q', user, '-af:t'] + ['ClusterId', 'ProcId', 'JobStatus', 'Args', 'RemoteHost']

	output = run_command(q_command, location=location)

	print(output)
























