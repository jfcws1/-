@echo off
setlocal
cd /d "%~dp0"

set "EDGE=C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
if not exist "%EDGE%" set "EDGE=C:\Program Files\Microsoft\Edge\Application\msedge.exe"

if not exist "%EDGE%" (
  echo Microsoft Edge was not found on this computer.
  pause
  exit /b 1
)

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0start-typing-hero.ps1"
