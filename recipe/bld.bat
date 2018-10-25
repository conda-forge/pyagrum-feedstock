
: remove sh.exe from PATH
set PATH=%PATH:C:\Program Files\Git\usr\bin;=%

mkdir build && cd build

:: Configure.
cmake -G "MinGW Makefiles" ^
  -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX:\=/%/mingw-w64 ^
  -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX:\=/%/mingw-w64 ^
  -DPYTHON_LIBRARY=%PREFIX%/libs/libpython%CONDA_PY%.dll.a ^
  -DCMAKE_C_FLAGS_RELEASE="-O2 -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions --param=ssp-buffer-size=4 -DNDEBUG -DMS_WIN64" ^
  -DCMAKE_CXX_FLAGS_RELEASE="-O2 -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions --param=ssp-buffer-size=4 -DNDEBUG -DMS_WIN64 -D_hypot=hypot" ^
  -DPYTHON_INSTALL="%SP_DIR:\=/%" ^
  -DBUILD_SHARED_LIBS=OFF ^
  -DFOR_PYTHON3=%PY3K% ^
  ..
if errorlevel 1 exit 1

:: Build.
mingw32-make install -j %CPU_COUNT% VERBOSE=1
if errorlevel 1 exit 1
