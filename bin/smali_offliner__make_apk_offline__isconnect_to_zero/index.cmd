@echo off
chcp 65001 1>nul 2>nul

call "node.exe" "%~sdp0\nodejs_folder_recursive_file_enumerate_edit_smali_multiline_connection_check_to_zero.js" "%~1"
set "EXIT_CODE=%ErrorLevel%"

echo [INFO] EXIT_CODE: %EXIT_CODE%. 1>&2
pause
exit /b %EXIT_CODE%

