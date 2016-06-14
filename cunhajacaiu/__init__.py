from flask import Flask
from flask_assets import Bundle, Environment
from flask_cors import CORS
from webassets.filter import register_filter
from webassets_elm import Elm

# create app
app = Flask('cunhajacaiu')
app.config.from_object('cunhajacaiu.settings')

# set CORS headers
CORS(app, resources={r'/api/*': {'origins': '*'}})

# create assets
register_filter(Elm)
assets = Environment(app)

css_args = dict(filters=('libsass',),
                output='css/app.min.css',
                depends=('**/*.sass',))
css_bundle = Bundle('sass/app.sass', **css_args)
assets.register('css', css_bundle)

js_args = dict(filters=('elm', 'rjsmin'),
               output='js/app.min.js',
               depends=('**/*.elm',))
js_bundle = Bundle('elm/Stopwatch.elm', **js_args)
assets.register('js', js_bundle)

# add amazon s3 via flask-s3
if app.config['FLASKS3_BUCKET_NAME'] and not app.debug:
    import flask_s3
    flask_s3.FlaskS3(app)
    flask_s3.create_all(app, filepath_filter_regex=r'^js\/|^css\/|^imgs\/')

# import & register blueprints
from cunhajacaiu.blueprints.home import home
from cunhajacaiu.blueprints.api import api
app.register_blueprint(home)
app.register_blueprint(api, url_prefix='/api')
