#!/bin/bash


set -x

cd /usr/src/orangefs/test


export PATH=$PATH:/opt/mpi/openmpi-3.1.0/bin
CFLAGS='-g ' ./configure  --with-db-backend=lmdb --prefix=/opt/orangefs --with-db=/opt/db4 --with-mpi=/opt/mpi/openmpi-3.1.0 --enable-strict && \
# kludge because perfbase won't compile.
rm -rf perfbase
rm -rf io
make && \
make install


