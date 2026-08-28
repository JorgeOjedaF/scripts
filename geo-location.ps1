# Retrieves the computer's location (latitude, longitude)
# For this to work, this option must be enabled: Settings → Privacy & security → Location → Location services = On
# If it receives any parameters, it displays more details.
$showlog = ($args.Count -gt 0)

Add-Type -AssemblyName System.Device

# Determines if Location is enabled on the computer
$path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location"
$valor = (Get-ItemProperty -Path $path -Name "Value" -ErrorAction SilentlyContinue).Value
if($showlog) { Write-Host "Location Services: $valor" }

# If it wasn't enabled, we enable it
if ($valor -ne "Allow") {
    New-Item -Path $path -Force | Out-Null
    Set-ItemProperty -Path $path -Name "Value" -Value "Allow"
    if ($showlog) { Write-Host "Location Services was not enabled and is now enabled" }
}

# Start the location service
$watcher = New-Object System.Device.Location.GeoCoordinateWatcher
$watcher.Start()

# Wait until the service is ready or exits after the timeout
$timeout = 60
$elapsed = 0

while ($watcher.Status -ne "Ready" -and $elapsed -lt $timeout) {
    if ($showlog) { Write-Host "Waiting for location service to be ready. (Watcher.Status: $($watcher.Status) )" }
    Start-Sleep -Seconds 1
    $elapsed++
}

if ($watcher.Status -eq "Ready") { 
    if($showlog) { Write-Host "Service location (Watcher.Status: $($watcher.Status))" } 
    $location = $watcher.Position.Location 

    if ($location.IsUnknown) { 
        Write-Host "Windows does not have an available location." 
    } 
    else { 
        Write-Host "-----------------" 
        Write-Host "Latitude: $($location.Latitude)" 
        Write-Host "Length: $($location.Longitude)" 
        Write-Host "https://www.google.com/maps/search/?api=1&query=$($location.Latitude),$($location.longitude)" 
    }

}
else { 
    Write-Host "Could not get location. $($elapsed)" 
    Write-Host "Status: $($watcher.Status)"
}

$watcher.Stop()
