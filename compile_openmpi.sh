#!/bin/bash

/configure CC=gcc CXX=g++ FC=gfortran --enable-mpi-fortran --enable-mpirun-prefix-by-default --with-slurm --prefix=/cluster/projects/nnXXX/softwares/openmpi-5.0.8/build
make -j all
make install


export PATH=cluster/projects/nnXXX/softwares/openmpi-5.0.8/build/bin:$PATH
export LD_LIBRARY_PATH=cluster/projects/nnXXX/softwares/openmpi-5.0.8/build/lib:$LD_LIBRARY_PATH
