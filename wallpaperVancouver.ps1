#cambia el wallpaper
Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop\' -Name Wallpaper -Value "C:\Wallpaper\vancouver.jpg"

#reinicia la computadora para que tome efecto
Restart-Computer -Force
