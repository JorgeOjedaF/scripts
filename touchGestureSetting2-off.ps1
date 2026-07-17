# esto deshabilita el gesto de 3 y 4 dedos en pantallas tactiles. 
# Settings → Bluetooth & devices → Touch → Three and four-finger touch gestures.

# Busca en todos los usuarios, para no hacerlo "HKCU" pues el script corre normalmente como SYSTEM ACCOUNT
Get-ChildItem Registry::HKEY_USERS |
Where-Object { $_.PSChildName -match '^S-1-5-21-' } |
ForEach-Object {
    New-ItemProperty -Path "$($_.PSPath)\Control Panel\Desktop" -Name "TouchGestureSetting" -Value 0 -PropertyType DWord -Force | Out-Null
}
