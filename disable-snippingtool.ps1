// deshabilita la herramienta de recortes
New-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\TabletPC" -Name "DisableSnippingTool" -Value 1 -PropertyType DWord -Force

// se puede reiniciar la pc para asegurar que tome el cambio
// Restart-Computer -Force
