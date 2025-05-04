from .imports import *
from . import misc


@fig.autoscript('_generic_run', description='run a command specified from a remote client')
def _generic_run(command, output_prefix='__output_tag_code__', error_prefix='__error_tag_code__'):
# def generic_run(cfg: fig.Configuration):
	"""
	Run a command on the cluster.

	Args:
		cfg (fig.Configuration): The configuration object.

	Returns:
		None
	"""
	# output_prefix = cfg.pull('output-prefix', '__output_tag_code__')
	# error_prefix = cfg.pull('error-prefix', '__error_tag_code__')
	# command = cfg.pull('command', None)
	result = subprocess.run(command, shell=True, capture_output=True, text=True)
	raw = result.stdout
	if len(raw) > 0:
		output = output_prefix + raw.replace('\n', f'\n{output_prefix}')
		print(output)

	raw = result.stderr
	if len(raw) > 0:
		error = error_prefix + raw.replace('\n', f'\n{error_prefix}')
		print(error)

	# sys.stdout.write(output)
	# sys.stdout.flush()
	# sys.stderr.write(error)
	# sys.stderr.flush()

	sys.stdout.flush()




def wrap_string(s: str) -> str:
	return (s.replace('\\', '\\\\').replace('"', '\\"')
			.replace('\n', '\\n').replace('\t', '\\t')
			.replace('$(', '\\$('))


def run_command(command: str, location: str = None, *,
				output_prefix: str = '__output_tag_code__',
				error_prefix: str = '__error_tag_code__') -> Tuple[str, str]:
	if location is None:
		res = subprocess.run(
			command,
			shell=True,
			capture_output=True,
			text=True,
		)
		return res.stdout, res.stderr

	args = {
		'output-prefix': output_prefix,
		'error-prefix': error_prefix,
		'command': command,
	}
	a = ' '.join(f'--{k} "{wrap_string(v)}"' for k, v in args.items())
	r = f"fig _generic_run {a}"
	b = f'bash -ic "{wrap_string(r)}"'
	full = f"ssh {location} '{b}'"

	res = subprocess.run(
		full,
		shell=True,
		capture_output=True,
		text=True,
	)
	raw = res.stdout

	output = []
	for line in raw.split('\n'):
		if line.startswith(output_prefix):
			output.append(line[len(output_prefix):])

	# raw = res.stderr
	errs = []
	for line in raw.split('\n'):
		if line.startswith(error_prefix):
			errs.append(line[len(error_prefix):])

	return '\n'.join(output).strip(), '\n'.join(errs).strip()



_file_cache = misc.repo_root().joinpath('assets', 'file_cache.json')
_file_cache = None
def load_file(path: Path, location: str = None) -> str:
	text = None
	cache = None
	pathcode = str(path).replace('\\', '/')
	if _file_cache is not None:
		cache = load_json(_file_cache)
		if pathcode.replace('\\', '/') in cache:
			return cache[pathcode]
	if location is None:
		if path.exists():
			text = path.read_text()
	else:
		command = f'cat {path}'.replace('\\', '/')
		text = run_command(command, location=location)

	if text is None:
		raise FileNotFoundError(f'File not found: {path}')
	if cache is not None:
		cache[pathcode] = text
		with open(_file_cache, 'w') as f:
			json.dump(cache, f)
	return text



