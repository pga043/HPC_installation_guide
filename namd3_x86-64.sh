#!/bin/bash

# load modules on Olivia compute nodes
# module load cray-fftw/3.3.10.8 cuda/12.6 gcc-native/12.3 cray-python/3.11.7
# 
# remember to download all the files on the login node
# the compute nodes have no access to internet
# also look at this guide:
# https://github.com/jvermaas/Software-Building-Instructions/blob/main/NAMD.md

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
    mkdir fftw_x86-64
    cd fftw-3.3.9
    ./configure CC=gcc --prefix=$PWD/../fftw_x86-64 \
        --enable-float --enable-fma \
        #--enable-neon \ # this is for arm cpus
        --enable-openmp --enable-threads | tee fftw_config.log
    make -j 8 | tee fftw_build.log
    make install
    cd ..
fi

#
# TCL
#
if [[ ! -e tcl ]]; then
    wget http://www.ks.uiuc.edu/Research/namd/libraries/tcl8.5.9-linux-x86_64-threaded.tar.gz
    tar xzf tcl8.5.9-linux-x86_64-threaded.tar.gz    
    mv tcl8.5.9-linux-x86_64-threaded tcl-threaded
fi

#
# Charm++
#
if [[ ! -a charm ]]; then
    git clone https://github.com/UIUC-PPL/charm.git
fi

cd charm
git checkout v7.0.0
./build charm++ multicore-linux-x86_64 gcc --with-production --enable-tracing -j 16
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
    ./config Linux-x86_64-g++ --charm-arch multicore-linux-x86_64-gcc --charm-base $PWD/../charm --with-tcl --tcl-prefix $PWD/../tcl-threaded --with-fftw --with-fftw3 --fftw-prefix $PWD/../fftw_x86-64
    cd Linux-x86_64-g++
    make depends
    make -j 20
    cd ..
#fi
cd ..

#================  worked ======================
# module list
Currently Loaded Modulefiles:
  1) cray-fftw/3.3.10.8   3) gcc-native/12.3      4) cray-python/3.11.7   5) cce/19.0.0



## mpi support =============
./config Linux-x86_64-g++ --charm-arch mpi-linux-x86_64-smp --charm-base ../../../NAMD_2.14_Source/charm-6.10.2 --with-tcl --tcl-prefix $PWD/../tcl-threaded --with-fftw --with-fftw3 --fftw-prefix $PWD/../fftw_x86-64
