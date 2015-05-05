SUBDIRS = libnbcompat libfetch

AM_CFLAGS = -Wall -Ilibnbcompat -Ilibfetch

bin_PROGRAMS = fetch
fetch_SOURCES = fetch.c
fetch_LDADD = libfetch/libfetch.a

man1_MANS = fetch.1

