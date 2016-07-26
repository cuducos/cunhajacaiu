from datetime import datetime
from dateutil.tz import gettz
from tests import FlaskTestCase
from unittest.mock import patch
from arrow import Arrow


class TestGet(FlaskTestCase):

    def setUp(self):
        super().setUp()
        self.resp = self.app.get('/')

    def test_status(self):
        self.assertEqual(200, self.resp.status_code)

    def test_content_type(self):
        self.assertIn('text/html', self.resp.headers['Content-Type'])

    @patch('cunhajacaiu.stopwatch.Stopwatch.get_now')
    def test_html(self, mocked_now):

        # patch now inside the Stopwatch object
        tz = gettz('America/Sao_Paulo')
        now = datetime(2016, 4, 29, hour=15, minute=38, second=8, tzinfo=tz)
        mocked_now.return_value = Arrow.fromdatetime(now)

        # make a new request
        resp = self.app.get('/')
        html_resp = resp.data.decode('utf-8')

        # assertions
        expected = (('<title>Cunha já caiu?</title>', 1),
                    ('<div id="elm"', 1))
        with self.subTest():
            for content, count in expected:
                self.assertIn(content, html_resp, count)
