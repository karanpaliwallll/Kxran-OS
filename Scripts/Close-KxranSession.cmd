@echo off
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Close-KxranSession.ps1" %*
