# esto deshabilita el gesto de 3 y 4 dedos en pantallas tactiles. 
# Settings → Bluetooth & devices → Touch → Three and four-finger touch gestures.

# Busca en todos los usuarios, para no hacerlo "HKCU" pues el script corre normalmente como SYSTEM ACCOUNT
Get-ChildItem Registry::HKEY_USERS |
Where-Object { $_.PSChildName -match '^S-1-5-21-.+-\d+$' } |
ForEach-Object {
    $Path = "$($_.PSPath)\Control Panel\Desktop"

    if (Test-Path $Path) {
        New-ItemProperty -Path $Path -Name "TouchGestureSetting" -Value 0 -PropertyType DWord -Force | Out-Null
    }
}

# Deshabilitar los gestos de borde de la pantalla táctil (configuración por equipo)
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EdgeUI" -Force | Out-Null; New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EdgeUI" -Name "AllowEdgeSwipe" -Value 0 -PropertyType DWord -Force | Out-Null

# Reiniciar el equipo para aplicar los cambios
Restart-Computer -Force
