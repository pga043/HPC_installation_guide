#!/bin/bash

# load modules on Olivia compute nodes
# module load cray-fftw/3.3.10.8 cuda/12.6 gcc-native/12.3 cray-python/3.11.7
# 
# remember to download all the files on the login node
# the compute nodes have no access to internet
#
set -e

if [[ ! -a build ]]; then
    mkdir build
fi
cd build

#
# FFTW
#
if [[ ! -a fftw-3.3.9 ]]; then
    #wget http://www.fftw.org/fftw-3.3.9.tar.gz
    tar xvfz fftw-3.3.9.tar.gz
fi

if [[ ! -a fftw ]]; then
    mkdir fftw
    cd fftw-3.3.9
    ./configure CC=gcc --prefix=$PWD/../fftw \
        --enable-float --enable-fma \
        --enable-neon \
        --enable-openmp --enable-threads | tee fftw_config.log
    make -j 8 | tee fftw_build.log
    make install
    cd ..
fi

#
# TCL
#
if [[ ! -e tcl ]]; then
    wget http://www.ks.uiuc.edu/Research/namd/libraries/tcl8.5.9-linux-arm64-threaded.tar.gz
    tar zxvf tcl8.5.9-linux-arm64-threaded.tar.gz
    mv tcl8.5.9-linux-arm64-threaded tcl
fi

#
# Charm++
#
if [[ ! -a charm ]]; then
    git clone https://github.com/UIUC-PPL/charm.git
fi

cd charm
git checkout v7.0.0
if [[ ! -a multicore-linux-arm8-gcc ]]; then
    ./build charm++ multicore-linux-arm8 gcc --with-production --enable-tracing -j 8
fi 
cd ..

#
# NAMD
#
#if [[ ! -a namd ]]; then
#    git clone git@gitlab.com:tcbgUIUC/namd.git
#    cd namd
#    git checkout release-3-0-beta-3
#    cd ..
#fi

cd namd

#if [[ ! -a Linux-ARM64-g++ ]]; then
    ./config Linux-ARM64-g++ \
        --charm-arch multicore-linux-arm8-gcc --charm-base $PWD/../charm \
        --with-tcl --tcl-prefix $PWD/../tcl \
        --with-fftw --with-fftw3 --fftw-prefix $PWD/../fftw
    #sed -i 's/FLOATOPTS = .*/FLOATOPTS = -Ofast -mcpu=neoverse-v2/g' arch/Linux-ARM64-g++.arch
    cd Linux-ARM64-g++
    make depends
    make -j 20
    cd ..
#fi
cd ..

./config Linux-ARM64-g++ --charm-arch multicore-linux-arm8-gcc --charm-base $PWD/../charm --with-tcl --tcl-prefix $PWD/../tcl --with-fftw --with-fftw3 --fftw-prefix $PWD/../fftw --with-single-node-cuda --with-cuda --cuda-gencode arch=compute_90,code=sm_90 --cuda-dlink arch=compute_90,code=sm_90

#================  worked ======================
# module list
Currently Loaded Modulefiles:
  1) cray-fftw/3.3.10.8   2) cuda/12.6            3) gcc-native/12.3      4) cray-python/3.11.7   5) cce/19.0.0

export LIBRARY_PATH=/opt/nvidia/hpc_sdk/Linux_aarch64/24.11/math_libs/12.6/lib64
