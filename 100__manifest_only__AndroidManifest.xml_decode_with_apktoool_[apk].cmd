@echo off
chcp 65001 1>nul 2>nul
pushd "%~sdp0"

title %~nx1

::------------------------------------- (compatible folder name)
set "PROJECT=%~nx1###"
set "PROJECT=%PROJECT:.apk###=%"
set "PROJECT=%PROJECT:.zip###=%"
set "PROJECT=%PROJECT:###=%"
set "PROJECT=%PROJECT:.=_%"

set "ARGS="
::------------------------------------- (pre-action)
set  ARGS=%ARGS% --verbose
::------------------------------------- (action)
set  ARGS=%ARGS% decode
::------------------------------------- don't write out debug info: .local, .param, .line
set  ARGS=%ARGS% --no-debug-info
::------------------------------------- Force delete destination directory.
set  ARGS=%ARGS% --force
::------------------------------------- Decode the APK's compiled manifest, even if decoding of resources is set to "false".
set  ARGS=%ARGS% --force-manifest
::------------------------------------- Use if there was an error and some resources were dropped, e.g. "Invalid config flags detected. Dropping resources", but you want to decode them anyway, even with errors. You will have to fix them manually before building.
::set  ARGS=%ARGS% --keep-broken-res
::------------------------------------- Do not decode assets.
set  ARGS=%ARGS% --no-assets
::------------------------------------- Do not decode resources.
set  ARGS=%ARGS% --no-res
::------------------------------------- Do not decode sources.
set  ARGS=%ARGS% --no-src
::------------------------------------- The name of folder that gets written. Default is apk.out
set  ARGS=%ARGS% --output "%TEMP%\project_for_androidmanifestxml_%PROJECT%"
::------------------------------------- (target - fully qualified)
set  ARGS=%ARGS% "%~f1"


set ARGS=%ARGS:\=/%


call "%~sdp0\bin\apktool\apktool.cmd" %ARGS% 2>&1 | "%~sdp0\bin\gnu\tee.exe" "%~sdp0\log_last_view_androidmanifestxml.log"
set "EXIT_CODE=%ErrorLevel%"

if ["%EXIT_CODE%"] NEQ ["0"] ( goto ERROR_APKTOOL )

if not exist "%TEMP%\project_for_androidmanifestxml_%PROJECT%\AndroidManifest.xml" ( goto ERROR_NO_ANDROIDMANIFESTXML )

call "%~sdp0\bin\notepad3\notepad3.exe" "%TEMP%\project_for_androidmanifestxml_%PROJECT%\AndroidManifest.xml"

goto END

:ERROR_APKTOOL
  echo [ERROR] APKTool ended with an error.
  goto END

:ERROR_NO_ANDROIDMANIFESTXML
  echo [ERROR] no AndroidManifest.xml at "%TEMP%\project_for_androidmanifestxml_%PROJECT%\" .
  set "EXIT_CODE=111"
  goto END

:END
  echo [INFO] EXIT_CODE: %EXIT_CODE%.
  ::pause
  popd
  exit /b %EXIT_CODE%
