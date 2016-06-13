# Cunha já caiu?

[![Build Status](https://travis-ci.org/cuducos/cunhajacaiu.svg?branch=master)](https://travis-ci.org/cuducos/cunhajacaiu)
[![Coverage Status](https://coveralls.io/repos/github/cuducos/cunhajacaiu/badge.svg?branch=master)](https://coveralls.io/github/cuducos/cunhajacaiu?branch=master)
[![Code Climate](https://codeclimate.com/github/cuducos/cunhajacaiu/badges/gpa.svg)](https://codeclimate.com/github/cuducos/cunhajacaiu)

Brazilian website counting the days to the fall of [Cunha](https://pt.wikipedia.org/wiki/Eduardo_Cunha).

* Official website: [www.cunhajacaiu.com.br](http://www.cunhajacaiu.com.br)
* API entrypoints:
 * Stopwatch: [`/api/stopwatch/`](http://www.cunhajacaiu.com.br/api/stopwatch/)
 * Related news: [`/api/news/`](http://www.cunhajacaiu.com.br/api/news/)
 

## Install

Make sure you are working in an environment with:

* [Python](http://python.org) 3 with `pip`
* [NodeJS](http://nodejs.org) with `npm`
* Optionally (but recommended) a local [Redis](http://redis.io) server

### Dependencies

Install the dependencies:

```console
pip install -r requirements.txt
npm install
```

### Environmental variables

Set up your environmental variables (copy `.env.sample` as `.env` for example). Optionally you can add:

* `BROWSERIFY_BIN`: (_default_: `browserify`) path to the [Broserify](http://browserify.org) binary
* `UGLIFYJS_BIN`: (_default_: `uglifyjs`) path to the [UglifyJS](http://lisperator.net/uglifyjs/) binary
* `HAS_FALLEN` (_default_: `False`) Is Cunha in the office yet?
* `REQUESTS_CACHE_BACKEND`: (_default_: `redis`) [requests-cache](http://requests-cache.readthedocs.io) backend
* `REDIS_URL`: (_default_: `redis://localhost:6379/0`) access to your Redis server
* `GOOGLE_ANALYTICS`: Google Analytics tracking code ID (e.g. `UA-XXXXXX-XX`)
* `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `FLASKS3_BUCKET_NAME`, `FLASKS3_REGION`, : Amazon S3 credentials to be consumed by [Flask-S3](https://flask-s3.readthedocs.io/)

### Ready, set, go

Now you can start your server:

```console
FLASK_APP=cunhajacaiu/__init__.py flask run
```

## Test, develop and contribute

Tests are implemented with [Nose](https://nose.readthedocs.io/) and and _Pull Requests_ are always welcomed.

First install some development dependencies then run the tests (optionally with [Coverage](https://coverage.readthedocs.org) and [rednose](https://github.com/JBKahn/rednose)):

```console
pip install -r requirements-dev.txt
nosetests --rednose --with-cover --cover-html --cover-package cunhajacaiu
```

## License

Copyright (c) 2016 Eduardo Cuducos.

Licensed under the [MIT license](LICENSE).
