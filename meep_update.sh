#!/bin/bash
# Script to update Meep from Git repo (may not be stable)
# Written by Ghanghoon "Will" Paik (gip5038@psu.edu)
# last updated: March 29 2019

BASE=$PWD
mkdir -p $BASE/meeptmp
BUILD_DIR=$BASE/MEEP_build
TMPDIR=$BASE/meeptmp

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$BUILD_DIR/lib
export PATH=$PATH:$BUILD_DIR/bin
export CPATH=$CPATH:$BUILD_DIR/include

export BLAS_LIBS=/usr/lib64/libblas.so
export LAPACK_LIBS=/usr/lib64/liblapack.so

cd $TMPDIR
git clone https://github.com/NanoComp/meep.git
cd meep

#sh autogen.sh --prefix=$BUIDL_DIR GUILE=$BUILD_DIR/bin/guile GUILE_CONFIG=$BUILD_DIR/bin/guile-config CPPFLAGS='-I'"$BUILD_DIR"'/include' LDFLAGS='-L'"$BUILD_DIR"'/lib' -with-libctl=$BUILD_DIR/share/libctl
sh autogen.sh --prefix=$BUIDL_DIR CPPFLAGS='-I'"$BUILD_DIR"'/include' LDFLAGS='-L'"$BUILD_DIR"'/lib' -with-libctl=$BUILD_DIR/share/libctl --without-python

make
make install

# remove source files
cd $BASE
rm -rf $TMPDIR
