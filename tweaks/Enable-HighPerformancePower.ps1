# Enable High Performance or Ultimate Performance Power Plan
$plans = powercfg /list
$guid = ($plans | Select-String "High performance" -Context 0,1).ToString().Split()[3]
if (-not $guid) {
    $guid = ($plans | Select-String "Ultimate Performance" -Context 0,1).ToString().Split()[3]
}
if ($guid) {
    powercfg /setactive $guid
    Write-Output "High Performance power plan activated: $guid"
} else {
    Write-Output "High Performance plan not found."
}
