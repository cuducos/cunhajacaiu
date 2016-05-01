from arrow import Arrow
from os import pardir, path
from decouple import config

DEBUG = config('DEBUG', default=False, cast=bool)
BASEDIR = path.abspath(path.join(__file__, pardir, pardir))
SECRET_KEY = config('SECRET_KEY', default='segredo+liso-q-bagre-ensaboado')

LIBSASS_STYLE = 'compressed'
UGLIFYJS_BIN = config('UGLIFYJS_BIN', default='uglifyjs')
BROWSERIFY_BIN = config('BROWSERIFY_BIN', default='browserify')

REQUESTS_CACHE_BACKEND = config('REQUESTS_CACHE_BACKEND', default='redis')
REDIS_URL = config('REDIS_URL', default='redis://localhost:6379/0')

GOOGLE_ANALYTICS = config('GOOGLE_ANALYTICS', default='')

TZ_NAME = 'America/Sao_Paulo'

LOWER_HOUSE_VOTING = Arrow(2016, 4, 17, hour=23, minute=37, tzinfo=TZ_NAME)
