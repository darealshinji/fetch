#!/bin/sh

rm -rf autom4te.cache config.h.in config.log configure Makefile
autoreconf -ivf
rm -rf autom4te.cache
