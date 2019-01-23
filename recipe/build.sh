#!/bin/sh

mkdir build && cd build
cmake \
  -DCMAKE_PREFIX_PATH=${PREFIX} \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  ..
make install -j${CPU_COUNT}
${PYTHON} ../wrappers/pyAgrum/testunits/gumTest.py
