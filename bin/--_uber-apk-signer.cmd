@echo off
chcp 65001 1>nul 2>nul

call "%~sdp0\uber-apk-signer\uber-apk-signer.cmd" %*
set "EXIT_CODE=%ErrorLevel%"
exit /b %EXIT_CODE%
