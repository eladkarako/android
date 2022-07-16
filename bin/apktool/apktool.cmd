@echo off
chcp 65001 1>nul 2>nul

::set "APKTOOL=apktool__2.6.1-6cfe29-SNAPSHOT.jar"
::set "APKTOOL=apktool__2.6.1-61fbc5-SNAPSHOT_mod_aapt2_google.jar"
::set "APKTOOL=apktool__2.6.1-61fbc5-SNAPSHOT.jar"
::set "APKTOOL=apktool__2.6.1-d29411-SNAPSHOT.jar"
::set "APKTOOL=apktool__2.6.1-9bdf38-SNAPSHOT.jar"
::set "APKTOOL=apktool__2.6.0.jar"
::set "APKTOOL=apktool__2.5.0.jar"
::set "APKTOOL=apktool__2.4.2-0143dc-SNAPSHOT.jar"
::set "APKTOOL=apktool__2.4.1.jar"
::set "APKTOOL=apktool__2.1.1-77d245-SNAPSHOT.jar"
::set "APKTOOL=apktool__2.1.0-1ff3a3-SNAPSHOT.jar"
::set "APKTOOL=apktool__2.6.1-a269a8-SNAPSHOT.jar"
::set "APKTOOL=2022-02-26__2.6.2-adc942-SNAPSHOT__smali_2.5.2__baksmali_2.5.2/apktool-cli-all.jar"
::set "APKTOOL=2022-04-25__2.6.2-d38ece-SNAPSHOT__smali_2.5.2__baksmali_2.5.2/apktool-cli-all.jar"
::set "APKTOOL=2022-05-23__2.6.2-7e71ad-SNAPSHOT__smali_2.5.2__baksmali_2.5.2/apktool-cli-all.jar"
  set "APKTOOL=2022-07-10__2.6.2-7a2c0c-SNAPSHOT__smali_2.5.2__baksmali_2.5.2/apktool-cli-all.jar"


::set ARGS=%*
::set ARGS=%ARGS:\=/%



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
set "JAVA_TOOL_OPTIONS=-XX:+UseLargePages -Dfile.encoding=UTF8 -Duser.language=en -Duser.country=US -Dspring.mvc.locale=en_US -Dspring.mvc.locale-resolver=fixed -Duser.timezone=UTC"



call "java.exe" "-Xmx16g" "-jar" "%~sdp0%APKTOOL%" %*
exit /b %ErrorLevel%
