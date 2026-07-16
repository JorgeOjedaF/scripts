# esto deshabilita el gesto de 3 y 4 dedos en pantallas tactiles. 
# Settings → Bluetooth & devices → Touch → Three and four-finger touch gestures.
New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "TouchGestureSetting" -Value 0 -PropertyType DWord -Force | Out-Null
