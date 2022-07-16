@echo off
chcp 65001 1>nul 2>nul
pushd "%~sdp0"

title %~nx1

::------------------------------------- (compatible folder name)
set "PROJECT=%~nx1###"
set "PROJECT=%PROJECT:.apk###=%"
set "PROJECT=%PROJECT:.zip###=%"
set "PROJECT=%PROJECT:###=%"
set "PROJECT=%PROJECT:.=_%"

ren "%~sdp1\sources_%PROJECT%" "sources_%PROJECT%_old" 1>nul 2>nul

call "%~sdp0\bin\jadx\bin\jadx.bat" "%~s1" --output-dir "%~sdp1\sources_%PROJECT%" --output-dir-src "%~sdp1\sources_%PROJECT%" --output-dir-res "%~sdp1\sources_%PROJECT%\resources" --add-debug-lines --deobf --comments-level debug --log-level debug  2>&1 | "%~sdp0\bin\gnu\tee.exe" "%~sdp0\log_last_java_source_extract.log"
set "EXIT_CODE=%ErrorLevel%"

::pause
popd
exit /b %EXIT_CODE%
