@echo off
chcp 65001 1>nul 2>nul
call "%~sdp0\jadx\bin\jadx.bat" %*
set "EXIT_CODE=%ErrorLevel%"
exit /b %EXIT_CODE%
