#!/bin/bash
# Script to install Meep 1.31.0 with mpi4py, h5py, Guile 3.0.10, libctl 4.5.1, 
# MPB 1.12.0, libGDSII, h5utils 1.13.2, and Harminv 1.4.2
# Written by Ghanghoon "Will" Paik (gip5038@psu.edu)
# March 14 2019
# Updated: Oct 27 2025

BASE=$PWD
mkdir -p $BASE/MEEP_build
BUILD_DIR=$BASE/MEEP_build
mkdir -p $BASE/meeptmpdir
TMP=$BASE/meeptmpdir

export HDF5_LIB=/usr/local/lib/libhdf5.so

export LD_LIBRARY_PATH=$BUILD_DIR/lib:$BUILD_DIR/lib64:$LD_LIBRARY_PATH
export CPATH=$BUILD_DIR/include:$CPATH

cd $TMP

export PKG_CONFIG_PATH=/usr/lib64/pkgconfig:$BUILD_DIR/lib/pkgconfig

### libctl 4.5.1 ###
wget https://github.com/NanoComp/libctl/archive/v4.5.1.tar.gz
tar xvzf v4.5.1.tar.gz
cd libctl-4.5.1/
./autogen.sh --enable-shared --prefix=$BUILD_DIR LDFLAGS="-L/usr/local/lib -Wl,-rpath,/usr/local/lib"
make -j 4 && make install

cd $TMP

export BLAS_LIBS=/usr/lib64/libblas.so
export LAPACK_LIBS=/usr/lib64/liblapack.so
export PATH=$BUILD_DIR/bin:$PATH

###  MPB 1.12.0  ##
wget https://github.com/NanoComp/mpb/archive/v1.12.0.tar.gz
tar xvzf v1.12.0.tar.gz
cd mpb-1.12.0
./autogen.sh --enable-shared --prefix=$BUILD_DIR --with-mpi --with-libctl=$BUILD_DIR/share/libctl CC=mpicc CXX=mpic++ \
LDFLAGS="-L$BUILD_DIR/lib -L/usr/local/lib" CPPFLAGS="-I$BUILD_DIR/include -I/usr/local/include" --with-hermitian-eps
make -j 4 && make install
# rebuild for non-MPI version
make distclean
./autogen.sh --enable-shared --prefix=$BUILD_DIR --with-libctl=$BUILD_DIR/share/libctl \
LDFLAGS="-L$BUILD_DIR/lib -L/usr/local/lib" CPPFLAGS="-I$BUILD_DIR/include -I/usr/local/include" --with-hermitian-eps
make -j 4 && make install

cd $TMP

### libGDSII ###
git clone https://github.com/HomerReid/libGDSII.git
cd libGDSII/
./autogen.sh --enable-shared --prefix=$BUILD_DIR
make -j 4 && make install

cd $TMP

### h5utils 1.13.2 ###
wget https://github.com/NanoComp/h5utils/archive/1.13.2.tar.gz
tar -xf 1.13.2.tar.gz
cd h5utils-1.13.2
./autogen.sh --enable-shared CC=mpicc --prefix=$BUILD_DIR
make -j 4 && make install

cd $TMP

### Harminv 1.4.2  ###
wget https://github.com/NanoComp/harminv/releases/download/v1.4.2/harminv-1.4.2.tar.gz
tar xvzf harminv-1.4.2.tar.gz
cd harminv-1.4.2/
./configure --enable-shared --prefix=$BUILD_DIR
make -j 4 && make install


cd $TMP

### mpi4py ###
pip install mpi4py

cd $TMP

### h5py ###
pip install h5py

cd $TMP

### MEEP 1.31.0 ###
wget https://github.com/NanoComp/meep/archive/v1.31.0.tar.gz
tar xvzf v1.31.0.tar.gz
cd meep-1.31.0
./autogen.sh --prefix=$BUILD_DIR --with-mpi --with-openmp --with-libctl=$BUILD_DIR/share/libctl CC=mpicc CXX=mpic++ PYTHON=python3 \
LDFLAGS=-L/usr/local/lib CPPFLAGS=-I/usr/local/include
make -j 4 && make install


cd $BASE
rm -rf meeptmpdir
