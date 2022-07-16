@echo off
chcp 65001 1>nul 2>nul


if ["%~1"] EQU [""] ( goto ERROR_NO_ARG )


pushd "%~sdp0"

::------------------------------------- (clean-up of old build folders)
echo [INFO] cleaning old [DIST]+[BUILD]+[.IDEA] folders...
del /f /s /q  "%~1\dist\*"      1>nul 2>nul
rmdir  /s /q  "%~1\dist\"       1>nul 2>nul
if exist "%~1\dist\" ( goto ERROR_CLEANUP_FAILED_DIST )
del /f /s /q  "%~1\build\*"     1>nul 2>nul
rmdir  /s /q  "%~1\build\"      1>nul 2>nul
if exist "%~1\dist\" ( goto ERROR_CLEANUP_FAILED_BUILD )
del /f /s /q  "%~1\dist\.idea"  1>nul 2>nul
rmdir  /s /q  "%~1\dist\.idea"  1>nul 2>nul
if exist "%~1\dist\" ( goto ERROR_CLEANUP_FAILED_IDEA )
echo [INFO] done.
echo.

set "ARGS="
::------------------------------------- (pre-action)
set  ARGS=%ARGS% --verbose
::------------------------------------- (action)
set  ARGS=%ARGS% build
::------------------------------------- Skip changes detection and build all files.
set  ARGS=%ARGS% --force-all
::------------------------------------- Disable crunching of resource files during the build step (exposed aapt/aapt2 argument to disables PNG processing - see: https://developer.android.com/studio/command-line/aapt2 ).
set  ARGS=%ARGS% --no-crunch
::------------------------------------- Upgrades apktool to use experimental aapt2 binary.
set  ARGS=%ARGS% --use-aapt2
::------------------------------------- (target - fully qualified)
set  ARGS=%ARGS% "%~f1"


set ARGS=%ARGS:\=/%


echo [INFO] building project...
echo.

call "%~sdp0\bin\apktool\apktool.cmd" %ARGS% 2>&1 | "%~sdp0\bin\gnu\tee.exe" "%~sdp0\log_last_build.log"
set "EXIT_CODE=%ErrorLevel%"

echo.
echo [INFO] done.
echo.


goto END


:ERROR_NO_ARG
  echo [ERROR] missing argument (project folder)
  set "EXIT_CODE=111"
  goto END

:ERROR_CLEANUP_FAILED_DIST
  echo [ERROR] dist folder still exists...
  set "EXIT_CODE=222"
  goto END

:ERROR_CLEANUP_FAILED_BUILD
  echo [ERROR] build folder still exists...
  set "EXIT_CODE=222"
  goto END

:ERROR_CLEANUP_FAILED_IDEA
  echo [ERROR] .idea folder still exists...
  set "EXIT_CODE=222"
  goto END

:END
  echo EXIT_CODE: %EXIT_CODE%.
  ::pause
  popd
  exit /b %EXIT_CODE%

