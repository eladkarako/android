@echo off
chcp 65001 2>nul >nul

del /f /q "%~sdp0\log_last_info_certificate.log" 1>nul 2>nul


echo. 2>&1 | "%~sdp0\bin\gnu\tee.exe" --append "%~sdp0\log_last_info_certificate.log"
echo -------------------------------------------------  2>&1 | "%~sdp0\bin\gnu\tee.exe" --append "%~sdp0\log_last_info_certificate.log"
echo -------------------------------------------------  2>&1 | "%~sdp0\bin\gnu\tee.exe" --append "%~sdp0\log_last_info_certificate.log"
echo.  2>&1 | "%~sdp0\bin\gnu\tee.exe" --append "%~sdp0\log_last_info_certificate.log"

call "%~sdp0\bin\--_jarsigner.cmd" -verify "-verbose:all" "%~s1" 2>&1 | "%~sdp0\bin\gnu\tee.exe" --append "%~sdp0\log_last_info_certificate.log"
  
echo.  2>&1 | "%~sdp0\bin\gnu\tee.exe" --append "%~sdp0\log_last_info_certificate.log"
echo -------------------------------------------------  2>&1 | "%~sdp0\bin\gnu\tee.exe" --append "%~sdp0\log_last_info_certificate.log"
echo -------------------------------------------------  2>&1 | "%~sdp0\bin\gnu\tee.exe" --append "%~sdp0\log_last_info_certificate.log"
echo.  2>&1 | "%~sdp0\bin\gnu\tee.exe" --append "%~sdp0\log_last_info_certificate.log"

call "keytool.exe" -printcert -v -jarfile "%~s1" 2>&1 | "%~sdp0\bin\gnu\tee.exe" --append "%~sdp0\log_last_info_certificate.log"

echo. 2>&1 | "%~sdp0\bin\gnu\tee.exe" --append "%~sdp0\log_last_info_certificate.log"
echo ------------------------------------------------- 2>&1 | "%~sdp0\bin\gnu\tee.exe" --append "%~sdp0\log_last_info_certificate.log"
echo ------------------------------------------------- 2>&1 | "%~sdp0\bin\gnu\tee.exe" --append "%~sdp0\log_last_info_certificate.log"
echo. 2>&1 | "%~sdp0\bin\gnu\tee.exe" --append "%~sdp0\log_last_info_certificate.log"

call "%~sdp0\bin\--_apksigner.cmd" verify --print-certs --verbose --in "%~s1" 2>&1 | "%~sdp0\bin\gnu\tee.exe" --append "%~sdp0\log_last_info_certificate.log"

echo. 2>&1 | "%~sdp0\bin\gnu\tee.exe" --append "%~sdp0\log_last_info_certificate.log"
echo ------------------------------------------------- 2>&1 | "%~sdp0\bin\gnu\tee.exe" --append "%~sdp0\log_last_info_certificate.log"
echo ------------------------------------------------- 2>&1 | "%~sdp0\bin\gnu\tee.exe" --append "%~sdp0\log_last_info_certificate.log"
echo. 2>&1 | "%~sdp0\bin\gnu\tee.exe" --append "%~sdp0\log_last_info_certificate.log"

::pause
exit /b 0
