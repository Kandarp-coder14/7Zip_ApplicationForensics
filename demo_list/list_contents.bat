@echo off
REM Usage: list_contents.bat [archive]
IF "%~1"=="" (
  set "ARCHIVE=%~dp0..\demo_compress\sample.7z"
) else (
  set "ARCHIVE=%~1"
)
if not defined 7ZIP set "7ZIP=7z"

echo Listing contents of "%ARCHIVE%"
"%7ZIP%" l "%ARCHIVE%"
