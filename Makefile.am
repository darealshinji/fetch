SUBDIRS = source

autoclean: maintainer-clean
	rm -rf build-aux source/libnbcompat/build-aux
	rm -f aclocal.m4 configure Makefile.in
	cd source && rm -f config.h.in* Makefile.in libfetch/Makefile.in
	cd source/libnbcompat && rm -f nbcompat/config.h.in* aclocal.m4 configure Makefile.in
