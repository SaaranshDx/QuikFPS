#remove sys trash
Start-Process "C:\WINDOWS\system32\cleanmgr.exe"

#defrag disk
Start-Process -FilePath "defrag.bat" -Wait

Start-Process -FilePath "Disable_Write_Cache_Buffer_Flushing.bat" -Wait

Start-Process -FilePath "optimise_nfts.bat" -Wait

Write-Host "enter your boot drive type"
Write-Host "[1] SSD"
Write-Host "[2] HDD"
$bootdrivechoice = Read-Host "enter your boot drive (press 1 for ssd and 2 for hdd)"

if ($bootdrivechoice -eq "1") {
    Write-Host "starting ssd optimisation script"
    Start-Process -FilePath "optimise_ssd.bat" -Wait
} elseif ($bootdrivechoice -eq "2") {
    Write-Host "starting hdd optimisation script"
    Start-Process -FilePath "optimise_hdd.bat" -Wait
} else {
    Write-Host "invalid input"
}