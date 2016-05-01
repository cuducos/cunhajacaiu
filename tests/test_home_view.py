from datetime import datetime
from dateutil.tz import gettz
from tests import FlaskTestCase, MockJsonNewsResponse
from unittest.mock import patch
from arrow import Arrow


class TestGet(FlaskTestCase):

    @patch('cunhajacaiu.news.requests.get')
    def setUp(self, mocked_get):
        super().setUp()
        mocked_get.return_value = MockJsonNewsResponse
        self.resp = self.app.get('/')

    def test_status(self):
        self.assertEqual(200, self.resp.status_code)

    def test_content_type(self):
        self.assertIn('text/html', self.resp.headers['Content-Type'])

    @patch('cunhajacaiu.news.requests.get')
    @patch('cunhajacaiu.stopwatch.Stopwatch.get_now')
    def test_html(self, mocked_now, mocked_get):

        # patch requests library
        mocked_get.return_value = MockJsonNewsResponse

        # patch now inside the Stopwatch object
        tz = gettz('America/Sao_Paulo')
        now = datetime(2016, 4, 29, hour=15, minute=38, second=8, tzinfo=tz)
        mocked_now.return_value = Arrow.fromdatetime(now)

        # make a new request
        resp = self.app.get('/')
        html_resp = resp.data.decode('utf-8')

        # assertions
        expected = (('<h1>Cunha já caiu?</h1>', 1),
                    ('<img src="/static/imgs/no.png" alt="Não">', 1),
                    ('<div id="stopwatch"', 1),
                    ('data-days="11"', 1),
                    ('data-hours="16"', 1),
                    ('data-minutes="1"', 1),
                    ('data-seconds="8"', 1),
                    ('Eduardo Cunha reclama da rapidez das investigações', 1),
                    ('gazetadopovo.com.br', 2),
                    ('Após reprovar filha de Eduardo Cunha, funcionário ', 1),
                    ('oglobo.globo.com', 2))
        with self.subTest():
            for content, count in expected:
                self.assertIn(content, html_resp, count)
