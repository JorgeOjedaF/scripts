# Ruta de la imagen que quieres usar como protector de pantalla
$ScreenSaverImageFolder = "C:\screensaver"

# Establecer el tipo de protector de pantalla como 'Photo Screensaver'
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name SCRNSAVE.EXE -Value "C:\Windows\System32\PhotoScreensaver.scr"

# Configurar el tiempo de espera antes de que el protector de pantalla se active (en segundos)
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name ScreenSaveTimeOut -Value 600

# Activar el protector de pantalla
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name ScreenSaveActive -Value 1

# Configurar la carpeta de la imagen en el registro
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows Photo Viewer\Slideshow\Screensaver" -Name EncryptedPIDL1 -Value ([System.Text.Encoding]::Unicode.GetBytes($ScreenSaverImageFolder) | % { $_.ToString("x2") } -join "")

# Asegúrate de que el usuario pueda ver los cambios
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters
