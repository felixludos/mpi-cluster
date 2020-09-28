
import sys, os

import omnibelt as util


def write_job(cmds, path, cddir=None, tmpl=None):
	
	if tmpl is None:
		tmpl = '#!\n# <header>\n<job>'
	
	if cddir is not None:
		tmpl.replace('# <header>', f'cd {cddir}')
	
	if isinstance(cmds, (list, tuple)):
		cmds = '\n'.join(cmds)
	
	tmpl.replace('<job>', cmds)
	
	with open(path, 'w') as f:
		f.write(tmpl)


def fmt_jobdir(jobdir=None):
	_def = ''
	if jobdir is None:
		_def = ' default'
		jobdir = os.path.join(os.environ['HOME'], 'jobdir') if 'HOME' in os.environ else \
			os.path.join(os.getcwd(), 'jobdir')
	jobdir = os.path.abspath(jobdir)
	util.create_dir(jobdir)
	print(f'Using{_def} job dir: {jobdir}')
	return jobdir