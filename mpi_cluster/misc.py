from typing import Union, List, Tuple, Dict, Any, Optional
import sys, os
from pathlib import Path

import omnibelt as util
import omnifig as fig


def package_root():
	return Path(__file__).parent.parent
	

def default_jobdir():
	return Path(os.environ.get('HOME', os.getcwd())) / '.cluster_jobs'

