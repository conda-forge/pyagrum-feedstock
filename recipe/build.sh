#!/bin/sh

set -x

# src/cmake/CxxTest.agrum.cmake:2:find_package(Python ${PYAGRUM_REQUIRED_PYTHON_VERSION} COMPONENTS Interpreter)
# sed -i.bak "s|COMPONENTS Interpreter|COMPONENTS Interpreter Development.Module|g" src/cmake/CxxTest.agrum.cmake

ls -l ${PREFIX}/include/python*
echo "xxxxxxxxxxxxx PYVER=${PY_VER}"

mkdir build && cd build
cmake ${CMAKE_ARGS} \
  -DCMAKE_PREFIX_PATH=${PREFIX} \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DBUILD_PYTHON=ON \
  -DPython_FIND_STRATEGY=LOCATION \
  -DPython_ROOT_DIR=${PREFIX} \
  -DPython_INCLUDE_DIR=${PREFIX}/include/python${PY_VER} \
  -DPYAGRUM_REQUIRED_PYTHON_VERSION=${PY_VER} \
  -LAH \
  ..
make install -j${CPU_COUNT}
#if test "${BUILD}" == "${HOST}"
#then
#  ${PYTHON} ../wrappers/pyAgrum/testunits/gumTest.py
#fi
