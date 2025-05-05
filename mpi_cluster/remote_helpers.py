from .imports import *
from . import misc


@fig.autoscript('_generic_run', description='run a command specified from a remote client')
def _generic_run(command, output_prefix='__output_tag_code__', error_prefix='__error_tag_code__', append_path=None):
# def generic_run(cfg: fig.Configuration):
	"""
	Run a command on the cluster.

	Args:
		cfg (fig.Configuration): The configuration object.

	Returns:
		None
	"""
	if append_path is not None:
		print(f'Appending to {append_path}:\n{command}')
		append_path = Path(append_path)
		with append_path.open('a') as f:
			f.write(command)
		return

	result = subprocess.run(command, shell=True, capture_output=True, text=True)
	raw = result.stdout
	if len(raw) > 0:
		output = output_prefix + raw.replace('\n', f'\n{output_prefix}')
		print(output)

	raw = result.stderr
	if len(raw) > 0:
		error = error_prefix + raw.replace('\n', f'\n{error_prefix}')
		print(error)

	sys.stdout.flush()



def wrap_string(s: str) -> str:
			# .replace('$', '\\$').replace('#!', '\\#!'))
			# .replace('$(', '\\$(').replace('$?{', '\\${'))
	return (s.replace('\\', '\\\\').replace('"', '\\"')
			.replace('\n', '\\n').replace('\t', '\\t'))



def run_command(command: str, location: str = None, *, append_path: Optional[Path] = None,
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
		'output_prefix': output_prefix,
		'error_prefix': error_prefix,
		'command': command,
	}
	if append_path is not None:
		args['append_path'] = str(append_path).replace('\\', '/')
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



def write_to_file(text: str, path: Path, location=None):
	if location is None:
		path.write_text(text)
	else:
		with tempfile.NamedTemporaryFile(delete=False, mode='w', suffix='.sh') as tmp:
			tmp.write(text)
			tmp_path = tmp.name

		try:
			# 3. Copy the script to the remote server
			subprocess.run(
				f'scp {tmp_path} {location}:{path}',
				shell=True,
			capture_output=True,
				check=True
			)
		finally:
			# 5. Clean up the local temp file
			os.remove(tmp_path)

	return path


def append_to_file(text: str, path: Path, location=None):
	run_command(f'"{wrap_string(text)}"', location=location, append_path=wrap_string(str(path)))



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
		text, _ = run_command(command, location=location)

	if text is None:
		raise FileNotFoundError(f'File not found: {path}')
	if cache is not None:
		cache[pathcode] = text
		with open(_file_cache, 'w') as f:
			json.dump(cache, f)
	return text



