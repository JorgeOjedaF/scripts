# Nombre o IP del servidor
$Origen = $args[0]

# Carpeta destino local
$Destination = $args[1]

# Crear carpeta destino
if (!(Test-Path $Destination)) {
    New-Item -ItemType Directory -Path $Destination
}

# Copiar archivos
Copy-Item "$Origen\*" -Destination $Destination -Recurse -Force
