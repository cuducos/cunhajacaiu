from os import pardir, path
from decouple import config

DEBUG = config('DEBUG', default=False, cast=bool)
BASEDIR = path.abspath(path.join(__file__, pardir, pardir))
SECRET_KEY = config('SECRET_KEY', default='segredo+liso-q-bagre-ensaboado')

LIBSASS_STYLE = 'compressed'
ELM_MAKE_BIN = config('ELM_MAKE_BIN', default='elm-make')
UGLIFYJS_BIN = config('UGLIFYJS_BIN', default='uglifyjs')
STATIC_PATH = path.join(BASEDIR, 'cunhajacaiu', 'static')

GOOGLE_ANALYTICS = config('GOOGLE_ANALYTICS', default='')

ELM_FLAGS = {
    'fallen': config('FALLEN', default='False', cast=bool),
    'voting': config('VOTING', default='2016-04-17T23:37:00-03:00')
}
