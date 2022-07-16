@echo off
chcp 65001 1>nul 2>nul
call "jarsigner.exe" %*
set "EXIT_CODE=%ErrorLevel%"
exit /b %EXIT_CODE%
