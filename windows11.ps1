# Ruta de la ISO
$isoDestino = "C:\Temp\Windows11.iso"

# Ruta de logs
$logFile = "C:\Temp\UpgradeWin11.log"
$transcriptFile = "C:\Temp\Transcript_UpgradeWin11.txt"

# Crear carpeta de log si no existe
if (-not (Test-Path "C:\Temp")) {
    New-Item -Path "C:\Temp" -ItemType Directory | Out-Null
}

# Iniciar transcripción completa
Start-Transcript -Path $transcriptFile -Append -Force

# Función para registrar eventos clave en log personalizado
function Log {
    param([string]$msg)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Add-Content -Path $logFile -Value "$timestamp - $msg"
}

Log "🔧 Iniciando script de actualización a Windows 11..."

# Verificar si existe la ISO
if (-not (Test-Path $isoDestino)) {
    Log "No se encontró la ISO en $isoDestino. Abortando."
    Stop-Transcript
    exit 1
}

# Montar la ISO
try {
    Log "Montando la ISO..."
    Mount-DiskImage -ImagePath $isoDestino -ErrorAction Stop
    Start-Sleep -Seconds 5
}
catch {
    Log "Error al montar la ISO: $_"
    Stop-Transcript
    exit 1
}

# Obtener la letra de la unidad montada
try {
    $unidadISO = (Get-DiskImage -ImagePath $isoDestino | Get-Volume).DriveLetter
    $unidadISOPath = "$unidadISO`:\setup.exe"
    Log "Unidad montada como $unidadISO. Ruta del setup: $unidadISOPath"
}
catch {
    Log "No se pudo detectar la letra de la unidad: $_"
    Dismount-DiskImage -ImagePath $isoDestino -ErrorAction SilentlyContinue
    Stop-Transcript
    exit 1
}

# Verificar si existe setup.exe
if (-not (Test-Path $unidadISOPath)) {
    Log "No se encontró setup.exe en $unidadISOPath"
    Dismount-DiskImage -ImagePath $isoDestino -ErrorAction SilentlyContinue
    Stop-Transcript
    exit 1
}

# Ejecutar setup.exe para actualizar
try {
    Log "Ejecutando setup.exe para iniciar la actualización..."
    Start-Process -FilePath $unidadISOPath -ArgumentList "/auto upgrade /quiet /noreboot /compat ignorewarning" -Wait
    Log "Comando ejecutado correctamente. El sistema se reiniciará si es necesario."
}
catch {
    Log "Error al ejecutar setup.exe: $_"
    Dismount-DiskImage -ImagePath $isoDestino -ErrorAction SilentlyContinue
    Stop-Transcript
    exit 1
}

# Desmontar la ISO
try {
    Log "Desmontando la ISO..."
    Dismount-DiskImage -ImagePath $isoDestino -ErrorAction SilentlyContinue
}
catch {
    Log "Error al desmontar la ISO (no crítico): $_"
}

Log "Reiniciando el equipo..."
Stop-Transcript
Restart-Computer -Force
