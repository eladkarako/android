::-- loop all exe files.
::-- parse name part (without .exe).
::-- dump both stdout and stderr to same stream and output to file. some exe files uses stderr for extra notes.

for %%e in (*.exe) do ( 
  for /f %%a in ("%%e") do ( 
    call "%%e" --help 1>"%%~na_readme.nfo" 2>&1
  )
) 
