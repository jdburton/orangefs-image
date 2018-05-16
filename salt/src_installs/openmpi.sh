#!/usr/bin/env bash


set -x
mkdir -p /opt/mpi
cd /usr/src/openmpi-3.1.0
./configure --prefix=/opt/mpi/openmpi-3.1.0 --enable-shared --with-pic \
  --with-io-romio-flags='--with-pvfs2=/opt/orangefs --with-file-system=pvfs2+nfs+ufs' 
make -j$(nproc) 
make install
export PATH=$PATH:/opt/mpi/openmpi-3.1.0/bin
if which mpicc
then
  cd /opt/mpi/openmpi-3.1.0/ompi/mca/io/romio/romio/test/
  make 
fi