import sys, os, shutil
import yaml
import subprocess
from datetime import datetime
from tabulate import tabulate

import omnifig as fig

from src import fmt_jobdir, collect_q_cmd
from src.cluster import COLATTRS


@fig.Script('status', description='check the status of jobs submitted to the cluster')
def get_status(A):
	
	silent = A.pull('silent', False, silent=True)
	
	user = A.pull('user', 'fleeb', silent=silent)
	
	cols = A.pull('columns', ['status', 'jnum', 'ID', 'host'], silent=silent)
	
	data = collect_q_cmd(user, silent=silent)
	
	rows = []
	
	if data is not None:
		for info in data:
			rows.append([info.get(key, 'N/A') for key in cols])
		
		print(tabulate(rows, headers=cols))
	
	return data


if __name__ == '__main__':
	fig.entry('status')
