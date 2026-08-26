Add-Type -AssemblyName System.Runtime.WindowsRuntime

$geolocator = [Windows.Devices.Geolocation.Geolocator, Windows.Devices.Geolocation, ContentType = WindowsRuntime]::new()

# Intentar obtener la ubicación actual
try {
    $asyncOperation = $geolocator.GetGeopositionAsync()
    $position = [System.WindowsRuntimeSystemExtensions]::AsTask($asyncOperation).Result
}
catch {
    $position = $null
}

# Si no se obtuvo ubicación actual, utilizar la última conocida
if ($null -eq $position) {
    try {
        $asyncOperation = $geolocator.GetLastKnownLocationAsync()
        $location = [System.WindowsRuntimeSystemExtensions]::AsTask($asyncOperation).Result

        if ($null -ne $location) {
            $latitude = $location.Coordinate.Point.Position.Latitude
            $longitude = $location.Coordinate.Point.Position.Longitude
            $accuracy = $location.Coordinate.Accuracy
            $timestamp = $location.Coordinate.Timestamp

            Write-Host "Fuente: Ultima ubicacion conocida"
        }
        else {
            Write-Host "No hay ninguna ubicacion disponible."
            exit
        }
    }
    catch {
        Write-Host "No se pudo obtener la ubicacion: $($_.Exception.Message)"
        exit
    }
}
else {
    $latitude = $position.Coordinate.Point.Position.Latitude
    $longitude = $position.Coordinate.Point.Position.Longitude
    $accuracy = $position.Coordinate.Accuracy
    $timestamp = $position.Coordinate.Timestamp

    Write-Host "Fuente: Ubicacion actual"
}

Write-Host ""
Write-Host "Latitud:   $latitude"
Write-Host "Longitud:  $longitude"
Write-Host "Precision: $accuracy metros"
Write-Host "Fecha:     $timestamp"
