@echo off
:: Windows Services & Performance Optimizer
:: Run as Administrator

echo.
echo Starting optimization process...
echo.

:: Disable Windows Search
echo [1/30] Disabling Windows Search...
sc stop "WSearch" >nul 2>&1
sc config "WSearch" start=disabled >nul 2>&1

:: Disable Superfetch/SysMain
echo [2/30] Disabling Superfetch/SysMain...
sc stop "SysMain" >nul 2>&1
sc config "SysMain" start=disabled >nul 2>&1

:: Disable Print Spooler (if you don't print)
echo [3/30] Disabling Print Spooler...
sc stop "Spooler" >nul 2>&1
sc config "Spooler" start=disabled >nul 2>&1

:: Disable Fax Service
echo [4/30] Disabling Fax Service...
sc stop "Fax" >nul 2>&1
sc config "Fax" start=disabled >nul 2>&1

:: Disable Windows Biometric Service
echo [5/30] Disabling Windows Biometric Service...
sc stop "WbioSrvc" >nul 2>&1
sc config "WbioSrvc" start=disabled >nul 2>&1

:: Disable Bluetooth Support Service
echo [6/30] Disabling Bluetooth Support Service...
sc stop "bthserv" >nul 2>&1
sc config "bthserv" start=disabled >nul 2>&1

:: Disable Remote Registry
echo [7/30] Disabling Remote Registry...
sc stop "RemoteRegistry" >nul 2>&1
sc config "RemoteRegistry" start=disabled >nul 2>&1

:: Disable Windows Mobile Hotspot Service
echo [8/30] Disabling Mobile Hotspot Service...
sc stop "icssvc" >nul 2>&1
sc config "icssvc" start=disabled >nul 2>&1

:: Disable Xbox Services
echo [9/30] Disabling Xbox Services...
sc stop "XblAuthManager" >nul 2>&1
sc config "XblAuthManager" start=disabled >nul 2>&1
sc stop "XblGameSave" >nul 2>&1
sc config "XblGameSave" start=disabled >nul 2>&1
sc stop "XboxGipSvc" >nul 2>&1
sc config "XboxGipSvc" start=disabled >nul 2>&1
sc stop "XboxNetApiSvc" >nul 2>&1
sc config "XboxNetApiSvc" start=disabled >nul 2>&1

:: Disable Windows Update (Manual mode)
echo [10/30] Setting Windows Update to Manual...
sc config "wuauserv" start=demand >nul 2>&1

:: Disable Background Intelligent Transfer Service
echo [11/30] Setting BITS to Manual...
sc config "BITS" start=demand >nul 2>&1

:: Disable HomeGroup Services
echo [12/30] Disabling HomeGroup Services...
sc stop "HomeGroupListener" >nul 2>&1
sc config "HomeGroupListener" start=disabled >nul 2>&1
sc stop "HomeGroupProvider" >nul 2>&1
sc config "HomeGroupProvider" start=disabled >nul 2>&1

:: Disable Tablet Input Service
echo [13/30] Disabling Tablet Input Service...
sc stop "TabletInputService" >nul 2>&1
sc config "TabletInputService" start=disabled >nul 2>&1

:: Disable Windows Defender (if using third-party AV)
echo [14/30] Disabling Windows Defender Services...
sc stop "WdNisSvc" >nul 2>&1
sc config "WdNisSvc" start=disabled >nul 2>&1
sc stop "WinDefend" >nul 2>&1
sc config "WinDefend" start=disabled >nul 2>&1

:: Disable Windows Media Player Network Sharing
echo [15/30] Disabling Windows Media Player Sharing...
sc stop "WMPNetworkSvc" >nul 2>&1
sc config "WMPNetworkSvc" start=disabled >nul 2>&1

:: Optimize Visual Effects for Performance
echo [16/30] Optimizing Visual Effects...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9012038010000000 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewAlphaSelect /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAnimations /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable Animations
echo [17/30] Disabling Animations...
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 0 /f >nul 2>&1

:: Disable Transparency Effects
echo [18/30] Disabling Transparency Effects...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable Startup Delay
echo [19/30] Disabling Startup Delay...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v StartupDelayInMSec /t REG_DWORD /d 0 /f >nul 2>&1

:: Optimize Processor Scheduling for Programs
echo [20/30] Optimizing Processor Scheduling...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 38 /f >nul 2>&1

:: Disable unnecessary Scheduled Tasks
echo [21/30] Disabling Unnecessary Scheduled Tasks...
schtasks /change /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Autochk\Proxy" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Maintenance\WinSAT" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Windows Error Reporting\QueueReporting" /disable >nul 2>&1

:: Disable Cloud Content
echo [22/30] Disabling Cloud Content...
reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f >nul 2>&1

:: Optimize Network Settings
echo [23/30] Optimizing Network Settings...
netsh interface tcp set global autotuninglevel=normal >nul 2>&1
netsh interface tcp set global chimney=enabled >nul 2>&1
netsh interface tcp set global dca=enabled >nul 2>&1
netsh interface tcp set global netdma=enabled >nul 2>&1

:: Disable Network Throttling
echo [24/30] Disabling Network Throttling...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 4294967295 /f >nul 2>&1

:: Optimize System Responsiveness
echo [25/30] Optimizing System Responsiveness...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable Hibernation (Frees up disk space)
echo [26/30] Disabling Hibernation...
powercfg -h off >nul 2>&1

:: Set Power Plan to High Performance
echo [27/30] Setting Power Plan to High Performance...
powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1

:: Disable Fast Startup (Can cause issues)
echo [28/30] Disabling Fast Startup...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 0 /f >nul 2>&1

:: Optimize Paging File
echo [29/30] Optimizing Paging File...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v DisablePagingExecutive /t REG_DWORD /d 1 /f >nul 2>&1

:: Disable App Launch Tracking
echo [30/30] Disabling App Launch Tracking...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_TrackProgs /t REG_DWORD /d 0 /f >nul 2>&1

