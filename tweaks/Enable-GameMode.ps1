# Enable Game Mode
New-Item -Path "HKCU:\SOFTWARE\Microsoft\GameBar" -Force | Out-Null
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\GameBar" -Name "AllowAutoGameMode" -Value 1 -Type DWord
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\GameBar" -Name "AutoGameModeEnabled" -Value 1 -Type DWord

Write-Output "Game Mode enabled successfully."
