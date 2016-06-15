import logging
from webassets.script import CommandLineEnvironment
from cunhajacaiu import assets

log = logging.getLogger('webassets')
log.addHandler(logging.StreamHandler())
log.setLevel(logging.DEBUG)

cli = CommandLineEnvironment(assets, log)
cli.build()
