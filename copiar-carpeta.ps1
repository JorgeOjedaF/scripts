# Nombre o IP del servidor
$Origen = $args[0]

# Carpeta destino local
$Destino = $args[1]

# Verificar que el origen exista
if (!(Test-Path $Origen)) {
    Write-Host "La ruta origen no existe: $Origen"
    exit 1
}

# Crear carpeta destino si no existe
if (!(Test-Path $Destino)) {
    New-Item -ItemType Directory -Path $Destino -Force | Out-Null
}

# Copiar archivos
Copy-Item "$Origen\*" -Destination $Destino -Recurse -Force
