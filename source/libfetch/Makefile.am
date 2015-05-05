AM_CFLAGS   = -Wall -I$(top_srcdir)/source/libnbcompat
AM_CPPFLAGS = -D_LARGEFILE_SOURCE -D_LARGE_FILES -D_FILE_OFFSET_BITS=64 -DINET6 -DWITH_SSL -DFTP_COMBINE_CWDS

CLEANFILES = ftperr.h httperr.h

noinst_LIBRARIES   = libfetch.a
libfetch_a_SOURCES = fetch.c common.c ftp.c http.c file.c

$(libfetch_a_SOURCES): ftperr.h httperr.h

ftperr.h:
	$(AM_V_GEN)./errlist.sh ftp_errlist FTP ftp.errors > $@

httperr.h:
	$(AM_V_GEN)./errlist.sh http_errlist HTTP http.errors > $@

