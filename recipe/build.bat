set PYTHONUTF8=1
set PYTHONIOENCODING=utf-8

cmake -LAH -G "Ninja" ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_PREFIX_PATH="%LIBRARY_PREFIX:\=/%%" ^
    -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX:\=/%%" ^
    -DCMAKE_UNITY_BUILD=ON ^
    -DBUILD_PYTHON=ON ^
    -DBUILD_SHARED_LIBS=OFF ^
    -DPython_FIND_STRATEGY=LOCATION ^
    -DPython_ROOT_DIR="%PREFIX%" ^
    -DINSTALL_PYTHONDIR="%SP_DIR:\=/%" ^
    -DAGRUM_PYTHON_SABI=ON ^
    -DCMAKE_CXX_FLAGS="/utf-8 /EHsc" ^
    -B build .
if errorlevel 1 exit 1

cmake --build build --target install --config Release --parallel %CPU_COUNT%
if errorlevel 1 exit 1

%PYTHON% wrappers\pyagrum\testunits\gumTest.py
if errorlevel 1 exit 1
