
noinst_HEADERS = nbcompat/nbconfig.h

CLEANFILES = nbcompat/nbconfig.h

nbcompat/nbconfig.h: nbcompat.awk nbcompat/config.h
	$(AWK) -f $^ > $@

