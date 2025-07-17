#!/bin/bash

# CHARMM

module purge
module load PrgEnv-gnu/8.6.0 cuda/12.6 nvidia/24.11 cray-fftw/3.3.10.8 cray-python/3.11.7
module unload gcc-native/14.2
module load gcc-native/12.3
export CRAY_CPU_TARGET=aarch64
export OPENMM_ENV=/cluster/projects/nn4700k/softwares/openmm-8.0.0/build
export OPENMM_PLUGIN_DIR=${OPENMM_ENV}/lib/plugins
export OPENMM_INCLUDE_PATH=${OPENMM_ENV}/include
export OPENMM_LIB_PATH=${OPENMM_ENV}/lib
export FFTW_HOME=/cluster/projects/nn4700k/softwares/fftw-3.3.10/build
export FFTW_DIR=${FFTW_HOME}
export CMAKE_PREFIX_PATH=/opt/nvidia/hpc_sdk/Linux_aarch64/24.11/math_libs/12.6/lib64:${CMAKE_PREFIX_PATH}
export CPATH=/opt/nvidia/hpc_sdk/Linux_aarch64/24.11/math_libs/12.6/include:${CPATH}
../configure -u --with-blade -D FFTW_INCLUDE_DIR=/cluster/projects/nn4700k/softwares/fftw-3.3.10/build/include -D FFTW_LIBRARIES=/cluster/projects/nn4700k/softwares/fftw-3.3.10/build/lib


../configure -u --with-blade -D FFTW_INCLUDE_DIR=/cluster/projects/nn4700k/softwares/fftw-3.3.10/build/include -D FFTW_LIBRARIES=/cluster/projects/nn4700k/softwares/fftw-3.3.10/build/lib --as-library
