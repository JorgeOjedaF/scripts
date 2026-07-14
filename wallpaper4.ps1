# Cambia el fondo de pantalla del escritorio
# recibe como parametro la url de una imagen para el wallpaper
# por ejemplo "https://raw.githubusercontent.com/JorgeOjedaF/install/main/perro-lago.jpg"

$RegKeyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP"

$DesktopPath = "DesktopImagePath"
$DesktopStatus = "DesktopImageStatus"
$DesktopUrl = "DesktopImageUrl"

$StatusValue = 1

# URL recibida como argumento
$url = $args[0]

if ([string]::IsNullOrWhiteSpace($url)) {
    Write-Error "Debe especificar la URL de la imagen como argumento."
    exit 1
}

$directory = "C:\Fondo"
New-Item -Path $directory -ItemType Directory -Force | Out-Null

# Obtener el nombre del archivo desde la URL
$fileName = Split-Path $url -Leaf
$DesktopImageValue = Join-Path $directory $fileName

# Descargar la imagen
$wc = New-Object System.Net.WebClient
$wc.DownloadFile($url, $DesktopImageValue)

# Crear la clave si no existe
if (!(Test-Path $RegKeyPath)) {
    New-Item -Path $RegKeyPath -Force | Out-Null
}

# Configurar PersonalizationCSP
New-ItemProperty -Path $RegKeyPath -Name $DesktopStatus -Value $StatusValue -PropertyType DWORD -Force | Out-Null
New-ItemProperty -Path $RegKeyPath -Name $DesktopPath -Value $DesktopImageValue -PropertyType String -Force | Out-Null
New-ItemProperty -Path $RegKeyPath -Name $DesktopUrl -Value $DesktopImageValue -PropertyType String -Force | Out-Null

# Actualizar el fondo
RUNDLL32.EXE USER32.DLL,UpdatePerUserSystemParameters 1,True

# Cierra la sesion para refrescar el fondo
logoff
