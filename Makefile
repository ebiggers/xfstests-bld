#
# A simple makefile for xfstests-bld
#

all: xfsprogs-dev xfstests-dev
	./build-all

xfsprogs-dev xfstests-dev:
	./get-all

clean:
	for i in acl attr dmapi e2fsprogs-libs libaio xfstests-dev ; \
	do \
		make -C $$i clean ; \
	done
	make -C xfsprogs-dev realclean
	rm -rf bld xfstests

realclean: clean
	rm -rf xfsprogs-dev xfstests-dev

tarball:
	rm -rf xfstests
	cp -r xfstests-dev xfstests
	rm -rf xfstests/.git xfstests/autom4te.cache
	find xfstests -type f -name \*.\[cho\]  -o -name \*.l[ao] | xargs rm
	mkdir xfstests/bin
	cp xfsprogs-dev/io/xfs_io xfsprogs-dev/db/xfs_db xfstests/bin
	-find xfstests -mindepth 2 -type f -perm +0111 | xargs strip
	tar cvf - xfstests | gzip -9 > xfstests.tar.gz