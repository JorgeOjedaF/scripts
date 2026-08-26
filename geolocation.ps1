Add-Type -AssemblyName System.Runtime.WindowsRuntime

$locator = [Windows.Devices.Geolocation.Geolocator, Windows.Devices.Geolocation, ContentType = WindowsRuntime]::new()

try {
    $operation = $locator.GetGeopositionAsync(
        [TimeSpan]::FromMinutes(10),
        [TimeSpan]::FromSeconds(15)
    )

    $task = [System.WindowsRuntimeSystemExtensions]::AsTask(
        [Windows.Foundation.IAsyncOperation[Windows.Devices.Geolocation.Geoposition]]$operation
    )

    $position = $task.Result

    $latitude  = $position.Coordinate.Point.Position.Latitude
    $longitude = $position.Coordinate.Point.Position.Longitude
    $accuracy  = $position.Coordinate.Accuracy
    $timestamp = $position.Coordinate.Timestamp

    Write-Host "Latitude:  $latitude"
    Write-Host "Longitude: $longitude"
    Write-Host "Accuracy:  $accuracy meters"
    Write-Host "Timestamp: $timestamp"
}
catch {
    Write-Host "ERROR 1:"
    Write-Host $_.Exception.ToString()
}
