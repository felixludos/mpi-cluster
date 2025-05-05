from .imports import *
from .misc import repo_root
from .remote_helpers import run_command
from .op import create_jobs


def is_cluster(name: str) -> bool:
	"""
	Determine if the given name is the cluster (requiring jobs to be submitted)

	on the MPI cluster the name will be login1.internal.cluster.is.localnet
	"""
	return name.endswith("cluster.is.localnet")



def get_gpu_info(location: str = None) -> Optional[List[Dict[str, Union[str, int]]]]:
	cmd = 'nvidia-smi --query-gpu=name,memory.total --format=csv,noheader,nounits'

	raw, _ = run_command(cmd, location=location)
	if raw.strip() == '':
		return None

	devices = raw.strip().split('\n')
	devices = [{'name': name.strip(), 'ram': int(ram.strip())} for name, ram in (d.split(',') for d in devices)]
	return devices



@fig.script('launch', description='Launch a vllm server through the cluster (usually remote)')
def launch_llm(cfg: fig.Configuration):
	silent = cfg.pull('silent', False, silent=True)
	cfg.silent = silent

	me = socket.gethostname()
	full_me = socket.getfqdn()
	user = cfg.pull('user', None)
	host = cfg.pull('host', None)
	if host is not None:
		assert user is not None, f'host is specified, but user is not'
	location = f'{user}@{host}' if user is not None and host is not None else None
	launch_location = full_me if location is None else location
	launch_on_cluster = is_cluster(launch_location)

	_local_msg = 'launching locally' if host is None else 'launch in job' if is_cluster(host) else f'launch on {host}'
	print(f'Currently on {me} - {_local_msg}')

	gpu_devices = get_gpu_info(location)
	total_gpu_ram = sum([d['ram'] for d in gpu_devices]) if gpu_devices is not None else 0

	model = cfg.pull('model', None)

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

		while model is None:
			model = input('Select a model> ').strip()
			if model not in available:
				try:
					model = int(model)
				except ValueError:
					model = None
				else:
					if model < 0 or model >= len(items):
						model = None
					else:
						model = items[model]['key']

	vllm_dir = cfg.pull('vllm-dir', '/home/fleeb/workspace/code/clones/vllm')

	settings = acc.get(model, None)
	if settings is None:
		raise KeyError(f'no such model settings found {model}')

	model_name = settings['model']

	port = cfg.pull('port', 8000)

	command = f'fig vllm --model {model_name} --port {port} {settings["command"]}'.format(vllm_dir=vllm_dir)
	resources = settings['resources']

	# cfg.push('command', command, silent=True)
	for k, v in resources.items():
		cfg.push(k, v, silent=True)

	# print('command would be:', command)
	# command = 'echo "Hello world"'

	return create_jobs(cfg, commands=command, location=location, confirm=True)



# @fig.script('serving', description='Get information about currently active servers')
def view_serving(cfg: fig.Configuration):
	raise NotImplementedError




@fig.script('vllm', description='vLLM OpenAI-Compatible RESTful API server')
def launch_vllm_server(cfg: fig.Configuration):
	"""
	Launch a vLLM server through the cluster.

	Args:
		cfg (fig.Configuration): The configuration object.

	Returns:
		None
	"""

	#

	import shlex
	raw_args = cfg.pull(silent=True)

	argv = []
	for k, v in raw_args.items():
		if k.startswith('_'):
			continue

		if isinstance(v, str):
			v = shlex.quote(v)
			# v = f'"{v.replace("\\", "\\\\").replace("\"", "\\\"")}"'
		if isinstance(v, bool):
			if v:
				argv.append(f"--{k}")
		else:
			argv.append(f"--{k}={v}")

	# print(argv)

	import threading
	from vllm.entrypoints.openai.api_server import logger, VLLM_VERSION, \
		build_app, build_async_engine_client, init_app_state, validate_parsed_serve_args, \
		serve_http, create_server_socket, set_ulimit, TIMEOUT_KEEP_ALIVE, ToolParserManager, \
		ReasoningParserManager, FlexibleArgumentParser, make_arg_parser, \
		is_valid_ipv6_address, cli_env_setup, signal, os, uvloop

	async def run_server(args, **uvicorn_kwargs) -> None:
		logger.info("vLLM API server version %s", VLLM_VERSION)
		logger.info("args: %s", args)

		if args.tool_parser_plugin and len(args.tool_parser_plugin) > 3:
			ToolParserManager.import_tool_parser(args.tool_parser_plugin)

		valid_tool_parses = ToolParserManager.tool_parsers.keys()
		if args.enable_auto_tool_choice \
			and args.tool_call_parser not in valid_tool_parses:
			raise KeyError(f"invalid tool call parser: {args.tool_call_parser} "
						f"(chose from {{ {','.join(valid_tool_parses)} }})")

		valid_reasoning_parses = ReasoningParserManager.reasoning_parsers.keys()
		if args.reasoning_parser \
			and args.reasoning_parser not in valid_reasoning_parses:
			raise KeyError(
				f"invalid reasoning parser: {args.reasoning_parser} "
				f"(chose from {{ {','.join(valid_reasoning_parses)} }})")

		# workaround to make sure that we bind the port before the engine is set up.
		# This avoids race conditions with ray.
		# see https://github.com/vllm-project/vllm/issues/8204
		sock_addr = (args.host or "", args.port)
		sock = create_server_socket(sock_addr)

		# workaround to avoid footguns where uvicorn drops requests with too
		# many concurrent requests active
		set_ulimit()

		def signal_handler(*_) -> None:
			# Interrupt server on sigterm while initializing
			raise KeyboardInterrupt("terminated")

		signal.signal(signal.SIGTERM, signal_handler)

		async with build_async_engine_client(args) as engine_client:
			app = build_app(args)

			@app.post("/shutdown")
			async def shutdown():
				"""Gracefully stop Uvicorn and the engine."""
				def _stop():
					print("Shutting down vLLM …")
					os.kill(os.getpid(), signal.SIGINT)   # lets Uvicorn close cleanly
				threading.Thread(target=_stop).start()
				return {"message": "Server is shutting down..."}


			vllm_config = await engine_client.get_vllm_config()
			await init_app_state(engine_client, vllm_config, app.state, args)

			def _listen_addr(a: str) -> str:
				if is_valid_ipv6_address(a):
					return '[' + a + ']'
				return a or "0.0.0.0"

			is_ssl = args.ssl_keyfile and args.ssl_certfile
			logger.info("Starting vLLM API server on http%s://%s:%d",
						"s" if is_ssl else "", _listen_addr(sock_addr[0]),
						sock_addr[1])

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
				timeout_keep_alive=TIMEOUT_KEEP_ALIVE,
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

	cli_env_setup()
	parser = FlexibleArgumentParser(
		description="vLLM OpenAI-Compatible RESTful API server.")
	parser = make_arg_parser(parser)

	# parser.set_defaults(**raw_args)
	args = parser.parse_args(argv)

	# args = parser.parse_args()
	validate_parsed_serve_args(args)

	uvloop.run(run_server(args))






