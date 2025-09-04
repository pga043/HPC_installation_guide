#!/bin/bash

cmake .. -DOPENBABEL3_INCLUDE_DIR=$CONDA_PREFIX/include/openbabel3  -DCMAKE_CXX_FLAGS="-Wno-error=maybe-uninitialized" -DCMAKE_INSTALL_PREFIX=/Home/siv32/pga043/Software/libmolgrid-0.5.5/install -DBUILD_SHARED_LIBS=ON -DLIBMOLGRID_VERSION_STRING="0.5.5"
make -j all
make install
