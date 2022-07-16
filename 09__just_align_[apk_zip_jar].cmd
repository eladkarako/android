::@echo off
chcp 65001 1>nul 2>nul

set "ARGS="
::----------------------- overwrite existing outputfile.zip
set  ARGS=%ARGS% -f
::----------------------- page-align uncompressed .so files
set  ARGS=%ARGS% -p
::----------------------- verbosed output
set  ARGS=%ARGS% -v
::----------------------- alignment in bytes, e.g. '4' provides 32-bit alignment
set  ARGS=%ARGS% 4
::----------------------- inputfile.zip (example)
set  ARGS=%ARGS% "%~1"
::----------------------- outputfile.zip (example)
set  ARGS=%ARGS% "%~dpn1_aligned%~x1"


call "%~sdp0\bin\build-tools\zipalign.exe" %ARGS%
set "EXIT_CODE=%ErrorLevel%"


echo.[INFO] EXIT_CODE: %EXIT_CODE%  1>&2
::pause  1>&2

exit /b %EXIT_CODE%
