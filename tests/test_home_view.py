from tests import FlaskTestCase


class TestGet(FlaskTestCase):

    def setUp(self):
        super().setUp()
        self.resp = self.app.get('/')

    def test_status(self):
        self.assertEqual(200, self.resp.status_code)

    def test_content_type(self):
        self.assertIn('text/html', self.resp.headers['Content-Type'])

    def test_html(self):
        expected = (('<title>Cunha já caiu?</title>', 1),
                    ('<div id="elm"', 1))
        with self.subTest():
            for content, count in expected:
                self.assertIn(content, self.resp.data.decode('utf-8'), count)
