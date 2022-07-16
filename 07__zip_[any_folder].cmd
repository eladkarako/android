@echo off
chcp 65001 1>nul 2>nul


if ["%~1"] EQU [""] ( goto ERROR_NO_ARG )


set "TIMESTAMP="
for /f "tokens=*" %%a in ('call "%~sdp0\bin\get_timestamp\index.cmd" 2^>nul') do ( set "TIMESTAMP=%%a" ) 


pushd "%~s1"

set "NAME_SHORT=%~snx1###"
set "NAME_SHORT=%NAME_SHORT:.apk###=%"
set "NAME_SHORT=%NAME_SHORT:.zip###=%"
set "NAME_SHORT=%NAME_SHORT:###=%"
set "NAME_SHORT=%NAME_SHORT%_repack_%TIMESTAMP%.apk"

set "NAME_LONG=%~nx1###"
set "NAME_LONG=%NAME_LONG:.apk###=%"
set "NAME_LONG=%NAME_LONG:.zip###=%"
set "NAME_LONG=%NAME_LONG:###=%"
set "NAME_LONG=%NAME_LONG%_repack_%TIMESTAMP%.apk"

ren "..\%NAME_LONG%" "%NAME_LONG%.old" 1>nul 2>nul
call "%~sdp0\bin\zip\zip.exe" -0Dr "..\%NAME_LONG%" .   2>&1 | "%~sdp0\bin\gnu\tee.exe" "%~sdp0\log_last_zip.log"
set "EXIT_CODE=%ErrorLevel%"

goto END


:ERROR_NO_ARG
  echo [ERROR] missing argument (folder)
  set "EXIT_CODE=111"
  goto END


:END
  echo EXIT_CODE: %EXIT_CODE%.
  ::pause
  popd
  exit /b %EXIT_CODE%
