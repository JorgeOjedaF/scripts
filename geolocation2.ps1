Add-Type -AssemblyName System.Runtime.WindowsRuntime

$locator = New-Object 'Windows.Devices.Geolocation.Geolocator'

try {
    # Permitir utilizar una ubicación almacenada de hasta 24 horas
    $maximumAge = [TimeSpan]::FromHours(24)

    # Tiempo máximo para obtener una ubicación nueva
    $timeout = [TimeSpan]::FromSeconds(10)

    $operation = $locator.GetGeopositionAsync($maximumAge, $timeout)

    # Esperar hasta que termine la operación
    while ($operation.Status -eq 0) {
        Start-Sleep -Milliseconds 100
    }

    # Obtener el resultado
    $position = $operation.GetResults()

    if ($null -eq $position) {
        Write-Host "No se obtuvo ninguna ubicación."
        exit
    }

    $coordinate = $position.Coordinate

    Write-Host ""
    Write-Host "Latitud:   $($coordinate.Point.Position.Latitude)"
    Write-Host "Longitud:  $($coordinate.Point.Position.Longitude)"
    Write-Host "Precision: $($coordinate.Accuracy) metros"
    Write-Host "Timestamp: $($coordinate.Timestamp)"
}
catch {
    Write-Host "Error:"
    Write-Host $_.Exception.Message
}
