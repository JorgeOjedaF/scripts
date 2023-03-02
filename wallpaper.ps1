# ruta de la imagen a usar como fondo de pantalla
$ImagePath = "C:\Windows\Web\Wallpaper\img1.jpg"

# Informacion del fondo de escritorio del registro del usuario 
$RegistryPath = "HKCU:\Control Panel\Desktop"
$WallpaperValue = Get-ItemProperty -Path $RegistryPath -Name WallPaper

# Cambia el wallpaper al cambiar el registro de windows
Set-ItemProperty -Path $RegistryPath -Name WallPaper -Value $ImagePath

# Refresca para que tome los cambios
RUNDLL32.EXE USER32.DLL,UpdatePerUserSystemParameters
