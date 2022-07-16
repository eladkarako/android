@echo off
chcp 65001 1>nul 2>nul

call "node.exe" "%~sdp0\index.js" "%~1"
set "EXIT_CODE=%ErrorLevel%"

echo [INFO] EXIT_CODE: %EXIT_CODE%. 1>&2
exit /b %EXIT_CODE%

