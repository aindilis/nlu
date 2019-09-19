#!/usr/bin/make -f

SYSNAME=nlu

configure: configure-stamp

configure-stamp:
	touch configure-stamp

build: build-stamp

build-stamp: configure-stamp 
	touch build-stamp

clean:
	find . | grep '~$$' | xargs rm

install:
	cp ${SYSNAME} $(DESTDIR)/usr/bin/
	cp -ar data/*.raw $(DESTDIR)/usr/share/$(SYSNAME)/data
	cp -ar NLU NLU.pm $(DESTDIR)/usr/share/perl5

.PHONY: build clean install configure
