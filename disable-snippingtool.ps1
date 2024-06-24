# deshabilita la herramienta de recortes o SnippingTool

# Si no existe la ruta, la crea
if (-not (Test-Path "HKLM:\Software\Policies\Microsoft\TabletPC")) {
    New-Item -Path "HKLM:\Software\Policies\Microsoft\TabletPC" -Force
}

New-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\TabletPC" -Name "DisableSnippingTool" -Value 1 -PropertyType DWord -Force

# se puede reiniciar la pc para asegurar que tome el cambio
# Restart-Computer -Force
