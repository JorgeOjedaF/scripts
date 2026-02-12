# Estos datos se recibe como parametros
$CarpetaCompartida = $args[0]
$Archivo = $args[1]

# ejemplo de parametros \\vmware-host\SharedFolders\Jorge apps.txt

# Carpeta de destino
$Carpeta = "C:\MV"
$Compartido = $CarpetaCompartida + "\" + $Archivo
$Destino = $Carpeta + "\" + $Archivo

# Crear carpeta destino si no existe
if (!(Test-Path $Carpeta)) {
    New-Item -Path $Carpeta -ItemType Directory | Out-Null
}

#copia el archivo
Start-BitsTransfer -Source $Compartido -Destination $Destino
