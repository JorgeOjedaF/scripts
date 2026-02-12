# Variables SuourceUrl lo recibe como parametro, puede ser algo asi http://servidor/archivo.iso 
$SourceUrl   = $args[0]
$Destination = "C:\MV"

# Crear carpeta destino si no existe
if (!(Test-Path $Destination)) {
    New-Item -Path $Destination -ItemType Directory | Out-Null
}

# Extraer el nombre del archivo automáticamente desde la URL
$FileName = [System.IO.Path]::GetFileName($SourceUrl)

# Construir ruta destino
$DestinationFile = $Destination + "\" + $FileName

# Descargar usando BITS (recomendado para archivos grandes)
Start-BitsTransfer -Source $SourceUrl -Destination $DestinationFile

Write-Output "Archivo descargado en: $DestinationFile"
