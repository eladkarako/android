@echo off
chcp 65001 1>nul 2>nul
call "java.exe" -jar "%~sdp0\build-tools\lib\apksigner.jar" %*
set "EXIT_CODE=%ErrorLevel%"
exit /b %EXIT_CODE%
