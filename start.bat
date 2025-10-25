@echo off
setlocal enabledelayedexpansion
setlocal DisableDelayedExpansion
mode con: cols=120 lines=40

title QuikFPS [console]

:: === Check for admin rights ===
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo INITIATING....
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
  exit /b
)

:: Show a simple security warning (non-blocking)
powershell -NoProfile -Command "Add-Type -AssemblyName PresentationCore,PresentationFramework; $msg='Please make a backup of your system before using this app.'; [System.Windows.MessageBox]::Show($msg,'Security warning',[System.Windows.MessageBoxButton]::OK,[System.Windows.MessageBoxImage]::Warning)" >nul 2>&1 || echo [WARNING] Please back up your system before using this app.

:: === Settings ===
set "required_version=3.11.4"
set "main_script=main.py"
set "package_cache=.quikfps_packages_installed"
set "requirements_hash=.quikfps_requirements_hash"
set "installer_file=python-%required_version%-amd64.exe"
set "python_url=https://www.python.org/ftp/python/%required_version%/%installer_file%"

:: === Set working directory to script location ===
cd /d "%~dp0"

:: === Logo ===
:: === Logo ===
echo [95m  ________        .__ __      _____   [0m
echo [95m \_____  \  __ __^|__^|  ^| ___/ ____\_____  ______[0m
echo [95m  /  / \  \^|  ^|  \  ^|  ^|/ /\   __\\____ \/  ___/[0m
echo [95m /   \_/.  \  ^|  /  ^|    ^<  ^|  ^|  ^|  ^|_^> ^>___ \ [0m
echo [95m \_____\ \_/____/^|__^|__^|_ \ ^|__^|  ^|   __/____  ^>[0m
echo [95m        \__^>             \/       ^|__^|       \/[0m
echo.
echo.
echo [INFO] QuikFPS - Ultimate Windows Performance Optimizer
echo [INFO] Made by Saaransh_Xd
del tweak_posts.json 2>nul
:: === Check for Python installation ===       
set "version="
for /f "tokens=2 delims= " %%a in ('python --version 2^>nul') do set "version=%%a"

if not defined version (
    echo [INFO] Python not found.
    goto install_python
) else (
    echo [INFO] Python found: %version%
)

:: === Check for requirements.txt ===
if not exist "requirements.txt" (
    echo [WARNING] requirements.txt not found. Skipping package installation.
    goto run_main
)

:: === Check if packages need to be installed ===
call :check_packages_needed
if "%packages_needed%"=="0" (
    echo [INFO] All required packages are already installed and up to date.
    goto update_check
)

echo [INFO] Installing/updating required Python packages...
python -m pip install --upgrade pip >nul 2>&1
python -m pip install -r requirements.txt >nul 2>&1
if %errorLevel%==0 (
    call :save_package_state
    echo [INFO] Packages installed successfully.
) else (
    echo [ERROR] Failed to install some packages.
    pause
)

:run_main
echo [INFO] Running QuikFPS...
echo [INFO] Done.

if exist "%main_script%" (
    python main.py
) else (
    echo [ERROR] %main_script% not found!
    pause
    exit /b 1
)

if exist "key.exe" (
    start "" "%~dp0key.exe"
)

goto end

:check_packages_needed
set "packages_needed=1"

:: If no cache, we need to install
if not exist "%package_cache%" (
    echo [INFO] No package cache found. Will install packages.
    goto :eof
)

:: Compute a simple hash of requirements.txt (concatenate lines)
set "hash_result="
if exist "requirements.txt" (
    for /f "usebackq delims=" %%a in ("requirements.txt") do set "hash_result=!hash_result!%%a"
)
set "current_hash=%hash_result%"
if exist "%requirements_hash%" (
    for /f "usebackq delims=" %%a in ("%requirements_hash%") do set "saved_hash=%%a"
    
    if "%current_hash%"=="%saved_hash%" (
        echo [INFO] Requirements unchanged since last install.
        set "packages_needed=0"
    ) else (
        echo [INFO] requirements.txt has changed. Will reinstall packages.
    )
) else (
    echo [INFO] No hash file found. Will install packages.
)
goto :eof

:save_package_state
echo Package installation completed on %date% %time% > "%package_cache%"
:: Save current requirements hash
set "hash_result="
for /f "usebackq delims=" %%a in ("requirements.txt") do set "hash_result=!hash_result!%%a"

echo %hash_result% > "%requirements_hash%"

echo [INFO] Package state saved.
goto :eof

:install_python
echo [INFO] Attempting to download Python %required_version%...
set "installer_file=python-%required_version%-amd64.exe"
set "python_url=https://www.python.org/ftp/python/%required_version%/%installer_file%"

powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%python_url%','%installer_file%')" || (
    echo [ERROR] Failed to download installer via PowerShell. Trying curl...
    curl -L -o "%installer_file%" "%python_url%" || (
        echo [ERROR] Failed to download Python installer. Please install Python %required_version% manually.
        pause
        exit /b 1
    )
)

echo [INFO] Installing Python silently...
start /wait "" "%cd%\%installer_file%" /quiet InstallAllUsers=1 PrependPath=1 Include_test=0 || (
    echo [ERROR] Python installer failed or requires interactive install. Please install Python manually.
    pause
    exit /b 1
)

:: Refresh environment: try refreshenv (from Chocolatey) then fallback to adding common install paths
call refreshenv 2>nul || (
    set "PATH=%PATH%;%LOCALAPPDATA%\Programs\Python\Python%required_version:\.= %%;%LOCALAPPDATA%\Programs\Python\Python%required_version%\Scripts%"
)

:: Verify installation
set "newver="
for /f "tokens=2 delims= " %%a in ('python --version 2^>nul') do set "newver=%%a"
if not defined newver (
    echo [ERROR] Failed to install Python. Please install manually and restart the terminal.
    pause
    exit /b 1
) else (
    echo [INFO] Python %newver% installed successfully.
    del "%installer_file%" 2>nul
    if exist "%package_cache%" del "%package_cache%"
    if exist "%requirements_hash%" del "%requirements_hash%"
)
goto :eof

:end
timeout 3 > nul
exit /b