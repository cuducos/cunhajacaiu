from json import loads
from unittest import TestCase
from cunhajacaiu import app


class FlaskTestCase(TestCase):

    def setUp(self):
        app.config['TESTING'] = True
        self.app = app.test_client()
