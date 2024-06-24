# Deshabilita el poder agregar impresoras
# Crear la ruta si no existe
if (-Not (Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Printer")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Printer" -Force
}

# Crear la subclave Settings si no existe
if (-Not (Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Printer\Settings")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Printer\Settings" -Force
}

# Deshabilitar la instalación de impresoras
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Printer\Settings" -Name "DisableAddPrinter" -Value 1 -Force

# Actualizar las políticas de grupo
gpupdate /force
