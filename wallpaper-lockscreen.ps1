# Script que cambia la imagen del wallpaper y protector de pantalla

$carpeta = "C:\Fondo"
$ImgWallpaper = "$carpeta\perro-playa.jpg"
$ImgProtector = "$carpeta\perro-rostro.jpg"
$RegPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP"
$address1 = "https://raw.githubusercontent.com/JorgeOjedaF/install/main/perro-playa.jpg"
$address2 = "https://raw.githubusercontent.com/JorgeOjedaF/install/main/perro-rostro.jpg"

# crea la carpeta si no existe
If(!(test-path -PathType container $carpeta)){
  New-Item -ItemType Directory -Path $carpeta
}

# Se descargan las imagenes
(New-Object System.Net.WebClient).DownloadFile($address1, $ImgWallpaper)
(New-Object System.Net.WebClient).DownloadFile($address2, $ImgProtector)

# Crea entradas en el registro
New-Item $RegPath -Force

New-ItemProperty -Path $RegPath -Name ImgProtectorPath -Value $ImgProtector -PropertyType String -Force | Out-Null
New-ItemProperty -Path $RegPath -Name ImgProtectorUrl -Value $ImgProtector -PropertyType String -Force | Out-Null
New-ItemProperty -Path $RegPath -Name ImgProtectorStatus -Value 1 -PropertyType DWORD -Force | Out-Null

New-ItemProperty -Path $RegPath -Name DesktopImagePath -Value $ImgWallpaper -PropertyType String -Force | Out-Null
New-ItemProperty -Path $RegPath -Name DesktopImageUrl -Value $ImgWallpaper -PropertyType String -Force | Out-Null
New-ItemProperty -Path $RegPath -Name DesktopImageStatus -Value 1 -PropertyType DWORD -Force | Out-Null

# es necesario reiniciar la computadora para que muestre los cambios
Restart-Computer -Force
