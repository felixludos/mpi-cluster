from typing import Any, Dict, List, Optional, Tuple, Type
import omnifig as fig


@fig.script('launch')
def launch_llm(cfg: fig.Configuration):
	pass


@fig.script('serving', description='Get information about currently active servers')
def view_serving(cfg: fig.Configuration):
	raise NotImplementedError
	pass









