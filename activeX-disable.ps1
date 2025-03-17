# Deshabilita las macros y ActiveX en cualquier versión de Microsoft Office para todos los usuarios (HKLM)

# Deshabilitar macros
Set-ItemProperty -Path "HKLM:\Software\Microsoft\Office\ClickToRun\REGISTRY\MACHINE\Software\Microsoft\Office\*\Word\Security" -Name "VBAWarnings" -Value 4 -Type DWord -Force

# Deshabilitar ActiveX
Set-ItemProperty -Path "HKLM:\Software\Microsoft\Office\ClickToRun\REGISTRY\MACHINE\Software\Microsoft\Office\Common\Security" -Name "DisableAllActiveX" -Value 1 -Type DWord -Force
Este comando realiza lo siguiente:

# Utiliza el comodín (*) en la ruta del registro para aplicar la configuración a todas las versiones de Office instaladas.
# Establece "VBAWarnings" a 4, lo que deshabilita todas las macros con notificación.
# Establece "DisableAllActiveX" a 1, lo que deshabilita todos los controles ActiveX.
# Usa la ruta HKLM (HKEY_LOCAL_MACHINE) para aplicar la configuración a todos los usuarios del sistema.
# Utiliza la ruta ClickToRun para asegurar la compatibilidad con las instalaciones modernas de Office.
