# Variables SuourceUrl lo recibe como parametro, puede ser algo asi http://servidor/archivo.iso 
$UrlOrigen   = $args[0]
$CarpetaDestino = "C:\MV"

# Crear carpeta destino si no existe
if (!(Test-Path $CarpetaDestino)) {
    New-Item -Path $CarpetaDestino -ItemType Directory | Out-Null
}

# Extraer el nombre del archivo automáticamente desde la URL
$NombreArchivo = [System.IO.Path]::GetFileName($UrlOrigen)

# Construir ruta destino
$ArchivoDestino = $CarpetaDestino + "\" + $NombreArchivo

# Descargar usando BITS (recomendado para archivos grandes)
Invoke-WebRequest -Uri $UrlOrigen -OutFile $ArchivoDestino

Write-Output "Archivo descargado en: $ArchivoDestino"
