@echo off
:: Windows Privacy Enhancement Script
:: Run as Administrator

echo ========================================
echo Windows Privacy Enhancement Script
echo ========================================
echo.
echo WARNING: This script will modify system settings
echo to enhance privacy by disabling telemetry and
echo data collection features.
echo.
echo Press Ctrl+C to cancel, or
pause

:: Check for admin rights
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ERROR: This script requires Administrator privileges
    echo Please right-click and select "Run as administrator"
    pause
    exit /b 1
)

echo.
echo Starting privacy enhancements...
echo.

:: Disable Telemetry
echo [1/15] Disabling Telemetry Services...
sc stop DiagTrack >nul 2>&1
sc config DiagTrack start=disabled >nul 2>&1
sc stop dmwappushservice >nul 2>&1
sc config dmwappushservice start=disabled >nul 2>&1

:: Disable Windows Error Reporting
echo [2/15] Disabling Windows Error Reporting...
sc stop WerSvc >nul 2>&1
sc config WerSvc start=disabled >nul 2>&1

:: Disable Data Collection via Registry
echo [3/15] Disabling Data Collection...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable Activity History
echo [4/15] Disabling Activity History...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v EnableActivityFeed /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v PublishUserActivities /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v UploadUserActivities /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable Location Tracking
echo [5/15] Disabling Location Tracking...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v DisableLocation /t REG_DWORD /d 1 /f >nul 2>&1

:: Disable Advertising ID
echo [6/15] Disabling Advertising ID...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v DisabledByGroupPolicy /t REG_DWORD /d 1 /f >nul 2>&1

:: Disable Cortana
echo [7/15] Disabling Cortana...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable Web Search in Start Menu
echo [8/15] Disabling Web Search in Start Menu...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v DisableWebSearch /t REG_DWORD /d 1 /f >nul 2>&1

:: Disable Windows Tips
echo [9/15] Disabling Windows Tips...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableSoftLanding /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsSpotlightFeatures /t REG_DWORD /d 1 /f >nul 2>&1

:: Disable Customer Experience Improvement Program
echo [10/15] Disabling Customer Experience Improvement Program...
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /disable >nul 2>&1

:: Disable Application Telemetry
echo [11/15] Disabling Application Telemetry...
schtasks /change /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /disable >nul 2>&1

:: Disable Feedback Notifications
echo [12/15] Disabling Feedback Notifications...
reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v NumberOfSIUFInPeriod /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v DoNotShowFeedbackNotifications /t REG_DWORD /d 1 /f >nul 2>&1

:: Disable Typing Insights
echo [13/15] Disabling Typing Insights...
reg add "HKCU\SOFTWARE\Microsoft\Input\TIPC" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable OneDrive Sync
echo [14/15] Disabling OneDrive...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v DisableFileSyncNGSC /t REG_DWORD /d 1 /f >nul 2>&1

:: Block Microsoft Telemetry Domains via Hosts File (Optional)
echo [15/15] Updating hosts file to block telemetry domains...
echo 0.0.0.0 vortex.data.microsoft.com >> %WINDIR%\System32\drivers\etc\hosts
echo 0.0.0.0 vortex-win.data.microsoft.com >> %WINDIR%\System32\drivers\etc\hosts
echo 0.0.0.0 telecommand.telemetry.microsoft.com >> %WINDIR%\System32\drivers\etc\hosts
echo 0.0.0.0 oca.telemetry.microsoft.com >> %WINDIR%\System32\drivers\etc\hosts
echo 0.0.0.0 sqm.telemetry.microsoft.com >> %WINDIR%\System32\drivers\etc\hosts
echo 0.0.0.0 watson.telemetry.microsoft.com >> %WINDIR%\System32\drivers\etc\hosts
