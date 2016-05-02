from flask import Flask
from flask.ext.assets import Bundle, Environment
from flask.ext.script import Manager
from webassets.filter import register_filter
from webassets_browserify import Browserify

# create app
app = Flask('cunhajacaiu')
app.config.from_object('cunhajacaiu.settings')

# create assets
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

# create manager
manager = Manager(app)

# import & register blueprints
from cunhajacaiu.blueprints.home import home
from cunhajacaiu.blueprints.api import api
app.register_blueprint(home)
app.register_blueprint(api, url_prefix='/api')
