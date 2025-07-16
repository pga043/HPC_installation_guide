#!/bin/bash

#module load cray-python/3.11.7 cpe-cuda/24.07 cray-fftw/3.3.10.10 cuda/12.6

Bison =>
wget http://ftp.gnu.org/gnu/bison/bison-3.8.tar.xz
../configure --prefix=/cluster/projects/nnXXX/softwares/bison-3.8/build
make -j all

Swig =>
wget https://altushost-bul.dl.sourceforge.net/project/swig/swig/swig-4.3.1/swig-4.3.1.tar.gz
export PATH=/cluster/projects/nnXXX/softwares/bison-3.8/build:$PATH
./configure --prefix=/cluster/projects/nnXXX/softwares/swig-4.3.1/build
make
make install

doxyegn =>
wget https://www.doxygen.nl/files/doxygen-1.14.0.src.tar.gz
cmake .. -B /cluster/projects/nnXXX/softwares/doxygen-1.14.0/build
make -j all

mkdir build
cd build

export PATH="/cluster/projects/nnXXX/softwares/doxygen-1.14.0/build/bin:$PATH"
export PATH=/cluster/projects/nnXXX/softwares/swig-4.3.1/build:$PATH
## line 47 in CmakeLists.txt
##         add_definitions(-D__ARM__=1) to
##         add_definitions(-D__ARM64__=1)
export SWIG_LIB=/cluster/projects/nnXXX/softwares/swig-4.3.1/build/share/swig/4.3.1
cmake .. --install-prefix=/cluster/projects/nnXXX/softwares/openmm-8.0.0/build
make -j4
make install
make PythonInstall


# running cuda tests:
# export OPENMM_CUDA_COMPILER=/opt/nvidia/hpc_sdk/Linux_aarch64/24.11/cuda/12.6/bin/nvcc
# module load cpe-cuda/24.07 cuda/12.6
