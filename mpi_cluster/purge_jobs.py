
import sys, os, shutil
from pathlib import Path

import sys, os
import shutil

import omnibelt as util

import omnifig as fig

from . import misc



@fig.autoscript('purge-jobs', description='Clears the jobs directory')
def purge_jobs(jobdir=None, skip_confirm=False):
	if jobdir is None:
		jobdir = misc.default_jobdir()
	if jobdir is not None:
		jobdir = Path(jobdir)

	if not skip_confirm:
		response = input(f'really empty {jobdir} (y/[n]) ? ')
		if response.lower() != 'y':
			print('Did nothing.')
			return 0
	
	if jobdir.exists():
		return 0
	
	shutil.rmtree(jobdir)
	os.mkdir(jobdir)
	
	print(f'{jobdir} purged.')

	return 0



if __name__ == '__main__':
	fig.entry('purge-jobs')


