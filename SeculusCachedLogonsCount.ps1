# Deshabilita el almacenamiento en caché de credenciales y apaga el PC
# Esto obliga al usuario a volver a conectarse al domain controler porque se limpia el cache del login
# Es posible tener que cambiar este valor nuevamente para permitir a un usuario logearse fuera del dominio en forma posterior.
# https://learn.microsoft.com/en-us/troubleshoot/windows-server/user-profiles-and-logon/cached-domain-logon-information
$registryPath = "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon"
$registryName = "CachedLogonsCount"

# Comprobar si la clave del registro ya existe
if (Test-Path $registryPath) {
    # Deshabilitar el almacenamiento en caché de credenciales estableciendo CachedLogonsCount en 0
    Set-ItemProperty -Path $registryPath -Name $registryName -Value 0

    Write-Host "El almacenamiento en caché de credenciales se ha deshabilitado."
} else {
    Write-Host "La clave del registro no existe. Asegúrate de estar ejecutando el script con privilegios elevados."
}
# apaga el PC para obligar a iniciar sesion.
Stop-Computer -Force
