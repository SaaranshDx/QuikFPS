@echo off
if not "%1" == "max" start /MAX cmd /c %0 max & exit/b
@echo off
:: Color Codes
set w=[97m
set p=[95m
set b=[96m
set o=[1m

:: Enabling ANSI Escape Sequences
Reg.exe add "HKCU\CONSOLE" /v "VirtualTerminalLevel" /t REG_DWORD /d "1" /f  > nul

::Enabling Delayed Expansion
setlocal EnabledelayedExpansion > nul
cls 
chcp 65001 >nul 2>&1

echo %w% - Disable Variable Refresh Rate (VRR) %b%
reg add "HKCU\Software\Microsoft\DirectX\UserGpuPreferences" /v VRROptimizeEnable /t REG_DWORD /d 0 /f