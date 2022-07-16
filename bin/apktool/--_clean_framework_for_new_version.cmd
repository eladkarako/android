::@echo off

del /f /q /s "%LocalAppData%\apktool\framework\*"
rmdir  /q /s "%LocalAppData%\apktool\framework\"

del /f /q /s "%UserProfile%\AppData\Local\apktool\framework\*"
rmdir  /q /s "%UserProfile%\AppData\Local\apktool\framework\"

pause