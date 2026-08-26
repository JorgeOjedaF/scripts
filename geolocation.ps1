Add-Type -AssemblyName System.Runtime.WindowsRuntime

# Cargar el tipo WinRT
$Geolocator = [Windows.Devices.Geolocation.Geolocator, Windows.Devices.Geolocation, ContentType = WindowsRuntime]

# Crear Geolocator
$locator = $Geolocator::new()

# Solicitar ubicación
$operation = $locator.GetGeopositionAsync()

# Obtener el tipo concreto de la operación
$task = [System.WindowsRuntimeSystemExtensions]::AsTask(
    [Windows.Foundation.IAsyncOperation[Windows.Devices.Geolocation.Geoposition]]$operation
)

# Esperar resultado
$position = $task.GetAwaiter().GetResult()

# Mostrar datos
$coordinate = $position.Coordinate

Write-Host "Latitude:  $($coordinate.Point.Position.Latitude)"
Write-Host "Longitude: $($coordinate.Point.Position.Longitude)"
Write-Host "Timestamp: $($coordinate.Timestamp)"
