# $Compartido = "DESKTOP-12N8ANK\Compartido\CambioFreeze.reg"
$Compartido = "\\vmware-host\Shared-Folders\Jorge\apps.txt"

# Crear la carpeta si no existe
$Destino = "C:\MV"
if (!(Test-Path $Destino)) {
    New-Item -Path $Destino -ItemType Directory | Out-Null
}

#copia el archivo
Start-BitsTransfer -Source $Compartido -Destination $Destino
