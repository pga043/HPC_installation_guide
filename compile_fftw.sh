#!/bin/bash

./configure CC=gcc --prefix=$PWD/build --enable-float --enable-fma --enable-neon --enable-openmp --enable-threads --enable-shared --enable-mpi
make -j 8
make install
