from .imports import *
from . import misc


@fig.script('_generic_run', description='run a command specified from a remote client')
def generic_run(cfg: fig.Configuration):
	"""
	Run a command on the cluster.

	Args:
		cfg (fig.Configuration): The configuration object.

	Returns:
		None
	"""
	output_prefix = cfg.pull('output-prefix', '__output_tag_code__')
	command = cfg.pull('command', None)
	result = subprocess.run(command, shell=True, capture_output=True, text=True)
	raw = result.stdout
	output = output_prefix + raw.replace('\n', f'\n{output_prefix}')
	print(output)



def wrap_string(s: str) -> str:
	return s.replace('\\', '\\\\').replace('"', '\\"')



def run_command(command: str, location: str = None, *, output_prefix: str = '__output_tag_code__') -> str:
	if location is None:
		res = subprocess.run(
			command,
			shell=True,
			capture_output=True,
			text=True,
		)
		return res.stdout

	args = {
		'output-prefix': output_prefix,
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

	return '\n'.join(output)



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



