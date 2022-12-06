#!/bin/sh

which python
echo ${PYTHON}
echo ${PREFIX}

OURPYTHON="which python"
echo ${OURPYTHON}

mkdir build && cd build
cmake ${CMAKE_ARGS} \
  -DCMAKE_PREFIX_PATH=${PREFIX} \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DBUILD_PYTHON=ON \
  -DPyhon_EXECUTABLE=${OURPYTHON} \
  ..
make install -j${CPU_COUNT}
if test "${BUILD}" == "${HOST}"
then
  ${PYTHON} ../wrappers/pyAgrum/testunits/gumTest.py
fi
