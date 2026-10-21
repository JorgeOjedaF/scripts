$path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired"

# Verificar si hay un reinicio pendiente por Windows Update
if (Test-Path $path) {
    Write-Host ">>>> Reinicio pendiente por Windows Update"
} else {
    Write-Host "OK: No se detecta reinicio pendiente"
}

# Verificar si el disco C: tiene al menos 10% de espacio libre
$disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"

if ($disk.Size -gt 0) {
    $freePercent = ($disk.FreeSpace / $disk.Size) * 100

    if ($freePercent -ge 10) {
        Write-Host ("OK: Espacio libre en C:: {0:N2}%" -f $freePercent)
    } else {
        Write-Host (">>>> Espacio libre en C:: {0:N2}% - INSUFICIENTE (se requiere al menos 10%)" -f $freePercent)
    }
} else {
    Write-Host "No se pudo obtener información del disco C:"
}
