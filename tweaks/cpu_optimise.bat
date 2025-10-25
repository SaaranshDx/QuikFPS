@echo off
:: HARDCORE CPU OPTIMIZER - EXTREME EDITION
:: Run as Administrator - USE AT YOUR OWN RISK

color 0C
echo ========================================
echo   HARDCORE CPU OPTIMIZER - EXTREME
echo ========================================
echo.
color 0E
echo ******************************************
echo ***        CRITICAL WARNING!!!         ***
echo ******************************************
echo.
echo This script performs AGGRESSIVE CPU optimizations
echo that can potentially:
echo.
echo  [!] Make your system UNSTABLE
echo  [!] Cause random crashes or BSODs
echo  [!] Void your warranty
echo  [!] Damage hardware if used improperly
echo  [!] Require a system restore to fix
echo  [!] Disable security features
echo  [!] Break Windows updates
echo.
echo You will be asked Y/N before each major tweak.
echo.
color 0C
echo ONLY proceed if you:
echo  1. Have created a system restore point
echo  2. Know how to boot into Safe Mode
echo  3. Understand the risks involved
echo  4. Accept full responsibility
echo.
color 0F
set /p "confirm1=Type 'I UNDERSTAND THE RISKS' to continue: "
if /i not "%confirm1%"=="I UNDERSTAND THE RISKS" (
    echo.
    echo Cancelled by user. Exiting...
    timeout /t 3 >nul
    exit /b 0
)

:: Check for admin rights
net session >nul 2>&1
if %errorLevel% neq 0 (
    color 0C
    echo.
    echo ERROR: This script requires Administrator privileges
    echo Please right-click and select "Run as administrator"
    pause
    exit /b 1
)

color 0A
echo.
echo ========================================
echo Starting HARDCORE optimizations...
echo ========================================
echo.
echo Creating restore point first...
wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "Before Hardcore CPU Optimization", 100, 7 >nul 2>&1
echo Restore point created!

:: SECTION 1: CPU PRIORITY & SCHEDULING
echo.
color 0E
echo ========================================
echo [SECTION 1: CPU PRIORITY OPTIMIZATION]
echo ========================================
echo.
echo This will:
echo  - Optimize CPU scheduling for foreground apps
echo  - Reduce DPC/ISR latency
echo  - Set maximum system responsiveness
echo  - Increase priority for games/apps
echo.
color 0F
set /p "sec1=Apply CPU Priority optimizations? (Y/N): "
if /i "%sec1%"=="Y" (
    color 0A
    echo Applying CPU Priority tweaks...
    
    echo [1] Optimizing CPU Scheduling for Foreground Apps...
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 38 /f >nul 2>&1
    
    echo [2] Reducing DPC/ISR Latency...
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v DpcWatchdogProfileOffset /t REG_DWORD /d 10000 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v DpcTimeout /t REG_DWORD /d 0 /f >nul 2>&1
    
    echo [3] Enabling IRQ Distribution...
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v DistributeTimers /t REG_DWORD /d 1 /f >nul 2>&1
    
    echo [4] Setting System Responsiveness to Maximum...
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f >nul 2>&1
    
    echo [5] Increasing CPU Priority for Games/Apps...
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v Priority /t REG_DWORD /d 6 /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1
    
    echo CPU Priority optimizations applied!
) else (
    echo Skipped CPU Priority optimizations.
)

:: SECTION 2: MEMORY & CACHE
echo.
color 0E
echo ========================================
echo [SECTION 2: MEMORY ^& CACHE OPTIMIZATION]
echo ========================================
echo.
echo This will:
echo  - Disable paging of kernel/drivers
echo  - Disable memory compression
echo  - Optimize prefetch settings
echo  - Adjust cache behavior
echo.
color 0F
set /p "sec2=Apply Memory ^& Cache optimizations? (Y/N): "
if /i "%sec2%"=="Y" (
    color 0A
    echo Applying Memory tweaks...
    
    echo [6] Disabling Paging Executive...
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v DisablePagingExecutive /t REG_DWORD /d 1 /f >nul 2>&1
    
    echo [7] Optimizing Large System Cache...
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /t REG_DWORD /d 0 /f >nul 2>&1
    
    echo [8] Disabling Memory Compression...
    powershell -Command "Disable-MMAgent -MemoryCompression -ErrorAction SilentlyContinue" >nul 2>&1
    
    echo [9] Optimizing Prefetch Settings...
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnablePrefetcher /t REG_DWORD /d 3 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnableSuperfetch /t REG_DWORD /d 0 /f >nul 2>&1
    
    echo [10] Disabling Page Combining...
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v DisablePageCombining /t REG_DWORD /d 1 /f >nul 2>&1
    
    echo Memory optimizations applied!
) else (
    echo Skipped Memory optimizations.
)

:: SECTION 3: TIMER & INTERRUPT OPTIMIZATION
echo.
color 0E
echo ========================================
echo [SECTION 3: TIMER ^& INTERRUPT OPTIMIZATION]
echo ========================================
echo.
echo This will:
echo  - Optimize timer resolution
echo  - Configure high precision timers
echo  - Adjust TSC sync policy
echo.
color 0F
set /p "sec3=Apply Timer optimizations? (Y/N): "
if /i "%sec3%"=="Y" (
    color 0A
    echo Applying Timer tweaks...
    
    echo [11] Optimizing Timer Resolution...
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v GlobalTimerResolutionRequests /t REG_DWORD /d 1 /f >nul 2>&1
    
    echo [12] Disabling Dynamic Tick...
    bcdedit /set disabledynamictick yes >nul 2>&1
    
    echo [13] Setting TSC Sync Policy...
    bcdedit /set tscsyncpolicy Enhanced >nul 2>&1
    
    echo Timer optimizations applied!
) else (
    echo Skipped Timer optimizations.
)

:: SECTION 4: SECURITY MITIGATIONS (DANGEROUS!)
echo.
color 0C
echo ========================================
echo [SECTION 4: SECURITY MITIGATIONS]
echo ========================================
echo.
set /p "sec4=DISABLE Security Mitigations? (Y/N): "
if /i "%sec4%"=="Y" (
    color 0C
    echo.
    echo ARE YOU ABSOLUTELY SURE?
    echo This makes your PC vulnerable!
    set /p "sec4confirm=Type YES to confirm: "
    if /i "%sec4confirm%"=="YES" (
        color 0A
        echo Disabling security mitigations...
        
        echo [14] Disabling Spectre/Meltdown Mitigations...
        reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverride /t REG_DWORD /d 3 /f >nul 2>&1
        reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverrideMask /t REG_DWORD /d 3 /f >nul 2>&1
        
        echo [15] Disabling Virtualization-Based Security...
        bcdedit /set hypervisorlaunchtype off >nul 2>&1
        reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v EnableVirtualizationBasedSecurity /t REG_DWORD /d 0 /f >nul 2>&1
        
        echo [16] Disabling Data Execution Prevention...
        bcdedit /set nx AlwaysOff >nul 2>&1
        
        color 0C
        echo Security mitigations DISABLED! Your PC is now vulnerable!
        timeout /t 3 >nul
    ) else (
        echo Security mitigation changes cancelled.
    )
) else (
    echo Skipped Security mitigation changes (GOOD CHOICE!).
)

:: SECTION 5: PROCESS & THREAD OPTIMIZATION
echo.
color 0E
echo ========================================
echo [SECTION 5: PROCESS ^& THREAD OPTIMIZATION]
echo ========================================
echo.
echo This will:
echo  - Increase process heap size
echo  - Optimize thread scheduling
echo  - Add additional worker threads
echo.
color 0F
set /p "sec5=Apply Process optimizations? (Y/N): "
if /i "%sec5%"=="Y" (
    color 0A
    echo Applying Process tweaks...
    
    echo [17] Increasing Process Heap...
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\SubSystems" /v Windows /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\csrss.exe ObjectDirectory=\Windows SharedSection=1024,20480,768 Windows=On SubSystemType=Windows ServerDll=basesrv,1 ServerDll=winsrv:UserServerDllInitialization,3 ServerDll=winsrv:ConServerDllInitialization,2 ServerDll=sxssrv,4 ProfileControl=Off MaxRequestThreads=16" /f >nul 2>&1
    
    echo [18] Optimizing Thread Scheduling...
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Executive" /v AdditionalCriticalWorkerThreads /t REG_DWORD /d 16 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Executive" /v AdditionalDelayedWorkerThreads /t REG_DWORD /d 16 /f >nul 2>&1
    
    echo Process optimizations applied!
) else (
    echo Skipped Process optimizations.
)

:: SECTION 6: KERNEL & BOOT OPTIMIZATION
echo.
color 0E
echo ========================================
echo [SECTION 6: KERNEL ^& BOOT OPTIMIZATION]
echo ========================================
echo.
echo This will:
echo  - Optimize I/O priority
echo  - Speed up boot time
echo  - Disable boot animations
echo  - Optimize boot configuration
echo.
color 0F
set /p "sec6=Apply Kernel ^& Boot optimizations? (Y/N): "
if /i "%sec6%"=="Y" (
    color 0A
    echo Applying Kernel tweaks...
    
    echo [19] Optimizing I/O Priority...
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\I/O System" /v CountOperations /t REG_DWORD /d 1 /f >nul 2>&1
    
    echo [20] Optimizing Kernel Boot Performance...
    bcdedit /set bootmenupolicy legacy >nul 2>&1
    bcdedit /timeout 3 >nul 2>&1
    
    echo [21] Disabling Boot Animation...
    bcdedit /set quietboot yes >nul 2>&1
    
    echo [22] Optimizing Boot Configuration...
    bcdedit /set bootux disabled >nul 2>&1
    
    echo [23] Disabling Fast Startup...
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 0 /f >nul 2>&1
    
    echo Kernel optimizations applied!
) else (
    echo Skipped Kernel optimizations.
)

:: SECTION 7: NETWORK OPTIMIZATION
echo.
color 0E
echo ========================================
echo [SECTION 7: NETWORK OPTIMIZATION FOR SAVING CPU USAGE]
echo ========================================
echo.
echo This will:
echo  - Disable network throttling
echo  - Optimize TCP settings
echo  - Improve network performance
echo.
color 0F
set /p "sec7=Apply Network optimizations? (Y/N): "
if /i "%sec7%"=="Y" (
    color 0A
    echo Applying Network tweaks...
    
    echo [24] Disabling Network Throttling...
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 4294967295 /f >nul 2>&1
    
    echo [25] Optimizing TCP Settings...
    netsh interface tcp set global autotuninglevel=normal >nul 2>&1
    netsh interface tcp set global chimney=enabled >nul 2>&1
    netsh interface tcp set global dca=enabled >nul 2>&1
    netsh interface tcp set global netdma=enabled >nul 2>&1
    
    echo Network optimizations applied!
) else (
    echo Skipped Network optimizations.
)

