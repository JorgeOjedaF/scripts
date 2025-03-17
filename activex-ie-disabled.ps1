# Configurar la opción para deshabilitar controles ActiveX no firmados
# La clave Zones\3 corresponde a la zona de Internet en las configuraciones de seguridad de Internet Explorer.
# Clave "1004": Controla la ejecución de controles ActiveX no firmados.
# Valor 3: Deshabilita la ejecución de controles ActiveX no firmados.
# Valor 1: Habilita los controles ActiveX con notificación.
# Valor 0: Habilita los controles ActiveX sin restricciones.
Set-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" -Name "1004" -Value 3 -Type DWord
