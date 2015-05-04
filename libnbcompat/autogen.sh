#!/bin/sh

rm -rf autom4te.cache config.h.in config.log configure
cp -f /usr/share/libtool/config/install-sh /usr/share/libtool/config/config.* .

autoreconf -ivf
rm -rf autom4te.cache
