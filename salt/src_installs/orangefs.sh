#!/bin/bash


set -x

mkdir -p /opt/orangefs

whoami

svn co http://dev.orangefs.org/svn/orangefs/trunk /usr/src/orangefs
cd /usr/src/orangefs
# export CFLAGS=' -std=gnu99 '

./prepare
gcc --version

if /sbin/modprobe orangefs 
then
	# For linux >= 4.6
	./configure --with-db-backend=lmdb --prefix=/opt/orangefs --with-db=/opt/db4 --enable-strict --enable-shared  && \
	make -j$(nproc) && \
	make install
	
elif [ -d /lib/modules/`uname -r`/source ]
then
	# for SUSE based systems
	./configure --with-db-backend=lmdb --prefix=/opt/orangefs --with-db=/opt/db4 --enable-strict --enable-shared --with-kernel=/lib/modules/`uname -r`/source && \
	make -j$(nproc) && \
	make install && \
	make kmod && \
	make kmod_install kmod_prefix=/opt/orangefs	
	
elif [ -d /lib/modules/`uname -r`/build ]
then
	# for Debian/Redhat systems
	./configure --with-db-backend=lmdb --prefix=/opt/orangefs --with-db=/opt/db4 --enable-strict --enable-shared --with-kernel=/lib/modules/`uname -r`/build && \
	make -j$(nproc) && \
	make install && \
	make kmod && \
	make kmod_install kmod_prefix=/opt/orangefs
	
else
	# fallback to fuse module
	./configure --with-db-backend=lmdb --prefix=/opt/orangefs --with-db=/opt/db4 --enable-strict --enable-shared --enable-fuse && \
	make -j$(nproc) && \
	make install
	
fi