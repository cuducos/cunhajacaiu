from os.path import join

from flask import Flask, render_template
from flask_assets import Bundle, Environment
from webassets.filter import register_filter
from webassets_elm import Elm
from whitenoise import WhiteNoise

# create app
app = Flask('cunhajacaiu')
app.config.from_object('cunhajacaiu.settings')

# config whitenoise
imgs = join(app.config['BASEDIR'], 'cunhajacaiu', 'static', 'imgs')
wsgi = WhiteNoise(app)
for dir in ('css', 'imgs', 'js'):
    wsgi.add_files(join(app.config['STATIC_PATH'], dir), prefix=dir)

# create assets
register_filter(Elm)
assets = Environment(app)

css = Bundle(
    'sass/app.sass',
    depends=('**/*.sass',),
    filters=('libsass',),
    output='css/app.css'
)
elm = Bundle(
    'elm/Main.elm',
    depends=('**/*.elm',),
    filters=('elm', 'uglifyjs',),
    output='js/app.js'
)

assets.register('css', css)
assets.register('elm', elm)


# home view
@app.route('/')
def home():
    return render_template('home.html')
