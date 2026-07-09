@echo off
setlocal
REM Usage: compress.bat [source_dir] [out_archive]
IF "%~1"=="" (
  set "SRC_DIR=%~dp0sample_files"
) else (
  set "SRC_DIR=%~1"
)
IF "%~2"=="" (
  set "OUT=%~dp0sample.7z"
) else (
  set "OUT=%~2"
)
REM If 7z is not in PATH, set 7ZIP to full path (e.g. C:\Program Files\7-Zip\7z.exe)
if not defined 7ZIP set "7ZIP=7z"
echo Compressing "%SRC_DIR%" -> "%OUT%"
"%7ZIP%" a -t7z "%OUT%" "%SRC_DIR%\*" -mhe=on
echo Done.
endlocal
