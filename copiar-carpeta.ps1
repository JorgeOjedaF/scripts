# este script recibe 2 parametros (origen y destino), y copia el origen al destino
# ejemplo1  \\vmware-host\sharedfolders\Jorge\excel C:\excel
# ejemplo2  https://sitio.com/archivo.zip C:\excel
# el primer parametro puede ser una carpeta compartida, por ej: \\vmware-host\sharedfolders\Jorge\excel
# o puede ser una url con un archivo a descargar, por ej: https://sitio.com/archivo.zip
# el segundo parametro puede ser una carpeta, por ej: C:\excel

# Origen (URL o carpeta)
$Origen = $args[0]

# Carpeta destino local
$Destino = $args[1]

# Crear carpeta destino si no existe
if (!(Test-Path $Destino)) {
    New-Item -ItemType Directory -Path $Destino -Force | Out-Null
}

try {

    # Detectar si es URL
    if ($Origen -match '^https?://') {

        Write-Host "Origen detectado: URL"

        # Obtener nombre del archivo desde la URL
        $NombreArchivo = [System.IO.Path]::GetFileName(
            ([System.Uri]$Origen).AbsolutePath
        )

        # Nombre por defecto si la URL no trae archivo
        if ([string]::IsNullOrWhiteSpace($NombreArchivo)) {
            $NombreArchivo = "archivo_descargado"
        }

        $RutaFinal = Join-Path $Destino $NombreArchivo

        Invoke-WebRequest -Uri $Origen -OutFile $RutaFinal

        Write-Host "Archivo descargado:"
        Write-Host $RutaFinal
    }

    else {

        Write-Host "Origen detectado: Carpeta/Ruta compartida"

        # Validar existencia
        if (!(Test-Path $Origen)) {
            Write-Host "La ruta origen no existe: $Origen"
            exit 1
        }

        # Copiar contenido
        Copy-Item "$Origen\*" -Destination $Destino -Recurse -Force

        Write-Host "Archivos copiados correctamente"
    }
}
catch {
    Write-Host "Error:"
    Write-Host $_.Exception.Message
    exit 1
}
