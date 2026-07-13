# Ejecutar como Administrador

$Url = "https://raw.githubusercontent.com/JorgeOjedaF/scripts/refs/heads/main/StartLayout.xml"
$Path = "$env:TEMP\StartLayout.xml"

# Descargar archivo XML
Invoke-WebRequest -Uri $Url -OutFile $Path

# Aplicar layout del menú Inicio
Import-StartLayout -LayoutPath $Path -MountPath C:\

# Reiniciar Explorer para aplicar cambios
Stop-Process -Name explorer -Force
Start-Process explorer.exe
