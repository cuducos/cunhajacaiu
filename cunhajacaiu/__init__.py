from flask import Flask, jsonify, render_template
from flask.ext.assets import Bundle, Environment
from flask.ext.script import Manager
from requests import get
from webassets.filter import register_filter
from webassets_browserify import Browserify
from cunhajacaiu.news import News
from cunhajacaiu.stopwatch import Stopwatch

app = Flask('cunhajacaiu')
app.config.from_object('cunhajacaiu.settings')

register_filter(Browserify)
assets = Environment(app)

css_args = dict(filters=('libsass',),
                output='css/app.min.css',
                depends=('**/*.sass',))
css_bundle = Bundle('sass/app.sass', **css_args)
assets.register('css', css_bundle)

js_args = dict(filters=('browserify', 'uglifyjs'),
               output='js/app.min.js',
               depends=('**/*.js', '**/*.jsx'))
js_bundle = Bundle('js/app.js', **js_args)
assets.register('js', js_bundle)

manager = Manager(app)


def get_stopwatch():
    return Stopwatch(app.config['LOWER_HOUSE_VOTING'], app.config['TZ_NAME'])


def get_news():
    return News(app.config['REQUESTS_CACHE_BACKEND'], app.config['REDIS_URL'])


@app.route('/')
def index():
    stopwatch = get_stopwatch()
    news = get_news()
    context = dict(news=list(news.parsed()))
    context.update(stopwatch.as_dict())
    return render_template('home.html', **context)


@app.route('/api/stopwatch/')
def api_stopwatch():
    stopwatch = get_stopwatch()
    return jsonify(**stopwatch.as_dict())


@app.route('/api/news/')
def api_news():
    news = get_news()
    return jsonify(dict(news=list(news.parsed())))
