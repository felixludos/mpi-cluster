import sys, os, shutil
import yaml
import subprocess
from datetime import datetime
from tabulate import tabulate

import omnifig as fig

from src import fmt_jobdir


@fig.Script('status', description='check the status of jobs submitted to the cluster')
def get_status(A):
	collect_q_cmd()
	
	pass


def old_get_status(jobdir=None, save_dir=None):
	
	jobdir = fmt_jobdir(jobdir)
	
	if save_dir is None:
		if 'FOUNDATION_SAVE_DIR' in os.environ:
			save_dir = os.environ['FOUNDATION_SAVE_DIR']
		else:
			print('WARNING: no trained nets path found')
	
	
	
	pass

if __name__ == '__main__':
	fig.entry('status')
