#!/bin/sh

if [[ "${target_platform}" == osx-* ]]; then
    # See https://conda-forge.org/docs/maintainer/knowledge_base.html#newer-c-features-with-old-sdk
    CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"
fi

cmake ${CMAKE_ARGS} \
  -DCMAKE_PREFIX_PATH=${PREFIX} \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DCMAKE_UNITY_BUILD=ON \
  -DBUILD_PYTHON=ON \
  -DAGRUM_PYTHON_SABI=ON \
  -DPython_EXECUTABLE=${PREFIX}/bin/python \
  -DPython_INCLUDE_DIR=${PREFIX}/include \
  -DPython_NumPy_INCLUDE_DIR=${PREFIX}/lib/python${PY_VER}/site-packages/numpy/core/include \
  -DPython_FIND_STRATEGY=LOCATION \
  -B build

cmake --build build --target install --parallel ${CPU_COUNT}

if test "${BUILD}" == "${HOST}"
then
  ${PYTHON} ./wrappers/pyagrum/testunits/gumTest.py
fi
