from typing import Union, List, Tuple, Dict, Any, Optional
import sys, os
from pathlib import Path

import omnibelt as util
import omnifig as fig



def is_todo(line):
	line = line.strip()
	return len(line) > 0 and line[0] != '#'



# def write_job(cmds: List[str], path: Path, cddir=None, tmpl=None):
#
# 	if tmpl is None:
# 		tmpl = '#!\n{header}\n{job}\n{tail}'
#
# 	if cddir is not None:
# 		tmpl = tmpl.replace('# <header>', f'cd {cddir}')
#
# 	if isinstance(cmds, (list, tuple)):
# 		cmds = '\n'.join(cmds)
#
# 	tmpl = tmpl.replace('<job>', cmds)
#
# 	path.write_text(tmpl)



def default_jobdir():
	jobdir = Path(os.environ.get('HOME', os.getcwd())) / '.mpi_jobs'
	if not jobdir.exists():
		jobdir.mkdir()
	return jobdir

