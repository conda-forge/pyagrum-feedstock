
curl -fsSLO https://github.com/openturns/build-agrum/releases/download/v%PKG_VERSION%/agrum-%PKG_VERSION%-py%PY_VER%-x86_64.zip
if errorlevel 1 exit 1

7za x agrum-%PKG_VERSION%-py%PY_VER%-x86_64.zip -o%SP_DIR% -y
if errorlevel 1 exit 1

%PYTHON% wrappers\pyagrum\testunits\gumTest.py
if errorlevel 1 exit 1
