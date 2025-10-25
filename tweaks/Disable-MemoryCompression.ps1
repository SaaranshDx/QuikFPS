# Disable Network Optimization
netsh int tcp set global autotuninglevel=normal

Write-Output "Network optimization disabled."
