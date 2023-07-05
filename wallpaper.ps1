# ruta de la imagen a usar como fondo de pantalla, concatena el parametro para que quede algo asi: "C:\wallpaper\img1.jpg"
$ImagePath = "C:\wallpaper\" + $args[0]

# Informacion del fondo de escritorio del registro del usuario actual
$RegistryPath = "HKCU:\Control Panel\Desktop"

# Cambia el wallpaper al cambiar el registro de windows
Set-ItemProperty -Path $RegistryPath -Name WallPaper -Value $ImagePath

# es necesario reiniciar la computadora para que muestre los cambios
Restart-Computer -Force
