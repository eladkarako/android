@echo off
chcp 65001 1>nul 2>nul

call "node.exe" "%~sdp0\bin\smali_offliner__make_apk_offline__isconnect_to_zero\nodejs_folder_recursive_file_enumerate_edit_smali_multiline_connection_check_to_zero.js" "%~1"  2>&1 | "%~sdp0\bin\gnu\tee.exe" "%~sdp0\log_last_smali_offliner__make_apk_offline__isconnect_to_zero.log"
set "EXIT_CODE=%ErrorLevel%"

echo [INFO] EXIT_CODE: %EXIT_CODE%. 1>&2
::pause
exit /b %EXIT_CODE%

