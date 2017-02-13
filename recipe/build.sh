#!/bin/sh

mkdir build && cd build
cmake \
  -DCMAKE_PREFIX_PATH=${PREFIX} \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DFOR_PYTHON3=${PY3K} \
  ..
make install -j${CPU_COUNT}
LD_LIBRARY_PATH=${PREFIX}/lib ldd ${SP_DIR}/pyAgrum/_pyAgrum.so
LD_LIBRARY_PATH=${PREFIX}/lib ${PYTHON} ../wrappers/pyAgrum/testunits/TestSuite.py
