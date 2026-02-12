# Variables
$CarpetaCompartida = "\\vmware-host\Shared-Folders\Jorge"
$Archivo = "apps.txt"
$Carpeta = "C:\MV"
$Compartido = $CarpetaCompartida + "\" + $Archivo
$Destino = $Carpeta + "\" + $Archivo

# Crear carpeta destino si no existe
if (!(Test-Path $Carpeta)) {
    New-Item -Path $Carpeta -ItemType Directory | Out-Null
}

#copia el archivo
Start-BitsTransfer -Source $Compartido -Destination $Destino
