from json import loads
from os import close, unlink
from tempfile import mkstemp
from unittest import TestCase
from cunhajacaiu import app


class FlaskTestCase(TestCase):

    def setUp(self):

        # set a test db
        self.db_handler, self.db_path = mkstemp()
        app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///' + self.db_path

        # set a testing app
        app.config['TESTING'] = True
        app.config['REQUESTS_CACHE_BACKEND'] = 'memory'
        self.app = app.test_client()

    def tearDown(self):
        close(self.db_handler)
        unlink(self.db_path)


class MockJsonNewsResponse:

    HTTP_STATUS_CODE = (500, 200)
    COUNT = 0

    @staticmethod
    def json():
        with open('tests/news.json') as file_handler:
            return loads(file_handler.read())

    @property
    def status_code(self):
        self.COUNT += 1
        return self.HTTP_STATUS_CODE[self.COUNT - 1]
