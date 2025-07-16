#!/bin/bash

Bison =>
wget http://ftp.gnu.org/gnu/bison/bison-3.8.tar.xz
../configure --prefix=/cluster/projects/nn4700k/softwares/bison-3.8/build
make -j all

Swig =>
wget https://altushost-bul.dl.sourceforge.net/project/swig/swig/swig-4.3.1/swig-4.3.1.tar.gz
export PATH=/cluster/projects/nn4700k/softwares/bison-3.8/build:$PATH
./configure --prefix=/cluster/projects/nn4700k/softwares/swig-4.3.1/build
make
make install

doxyegn =>
wget https://www.doxygen.nl/files/doxygen-1.14.0.src.tar.gz
cmake .. -B /cluster/projects/nn4700k/softwares/doxygen-1.14.0/build
make -j all

mkdir build
cd build

export PATH="/cluster/projects/nn4700k/softwares/doxygen-1.14.0/build/bin:$PATH"
export PATH=/cluster/projects/nn4700k/softwares/swig-4.3.1/build:$PATH
## line 47 in CmakeLists.txt
##         add_definitions(-D__ARM__=1) to
##         add_definitions(-D__ARM64__=1)
export SWIG_LIB=/cluster/projects/nn4700k/softwares/swig-4.3.1/build/share/swig/4.3.1
cmake .. --install-prefix=/cluster/projects/nn4700k/softwares/openmm-8.0.0/build
make -j4
make install
make PythonInstall
