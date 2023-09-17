
SUBMISSION_FORMAT = '''executable = /bin/sh
args = {exec}
getenv = True
error = {err}
output = {out}
log = {log}
queue {procs}'''

GPU_NAMES = {
	'2080': 'GeForce RTX 2080 Ti',
	'2080ti': 'GeForce RTX 2080 Ti',
	'2080Ti': 'GeForce RTX 2080 Ti',
	
	'K80': 'Tesla K80',
	
	'K20': 'Tesla K20Xm',
	
	'V100-16': 'Tesla V100-PCIE-16GB',
	
	'V100-32-pci': 'Tesla V100-PCIE-32GB',
	'V100-32-PCI': 'Tesla V100-PCIE-32GB',
	'V100-32-p': 'Tesla V100-PCIE-32GB',
	
	'V100-32-s': 'Tesla V100-SXM2-32GB',
	'V100-32-sxm': 'Tesla V100-SXM2-32GB',
	'V100-32-sxm2': 'Tesla V100-SXM2-32GB',
	'V100-32-SXM': 'Tesla V100-SXM2-32GB',
	'V100-32-SXM2': 'Tesla V100-SXM2-32GB',
	'V100-32': 'Tesla V100-SXM2-32GB',

	'A100': 'NVIDIA A100-SXM-80GB',
	'A100-80': 'NVIDIA A100-SXM4-80GB',
	'A100-40': 'NVIDIA A100-SXM4-40GB',
	
	'P40': 'Tesla P40',
	'P100': 'Tesla P100-PCIE-16GB',
	'quadro': 'Quadro RTX 6000',
	'Quadro': 'Quadro RTX 6000',
}

COLATTRS = ['ClusterId', 'ProcId', 'JobStatus', 'Args', 'RemoteHost']

STATUS_CODES = {
	'0': 'Unexpanded',
	'1': 'Idle',
	'2': 'Running',
	'3': 'Removed',
	'4': 'Completed',
	'5': 'Held',
	'6': 'Submission_err',
	
}




