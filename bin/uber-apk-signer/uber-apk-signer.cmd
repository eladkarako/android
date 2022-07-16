@echo off
chcp 65001 1>nul 2>nul

::---------------------------------- locale environment variables (prevents operation-system effecting output).
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


call "java.exe" -jar "%~sdp0\uber-apk-signer-1.2.1.jar" %*
set "EXIT_CODE=%ErrorLevel%"
exit /b %EXIT_CODE%
