#!/bin/sh

if test `uname` == "Darwin"; then
  export CXXFLAGS="${CXXFLAGS} -fno-assume-unique-vtables"
fi

if [[ "${target_platform}" == osx-* ]]; then
    # See https://conda-forge.org/docs/maintainer/knowledge_base.html#newer-c-features-with-old-sdk
    CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"
fi

cmake ${CMAKE_ARGS} \
  -DCMAKE_PREFIX_PATH=${PREFIX} \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DBUILD_PYTHON=ON \
  -DPython_FIND_STRATEGY=LOCATION \
  -DPython_ROOT_DIR=${PREFIX} \
  -DAGRUM_PYTHON_SABI=OFF \
  -B build .
cmake --build build --target install --parallel ${CPU_COUNT}

if test "${BUILD}" == "${HOST}"
then
  ${PYTHON} ./wrappers/pyagrum/testunits/gumTest.py
fi
