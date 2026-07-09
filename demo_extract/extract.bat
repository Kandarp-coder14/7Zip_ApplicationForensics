@echo off
setlocal
REM Usage: extract.bat [archive] [output_dir]
IF "%~1"=="" (
  set "ARCHIVE=%~dp0..\demo_compress\sample.7z"
) else (
  set "ARCHIVE=%~1"
)
IF "%~2"=="" (
  set "OUT=%~dp0extracted"
) else (
  set "OUT=%~2"
)
if not defined 7ZIP set "7ZIP=7z"
echo Extracting "%ARCHIVE%" -> "%OUT%"
md "%OUT%" 2>nul
"%7ZIP%" x "%ARCHIVE%" -o"%OUT%"
echo Done.
endlocal
