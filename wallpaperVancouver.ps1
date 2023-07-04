#cambia el wallpaper
Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop\' -Name Wallpaper -Value "C:\Wallpaper\vancouver.jpg"

Start-Sleep -s 10

#reinicia la computadora para que tome efecto
Restart-Computer -Force
