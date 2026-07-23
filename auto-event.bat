@echo off
cd /d "%~dp0"
python local_tools\auto_pipeline.py %*
pause
