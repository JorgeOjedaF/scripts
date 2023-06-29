# Ruta de la imagen del fondo de pantalla
$imagenFondo = "C:\wallpaper\img2.jpg"

# Obtener la ubicación del archivo de configuración de temas de Windows
$rutaConfiguracion = "$env:APPDATA\Microsoft\Windows\Themes\TranscodedWallpaper"

# Copiar la imagen del fondo de pantalla a la ubicación del archivo de configuración
Copy-Item -Path $imagenFondo -Destination $rutaConfiguracion -Force

# Reiniciar el servicio de Temas de Windows para aplicar los cambios
$temasService = Get-Service -Name Themes
if ($temasService.Status -eq 'Running') {
    Restart-Service -Name Themes -Force
} else {
    Start-Service -Name Themes
}

#reinicia la computadora
Restart-Computer -Force
