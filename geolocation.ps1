Add-Type -AssemblyName System.Runtime.WindowsRuntime

$geolocator = [Windows.Devices.Geolocation.Geolocator, Windows.Devices.Geolocation, ContentType = WindowsRuntime]::new()

$geolocator.DesiredAccuracy = [Windows.Devices.Geolocation.PositionAccuracy]::Default
$geolocator.ReportInterval = 0

try {
    $operation = $geolocator.GetGeopositionAsync()

    $task = [System.WindowsRuntimeSystemExtensions]::AsTask($operation)

    $position = $task.Result

    $latitude = $position.Coordinate.Point.Position.Latitude
    $longitude = $position.Coordinate.Point.Position.Longitude
    $accuracy = $position.Coordinate.Accuracy
    $timestamp = $position.Coordinate.Timestamp

    Write-Host "Latitud:   $latitude"
    Write-Host "Longitud:  $longitude"
    Write-Host "Precision: $accuracy metros"
    Write-Host "Fecha:     $timestamp"
}
catch {
    Write-Host "Error: $($_.Exception.Message)"
}
