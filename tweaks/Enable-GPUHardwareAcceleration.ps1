# Enable GPU Hardware Acceleration
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" -Name "HwSchMode" -Value 2 -Type DWord

New-Item -Path "HKCU:\SOFTWARE\Microsoft\DirectX\UserGpuPreferences" -Force | Out-Null
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\DirectX\UserGpuPreferences" -Name "DirectXUserGlobalSettings" -Value "GpuPreference=2;" -Type String

Write-Output "GPU Hardware Acceleration enabled."
