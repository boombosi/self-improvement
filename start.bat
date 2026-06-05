@echo off
title SelfBank
cd /d "%~dp0"

echo ==============================
echo   Learning Dashboard Startup
echo ==============================

if not exist "venv\Scripts\activate.bat" (
    echo [ERROR] venv not found. Run: python -m venv venv
    pause
    exit
)

call venv\Scripts\activate.bat

echo.
echo ==============================
echo   Server starting...
echo   Open: http://selfbank.localhost:5000
echo   Press Ctrl+C to stop
echo ==============================
echo.

start /b python app.py
echo   Waiting for server to start...
timeout /t 3 /nobreak >nul
start http://selfbank.localhost:5000
echo   Server is running. Press Ctrl+C to stop.
pause
