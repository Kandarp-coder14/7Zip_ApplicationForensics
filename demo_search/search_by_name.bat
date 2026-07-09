@echo off
REM Usage: search_by_name.bat [pattern]
IF "%~1"=="" (
  set "NAME_PATTERN=secret"
) else (
  set "NAME_PATTERN=%~1"
)

echo Searching for "%NAME_PATTERN%" inside archives in "%~dp0..\demo_compress\"
for %%a in ("%~dp0..\demo_compress\*.7z") do (
  echo Checking %%~nxa
  "%~dp0\..\demo_list\..\..\7z.exe" l "%%a" 2>nul | findstr /I /C:"%NAME_PATTERN%" >nul && echo Found in %%a
)

echo Done.
