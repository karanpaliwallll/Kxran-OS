@echo off
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Backup-KxranOS.ps1" %*
