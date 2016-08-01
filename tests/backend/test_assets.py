from tests.backend import FlaskTestCase
import cunhajacaiu.assets


class TestStylesheet(FlaskTestCase):

    def setUp(self):
        super().setUp()
        self.resp = self.app.get('/static/css/app.min.css')

    def test_status(self):
        self.assertEqual(200, self.resp.status_code)

    def test_content_type(self):
        self.assertIn('text/css', self.resp.headers['Content-Type'])


class TestJavascript(FlaskTestCase):

    def setUp(self):
        super().setUp()
        self.resp = self.app.get('/static/js/app.min.js')

    def test_status(self):
        self.assertEqual(200, self.resp.status_code)

    def test_content_type(self):
        mimetype = self.resp.headers['Content-Type']
        self.assertIn('application/javascript', mimetype)
