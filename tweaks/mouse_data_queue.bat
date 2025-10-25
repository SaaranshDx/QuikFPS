echo input what kind of CPU you have 
echo.
echo 1 for high end Cpu
echo.
echo 2 for mid end Cpu
echo.
echo 3 for low end Cpu




set /p input=: 
if /i %input% == 1 goto 13v
if /i %input% == 2 goto 18v
if /i %input% == 3 goto 22v
if /i %input% == R goto Revert
if /i %input% == T start taskmgr & goto :dataqueue
if /i %input% == E cls & exit

) ELSE (
echo Invalid Input & goto MisspellRedirect

:MisspellRedirect
cls
echo invalid input
timeout 2 
goto Redirectmouse

:Redirectmouse
cls
:dataqueue

:revert
echo %w% - Default %b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v "MouseDataQueueSize" /t REG_DWORD /d "256" /f



:13v
echo %w% - 13 %b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v "MouseDataQueueSize" /t REG_DWORD /d "19" /f


:18v
echo %w% - 18 %b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v "MouseDataQueueSize" /t REG_DWORD /d "24" /f


:22v
echo %w% - 22 %b%
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v "MouseDataQueueSize" /t REG_DWORD /d "34" /f
