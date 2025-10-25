@echo off
setlocal enabledelayedexpansion

:: 1. Set GPU to Maximum Performance via Registry
echo [1/50] Setting GPU to Maximum Performance...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v CsEnabled /t REG_DWORD /d 0 /f >nul

:: 2. Disable GPU Power Saving
echo [2/50] Disabling GPU Power Saving...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v DefaultD3TransitionLatencyActivelyUsed /t REG_DWORD /d 0 /f >nul

:: 3. Disable Power Throttling
echo [3/50] Disabling Power Throttling...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v PowerThrottlingOff /t REG_DWORD /d 1 /f >nul

:: 4. Disable USB Power Savings
echo [4/50] Disabling USB Power Savings...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USB" /v DisableSelectiveSuspend /t REG_DWORD /d 1 /f >nul

:: 5. Disable PCI Express Link State Management
echo [5/50] Disabling PCI Express Link State Management...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\pci\Parameters" /v EnablePCIeLinkPowerManagement /t REG_DWORD /d 0 /f >nul

:: 6. Disable Windows Game Bar
echo [6/50] Disabling Windows Game Bar...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f >nul

:: 7. Disable Game DVR
echo [7/50] Disabling Game DVR...
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul

:: 8. Set Hardware-Accelerated GPU Scheduling
echo [8/50] Enabling Hardware-Accelerated GPU Scheduling...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 2 /f >nul

:: 9. Optimize NVIDIA settings (if present)
echo [9/50] Optimizing NVIDIA Power Management...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v PowerMizerEnable /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v PowerMizerLevel /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v PerfLevelSrc /t REG_DWORD /d 8738 /f >nul 2>&1

:: 10. Disable Full-Screen Optimizations
echo [10/50] Disabling Full-Screen Optimizations...
reg add "HKCU\System\GameConfigStore" /v GameDVR_FSEBehaviorMode /t REG_DWORD /d 2 /f >nul

:: 11. Disable Nagle's Algorithm for Gaming
echo [11/50] Disabling Nagle's Algorithm...
for /f "tokens=*" %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /s /f "DhcpIPAddress" ^| findstr "HKEY"') do (
    reg add "%%i" /v TcpAckFrequency /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "%%i" /v TCPNoDelay /t REG_DWORD /d 1 /f >nul 2>&1
)

:: 12. Set Network Throttling Index
echo [12/50] Optimizing Network Throttling...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 4294967295 /f >nul

:: 13. Set System Responsiveness
echo [13/50] Setting System Responsiveness...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f >nul

:: 14. Disable VSync in Registry
echo [14/50] Disabling VSync in Registry...
reg add "HKCU\Software\Microsoft\DirectX\UserGpuPreferences" /v VSync /t REG_DWORD /d 0 /f >nul

:: 15. Enable GPU Priority
echo [15/50] Setting GPU Priority to High...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul

:: 16. Set GPU Scheduling Priority
echo [16/50] Setting GPU Scheduling Priority...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v Priority /t REG_DWORD /d 6 /f >nul

:: 17. Set Gaming Scheduling Category
echo [17/50] Optimizing Gaming Scheduling Category...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul

:: 18. Disable Animations
echo [18/50] Disabling Visual Animations...
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f >nul

:: 19. Disable Visual Effects
echo [19/50] Disabling Visual Effects...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul

:: 20. Disable Transparency Effects
echo [20/50] Disabling Transparency Effects...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 0 /f >nul

echo.
echo ========================================
echo RISKY OPTIMIZATIONS AHEAD!
echo ========================================
echo.
echo WARNING: The following tweaks may cause instability
echo Continue only if you know what you're doing!
echo.
set /p risky="Apply risky optimizations? (Y/N): "
if /i not "%risky%"=="Y" goto :skip_risky

:: 21. Disable Driver Updates via Windows Update
echo [21/50] Disabling Driver Updates via Windows Update...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v SearchOrderConfig /t REG_DWORD /d 0 /f >nul

:: 22. Disable Windows Update (RISKY)
echo [22/50] Disabling Windows Update...
sc config wuauserv start=disabled >nul

:: 23. Disable Windows Defender Real-Time Protection (RISKY)
echo [23/50] Disabling Windows Defender...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f >nul

:: 24. Disable Memory Compression
echo [24/50] Disabling Memory Compression...
powershell -Command "Disable-MMAgent -MemoryCompression" >nul 2>&1

:: 25. Disable Page Combining
echo [25/50] Disabling Page Combining...
powershell -Command "Disable-MMAgent -PageCombining" >nul 2>&1

:: 26. Set BCLK to Maximum (WARNING: Can cause instability)
echo [26/50] Setting BCLK Optimization...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v DisableTsx /t REG_DWORD /d 0 /f >nul

:: 27. Disable Core Parking
echo [27/50] Disabling CPU Core Parking...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v ValueMax /t REG_DWORD /d 0 /f >nul

:: 28. Set CPU Priority to High
echo [28/50] Setting CPU Priority to High...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f >nul

:: 29. Disable Prefetch
echo [29/50] Disabling Prefetch...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnablePrefetcher /t REG_DWORD /d 0 /f >nul

:: 30. Disable Superfetch/SysMain
echo [30/50] Disabling Superfetch...
sc stop "SysMain" >nul 2>&1
sc config "SysMain" start=disabled >nul 2>&1

:: 31. Disable Windows Search
echo [31/50] Disabling Windows Search...
sc stop "WSearch" >nul 2>&1
sc config "WSearch" start=disabled >nul 2>&1

:: 32. Disable Print Spooler
echo [32/50] Disabling Print Spooler...
sc stop "Spooler" >nul 2>&1
sc config "Spooler" start=disabled >nul 2>&1

:: 33. Disable BITS
echo [33/50] Disabling Background Intelligent Transfer Service...
sc stop "BITS" >nul 2>&1
sc config "BITS" start=disabled >nul 2>&1

:: 34. Set Large System Cache
echo [34/50] Enabling Large System Cache...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /t REG_DWORD /d 1 /f >nul

:: 35. Disable Paging Executive
echo [35/50] Disabling Paging Executive...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v DisablePagingExecutive /t REG_DWORD /d 1 /f >nul

:: 36. Set IRQ Priority for GPU
echo [36/50] Setting IRQ Priority for GPU...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v IRQ8Priority /t REG_DWORD /d 1 /f >nul

:: 37. Disable HPET (High Precision Event Timer)
echo [37/50] Disabling HPET...
bcdedit /deletevalue useplatformclock >nul 2>&1

:: 38. Disable Dynamic Tick
echo [38/50] Disabling Dynamic Tick...
bcdedit /set disabledynamictick yes >nul 2>&1

:: 39. Set TSC Sync Policy
echo [39/50] Setting TSC Sync Policy...
bcdedit /set tscsyncpolicy enhanced >nul 2>&1

:: 40. Disable CPU Mitigations for Spectre/Meltdown
echo [40/50] Disabling CPU Mitigations (Security Risk!)...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverride /t REG_DWORD /d 3 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverrideMask /t REG_DWORD /d 3 /f >nul

:skip_risky

echo.
echo ========================================
echo EXTREME OPTIMIZATIONS!
echo ========================================
echo.
echo WARNING: These tweaks have HIGH risk of system instability!
echo Only proceed if you have a backup and recovery plan!
echo.
set /p extreme="Apply EXTREME optimizations? (Y/N): "
if /i not "%extreme%"=="Y" goto :skip_extreme

:: 41. Disable NTFS Last Access Time
echo [41/50] Disabling NTFS Last Access Time...
fsutil behavior set disablelastaccess 1 >nul

:: 42. Disable 8.3 Naming
echo [42/50] Disabling 8.3 Naming...
fsutil behavior set disable8dot3 1 >nul

:: 43. Increase GPU Timeout Detection
echo [43/50] Increasing GPU Timeout (TDR) Detection...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v TdrDelay /t REG_DWORD /d 60 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v TdrDdiDelay /t REG_DWORD /d 60 /f >nul

:: 44. Disable TDR (Timeout Detection and Recovery) - VERY RISKY
echo [44/50] Disabling TDR (Can cause black screens!)...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v TdrLevel /t REG_DWORD /d 0 /f >nul

:: 45. Set Maximum Pre-Rendered Frames to 1
echo [45/50] Setting Pre-Rendered Frames...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v MaxPreRenderedFrames /t REG_DWORD /d 1 /f >nul

:: 46. Disable Hibernation
echo [46/50] Disabling Hibernation...
powercfg /hibernate off

:: 47. Set Win32 Priority Separation
echo [47/50] Optimizing Win32 Priority Separation...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 38 /f >nul

:: 48. Disable Memory Dump
echo [48/50] Disabling Memory Dump...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v CrashDumpEnabled /t REG_DWORD /d 0 /f >nul

:: 49. Set GPU Memory Clock to Maximum
echo [49/50] Setting GPU Memory Clock Registry Keys...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v EnableUlps /t REG_DWORD /d 0 /f >nul 2>&1

:: 50. Disable CPU Throttling
echo [50/50] Disabling CPU Throttling...
powercfg -setacvalueindex scheme_current sub_processor THROTTLING 0 >nul

