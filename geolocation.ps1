# Se recupera la ubicacion del equipo (latitud,longitud) 
# Para que esto funcione debe estar activado esta opcion: Settings → Privacy & security → Location → Location services = On

Add-Type -AssemblyName System.Device

$watcher = New-Object System.Device.Location.GeoCoordinateWatcher

# Iniciar el servicio de ubicación
$watcher.Start()

# Esperar hasta que Windows tenga una posición
$timeout = 30
$elapsed = 0

while ($watcher.Status -eq "NoData" -and $elapsed -lt $timeout) {
    Start-Sleep -Seconds 1
    $elapsed++
}

if ($watcher.Status -eq "Ready") {

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
