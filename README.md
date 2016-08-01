# Cunha já caiu?

[![Build Status](https://travis-ci.org/cuducos/cunhajacaiu.svg?branch=master)](https://travis-ci.org/cuducos/cunhajacaiu)
[![Coverage Status](https://coveralls.io/repos/github/cuducos/cunhajacaiu/badge.svg?branch=master)](https://coveralls.io/github/cuducos/cunhajacaiu?branch=master)
[![Code Climate](https://codeclimate.com/github/cuducos/cunhajacaiu/badges/gpa.svg)](https://codeclimate.com/github/cuducos/cunhajacaiu)

Brazilian website counting the days to the fall of [Cunha](https://pt.wikipedia.org/wiki/Eduardo_Cunha): [www.cunhajacaiu.com.br](http://www.cunhajacaiu.com.br)
 
## Install

Make sure you are working in an environment with:

* [Python](http://python.org) 3 with `pip`
* [NodeJS](http://nodejs.org) with `npm`

### Dependencies

Install the dependencies:

```console
$ pip install -r requirements.txt
$ npm i
```

### Environmental variables

Set up your environmental variables (copy `.env.sample` as `.env` for example). Optionally you can add:

* `ELM_MAKE_BIN`: (_default_: `elm-make`) path to the `elm-make` binary from [Elm](http://elm-lang.org)
  (installed via `npm` by default)
* `UGLIFYJS_BIN`: (_default_: `uglifyjs`) path to the `uglifyjs` binary from [UglifyJS2](https://github.com/mishoo/UglifyJS2)
  (installed via `npm` by default)
* `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `FLASKS3_BUCKET_NAME`, `FLASKS3_REGION`, : Amazon S3 credentials to be consumed by [Flask-S3](https://flask-s3.readthedocs.io/)

* `GOOGLE_ANALYTICS`: Google Analytics tracking code ID (e.g. `UA-XXXXXX-XX`)


### Ready, set, go

Now you can start your server. According to [Flask's new CLI](http://flask.pocoo.org/docs/0.11/cli/) set the `FLASK_APP` environment variable pointint to the entrypoint of the application and you're good to go:

```console
$ export FLASK_APP=cunhajacaiu/__init__.py
$ flask run
```



## Test, develop and contribute

_Pull Requests_ are always welcomed.

Running tests requires [Nose](https://nose.readthedocs.io/) and [elm-test](https://github.com/elm-community/elm-test) (but at this point they are already installed for you).


```console
$ nosetests
$ npm test
```

## License

Copyright (c) 2016 Eduardo Cuducos.

Licensed under the [MIT license](LICENSE).
