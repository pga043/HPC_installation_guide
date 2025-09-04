#!/bin/bash

# get some instructions here if stuck:
# https://github.com/jvermaas/Software-Building-Instructions/blob/main/NAMD.md

./config Linux-x86_64-g++ --charm-arch multicore-linux-x86_64-gcc --charm-base charm-6.10.2 --with-tcl --tcl-prefix $PWD/../NAMD_3.0.1_Source/build/tcl-threaded --with-fftw --with-fftw3 --fftw-prefix $PWD/../NAMD_3.0.1_Source/build/fftw_x86-64

#==== mpi version ==========
./build charm++ mpi-linux-x86_64 smp --with-production -j8

./config Linux-x86_64-g++ --charm-arch mpi-linux-x86_64-smp --charm-base charm-6.10.2 --with-tcl --tcl-prefix $PWD/../NAMD_3.0.1_Source/build/tcl-threaded --with-fftw --with-fftw3 --fftw-prefix $PWD/../NAMD_3.0.1_Source/build/fftw_x86-64
