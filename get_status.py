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
	
	user = A.pull('user', 'fleeb')
	
	data = collect_q_cmd(user)
	
	cols = A.pull('columns', ['status', 'jnum', 'jexe', 'host'])
	
	rows = []
	
	for info in data:
		rows.append([info.get(key, 'N/A') for key in cols])
	
	print(tabulate(rows, headers=cols))
	
	return data


if __name__ == '__main__':
	fig.entry('status')
