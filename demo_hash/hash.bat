@echo off
REM Usage: hash.bat [file]
IF "%~1"=="" (
  set "TARGET=%~dp0..\demo_compress\sample.7z"
) else (
  set "TARGET=%~1"
)
echo Computing SHA256 for "%TARGET%"
CertUtil -hashfile "%TARGET%" SHA256
