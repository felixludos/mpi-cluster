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

	output_prefix = cfg.pull('output-prefix', ')@(')

	command = cfg.pull('command', None)
	# command = json.loads(command)
	if isinstance(command, str):
		command = [command]

	try:
		raw = subprocess.check_output(command).decode()
	except FileNotFoundError:
		return None

	output = output_prefix + raw.replace('\n', f'\n{output_prefix}')
	print(output)



def run_command(command, location=None, output_prefix=')@(') -> str:
	if location is None:
		raw = subprocess.check_output(command).decode()
		return raw

	# command_data = json.dumps(command)
	command_data = ' '.join(command)
	run_command_lines = ['fig _generic_run',
				   f'--output-prefix {output_prefix!r}',
				   f'--command {command_data!r}']
	cmd = ' '.join(run_command_lines)

	# location = f'{user}@{host}'

	ssh_command = ['ssh', location, f'bash -ic {cmd!r}']

	print(' '.join(ssh_command))

	try:
		raw = subprocess.check_output(ssh_command).decode()
	except FileNotFoundError:
		return None

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
























