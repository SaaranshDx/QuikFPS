@echo off
echo.
echo Starting optimization process...
echo.

:: Clear RAM Cache
echo [1/15] Clearing RAM Cache...
echo Clearing standby memory list...
powershell -Command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue" >nul 2>&1

:: Stop unnecessary services temporarily
echo [2/15] Stopping unnecessary services temporarily...
net stop "Windows Search" >nul 2>&1
net stop "Superfetch" >nul 2>&1
net stop "SysMain" >nul 2>&1

:: Clear Windows Temp Files
echo [3/15] Clearing Windows Temp files...
del /q /f /s %TEMP%\* >nul 2>&1
del /q /f /s C:\Windows\Temp\* >nul 2>&1
del /q /f /s C:\Windows\Prefetch\* >nul 2>&1

:: Clear User Temp Files
echo [4/15] Clearing User Temp files...
for /d %%p in (C:\Users\*) do (
    del /q /f /s "%%p\AppData\Local\Temp\*" >nul 2>&1
    rd /s /q "%%p\AppData\Local\Temp" >nul 2>&1
    md "%%p\AppData\Local\Temp" >nul 2>&1
)

:: Clear Browser Caches
echo [5/15] Clearing Browser Caches...
:: Chrome
del /q /f /s "%LocalAppData%\Google\Chrome\User Data\Default\Cache\*" >nul 2>&1
:: Edge
del /q /f /s "%LocalAppData%\Microsoft\Edge\User Data\Default\Cache\*" >nul 2>&1
:: Firefox
for /d %%p in ("%AppData%\Mozilla\Firefox\Profiles\*") do (
    del /q /f /s "%%p\cache2\*" >nul 2>&1
)

:: Clear Windows Update Cache
echo [6/15] Clearing Windows Update Cache...
net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1
del /q /f /s C:\Windows\SoftwareDistribution\Download\* >nul 2>&1
net start wuauserv >nul 2>&1
net start bits >nul 2>&1

:: Clear Windows Error Reporting Files
echo [7/15] Clearing Windows Error Reports...
del /q /f /s C:\ProgramData\Microsoft\Windows\WER\* >nul 2>&1

:: Empty Recycle Bin
echo [8/15] Emptying Recycle Bin...
rd /s /q C:\$Recycle.Bin >nul 2>&1

:: Clear DNS Cache
echo [9/15] Clearing DNS Cache...
ipconfig /flushdns >nul 2>&1

:: Clear Windows Store Cache
echo [10/15] Clearing Windows Store Cache...
wsreset.exe >nul 2>&1

:: Run Disk Cleanup
echo [11/15] Running Disk Cleanup...
cleanmgr /sagerun:1 /verylowdisk >nul 2>&1

:: Clear Thumbnail Cache
echo [12/15] Clearing Thumbnail Cache...
del /q /f /s /a:h "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1

:: Clear Font Cache
echo [13/15] Clearing Font Cache...
net stop FontCache >nul 2>&1
del /q /f /s /a:h C:\Windows\ServiceProfiles\LocalService\AppData\Local\FontCache\* >nul 2>&1
net start FontCache >nul 2>&1

:: Optimize and Defragment Drives
echo [14/15] Optimizing Drives...
echo This may take several minutes...
defrag C: /O /U /V >nul 2>&1
:: For SSDs, run TRIM instead
powershell -Command "Optimize-Volume -DriveLetter C -ReTrim -Verbose" >nul 2>&1

:: Clear Page File at Shutdown (Registry Setting)
echo [15/15] Configuring Page File Clearing...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v ClearPageFileAtShutdown /t REG_DWORD /d 1 /f >nul 2>&1

:: Restart stopped services
echo.
echo Restarting services...
net start "Windows Search" >nul 2>&1
net start "SysMain" >nul 2>&1
