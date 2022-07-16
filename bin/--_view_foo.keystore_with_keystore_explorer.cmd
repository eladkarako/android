::@echo off
chcp 65001 1>nul 2>nul
call "java" -jar "%~sdp0\keystore_explorer\kse.jar" "%~sdp0/foo.keystore" %*
set "EXIT_CODE=%ErrorLevel%"
exit /b %EXIT_CODE%
