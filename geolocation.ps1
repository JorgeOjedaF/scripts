# Se recupera la ubicacion del equipo (latitud,longitud) 
# Para que esto funcione debe estar activado esta opcion: Settings → Privacy & security → Location → Location services = On

Add-Type -AssemblyName System.Device

$watcher = New-Object System.Device.Location.GeoCoordinateWatcher

# determina si esta habilitado Location en el equipo
$path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location"
$valor = (Get-ItemProperty -Path $path -Name "Value" -ErrorAction SilentlyContinue).Value
Write-Host "Location Services: $valor"

# Si no estaba habilitado, se habilita
if ($valor -ne "Allow") {
    New-Item -Path $path -Force | Out-Null
    Set-ItemProperty -Path $path -Name "Value" -Value "Allow"
    Write-Host "Location Services no estaba habilitado y se habilito"
}

# Iniciar el servicio de ubicación
$watcher.Start()

# Esperar hasta que el servicio esta listo o sale despues del timeout
$timeout = 60
$elapsed = 0

while ($watcher.Status -ne "Ready" -and $elapsed -lt $timeout) {
    Write-Host "Esperando que servicio location este listo. (Watcher.Status: $($watcher.Status) )"
    Start-Sleep -Seconds 1
    $elapsed++
}

if ($watcher.Status -eq "Ready") {
    Write-Host "Servicio location (Watcher.Status: $($watcher.Status)"

    $location = $watcher.Position.Location

    if ($location.IsUnknown) {
        Write-Host "Windows no tiene una ubicación disponible."
    }
    else {
        Write-Host "Latitud:   $($location.Latitude)"
        Write-Host "Longitud:  $($location.Longitude)"
        Write-Host "https://www.google.com/maps/search/?api=1&query=$($location.Latitude),$($location.longitude)"
    }

}
else {
    Write-Host "No se pudo obtener la ubicacion. $($elapsed)"
    Write-Host "Status: $($watcher.Status)"
}

$watcher.Stop()
