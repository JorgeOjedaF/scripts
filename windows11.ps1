# Rutas origen y destino del archivo ISO con windows 11
$isoOrigen = "\\vmware-host\sharedfolders\Jorge\iso\Windows11.iso"
$isoDestino = "C:\Temp\Windows11.iso"

# Crear carpeta temporal si no existe
if (-not (Test-Path "C:\Temp")) {
    New-Item -Path "C:\Temp" -ItemType Directory | Out-Null
}

# Copiar la ISO
Copy-Item -Path $isoOrigen -Destination $isoDestino -Force

# Verifica si la ISO está presente
if (-not (Test-Path $isoDestino)) {
    Write-Output "No se encontró la ISO en $isoDestino. Abortando."
    exit 1
}

# Montar la ISO
try {
    Mount-DiskImage -ImagePath $isoDestino -ErrorAction Stop
    Start-Sleep -Seconds 5
}
catch {
    Write-Output " Error al montar la ISO: $_"
    exit 1
}

# Obtener letra de unidad montada
try {
    $unidadISO = (Get-DiskImage -ImagePath $isoDestino | Get-Volume).DriveLetter
    $unidadISOPath = "$unidadISO`:\setup.exe"
}
catch {
    Write-Output "No se pudo detectar la letra de unidad montada: $_"
    Dismount-DiskImage -ImagePath $isoDestino -ErrorAction SilentlyContinue
    exit 1
}

# Verifica que setup.exe exista
if (-not (Test-Path $unidadISOPath)) {
    Write-Output "No se encontró setup.exe en $unidadISOPath"
    Dismount-DiskImage -ImagePath "C:\Temp\Windows11.iso"
    exit 1
}

# Ejecutar la actualización (manteniendo datos y apps)
try {
    Write-Output " Iniciando actualización a Windows 11 desde $unidadISOPath..."
    Start-Process -FilePath $unidadISOPath -ArgumentList "/auto upgrade /quiet /noreboot /compat ignorewarning" -Wait
}
catch {
    Write-Output " Error al ejecutar el setup.exe: $_"
    Dismount-DiskImage -ImagePath $isoDestino -ErrorAction SilentlyContinue
    exit 1
}

# Desmontar la ISO
Dismount-DiskImage -ImagePath $isoDestino

# Reiniciar el equipo
Restart-Computer -Force
