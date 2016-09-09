import logging
from os import makedirs, path

from webassets.script import CommandLineEnvironment
from cunhajacaiu import assets
from cunhajacaiu.settings import STATIC_PATH

for dir in ('css', 'js'):
    makedirs(path.join(path.abspath(STATIC_PATH), dir), exist_ok=True)

log = logging.getLogger('webassets')
log.addHandler(logging.StreamHandler())
log.setLevel(logging.DEBUG)

cli = CommandLineEnvironment(assets, log)
cli.build()
