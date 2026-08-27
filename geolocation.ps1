# Se recupera la ubicacion del equipo (latitud,longitud) 
# Para que esto funcione debe estar activado esta opcion: Settings → Privacy & security → Location → Location services = On

Add-Type -AssemblyName System.Device

$watcher = New-Object System.Device.Location.GeoCoordinateWatcher

$locationUser = (Get-ItemProperty `
    -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" `
    -Name Value -ErrorAction SilentlyContinue).Value

$locationMachine = (Get-ItemProperty `
    -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" `
    -Name Value -ErrorAction SilentlyContinue).Value

# Location Services debe tener el valor "Allow" para que este habilitado."
Write-Host "Location Services (Machine): $locationMachine"
Write-Host "Location Services (User):    $locationUser"

<#
# Si no estaba habilitado, se habilita
$path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location"
$current = (Get-ItemProperty -Path $path -Name "Value" -ErrorAction SilentlyContinue).Value
if ($current -ne "Allow") {
    New-Item -Path $path -Force | Out-Null
    Set-ItemProperty -Path $path -Name "Value" -Value "Allow"
    Write-Host "Location Services no estaba habilitado y se habilito"
}
else {
    Write-Host "Location Services ya estaba habilitado."
}

#>

# Iniciar el servicio de ubicación
$watcher.Start()

# Esperar hasta que Windows tenga una posición
$timeout = 30
$elapsed = 0

while ($watcher.Status -ne "Ready" -and $elapsed -lt $timeout) {
    Write-Host "Esperando ubicacion... Status: $($watcher.Status)"
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
