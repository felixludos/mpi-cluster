
import sys, os, shutil

import sys, os
import shutil

import omnibelt as util

import omnifig as fig

from cluster_src import fmt_jobdir

@fig.AutoScript('purge-jobs', description='Clears the jobs directory')
def purge_jobs(jobdir=None, skip_confirm=False):

	jobdir = fmt_jobdir(jobdir)
	
	if not skip_confirm:
		response = input(f'really empty {jobdir} (y/[n]) ? ')
		if response.lower() != 'y':
			print('Did nothing.')
			return 0
	
	if os.path.isfile(jobdir):
		return 0
	
	shutil.rmtree(jobdir)
	os.mkdir(jobdir)
	
	print(f'{jobdir} purged.')

	return 0

if __name__ == '__main__':
	fig.entry('purge-jobs')


