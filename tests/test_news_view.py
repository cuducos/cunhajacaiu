from json import loads
from tests import FlaskTestCase, MockJsonNewsResponse
from unittest.mock import patch


class TestGet(FlaskTestCase):

    @patch('cunhajacaiu.news.requests.get')
    def setUp(self, mocked_get):
        super().setUp()
        mocked_get.return_value = MockJsonNewsResponse()
        self.resp = self.app.get('/api/news/')

    def test_status(self):
        self.assertEqual(200, self.resp.status_code)

    def test_content_type(self):
        self.assertIn('application/json', self.resp.headers['Content-Type'])

    def test_json(self):
        fields = ('domain', 'url', 'title')
        json_resp = loads(self.resp.data.decode('utf-8'))
        news = json_resp['news']
        with self.subTest():
            self.assertEqual(2, len(news))
            for news_item in news:
                for field in fields:
                    self.assertIn(field, news_item)
