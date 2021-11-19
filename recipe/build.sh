#!/bin/sh

mkdir build && cd build
cmake ${CMAKE_ARGS} \
  -DCMAKE_PREFIX_PATH=${PREFIX} \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DBUILD_PYTHON=ON \
  ..
make install -j${CPU_COUNT}
${PYTHON} ../wrappers/pyAgrum/testunits/gumTest.py
