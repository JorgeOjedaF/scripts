# ruta de la imagen a usar como fondo de pantalla, concatena el parametro para que quede algo asi: "C:\wallpaper\img1.jpg"
$ImagePath = "C:\wallpaper\" + $args[0]

# Informacion del fondo de escritorio del registro del usuario 
$RegistryPath = "HKCU:\Control Panel\Desktop"
Get-ItemProperty -Path $RegistryPath -Name WallPaper

# Cambia el wallpaper al cambiar el registro de windows
Set-ItemProperty -Path $RegistryPath -Name WallPaper -Value $ImagePath
Get-ItemProperty -Path $RegistryPath -Name WallPaper

# Refresca para que tome los cambios
RUNDLL32.EXE USER32.DLL,UpdatePerUserSystemParameters

#reinicia la computadora
#Restart-Computer -Force
