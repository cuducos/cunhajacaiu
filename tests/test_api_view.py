from datetime import datetime
from dateutil.tz import gettz
from json import loads
from tests import FlaskTestCase
from unittest.mock import patch
from arrow import Arrow


class TestGet(FlaskTestCase):

    def setUp(self):
        super().setUp()
        self.resp = self.app.get('/api/stopwatch/')

    def test_status(self):
        self.assertEqual(200, self.resp.status_code)

    def test_content_type(self):
        self.assertIn('application/json', self.resp.headers['Content-Type'])

    @patch('cunhajacaiu.stopwatch.Stopwatch.get_now')
    def test_json(self, mocked_now):

        # patch now inside the Stopwatch object
        tz = gettz('America/Sao_Paulo')
        now = datetime(2016, 4, 29, hour=15, minute=38, second=8, tzinfo=tz)
        mocked_now.return_value = Arrow.fromdatetime(now)

        # make a new request
        resp = self.app.get('/api/stopwatch/')
        json_resp = loads(resp.data.decode('utf-8'))

        # assertions
        keys = ('days', 'hours', 'minutes', 'seconds')
        values = (11, 16, 1, 8)
        with self.subTest():
            for key, value in zip(keys, values):
                self.assertIn(key, json_resp)
                self.assertEqual(json_resp[key], value)
