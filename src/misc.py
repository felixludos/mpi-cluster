
import sys, os

import omnibelt as util




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