#cambia el wallpaper
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\" -Name Wallpaper -Value "C:\Wallpaper\vancouver.jpg" -Force

Start-Sleep -s 10

Get-ItemProperty "HKCU:\Control Panel\Desktop\Wallpaper"

#reinicia la computadora para que tome efecto
Restart-Computer -Force
