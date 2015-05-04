BMAKE   := bmake
INSTALL := install
PREFIX  := /usr/local
RM      := rm -f


all: source/fetch

clean:
	cd source && $(BMAKE) clean
	cd libfetch && $(BMAKE) clean
	cd libnbcompat && $(BMAKE) clean

distclean:
	cd source && $(BMAKE) distclean
	cd libfetch && $(BMAKE) distclean
	cd libnbcompat && $(BMAKE) distclean

clobber: distclean
	cd source && $(RM) config.* configure install-sh Makefile
	cd libnbcompat && $(RM) nbcompat/config.h.in* config.* configure install-sh


source/fetch: libfetch/libfetch.a source/configure
	cd source && ./configure
	cd source && $(BMAKE)

source/configure:
	cd source && ./autogen.sh


libfetch/libfetch.a: libnbcompat/nbcompat/nbconfig.h
	cd libfetch && $(BMAKE) ftperr.h httperr.h
	cd libfetch && $(BMAKE)


libnbcompat/nbcompat/nbconfig.h: libnbcompat/configure
	cd libnbcompat && ./configure
	cd libnbcompat && $(BMAKE) nbcompat/nbconfig.h

libnbcompat/configure:
	cd libnbcompat && ./autogen.sh


install:
	$(INSTALL) -d $(DESTDIR)$(PREFIX)/bin
	$(INSTALL) -d $(DESTDIR)$(PREFIX)/share/man/man1
	$(INSTALL) -D -m755 source/fetch $(DESTDIR)$(PREFIX)/bin
	$(INSTALL) -D -m644 source/fetch.1 $(DESTDIR)$(PREFIX)/share/man/man1

