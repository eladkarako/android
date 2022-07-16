@echo off
chcp 65001 1>nul 2>nul


::---------------------------------------------------------------
if ["%~1"]  EQU [""]     ( goto ERROR_NO_ARG_INPUT_FILE    )
if ["%~x1"] NEQ [".apk"] ( goto ERROR_NO_APK_INPUT_FILE    )
if not exist "%~1"       ( goto ERROR_NOT_EXIST_INPUT_FILE )
::---------------------------------------------------------------


::---------------------------------------------------------------
call "where.exe" "java.exe"    1>nul 2>nul
set "EXIT_CODE=%ErrorLevel%"
if ["%EXIT_CODE%"] NEQ ["0"] ( goto ERROR_NO_JAVA )
::---------------------------------------------------------------
call "where.exe" "keytool.exe" 1>nul 2>nul
set "EXIT_CODE=%ErrorLevel%"
if ["%EXIT_CODE%"] NEQ ["0"] ( goto ERROR_NO_KEYTOOL )
::---------------------------------------------------------------


::---------------------------------------------------------------
::this helps if the script runs from explorer where the starting point of CMD is C:\Windows\System32
pushd "%~sdp0"
::---------------------------------------------------------------


::---------------------------------------------------------------
::locale environment variables (prevents operation-system effecting output).
set "LANG=en_US.UTF-8"
set "LANGUAGE=en_US"
set "LC_CTYPE=en_US.UTF-8"
set "LC_NUMERIC=en_US.UTF-8"
set "LC_TIME=en_US.UTF-8"
set "LC_COLLATE=en_US.UTF-8"
set "LC_MONETARY=en_US.UTF-8"
set "LC_MESSAGES=en_US.UTF-8"
set "LC_PAPER=en_US.UTF-8"
set "LC_NAME=en_US.UTF-8"
set "LC_ADDRESS=en_US.UTF-8"
set "LC_TELEPHONE=en_US.UTF-8"
set "LC_MEASUREMENT=en_US.UTF-8"
set "LC_IDENTIFICATION=en_US.UTF-8"
set "LC_ALL=en_US.UTF-8"
set "TZ=UTC"
set "JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF8 -Duser.language=en -Duser.country=US -Dspring.mvc.locale=en_US -Dspring.mvc.locale-resolver=fixed -Duser.timezone=UTC"
::---------------------------------------------------------------


::---------------------------------------------------------------
::remove last \ (if any)
set "HOME=%~sdp0###"
set "HOME=%HOME:\###=%"
set "HOME=%HOME:###=%"
::---------------------------------------------------------------
set "INPUT_FILE=%~1"
set "INPUT_PATH=%~sdp1"
set "KEYSTORE_FILE=%HOME%\bin\foo.keystore"
set "CUSTOM_ZIPALIGN_FILE=%HOME%\bin\build-tools\zipalign.exe"
set "UBER_APK_SIGNER_FILE=%HOME%\bin\uber-apk-signer\uber-apk-signer-1.2.1.jar"
::---------------------------------------------------------------




::---------------------------------------------------------------
::normalize RANDOM from 0-32767 to 87654321-987654321.
set /a PASSWORD=0
set /a PASSWORD=((%RANDOM% * (1 + 987654321 - 87654321)) / (32767 - 0)) + 87654321
::(optional)log random password to file for debugging with 'keystore-explorer'. it's fine.
echo.%PASSWORD%>%HOME%\bin\password.txt
::---------------------------------------------------------------


::---------------------------------------------------------------
::normalize RANDOM from 0-32767 to 311-345. gives a more random certificate. it then duplicate it with 35 to get about 35 years.
set /a DAYS=0
set /a DAYS=((%RANDOM% * (1 + 345 - 311)) / (32767 - 0)) + 311
set /a DAYS=%DAYS% * 35
::---------------------------------------------------------------


::---------------------------------------------------------------
::remove old keystore file.
del /f /q "%KEYSTORE_FILE%"  1>nul 2>nul
::---------------------------------------------------------------


::---------------------------------------------------------------
set "ARGS="
set  ARGS=%ARGS% -genkeypair
set  ARGS=%ARGS% -alias         "cert"
set  ARGS=%ARGS% -keyalg        "RSA"
set  ARGS=%ARGS% -keysize       "2048"
set  ARGS=%ARGS% -sigalg        "SHA256withRSA"
set  ARGS=%ARGS% -deststoretype "PKCS12"
set  ARGS=%ARGS% -validity      "%DAYS%"
set  ARGS=%ARGS% -keypass       "%PASSWORD%"
set  ARGS=%ARGS% -keystore      "%KEYSTORE_FILE%"
set  ARGS=%ARGS% -storepass     "%PASSWORD%"
set  ARGS=%ARGS% -dname         "CN=*, OU=*, O=*, L=*, S=*, C=*"
set  ARGS=%ARGS% -v
call "keytool.exe" %ARGS%      2>&1 | "%~sdp0\bin\gnu\tee.exe" "%~sdp0\log_last_keytool_generator.log"
set "EXIT_CODE=%ErrorLevel%"
if ["%EXIT_CODE%"] NEQ ["0"] ( goto ERROR_KEYSTORE_ERROR )
::---------------------------------------------------------------


::---------------------------------------------------------------
::re-format the paths from \ to / (unix like), java likes it better.
::set "KEYSTORE_FILE=%KEYSTORE_FILE:\=/%"
::set "INPUT_FILE=%INPUT_FILE:\=/%"
::set "CUSTOM_ZIPALIGN_FILE=%CUSTOM_ZIPALIGN_FILE:\=/%"
::---------------------------------------------------------------


::---------------------------------------------------------------
::writing the apk is in the working folder.
  set "ARGS="
  set  ARGS=%ARGS% --apks         "%INPUT_FILE%"
  set  ARGS=%ARGS% --allowResign
::set  ARGS=%ARGS% --overwrite
  set  ARGS=%ARGS% --ks           "%KEYSTORE_FILE%"
  set  ARGS=%ARGS% --ksPass       "%PASSWORD%"
  set  ARGS=%ARGS% --ksAlias      "cert"
  set  ARGS=%ARGS% --ksKeyPass    "%PASSWORD%"
  set  ARGS=%ARGS% --zipAlignPath "%CUSTOM_ZIPALIGN_FILE%"
::set  ARGS=%ARGS% --out          "%INPUT_PATH%"
  set  ARGS=%ARGS% --verbose
  set  ARGS=%ARGS% --debug
call "java.exe" "-Xmx16g" -jar "%UBER_APK_SIGNER_FILE%" %ARGS%  2>&1 | "%~sdp0\bin\gnu\tee.exe" "%~sdp0\log_last_align_and_sign_with_uber_apk_signer.log"
set "EXIT_CODE=%ErrorLevel%"
if ["%EXIT_CODE%"] NEQ ["0"] ( goto ERROR_UBER_APK_SIGNER )
::---------------------------------------------------------------

echo. 1>&2
echo. 1>&2

goto END


:ERROR_NO_ARG_INPUT_FILE
  echo [ERROR] missing an argument (apk file). 1>&2
  set "EXIT_CODE=111"
  goto END

:ERROR_NO_APK_INPUT_FILE
  echo [ERROR] input is not apk, uber-apk-signer can only handle apk files. 1>&2
  set "EXIT_CODE=222"
  goto END
  
:ERROR_NOT_EXIST_INPUT_FILE
  echo [ERROR] argument not found. 1>&2
  set "EXIT_CODE=333"
  goto END
  
:ERROR_NO_JAVA
  echo [ERROR] no 'java.exe' in the PATH environment-variable. 1>&2
  goto END

:ERROR_NO_KEYTOOL
  echo [ERROR] no 'keytool.exe' (part of Java) in the PATH environment-variable. 1>&2
  goto END
  
:ERROR_KEYSTORE_ERROR
  echo [ERROR] 'keytool.exe' ended with an error. 1>&2
  goto END

:ERROR_UBER_APK_SIGNER
  echo [ERROR] 'uber-apk-signer' ended with an error. 1>&2
  goto END
  
::----------------------------------------  

:END
  echo [INFO] EXIT_CODE: %EXIT_CODE%. 1>&2
  ::pause
  popd
  exit /b %EXIT_CODE%

