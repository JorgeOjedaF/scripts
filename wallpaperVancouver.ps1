#crea una carpeta si no existe
If(!(test-path -PathType container "C:\wallpaper"))
{
      New-Item -ItemType Directory -Path "C:\wallpaper"
}
#descarga la imagen a la carpeta wallpaper
Invoke-WebRequest -Uri https://raw.githubusercontent.com/JorgeOjedaF/install/main/vancouver.jpg -OutFile C:\wallpaper\vancouver.jpg;

#espera 20 segds
Start-Sleep -s 20

#cambia el wallpaper
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\" -Name Wallpaper -Value "C:\wallpaper\vancouver.jpg" -Force

Write-Host "Se ejecuto el script wallpaperVancouver"
