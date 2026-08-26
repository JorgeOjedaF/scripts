Add-Type -AssemblyName System.Runtime.WindowsRuntime

$geolocator = [Windows.Devices.Geolocation.Geolocator, Windows.Devices.Geolocation, ContentType = WindowsRuntime]::new()

try {
    $operation = $geolocator.GetGeopositionAsync()

    $result = [System.WindowsRuntimeSystemExtensions]::GetAwaiter($operation).GetResult()

    $latitude  = $result.Coordinate.Point.Position.Latitude
    $longitude = $result.Coordinate.Point.Position.Longitude
    $accuracy = $result.Coordinate.Accuracy
    $timestamp = $result.Coordinate.Timestamp

    Write-Host "Latitud:   $latitude"
    Write-Host "Longitud:  $longitude"
    Write-Host "Precision: $accuracy metros"
    Write-Host "Fecha:     $timestamp"
}
catch {
    Write-Host "Error: $($_.Exception.Message)"
}
