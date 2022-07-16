@echo off
chcp 65001 1>nul 2>nul
call "java.exe" -jar "%~sdp0\apktool\apktool.cmd" %*
set "EXIT_CODE=%ErrorLevel%"
exit /b %EXIT_CODE%
