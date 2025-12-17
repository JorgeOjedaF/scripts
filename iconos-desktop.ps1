# $args[0] puede ser 1 o 0 para ocultar o no los iconnos del escritorio
Set-ItemProperty `
 -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" `
 -Name HideIcons `
 -Value $args[0]

Stop-Process -Name explorer -Force
