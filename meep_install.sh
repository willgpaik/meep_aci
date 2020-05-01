#!/bin/bash
# Script to install Meep 1.14.0 with libgc 8.0.4, GMP 6.1.2, zlib 1.2.11, libunistring 0.9.9,
# Guile 3.0.2, libctl 4.5.0, MPB 1.10.0, and Harminv 1.4.1
# Written by Ghanghoon "Will" Paik (gip5038@psu.edu)
# March 14 2019
# Updated: May 1 2020

BASE=$PWD
mkdir -p $BASE/MEEP_build
BUILD_DIR=$BASE/MEEP_build
mkdir -p $BASE/meeptmpdir
TMP=$BASE/meeptmpdir

export HDF5_LIB=/usr/local/lib/libhdf5.so

cd $TMP

###  libgc 8.0.4  ###
wget https://www.hboehm.info/gc/gc_source/gc-8.0.4.tar.gz
tar xvzf gc-8.0.4.tar.gz
cd gc-8.0.4
./configure --prefix=$BUILD_DIR
make && make install

#cd $TMP

###  gmp 6.1.2  ###
#wget https://gmplib.org/download/gmp/gmp-6.1.2.tar.xz
#tar -xf gmp-6.1.2.tar.xz
#cd gmp-6.1.2
#./configure --prefix=$BUILD_DIR
#make && make install

#cd $TMP

###  zlib 1.2.11  ###
#wget https://zlib.net/zlib-1.2.11.tar.gz
#tar xvzf zlib-1.2.11.tar.gz
#cd zlib-1.2.11
#./configure --prefix=$BUILD_DIR
#make && make install

#cd $TMP

###  libunistring 0.9.9  ###
#wget http://ftp.gnu.org/gnu/libunistring/libunistring-0.9.9.tar.xz
#tar -xf libunistring-0.9.9.tar.xz
#cd libunistring-0.9.9
#./configure --prefix=$BUILD_DIR
#make && make install

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$BUILD_DIR/lib
export CPATH=$CPATH:$BUILD_DIR/include

#cd $TMP

export PKG_CONFIG_PATH=/usr/lib64/pkgconfig:$BUILD_DIR/lib/pkgconfig

# MEEP python requires newer version of Guile: https://github.com/NanoComp/meep/issues/938
###  Guile 3.0.2  ###
wget https://ftp.gnu.org/gnu/guile/guile-3.0.2.tar.gz
tar xvzf guile-3.0.2.tar.gz
cd guile-3.0.2
./configure --prefix=$BUILD_DIR CFLAGS='-I'"$BUILD_DIR"'/include' 
make && make install

cd $TMP

### libctl 4.5.0 ###
wget https://github.com/NanoComp/libctl/archive/v4.5.0.tar.gz
tar xvzf v4.5.0.tar.gz
cd libctl-4.5.0/
#./configure --enable-shared --prefix=$BUILD_DIR GUILE=$BUILD_DIR/bin/guile GUILE_CONFIG=$BUILD_DIR/bin/guile-config CPPFLAGS='-I'"$BUILD_DIR"'/include'
./configure --enable-shared --prefix=$BUILD_DIR CPPFLAGS='-I'"$BUILD_DIR"'/include'
make && make install

cd $TMP

export BLAS_LIBS=/usr/lib64/libblas.so
export LAPACK_LIBS=/usr/lib64/liblapack.so
export PATH=$BUILD_DIR/bin:$PATH


###  MPB 1.10.0  ##
wget https://github.com/NanoComp/mpb/archive/v1.10.0.tar.gz
tar xvzf v1.10.0.tar.gz
cd mpb-1.10.0
./configure --enable-shared --prefix=$BUILD_DIR --with-mpi --with-libctl=$BUILD_DIR/share/libctl CC=mpicc CXX=mpic++ \
LDFLAGS="-L$BUILD_DIR/lib -L/usr/local/lib" CPPFLAGS="-I$BUILD_DIR/include -I/usr/local/include"
make && make install
# rebuild for non-MPI version
make distclean
./configure --enable-shared --prefix=$BUILD_DIR --with-libctl=$BUILD_DIR/share/libctl \
LDFLAGS="-L$BUILD_DIR/lib -L/usr/local/lib" CPPFLAGS="-I$BUILD_DIR/include -I/usr/local/include"
make && make install

cd $TMP


### Harminv 1.4.1  ###
wget https://github.com/NanoComp/harminv/releases/download/v1.4.1/harminv-1.4.1.tar.gz
tar xvzf harminv-1.4.1.tar.gz
cd harminv-1.4.1/
./configure --enable-shared --prefix=$BUILD_DIR
make && make install

cd $TMP

### MEEP 1.14.0 ###
wget https://github.com/NanoComp/meep/archive/v1.14.0.tar.gz
tar xvzf v1.14.0.tar.gz
cd meep-1.14.0
./autogen.sh
./configure --prefix=$BUILD_DIR --with-mpi --with-openmp --with-libctl=$BUILD_DIR/share/libctl CC=mpicc CXX=mpic++ PYTHON=python3 \
LDFLAGS=-L/usr/local/lib CPPFLAGS=-I/usr/local/include
make && make install


cd $BASE
rm -rf meeptmpdir
