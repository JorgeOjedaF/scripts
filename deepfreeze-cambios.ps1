# Este scrip es para realuzar algunos cambios en una PC estando congelada con DF para demostrar su funcionamiento

# Crear un archivo de texto en el escritorio
$desktop = [Environment]::GetFolderPath("Desktop")
New-Item -Path "$desktop\DEMO_DeepFreeze.txt" -ItemType File -Value "Cambio de ejemplo revertido por Deep Freeze."

# Crear una nueva carpeta en C:\
New-Item -Path "C:\Carpeta_Demo" -ItemType Directory

# Cambiar el fondo de pantalla
Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name Wallpaper -Value 'C:\Windows\Web\Wallpaper\Windows\img0.jpg'

# Crear una clave en el registro
New-ItemProperty -Path 'HKLM:\SOFTWARE' -Name 'DFDemo' -Value 'Este cambio será revertido por Deep Freeze' -PropertyType String
