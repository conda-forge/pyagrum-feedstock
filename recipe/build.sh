#!/bin/sh

if test `uname` == "Darwin"; then
  export CXXFLAGS="${CXXFLAGS} -fno-assume-unique-vtables"
fi

mkdir build && cd build
cmake ${CMAKE_ARGS} \
  -DCMAKE_PREFIX_PATH=${PREFIX} \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DBUILD_PYTHON=ON \
  -DPython_FIND_STRATEGY=LOCATION \
  -DPython_ROOT_DIR=${PREFIX} \
  -DPython_INCLUDE_DIR=${PREFIX}/include/python${PY_VER} \
  ..
make install -j${CPU_COUNT}
if test "${BUILD}" == "${HOST}"
then
  ${PYTHON} ../wrappers/pyAgrum/testunits/gumTest.py
fi
