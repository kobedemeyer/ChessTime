@echo off
title Chess Clock — Local Server
cd /d "%~dp0"

echo.
echo  ============================================
echo   CHESS CLOCK  —  Starting server...
echo  ============================================
echo.

:: Get local IP via ipconfig
set ip=
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /i "IPv4"') do (
    if not defined ip (
        set ip=%%a
    )
)
:: Strip leading space
set ip=%ip: =%

echo   On your PC:
echo   ^> http://localhost:8080/chess-clock.html
echo.
if defined ip (
    echo   On your phone (same WiFi^):
    echo   ^> http://%ip%:8080/chess-clock.html
    echo.
)
echo   Android: Chrome menu ^> "Add to Home Screen"
echo   iPhone:  Safari Share ^> "Add to Home Screen"
echo.
echo   Press Ctrl+C to stop.
echo  ============================================
echo.

python -m http.server 8080
pause
