# Variables SuourceUrl lo recibe como parametro, puede ser algo asi http://servidor/archivo.iso y NombreArchivo es archivo.iso
$UrlOrigen   = $args[0]
$NombreArchivo = $args[1]
$CarpetaDestino = "C:\MV"

# Crear carpeta destino si no existe
if (!(Test-Path $CarpetaDestino)) {
    New-Item -Path $CarpetaDestino -ItemType Directory | Out-Null
}


# Construir ruta destino
$ArchivoDestino = $CarpetaDestino + "\" + $NombreArchivo

# descarga el archivo y lo deja en la carpeta destino
(New-Object System.Net.WebClient).DownloadFile($UrlOrigen, $ArchivoDestino)	

Write-Output "Archivo descargado en: $ArchivoDestino"
