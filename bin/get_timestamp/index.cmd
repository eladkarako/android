@echo off
chcp 65001 1>nul 2>nul

call where "node.exe" 1>nul 2>nul
set "EXIT_CODE=%ErrorLevel%"
if ["%EXIT_CODE%"] NEQ ["0"] ( goto END ) 


call "node.exe" "%~sdp0\index.js" "%~1"
set "EXIT_CODE=%ErrorLevel%"


:END
exit /b %EXIT_CODE%

