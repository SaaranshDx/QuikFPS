# Requires -RunAsAdministrator


reg export HKCU C:\backup_gpu_user.reg /y
reg export HKLM\SYSTEM C:\backup_gpu_system.reg /y

New-Item -Path "HKCU:\Software\Microsoft\Avalon.Graphics" -Force -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Avalon.Graphics" -Name "DisableHWAcceleration" -Value 0 -Force

powercfg /setacvalueindex scheme_current sub_video videoidle 0
powercfg /setdcvalueindex scheme_current sub_video videoidle 0
powercfg /setactive scheme_current

Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "Win8DpiScaling" -Value 1 -Force
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "LogPixels" -Value 96 -Force

New-Item -Path "HKCU:\System\GameConfigStore" -Force -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_FSEBehaviorMode" -Value 2 -Force
Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_HonorUserFSEBehaviorMode" -Value 1 -Force
Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_DXGIHonorFSEWindowsCompatible" -Value 1 -Force

bcdedit /deletevalue useplatformclock
bcdedit /set disabledynamictick yes

$hpet = Get-PnpDevice | Where-Object { $_.FriendlyName -like "*High Precision Event Timer*" }
if ($hpet) {
    Disable-PnpDevice -InstanceId $hpet.InstanceId -Confirm:$false
}

$gpuDevices = Get-PnpDevice -Class Display | Where-Object { $_.Status -eq "OK" }
foreach ($gpu in $gpuDevices) {
    $instancePath = $gpu.InstanceId
    $regPath = "HKLM:\SYSTEM\CurrentControlSet\Enum\$instancePath\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties"
    if (Test-Path $regPath) {
        Set-ItemProperty -Path $regPath -Name "MSISupported" -Value 1 -Force
    } else {
        New-Item -Path $regPath -Force -ErrorAction SilentlyContinue
        New-ItemProperty -Path $regPath -Name "MSISupported" -Value 1 -PropertyType DWord -Force -ErrorAction SilentlyContinue
    }
}

Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" -Name "PP_ThermalAutoThrottlingEnable" -Value 0 -Force -ErrorAction SilentlyContinue

Write-Host "GPU tweaks applied. Restart required." -ForegroundColor Green