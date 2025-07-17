#!/bin/bash

# do this one by one on the terminal

export OPENMM_ENV=/cluster/projects/nn4700k/softwares/openmm-8.0.0/build
export OPENMM_PLUGIN_DIR=${OPENMM_ENV}/lib/plugins
export OPENMM_INCLUDE_PATH=${OPENMM_ENV}/include
export OPENMM_LIB_PATH=${OPENMM_ENV}/lib
#export LD_LIBRARY_PATH=${OPENMM_LIB_PATH}:${OPENMM_PLUGIN_DIR}:${LD_LIBRARY_PATH}

#export CUDA_HOME=/opt/nvidia/hpc_sdk/Linux_aarch64/24.11/cuda/12.6
#export CUDATK=${CUDA_HOME}

export FFTW_HOME=/cluster/projects/nn4700k/softwares/fftw-3.3.10/build
export FFTW_DIR=${FFTW_HOME}

#export LD_LIBRARY_PATH=${FFTW_HOME}/lib:${CUDA_HOME}/lib64:${LD_LIBRARY_PATH}


#---------------- worked ----------------------
 module purge
# module load cuda/12.6 cray-fftw/3.3.10.8 nvidia/24.11 PrgEnv-gnu/8.6.0 cray-python/3.11.7
 module load PrgEnv-gnu/8.6.0 cuda/12.6 nvidia/24.11 cray-fftw/3.3.10.8 cray-python/3.11.7
 module unload gcc-native/14.2
 module load gcc-native/12.3 
 edited CMakeLists.txt
 added : line 399 - 401
#  elseif(NOT CMAKE_CUDA_COMPILER)
#    set(CMAKE_CUDA_COMPILER "/opt/nvidia/hpc_sdk/Linux_aarch64/24.11/compilers/bin/nvcc")
#    enable_language(CUDA)
 export CRAY_CPU_TARGET=aarch64
 cd build
 ../configure -u --with-blade --without-opencl --without-html --without-mkl --without-library --without-openmm
 make

../configure -u --with-blade --without-opencl --without-openmm --without-mkl --without-html --static

## openmm error => 
/cluster/projects/nn4700k/softwares/openmm-8.0.0/build/include/openmm/internal/vectorize_sse.h
smmintrin.h =>  intrinsic header for x86 processor architecture

#------------------------ 
# maybe solution:
#------------------------
#if defined(__x86_64__)
#  include <smmintrin.h>
#elif defined(__aarch64__)
#  include <arm_neon.h>
#endif

 
#*******************************************************************************************************
#-------------- tests ----------------------------------------------------------------------------------
module load CMake/3.24.3-GCCcore-12.2.0 FFTW.MPI/3.3.10-gompi-2022b OpenMPI/4.1.4-GCC-12.2.0 CUDA/12.4.0

../configure -u --with-blade --without-opencl --without-html --without-mkl --without-library




# module load module load cpe-cuda/24.07 cuda/12.6 cray-fftw/3.3.10.10 
#../configure -u --with-blade --without-library --without-opencl
../configure -u --with-blade --without-library --without-opencl --without-mkl

export PATH="/opt/nvidia/hpc_sdk/Linux_aarch64/24.11/cuda/bin:$PATH"
export LIBRARY_PATH="/opt/nvidia/hpc_sdk/Linux_aarch64/24.11/cuda/lib64:$LD_LIBRARY_PATH"

#module load cray-fftw/3.3.10.8 cray-python/3.11.7 gcc-native/14.2 cudatoolkit/24.11_11.8 cray-mpich/8.1.32 nvhpc-hpcx-cuda12/24.11

#export OPENMM_CUDA_COMPILER=


module load nvhpc-hpcx-cuda12/24.11 cray-fftw/3.3.10.8
../configure -u --with-blade  --without-opencl --without-html --without-library

#--------------------------------------------------------------------------------------------------------------#
../configure -u --with-blade -D FFTW_INCLUDE_DIR=/cluster/projects/nn4700k/softwares/fftw-3.3.10/build/include -D FFTW_LIBRARIES=/cluster/projects/nn4700k/softwares/fftw-3.3.10/build/lib

export CMAKE_PREFIX_PATH=/opt/nvidia/hpc_sdk/Linux_aarch64/24.11/math_libs/12.6/lib64:${CMAKE_PREFIX_PATH}
export CPATH=/opt/nvidia/hpc_sdk/Linux_aarch64/24.11/math_libs/12.6/include:${CPATH}
