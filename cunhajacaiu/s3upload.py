import flask_s3
from flask.ext.script import Command


class AmazonS3Upload(Command):

    def __init__(self, app=None):
        super().__init__()
        self.app = app

    def run(self):
        if self.app:
            flask_s3.create_all(self.app)
