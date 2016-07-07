from json import loads
from unittest import TestCase
from cunhajacaiu import app


class FlaskTestCase(TestCase):

    def setUp(self):
        app.config['TESTING'] = True
        self.app = app.test_client()


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
