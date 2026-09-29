#!/bin/sh

if [[ "${target_platform}" == osx-* ]]; then
    CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"
fi

CMAKE_PYTHON_ARGS=(
    -DPython_EXECUTABLE="${PREFIX}/bin/python"
    -DPython_INCLUDE_DIR="${PREFIX}/include/python${PY_VER}"
    -DPython_NumPy_INCLUDE_DIR="${PREFIX}/lib/python${PY_VER}/site-packages/numpy/_core/include"
    -DPython_FIND_STRATEGY=LOCATION
)

cmake ${CMAKE_ARGS} \
  "${CMAKE_PYTHON_ARGS[@]}" \
  -DCMAKE_PREFIX_PATH=${PREFIX} \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DCMAKE_UNITY_BUILD=ON \
  -DBUILD_PYTHON=ON \
  -DAGRUM_PYTHON_SABI=ON \
  -DINSTALL_PYTHONDIR=${SP_DIR} \
  -B build .

cmake --build build --target install --parallel ${CPU_COUNT}

if test "${BUILD}" == "${HOST}"
then
  cd ${PREFIX}
  
  PYTHONPATH=${SP_DIR} ${PYTHON} ${SRC_DIR}/wrappers/pyagrum/testunits/gumTest.py
fi
