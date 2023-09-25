
import sys, os
import subprocess

from datetime import datetime

# import omnibelt as belt

from .cluster import STATUS_CODES, COLATTRS



def parse_jobexec(raw, info): # processes the job name/path -> remove
	*root, jdir, jexe = raw.split('/')

	info['name'] = jdir

	return info


def parse_remotehost(raw):
	s, g = raw.split('.')[0].split('@')
	s = s.split('_')[-1]
	return f'{s}{g}'


def parse_job_status(raw):
	info = {}
	
	if 'ClusterId' in raw:
		info['cID'] = raw['ClusterId']
	
	if 'ProcId' in raw:
		info['proc'] = raw['ProcId']
	
	if 'proc' in info and 'cID' in info:
		info['ID'] = '{}.{}'.format(info['cID'], info['proc'])
	
	if 'JobStatus' in raw:
		info['status'] = STATUS_CODES.get(raw['JobStatus'], raw['JobStatus'])
	
	if 'Args' in raw:
		parse_jobexec(raw['Args'], info)
	
	if 'RemoteHost' in raw:
		try:
			info['host'] = parse_remotehost(raw['RemoteHost'])
		except Exception:
			info['host'] = raw['RemoteHost']
	
	return info


def collect_q_cmd(user, silent=False):
	if not silent:
		print('Getting job status ... ', end='')
	
	try:
		
		# raw = subprocess.check_output(['condor_q', 'fleeb', '-af', 'ClusterId', 'ProcId', 'Args', 'JobStatus', 'RemoteHost', 'Env'])
		raw = subprocess.check_output(['condor_q', user, '-af:t'] + COLATTRS).decode()
	
	except FileNotFoundError:
		if not silent:
			print('FAILED')
		return None
	
	if len(raw) == 0:
		if not silent:
			print('No jobs running.')
		return None
	else:
		lines = raw.split('\n')
		if not silent:
			print(f'found {len(lines) - 1} jobs')
	
	# print(lines)
	
	active = [parse_job_status(dict(zip(COLATTRS, line.split('\t')))) for line in lines if len(line)]
	
	return active

