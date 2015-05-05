CC      := gcc
AWK     := gawk
AR      := ar
RANLIB  := ranlib
INSTALL := install

PREFIX ?= /usr/local

libfetch_OBJS     = fetch.o common.o ftp.o http.o file.o
libfetch_CPPFLAGS = -D_LARGEFILE_SOURCE -D_LARGE_FILES -D_FILE_OFFSET_BITS=64 -DINET6 -DWITH_SSL -DFTP_COMBINE_CWDS



all: fetch

clean:
	rm -rf libnbcompat/autom4te.cache source/autom4te.cache
	rm -f libnbcompat/nbcompat/nbconfig.h libfetch/ftperr.h libfetch/httperr.h
	rm -f fetch *.o *.a

distclean: clean
	cd libnbcompat && rm -f nbcompat/config.h config.log config.status Makefile || true
	cd source && rm -f config.h config.log config.status Makefile || true

clobber: distclean
	rm -f libnbcompat/configure	libnbcompat/nbcompat/config.h.in source/config.h.in source/configure


fetch: main.o libfetch.a
	$(CC) $(LDFLAGS) -o $@ $^ -lssl -lcrypto -lnsl

main.o: source/config.h libnbcompat/nbcompat/nbconfig.h
	cd source && $(CC) -c -Wall $(CFLAGS) $(CPPFLAGS) -DHAVE_CONFIG_H -I../libnbcompat -I../libfetch -o ../$@ fetch.c

source/config.h: source/configure
	cd source && ./configure

source/configure:
	cd source && ./autogen.sh


libfetch.a: $(libfetch_OBJS)
	$(AR) cru $@ $^
	$(RANLIB) $@

$(libfetch_OBJS): libnbcompat/nbcompat/nbconfig.h libfetch/ftperr.h libfetch/httperr.h
	cd libfetch && $(CC) -c -Wall -O2 -I. -I../libnbcompat $(libfetch_CPPFLAGS) $(CFLAGS) $(CPPFLAGS) -o ../$@ `echo $@ | sed 's|\.o$$|.c|'`

libfetch/ftperr.h:
	cd libfetch && ./errlist.sh ftp_errlist FTP ftp.errors > ../$@

libfetch/httperr.h:
	cd libfetch && ./errlist.sh http_errlist HTTP http.errors > ../$@


libnbcompat/nbcompat/nbconfig.h: libnbcompat/nbcompat/config.h
	$(AWK) -f libnbcompat/nbcompat.awk $^ > $@

libnbcompat/nbcompat/config.h: libnbcompat/configure
	cd libnbcompat && ./configure

libnbcompat/configure:
	cd libnbcompat && ./autogen.sh


install:
	$(INSTALL) -d $(DESTDIR)$(PREFIX)/bin
	$(INSTALL) -d $(DESTDIR)$(PREFIX)/share/man/man1
	$(INSTALL) -D -m755 source/fetch $(DESTDIR)$(PREFIX)/bin
	$(INSTALL) -D -m644 source/fetch.1 $(DESTDIR)$(PREFIX)/share/man/man1

