# Disable Game Mode
New-Item -Path "HKCU:\SOFTWARE\Microsoft\GameBar" -Force | Out-Null
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\GameBar" -Name "AllowAutoGameMode" -Value 0 -Type DWord
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\GameBar" -Name "AutoGameModeEnabled" -Value 0 -Type DWord

Write-Output "Game Mode disabled successfully."
