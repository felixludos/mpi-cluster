import argparse
import io
import os, re
from contextlib import asynccontextmanager

import humanize
import sshtunnel
from http import HTTPStatus

from .imports import *
from .misc import repo_root
from .remote_helpers import run_command, append_to_file, load_file
from .op import create_jobs


def is_cluster(name: str) -> bool:
	# regex pattern that matches: "login.cluster.is.localnet", "login1.internal.cluster.is.localnet", "login2.internal.cluster.is.localnet"...
	pattern = r"^login\d*(?:\.internal)?\.cluster\.is\.localnet$"
	return bool(re.match(pattern, name.split('@')[-1]))


def is_on_cluster(name: str) -> bool:
	# regex pattern that matches: "g121.internal.cluster.is.localnet", "login.internal.cluster.is.localnet"...
	pattern = r"^g\d+\.internal\.cluster\.is\.localnet$"
	return bool(re.match(pattern, name.split('@')[-1]))



def get_gpu_info(location: str = None) -> Optional[List[Dict[str, Union[str, int]]]]:
	cmd = 'nvidia-smi --query-gpu=name,memory.total --format=csv,noheader,nounits'

	raw, _ = run_command(cmd, location=location)
	if raw.strip() == '':
		return None

	devices = raw.strip().split('\n')
	devices = [{'name': name.strip(), 'ram': int(ram.strip())} for name, ram in (d.split(',') for d in devices)]
	return devices


@fig.script('vllm-ids')
def vllm_ids(cfg: fig.Configuration):
	"""
	Get the list of available vllm ids.

	Args:
		cfg (fig.Configuration): The configuration object.

	Returns:
		None
	"""

	details = cfg.pulls('details', 'verbose', 'v', default=False, silent=True)

	acc_path = repo_root().joinpath('assets', 'vllm-settings.yml')
	acc = load_yaml(acc_path)

	if details:
		for key, item in acc.items():
			print(f'{colorize(key, "green")}')
			print(tabulate([(arg, val) for arg, val in item.items()], headers=['Param', 'Value']))
			print()

	nametbl = [(key, item.get('model')) for key, item in acc.items()]
	cfg.print(tabulate(nametbl, headers=['ID', 'Model']))

	return acc


@fig.script('launch', description='Launch a vllm server through the cluster (usually remote)')
def launch_llm(cfg: fig.Configuration):
	silent = cfg.pull('silent', False, silent=True)
	cfg.silent = silent

	me = socket.gethostname()
	full_me = socket.getfqdn()
	user = cfg.pull('user', None)
	host = cfg.pull('loc', None)
	if host is not None:
		assert user is not None, f'host is specified, but user is not'
	location = f'{user}@{host}' if user is not None and host is not None else None
	launch_location = full_me if location is None else location
	launch_on_cluster = is_cluster(launch_location)

	_local_msg = 'launching locally' if host is None else 'launch as job on cluster' \
		if is_cluster(host) else f'launch on {host}'
	print(f'Currently on {me} - {_local_msg}')

	ident = cfg.pulls('ident', 'id', default=None)

	gpu_devices = get_gpu_info(location)
	total_gpu_ram = sum([d['ram'] for d in gpu_devices]) if gpu_devices is not None else 0

	acc_path = repo_root().joinpath('assets', 'vllm-settings.yml')
	acc = load_yaml(acc_path)

	available = cfg.pull('available', False, silent=True)
	if available:
		def format_gpu_req(resources):
			n = resources.get('gpu', 0)
			if n == 0:
				return '-'
			m = resources.get('gpu-ram')
			if n == 1:
				return '?' if m is None else f'{m}'
			return f'{n}x?' if m is None else f'{n}x{m}'

		items = [{'key': key, 'model': item['model'], 'gpu-req': format_gpu_req(item['resources']),
				   'compatible': launch_on_cluster
						or total_gpu_ram >= item['resources'].get('gpu-ram',0)*item['resources'].get('gpu',1)*1024}
				  for key, item in acc.items()]
		items = sorted(items, key=lambda x: (not x['compatible'], x['model'], x['key']))
		for i, item in enumerate(items):
			item['index'] = i

		tbl = [
			[item['index'], colorize(item['key'], 'yellow'), item['model'], item['gpu-req']]
		for item in items]
		print(tabulate(tbl))

		while ident is None:
			ident = input('Select a ident> ').strip()
			if ident not in available:
				try:
					ident = int(ident)
				except ValueError:
					ident = None
				else:
					if ident < 0 or ident >= len(items):
						ident = None
					else:
						ident = items[ident]['key']

	vllm_dir = cfg.pull('vllm-dir', '/home/fleeb/workspace/code/clones/vllm')
	hf_dir = cfg.pull('hf-dir', '/fast/fleeb/huggingface_cache/hub')

	settings = acc.get(ident, {})
	if settings is None:
		raise KeyError(f'no such model settings found {ident!r}')
	
	# should use flattened settings (for deeper updates)
	arginfo = load_json(repo_root().joinpath('assets', 'vllm_args.json'))
	argdefaults = {info['name']: info['default'] for info in arginfo if info['default'] is not None}

	specified_args = collect_vllm_args(cfg, arginfo)

	# set union of settings and specified args
	allargs = set(settings.keys()).union(specified_args.keys())

	tbl = [(key, settings.get(key, argdefaults.get(key, '')), specified_args.get(key, settings.get(key, ''))) for key in allargs]
	print('Settings:')
	print(tabulate(tbl, headers=['Arg', 'Default', 'Specified']))

	settings.update(specified_args)

	known_vllm_args = set(key for items in acc.values() for key in items.keys())
	update = {}
	novalue = object()
	for key in known_vllm_args:
		value = cfg.pull(key, novalue, silent=True)
		if value is not novalue:
			update[key] = value
	if len(update) > 0:
		print(f'Overriding {len(update)} vllm args:\n{tabulate(update.items())}')
		settings.update(update)

	port = cfg.pull('port', None)

	args = settings
	args.update({k: v.format(vllm_dir=vllm_dir, hf_dir=hf_dir) for k, v in args.items() if isinstance(v, str)})

	if port is not None:
		args['port'] = port
	# model_name = args['model']

	if launch_on_cluster:
		resources = settings.pop('resources', {})
		terms = argdict2argv({f'--{k}':v for k,v in args.items()})
		arg_str = ' '.join(shlex.quote(v) if isinstance(v, str) else v for v in terms)

		command = f'fig vllm {arg_str}'

		# cfg.push('command', command, silent=True)
		for k, v in resources.items():
			cfg.push(k, v, overwrite=False, silent=True)

		return create_jobs(cfg, commands=command, location=location)

	elif location is not None:
		raise NotImplementedError

	else:
		return fig.quick_run('vllm', **args)


import asyncio
import httpx
import socket
import signal
from sshtunnel import SSHTunnelForwarder
from rich.live import Live
from rich.table import Table
from rich import box

def make_serving_table(data, columns, online_only=False):
	if not isinstance(columns, dict):
		columns = {col: {} for col in columns}
	# table = Table(title="Server Status", box=box.SIMPLE_HEAVY)
	table = Table(box=box.SIMPLE_HEAVY)
	for col, style in columns.items():
		table.add_column(col, **style)
	# table.add_column("Server", style="cyan", no_wrap=True)
	# table.add_column("Status", style="bold")
	status_color = {'ended': 'grey', 'error': 'red', 'unknown': 'red', 'offline': 'grey',
					'loading': 'blue', 'waiting': 'cyan', 'online': 'green'}
	def _display(item, key, val):
		if key == 'live':
			if val is None and item['status'] == 'online' and 'live' in item['events']:
				val = (datetime.now() - item['events']['live']).total_seconds() #/ 3600
			return '--' if val is None else humanize.naturaldelta(val)
		if key == 'startup':
			return '--' if val is None else f'{val/60:.1f}'
			return '--' if val is None else humanize.naturaldelta(val)
		if isinstance(val, float):
			return f'{val:.2f}'
		if key == 'started':
			# return '--' if val is None else val.strftime('%b-%-d %H:%M:%S')
			return '--' if val is None else val.strftime('%b %-d %H:%M')
		if key == 'status':
			return f'[{status_color.get(val,"red")}]{val.upper()}'
		if key == 'loc':
			if item['host'] is None:
				return 'localhost'
			return item['host'].split('.')[0]
		if key == 'address':
			if item['status'] in {'offline', 'ended', 'error'}:
				return '--'
			if item['needs_tunnel']:
				return item.get('tunnel', '--')
			return item.get('url', '--')
		if val is None:
			return '--'
		return str(val)

	if online_only:
		data = [item for item in data if item['status'] not in {'offline', 'ended', 'error'}]

	data = sort_serving_data(data)

	for item in data:
		table.add_row(*[_display(item, col, item.get(col)) for col in columns.keys()],
					  style="grey50" if item['status'] in {'offline', 'ended', 'error'} else "white")
	return table

def sort_serving_data(data):
	status_order = ['online', 'loading', 'waiting', 'error']#, 'unknown', 'ended', 'offline']
	now = datetime.now()
	data.sort(key=lambda item: (status_order.index(item['status'])
							 if item['status'] in status_order else len(status_order),
								now - (item['started'] or now),
								item.get('live') or 0, item['url']))
	return data


def load_serving_log(path, location=None):
	def compute_status(info):
		events = info['events']
		if 'end' in events:
			return 'ended' # ended correctly without error
		if 'error' in events:
			return 'error' # there was some error
		if 'offline' in events:
			return 'offline' # server is confirmed offline
		if 'live' in events:
			return 'waiting' # server should be live, but not confirmed yet
		if 'start' in events:
			return 'loading' # server is starting up
		return 'unknown'
	def compute_startup(info):
		if 'start' in info['events'] and 'live' in info['events']:
			return (info['events']['live'] - info['events']['start']).total_seconds() #/ 60
	def compute_duration(info):
		if 'live' in info['events'] and ('end' in info['events'] or 'error' in info['events']):
			return (info['events'].get('end', info['events'].get('error')) - info['events']['live']
					).total_seconds() #/ 60 / 60
	def compute_url(info):
		if 'live' in info['events']:
			return f"http://{info.get('host', 'localhost')}:{info['port']}"
	def compute_started(info):
		if 'start' in info['events']:
			return info['events']['start']
		# if 'live' in info['events']:
		# 	return info['events']['live']
	def compute_needs_tunnel(info):
		if 'live' in info['events']:
			return info.get('host', 'localhost') != info['location'].split('@')[-1]
		return False
	def filter_model_name(info):
		name = info.get('model', '')
		if name.startswith('/fast/fleeb/huggingface_cache/hub/'):
			name = name.split('/snapshots', 1)[0].split('/')[-1].replace('models--', '').replace('--', '/')
		return name
	feats = {
		'status': compute_status,
		'startup': compute_startup,
		'started': compute_started,
		'live': compute_duration,
		'url': compute_url,
		'needs_tunnel': compute_needs_tunnel,
		'model': filter_model_name,
	}

	columns = ['event', 'timestamp', 'model', 'host', 'port', 'pid', 'id']
	props = ['model', 'host', 'port', 'pid', 'id']

	items = {}

	try:
		text = load_file(path, location)
	except FileNotFoundError:
		return items

	for line in text.split('\n'):
		if line.strip() == '':
			continue
		info = {key: val for key, val in zip(columns, line.split('\t'))}
		if info['id'] not in items:
			items[info['id']] = {**{key: info[key] for key in props}, 'location': location, 'events': {}}
		if info['event'] in items[info['id']]['events']:
			raise ValueError(f'{info} already exists in {items[info["id"]]}')
		items[info['id']]['events'][info['event']] = datetime.strptime(info['timestamp'], '%y%m%d-%H%M%S')

	for item in items.values():
		for k, f in feats.items():
			item[k] = f(item)

	return items

# async def check_server(url):
#     try:
#         async with httpx.AsyncClient(timeout=3.0) as client:
#             response = await client.get(url)
#             status_map[url]["code"] = response.status_code
#             status_map[url]["response_time"] = int(response.elapsed.total_seconds() * 1000)
#             status_map[url]["status"] = "[green]running" if response.status_code < 500 else "[red]offline"
#     except Exception:
#         status_map[url]["status"] = "[red]offline"
#         status_map[url]["code"] = "-"
#         status_map[url]["response_time"] = "-"

@fig.script('all-offline', description='Set all servers to offline (declutter serving)')
def set_all_offline(cfg: fig.Configuration):
	silent = cfg.pull('silent', False, silent=True)
	cfg.silent = silent

	logpath = cfg.pull('logpath', '~/vllm.log')
	locations = cfg.pull('locations', [])
	if isinstance(locations, list):
		locations = {loc: logpath for loc in locations}
	locations[None] = logpath

	now = datetime.now().strftime('%y%m%d-%H%M%S')

	fixes = Counter({loc: 0 for loc in locations})

	for loc, path in locations.items():
		updates = []
		items = load_serving_log(path, loc)
		for item in items.values():
			if item['status'] == 'waiting' or item['status'] == 'loading':
				line = ['offline', now, item['model'], item['host'], item['port'], item['pid'], item['id']]
				updates.append('\t'.join(map(str, line)))
		if updates:
			append_to_file('\n'.join(updates) + '\n', path, location=loc)
			fixes[loc] += len(updates)

	total = sum(fixes.values())
	print(f'Set {total} entries to offline')
	if total:
		print(tabulate([[loc, count] for loc, count in fixes.items() if count > 0], headers=['Location', 'Count']))



@fig.script('serving', description='Get information about currently active servers')
def view_serving(cfg: fig.Configuration):
	# headless = cfg.pull('headless', False, silent=True) # TODO
	silent = cfg.pull('silent', False, silent=True)
	cfg.silent = silent

	scan_freq = cfg.pull('scan', 60)

	only_active = cfg.pull('only-active', False)

	logpath = cfg.pull('logpath', '~/vllm.log')
	locations = cfg.pull('locations', [])
	if isinstance(locations, list):
		locations = {loc: logpath for loc in locations}
	locations[None] = logpath

	# autotunnel = cfg.pull('tunnel', True)
	# _default_columns = ['status', 'live', 'model', 'url', 'tunnel'] if autotunnel
	columns = cfg.pull('columns', ['status', 'model', 'loc', 'address', 'started', 'live', 'startup'])
	columns = {col: {} for col in columns}
	if 'status' in columns:
		columns['status']['justify'] = 'cyan'
	if 'model' in columns:
		columns['model']['no_wrap'] = True
		columns['model']['style'] = 'bold'
	if 'url' in columns:
		columns['url']['no_wrap'] = True
	if 'address' in columns:
		columns['address']['no_wrap'] = True

	# tunnel as needed
	tunnels = []
	tunnel_base = cfg.pull('tunnel-base', 8001)
	def is_port_free(port, host='localhost'):
		with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
			return s.connect_ex((host, port)) != 0
	def get_free_port():
		nonlocal tunnel_base
		port = tunnel_base
		while not is_port_free(port):
			port += 1
		assert port < 65535, f'no free port found starting from {tunnel_base}'
		tunnel_base = port + 1
		return port
	def create_tunnel(item, localport=None):
		if localport is None:
			localport = get_free_port()
		location = item.get('location')
		assert location is not None
		user, host = location.split('@')
		# no tunnel needed if host is the same
		# this should maybe confirm that pinging the host directly works
		assert host != item['host'], f'host {item["host"]} is the same as location {location}'

		with redirect_stderr(io.StringIO()), redirect_stdout(io.StringIO()):
			tunnel = SSHTunnelForwarder(
				ssh_address_or_host=(host, 22),
				ssh_username=user,
				ssh_pkey='~/.ssh/id_rsa',
				allow_agent=False,
				remote_bind_address=(item['host'], int(item['port'])),
				local_bind_address=('localhost', localport),
			)
			try:
				tunnel.start()
			except sshtunnel.BaseSSHTunnelForwarderError:
				return None
			else:
				item['tunnel'] = f'http://localhost:{localport}'
				item['tunnel_obj'] = tunnel
				return tunnel

	# view serving
	async def check_server(item):
		try:
			while True:# item['status'] == 'waiting':
				if item.get('needs_tunnel', item['location'] is not None):
					if 'tunnel' not in item:
						create_tunnel(item)
					url = item['tunnel']
				else:
					url = item['url']
				async with httpx.AsyncClient(timeout=3.0) as client:
					response = await client.get(f'{url}/ping')
					if response.status_code < 500:
						item['status'] = 'online'
						return
					elif item['status'] == 'waiting':
						break
					# not sure what other outcomes there are
				await asyncio.sleep(1)
		except asyncio.CancelledError:
			return
		except:
			pass
		item['status'] = 'offline'
		if 'tunnel_obj' in item:
			item['tunnel_obj'].stop()
			del item['tunnel'], item['tunnel_obj']

	stop_event = asyncio.Event()
	def handle_sigint():
		stop_event.set()

	async def view_serving():
		progress = {}
		tasks = []
		try:
			with Live(make_serving_table([], columns, online_only=only_active), refresh_per_second=4) as live:
				while scan_freq is not None and scan_freq > 0:
					log = []
					for loc, path in locations.items():
						log.extend(load_serving_log(path, loc).values())

					if only_active:
						log = [item for item in log if item['status'] in {'online', 'loading', 'waiting'}]

					todo = [item for item in log if item['status'] == 'waiting']
					for item in todo:
						if item['id'] in progress:
							item['status'] = progress[item['id']]['status']
							if 'tunnel' in progress[item['id']]:
								item['tunnel'] = progress[item['id']]['tunnel']
								item['tunnel_obj'] = progress[item['id']]['tunnel_obj']

					tasks.extend(asyncio.create_task(check_server(item)) for item in todo)

					while any(not task.done() for task in tasks):
						await asyncio.sleep(0.5)
						live.update(make_serving_table(log, columns, online_only=only_active))
					await asyncio.gather(*tasks)
					tasks.clear()
					# print("\033c", end="")
					# height = shutil.get_terminal_size().lines
					# print("\n" * height)
					live.update(make_serving_table(log, columns, online_only=only_active))  # final update

					progress.update({item['id']: item for item in log})

		except (KeyboardInterrupt, asyncio.CancelledError):
			print("\n[!] Keyboard interrupt received. Exiting...")
			for task in tasks:
				task.cancel()
			await asyncio.gather(*tasks)
		else:
			loop = asyncio.get_running_loop()
			loop.add_signal_handler(signal.SIGINT, handle_sigint)
			print("[Not scanning] Press Ctrl+C to stop...")
			await stop_event.wait()
			print("\n[!] Keyboard interrupt received. Exiting...")

		for item in log:
			if 'tunnel_obj' in item:
				item['tunnel_obj'].stop()
				del item['tunnel'], item['tunnel_obj']
		print("Cleanup complete.")
		return log

	log = asyncio.run(view_serving())
	return log



def argdict2argv(args: Dict[str, Any]) -> List[str]:
	argv = []
	for k, v in args.items():
		if k.startswith('_'):
			continue
		if isinstance(v, str):
			v = shlex.quote(v)
		if isinstance(v, bool):
			if v:
				argv.append(f"{k}")
		else:
			argv.append(k)
			argv.append(str(v))
	return argv


def collect_vllm_args(cfg: fig.Configuration, arginfo) -> Dict[str, Any]:
	argvals = {}

	empty = object()
	for info in arginfo:
		value = cfg.pull(info['name'], empty, silent=True)
		if value is not argparse.SUPPRESS and value is not empty:
			argvals[info['name']] = value

	return argvals


def apply_vllm_args(cfg: fig.Configuration, parser) -> Dict[str, Any]:
	arginfo = [{'name': action.dest.replace('_', '-'), 'option': action.option_strings[0],
				'default': action.default}
			   for action in parser._actions if action.dest != 'help' and action.option_strings]

	name2option = {info['name']: info['option'] for info in arginfo}

	rawargs = collect_vllm_args(cfg, arginfo)

	argv = argdict2argv({name2option[k]: v for k, v in rawargs.items()})
	print('Equivalent `vllm` command:')
	print(f'vllm serve {" ".join(map(shlex.quote,argv))}')

	args = parser.parse_args(argv)
	return args



@fig.script('vllm', description='vLLM OpenAI-Compatible RESTful API server')
def start_vllm_server(cfg: fig.Configuration):
	"""
	Launch a vLLM server through the cluster.

	Args:
		cfg (fig.Configuration): The configuration object.

	Returns:
		None
	"""

	host = socket.getfqdn()

	model = cfg.pull('model')
	port = cfg.pull('port', 8000)

	logpath = cfg.pull('logpath', '~/vllm.log')
	logpath = Path(logpath).expanduser().resolve().absolute()

	import secrets
	import os

	jobid = os.environ.get('JOB_ID', secrets.token_hex(4))
	print(f'Job ID: {jobid}')
	pid = os.getpid()

	# begin startup

	# log server launch with columns: [event, timestamp, model, host, port, pid, jobid]
	launch_message = ['start', datetime.now().strftime('%y%m%d-%H%M%S'), model, host, port, pid, jobid]
	if not cfg.pull('dump-args', False, silent=True):
		with logpath.open('a') as f:
			f.write('\t'.join(map(str, launch_message)) + '\n')

	import threading
	from vllm.entrypoints.openai.api_server import (logger, build_async_engine_client, init_app_state,
		validate_parsed_serve_args, serve_http, ToolParserManager, FlexibleArgumentParser, make_arg_parser,
		cli_env_setup, signal, os, uvloop, envs, setup_server, load_log_config, lifespan, Namespace, FastAPI,
		router, mount_metrics, CORSMiddleware, HTTPException, Request, ErrorResponse, JSONResponse,
		RequestValidationError, AuthenticationMiddleware, XRequestIdMiddleware, iterate_in_threadpool,
		importlib, inspect)

	# @asynccontextmanager
	async def time_lifespand(app):
		"""Lifespan context manager for the app."""
		async with lifespan(app):
			# startup complete
			live_message = ['live', datetime.now().strftime('%y%m%d-%H%M%S'), model, host, port, pid, jobid]
			with logpath.open('a') as f:
				f.write('\t'.join(map(str, live_message)) + '\n')
			yield
			# shutdown starting
			# shutdown_message = ['shutdown', datetime.now().strftime('%y%m%d-%H%M%S'), model, host, port, pid, jobid]
			# with logpath.open('a') as f:
			# 	f.write('\t'.join(map(str, shutdown_message)) + '\n')

	def build_app(args: Namespace) -> FastAPI:
		if args.disable_fastapi_docs:
			app = FastAPI(openapi_url=None,
						  docs_url=None,
						  redoc_url=None,
						  lifespan=time_lifespand)
		else:
			app = FastAPI(lifespan=time_lifespand)
		app.include_router(router)
		app.root_path = args.root_path

		mount_metrics(app)

		app.add_middleware(
			CORSMiddleware,
			allow_origins=args.allowed_origins,
			allow_credentials=args.allow_credentials,
			allow_methods=args.allowed_methods,
			allow_headers=args.allowed_headers,
		)

		@app.exception_handler(HTTPException)
		async def http_exception_handler(_: Request, exc: HTTPException):
			err = ErrorResponse(message=exc.detail,
								type=HTTPStatus(exc.status_code).phrase,
								code=exc.status_code)
			return JSONResponse(err.model_dump(), status_code=exc.status_code)

		@app.exception_handler(RequestValidationError)
		async def validation_exception_handler(_: Request,
											   exc: RequestValidationError):
			exc_str = str(exc)
			errors_str = str(exc.errors())

			if exc.errors() and errors_str and errors_str != exc_str:
				message = f"{exc_str} {errors_str}"
			else:
				message = exc_str

			err = ErrorResponse(message=message,
								type=HTTPStatus.BAD_REQUEST.phrase,
								code=HTTPStatus.BAD_REQUEST)
			return JSONResponse(err.model_dump(),
								status_code=HTTPStatus.BAD_REQUEST)

		# Ensure --api-key option from CLI takes precedence over VLLM_API_KEY
		if token := args.api_key or envs.VLLM_API_KEY:
			app.add_middleware(AuthenticationMiddleware, api_token=token)

		if args.enable_request_id_headers:
			app.add_middleware(XRequestIdMiddleware)

		if envs.VLLM_DEBUG_LOG_API_SERVER_RESPONSE:
			logger.warning("CAUTION: Enabling log response in the API Server. "
						   "This can include sensitive information and should be "
						   "avoided in production.")

			@app.middleware("http")
			async def log_response(request: Request, call_next):
				response = await call_next(request)
				response_body = [
					section async for section in response.body_iterator
				]
				response.body_iterator = iterate_in_threadpool(iter(response_body))
				logger.info("response_body={%s}",
							response_body[0].decode() if response_body else None)
				return response

		for middleware in args.middleware:
			module_path, object_name = middleware.rsplit(".", 1)
			imported = getattr(importlib.import_module(module_path), object_name)
			if inspect.isclass(imported):
				app.add_middleware(imported)  # type: ignore[arg-type]
			elif inspect.iscoroutinefunction(imported):
				app.middleware("http")(imported)
			else:
				raise ValueError(f"Invalid middleware {middleware}. "
								 f"Must be a function or a class.")

		return app

	# reference: vllm\entrypoints\openai\api_server.py

	async def run_server(args, **uvicorn_kwargs) -> None:
		"""Run a single-worker API server."""
		listen_address, sock = setup_server(args)
		await run_server_worker(listen_address, sock, args, **uvicorn_kwargs)

	async def run_server_worker(listen_address,
								sock,
								args,
								client_config=None,
								**uvicorn_kwargs) -> None:
		"""Run a single API server worker."""

		if args.tool_parser_plugin and len(args.tool_parser_plugin) > 3:
			ToolParserManager.import_tool_parser(args.tool_parser_plugin)

		server_index = client_config.get("client_index", 0) if client_config else 0

		# Load logging config for uvicorn if specified
		log_config = load_log_config(args.log_config_file)
		if log_config is not None:
			uvicorn_kwargs['log_config'] = log_config

		async with build_async_engine_client(args, client_config) as engine_client:
			app = build_app(args)

			@app.get("/shutdown")
			async def shutdown():
				"""Gracefully stop Uvicorn and the engine."""
				def _stop():
					print("Received shutdown request …")
					os.kill(os.getpid(), signal.SIGINT)   # lets Uvicorn close cleanly
				threading.Thread(target=_stop).start()
				return 'Shutting down server.'

			vllm_config = await engine_client.get_vllm_config()
			await init_app_state(engine_client, vllm_config, app.state, args)

			logger.info("Starting vLLM API server %d on %s", server_index,
						listen_address)
			shutdown_task = await serve_http(
				app,
				sock=sock,
				enable_ssl_refresh=args.enable_ssl_refresh,
				host=args.host,
				port=args.port,
				log_level=args.uvicorn_log_level,
				# NOTE: When the 'disable_uvicorn_access_log' value is True,
				# no access log will be output.
				access_log=not args.disable_uvicorn_access_log,
				timeout_keep_alive=envs.VLLM_HTTP_TIMEOUT_KEEP_ALIVE,
				ssl_keyfile=args.ssl_keyfile,
				ssl_certfile=args.ssl_certfile,
				ssl_ca_certs=args.ssl_ca_certs,
				ssl_cert_reqs=args.ssl_cert_reqs,
				**uvicorn_kwargs,
			)

		# NB: Await server shutdown only after the backend context is exited
		try:
			await shutdown_task
		finally:
			sock.close()

	# #########
	# async def run_server(args, **uvicorn_kwargs) -> None:
	# 	logger.info("vLLM API server version %s", VLLM_VERSION)
	# 	logger.info("args: %s", args)
	#
	# 	if args.tool_parser_plugin and len(args.tool_parser_plugin) > 3:
	# 		ToolParserManager.import_tool_parser(args.tool_parser_plugin)
	#
	# 	valid_tool_parses = ToolParserManager.tool_parsers.keys()
	# 	if args.enable_auto_tool_choice \
	# 		and args.tool_call_parser not in valid_tool_parses:
	# 		raise KeyError(f"invalid tool call parser: {args.tool_call_parser} "
	# 					f"(chose from {{ {','.join(valid_tool_parses)} }})")
	#
	# 	valid_reasoning_parses = ReasoningParserManager.reasoning_parsers.keys()
	# 	if args.reasoning_parser \
	# 		and args.reasoning_parser not in valid_reasoning_parses:
	# 		raise KeyError(
	# 			f"invalid reasoning parser: {args.reasoning_parser} "
	# 			f"(chose from {{ {','.join(valid_reasoning_parses)} }})")
	#
	# 	# workaround to make sure that we bind the port before the engine is set up.
	# 	# This avoids race conditions with ray.
	# 	# see https://github.com/vllm-project/vllm/issues/8204
	# 	sock_addr = (args.host or "", args.port)
	# 	sock = create_server_socket(sock_addr)
	#
	# 	# workaround to avoid footguns where uvicorn drops requests with too
	# 	# many concurrent requests active
	# 	set_ulimit()
	#
	# 	def signal_handler(*_) -> None:
	# 		# Interrupt server on sigterm while initializing
	# 		raise KeyboardInterrupt("terminated")
	#
	# 	signal.signal(signal.SIGTERM, signal_handler)
	#
	# 	async with build_async_engine_client(args) as engine_client:
	# 		app = build_app(args)
	#
	# 		@app.get("/shutdown")
	# 		async def shutdown():
	# 			"""Gracefully stop Uvicorn and the engine."""
	# 			def _stop():
	# 				print("Received shutdown request …")
	# 				os.kill(os.getpid(), signal.SIGINT)   # lets Uvicorn close cleanly
	# 			threading.Thread(target=_stop).start()
	# 			return 'Shutting down server.'
	#
	# 		vllm_config = await engine_client.get_vllm_config()
	# 		await init_app_state(engine_client, vllm_config, app.state, args)
	#
	# 		def _listen_addr(a: str) -> str:
	# 			if is_valid_ipv6_address(a):
	# 				return '[' + a + ']'
	# 			return a or "0.0.0.0"
	#
	# 		is_ssl = args.ssl_keyfile and args.ssl_certfile
	# 		logger.info("Starting vLLM API server on http%s://%s:%d",
	# 					"s" if is_ssl else "", _listen_addr(sock_addr[0]),
	# 					sock_addr[1])
	#
	# 		shutdown_task = await serve_http(
	# 			app,
	# 			sock=sock,
	# 			enable_ssl_refresh=args.enable_ssl_refresh,
	# 			host=args.host,
	# 			port=args.port,
	# 			log_level=args.uvicorn_log_level,
	# 			# NOTE: When the 'disable_uvicorn_access_log' value is True,
	# 			# no access log will be output.
	# 			access_log=not args.disable_uvicorn_access_log,
	# 			# timeout_keep_alive=TIMEOUT_KEEP_ALIVE,
	# 			ssl_keyfile=args.ssl_keyfile,
	# 			ssl_certfile=args.ssl_certfile,
	# 			ssl_ca_certs=args.ssl_ca_certs,
	# 			ssl_cert_reqs=args.ssl_cert_reqs,
	# 			**uvicorn_kwargs,
	# 		)
	#
	# 	# NB: Await server shutdown only after the backend context is exited
	# 	try:
	# 		await shutdown_task
	# 	finally:
	# 		sock.close()

	try:
		cli_env_setup()
		parser = FlexibleArgumentParser(description="vLLM OpenAI-Compatible RESTful API server.")
		parser = make_arg_parser(parser)

		args = apply_vllm_args(cfg, parser)
		# args = parser.parse_args(argv)
		# args = parser.parse_args()

		validate_parsed_serve_args(args)

		uvloop.run(run_server(args))

	except KeyboardInterrupt:
		pass
	except Exception as e:
		err_message = ['error', datetime.now().strftime('%y%m%d-%H%M%S'), model, host, port, pid, jobid]
		with logpath.open('a') as f:
			f.write('\t'.join(map(str, err_message)) + '\n')
		raise e

	# shutdown complete

	# log server shutdown
	end_message = ['end', datetime.now().strftime('%y%m%d-%H%M%S'), model, host, port, pid, jobid]
	with logpath.open('a') as f:
		f.write('\t'.join(map(str, end_message)) + '\n')






