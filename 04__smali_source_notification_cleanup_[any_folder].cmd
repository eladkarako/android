@echo off
chcp 65001 1>nul 2>nul

call "node.exe" "%~sdp0\bin\smali_source_notification_cleanup\nodejs_folder_recursive_file_enumerate_edit_smali_removing_source_line.js" "%~1"  2>&1 | "%~sdp0\bin\gnu\tee.exe" "%~sdp0\log_last_smali_source_notification_cleanup.log"
set "EXIT_CODE=%ErrorLevel%"

echo [INFO] EXIT_CODE: %EXIT_CODE%. 1>&2
::pause
exit /b %EXIT_CODE%

