#!/bin/bash

https://documentation.sigma2.no/software/userinstallsw/python.html

# go to a compute node with gpu
# see ../interactive.sh

# turn on internet access
# see /cluster/home/pga043/new_updates.sh

# load modules
module purge
module load PrgEnv-gnu/8.6.0 cuda/12.6 nvidia/24.11 cray-fftw/3.3.10.8 cray-python/3.11.7
module unload gcc-native/14.2
module load gcc-native/12.3

# create a virutal python environment (for user only)
python -m venv $HOME/boltz --system-site-packages
source $HOME/boltz/bin/activate

# install boltz
python -m pip install boltz[cuda] -U

# deactivate the python environment
deactivate
