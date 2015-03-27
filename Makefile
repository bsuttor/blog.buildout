#!/usr/bin/make
#
all: run

bootstrap.py:
	wget http://downloads.buildout.org/2/bootstrap.py

bin/python:
	virtualenv-2.7 --no-site-packages .

bin/buildout: bin/python bootstrap.py
	./bin/python bootstrap.py

.PHONY: buildout
buildout: bin/buildout
	bin/buildout -Nt 7

.PHONY: heroku
heroku: bin/buildout
	bin/buildout -Nt 7 -c heroku.cfg

.PHONY: run
run: buildout
	bin/instance fg

.PHONY: push2heroku
push2heroku:
	git push heroku master

.PHONY: cleanall
cleanall:
	rm -fr develop-eggs downloads eggs parts .installed.cfg lib include bin .mr.developer.cfg
