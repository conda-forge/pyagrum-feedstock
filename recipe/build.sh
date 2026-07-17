#!/bin/sh

if [[ "${target_platform}" == osx-* ]]; then
    CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"
fi
if [[ "${BUILD}" != "${HOST}" ]]; then
    CMAKE_PYTHON_ARGS=(
        -DPython_EXECUTABLE="${PREFIX}/bin/python"
        -DPython_INCLUDE_DIR="${PREFIX}/include/python${PY_VER}"
        -DPython_NumPy_INCLUDE_DIR="${PREFIX}/lib/python${PY_VER}/site-packages/numpy/core/include"
        -DPython_FIND_STRATEGY=LOCATION
    )
else
    CMAKE_PYTHON_ARGS=()
fi

find $PREFIX -name "arrayobject.h"

cmake ${CMAKE_ARGS} \
  "${CMAKE_PYTHON_ARGS[@]}" \
  -DCMAKE_PREFIX_PATH=${PREFIX} \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DCMAKE_UNITY_BUILD=ON \
  -DBUILD_PYTHON=ON \
  -DAGRUM_PYTHON_SABI=ON \
  -B build .

cmake --build build --target install --parallel ${CPU_COUNT}

if test "${BUILD}" == "${HOST}"
then
  ${PYTHON} ./wrappers/pyagrum/testunits/gumTest.py
fi
