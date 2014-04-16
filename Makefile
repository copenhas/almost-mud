SHELL=/bin/bash

APP_JS_SRC:=$(shell ls app/**/*.js)
APP_JS_DEV:=$(patsubst %.js, _build/dev/%.js, $(APP_JS_SRC))

JSHINT?=node_modules/jshint/bin/jshint

MODULE_OPTS?=--infer-name
COMPILE_MODULE?=node_modules/es6-module-transpiler/bin/compile-modules

UGLIFYJS_OPTS?=--compress --mangle
UGLIFYJS?=node_modules/uglify-js/bin/uglifyjs

TESTEM?=node_modules/testem/testem.js

default: _build lint _build/prod/app.min.js

ci: default
	$(TESTEM) ci

_build/prod/app.min.js: $(APP_JS_DEV)
	$(UGLIFYJS) $(APP_JS_DEV) $(UGLIFYJS_OPTS) --source-map $@.map --output $@

_build/dev/app/%.js: app/%.js
	$(COMPILE_MODULE) $< --to _build/dev $(MODULE_OPTS)

_build:
	mkdir _build

lint:
	$(JSHINT) .

clean:
	rm -rf _build