#!/bin/sh

# src/cmake/CxxTest.agrum.cmake:2:find_package(Python ${PYAGRUM_REQUIRED_PYTHON_VERSION} COMPONENTS Interpreter)
sed -i.bak "s|COMPONENTS Interpreter|COMPONENTS Interpreter Development.Module|g" src/cmake/CxxTest.agrum.cmake

mkdir build && cd build
cmake ${CMAKE_ARGS} \
  -DCMAKE_PREFIX_PATH=${PREFIX} \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DBUILD_PYTHON=ON \
  -DPython_FIND_STRATEGY=LOCATION \
  -DPython_ROOT_DIR=${PREFIX} \
  -DZPYAGRUM_REQUIRED_PYTHON_VERSION=${PY_VER} \
  ..
make install -j${CPU_COUNT}
if test "${BUILD}" == "${HOST}"
then
  ${PYTHON} ../wrappers/pyAgrum/testunits/gumTest.py
fi
