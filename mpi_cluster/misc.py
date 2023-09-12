from typing import Union, List, Tuple, Dict, Any, Optional
import sys, os
from pathlib import Path

import omnibelt as util


def is_todo(line):
	line = line.strip()
	return len(line) > 0 and line[0] != '#'


def write_job(cmds, path, cddir=None, tmpl=None):
	
	if tmpl is None:
		tmpl = '#!\n# <header>\n<job>'
	
	if cddir is not None:
		tmpl = tmpl.replace('# <header>', f'cd {cddir}')
	
	if isinstance(cmds, (list, tuple)):
		cmds = '\n'.join(cmds)
	
	tmpl = tmpl.replace('<job>', cmds)
	
	with open(path, 'w') as f:
		f.write(tmpl)


def default_jobdir():
	jobdir = Path(os.environ.get('HOME', os.getcwd())) / '.mpi_jobs'
	if not jobdir.exists():
		jobdir.mkdir()
	return jobdir