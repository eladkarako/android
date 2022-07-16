@echo off
chcp 65001 1>nul 2>nul

if ["%~1"] EQU [""] ( goto ERROR_NO_ARG )

set "FILE_AAPT2=D:\DOS\android\bin\--_aapt2.cmd"
set "FILE_INPUT=%~f1"
set "FILE_OUTPUT=%TEMP%\aapt2__%~sn1.txt"

echo %DATE% %TIME%   1>"%FILE_OUTPUT%"
echo "%FILE_INPUT%"   1>>"%FILE_OUTPUT%"

for %%x in ( 
  "packagename"
  "badging"
  "permissions"
) do ( 
  call :METHOD__GENERIC %%x
)

start /MAX /ABOVENORMAL "cmd /c "call notepad2.exe /n /o "%FILE_OUTPUT%"""

::start "notepad2" /D "%TEMP%" /MAX /ABOVENORMAL "notepad2.exe" "/n" "/o" "%FILE_OUTPUT%"

goto END


::======================================================================================================
::======================================================================================================
:METHOD__GENERIC
  set "ARGUMENT=%~1"

  echo.                                                   1>&2  1>>"%FILE_OUTPUT%"
  echo.----------------------------------- [%ARGUMENT%]   1>&2  1>>"%FILE_OUTPUT%"
  call "%FILE_AAPT2%" "dump" "%ARGUMENT%" "%FILE_INPUT%"  1>&2  1>>"%FILE_OUTPUT%"
  echo.-----------------------------------                1>&2  1>>"%FILE_OUTPUT%"

  goto :EOF
::======================================================================================================
::======================================================================================================


:ERROR_NO_ARG
  echo [ERROR] missing an argument (apk file path)             1>&2
  goto END

:END
  ::pause
  exit /b 0
