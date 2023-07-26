# Cambia el fondo de pantalla del escritorio

# Se descarga la imagen
$address = "https://raw.githubusercontent.com/JorgeOjedaF/install/main/vancouver.jpg"
$fileName = "C:\wallpaper2\vancouver.jpg"
(New-Object System.Net.WebClient).DownloadFile($address, $fileName)

# Informacion del fondo de escritorio del registro del usuario actual
# Importante: este script debe ejecutarse con la cuenta del usuario, por lo del HKCU.
$path = "HKCU:\Control Panel\Desktop"

# Cambia el wallpaper al cambiar el registro de windows
Set-ItemProperty -Path $path -Name WallPaper -Value $fileName

# es necesario reiniciar la computadora para que muestre los cambios
Restart-Computer -Force

