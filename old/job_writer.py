import omnifig as fig



class JobManifest(fig.Configurable):
	pass



class JobWriter(fig.Configurable):
	def __init__(self, *, template=None, root=None, **kwargs):
		super().__init__(**kwargs)


	def prepare_job(self):
		raise NotImplementedError


	def prepare_submission(self):
		raise NotImplementedError






















