@echo off
chcp 65001 1>nul 2>nul

call "apktool.cmd" --advanced   >readme_apktool.nfo

exit /b %ErrorLevel%
