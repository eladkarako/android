@echo off
chcp 65001 1>nul 2>nul

set "SINGLE_ACTION=07__zip_[any_folder].cmd"
set "SINGLE_ACTION=%~dp0\%SINGLE_ACTION%"

:LOOP
  if ["%~1"] EQU [""] ( goto END )
  call "%SINGLE_ACTION%" "%~1"
  call "timeout.exe" /T 1 /NOBREAK 1>nul 2>nul
  goto NEXT

:NEXT
  shift
  goto LOOP

:END
  exit /b 0