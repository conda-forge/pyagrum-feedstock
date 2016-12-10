#!/bin/sh

if test "${PY3K}" == "1"
then
  PY2=OFF
else
  PY2=ON
fi

mkdir -p build && cd build
cmake \
  -DCMAKE_PREFIX_PATH=${PREFIX} \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DFOR_PYTHON2="${PY2}" \
  ..
make install -j${CPU_COUNT}
