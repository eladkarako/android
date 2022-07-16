@echo off
chcp 65001 2>nul >nul


::this directory (8.3 name).
set "HOME=%~sdp0"
::remove '\' suffix.  
set "HOME=%HOME%##"
set "HOME=%HOME:\##=%"
set "HOME=%HOME:##=%"


set "FILE_KEYSTORE=%HOME%\foo.keystore"


set "KEYTOOL="
for /f "tokens=*" %%a in ('where keytool.exe 2^>nul') do ( set "KEYTOOL=%%a"    )
if ["%KEYTOOL%"] EQU [""]      ( goto ERROR_NOKEYTOOL )
for /f %%a in ("%KEYTOOL%") do ( set "KEYTOOL=%%~fsa" )
if not exist %KEYTOOL%         ( goto ERROR_NOKEYTOOL )


::remove old keystore file.
del /f /q "%FILE_KEYSTORE%"   2>nul >nul


::re-format the path to a better compatible unix-like rtl-slash path.
set "FILE_KEYSTORE=%FILE_KEYSTORE:\=/%"


::normalize RANDOM from 0-32767 to 311-345. gives a more random certificate. it then duplicate it with 35 to get about 35 years.
set /a DAYS=0
set /a DAYS=((%RANDOM% * (1 + 345 - 311)) / (32767 - 0)) + 311
set /a DAYS=%DAYS% * 35


set "ARGS="
set  ARGS=%ARGS% -genkeypair
::set  ARGS=%ARGS% -alias      "alias_name"
set  ARGS=%ARGS% -alias      "cert"

::----------------------------------------- old
::set  ARGS=%ARGS% -keyalg        "RSA"
::set  ARGS=%ARGS% -keysize       "2048"
::set  ARGS=%ARGS% -sigalg        "SHA1withRSA"
::set  ARGS=%ARGS% -deststoretype "JKS"

::----------------------------------------- default
set  ARGS=%ARGS% -keyalg        "RSA"
set  ARGS=%ARGS% -keysize       "2048"
set  ARGS=%ARGS% -sigalg        "SHA256withRSA"
set  ARGS=%ARGS% -deststoretype "PKCS12"

::----------------------------------------- better (not supported with APKSIGNER)
::set  ARGS=%ARGS% -keyalg        "RSA"
::set  ARGS=%ARGS% -keysize       "4096"
::set  ARGS=%ARGS% -sigalg        "SHA512withRSA"
::set  ARGS=%ARGS% -deststoretype "PKCS12"


::set  ARGS=%ARGS% -validity   "10000"
set  ARGS=%ARGS% -validity   "%DAYS%"
set  ARGS=%ARGS% -keypass    "12345678"
::set  ARGS=%ARGS% -keystore   "foo.keystore"
set  ARGS=%ARGS% -keystore   "%FILE_KEYSTORE%"
set  ARGS=%ARGS% -storepass  "12345678"
set  ARGS=%ARGS% -dname      "CN=*, OU=*, O=*, L=*, S=*, C=*"
set  ARGS=%ARGS% -v

::set "KEYTOOL=d:\Software\Java\8\x64\jdk1.8.0_151\bin\keytool.exe"

echo "%KEYTOOL%" %ARGS%
call "%KEYTOOL%" %ARGS%
set "EXIT_CODE=%ErrorLevel%"

::migrate to 'pkcs12'
::call "%KEYTOOL%" -importkeystore -srckeystore "%FILE_KEYSTORE%" -destkeystore "%FILE_KEYSTORE%" -deststoretype "pkcs12" -v


goto END


:ERROR_NOKEYTOOL
  echo [ERROR] can not find keytool.exe     1>&2
  set "EXIT_CODE=1111"
  goto END


:END
  ::pause 1>&2
  exit /b %EXIT_CODE%
