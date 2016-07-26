from arrow import Arrow
from os import pardir, path
from decouple import config

DEBUG = config('DEBUG', default=False, cast=bool)
BASEDIR = path.abspath(path.join(__file__, pardir, pardir))
SECRET_KEY = config('SECRET_KEY', default='segredo+liso-q-bagre-ensaboado')

LIBSASS_STYLE = 'compressed'
ELM_MAKE_BIN = config('ELM_MAKE_BIN', default='elm-make')
UGLIFYJS_BIN = config('UGLIFYJS_BIN', default='uglifyjs')

GOOGLE_ANALYTICS = config('GOOGLE_ANALYTICS', default='')

TZ_NAME = 'America/Sao_Paulo'

LOWER_HOUSE_VOTING = Arrow(2016, 4, 17, hour=23, minute=37, tzinfo=TZ_NAME)
HAS_FALLEN = config('HAS_FALLEN', default=False, cast=bool)

FLASKS3_BUCKET_NAME = config('FLASKS3_BUCKET_NAME', default='')
AWS_ACCESS_KEY_ID = config('AWS_ACCESS_KEY_ID', default='')
AWS_SECRET_ACCESS_KEY = config('AWS_SECRET_ACCESS_KEY', default='')
FLASKS3_REGION = config('FLASKS3_REGION', default='')
FLASKS3_FORCE_MIMETYPE = True
FLASK_ASSETS_USE_S3 = True if FLASKS3_BUCKET_NAME else False
