# Buscar y eliminar claves en HKEY_LOCAL_MACHINE\Software
$operaKeysHKLM = Get-ChildItem -Path "HKLM:\SOFTWARE" | Where-Object { $_.Name -match "Opera" }
foreach ($key in $operaKeysHKLM) {
    Write-Output "Eliminando clave: $($key.Name)"
    Remove-Item -Path $key.PSPath -Recurse -Force
}

# Buscar y eliminar claves en HKEY_CURRENT_USER\Software
$operaKeysHKCU = Get-ChildItem -Path "HKCU:\Software" | Where-Object { $_.Name -match "Opera" }
foreach ($key in $operaKeysHKCU) {
    Write-Output "Eliminando clave: $($key.Name)"
    Remove-Item -Path $key.PSPath -Recurse -Force
}

# Eliminar entradas en la lista de desinstalación
$uninstallKeys = Get-ChildItem -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall" | Where-Object { $_.Name -match "Opera" }
foreach ($key in $uninstallKeys) {
    Write-Output "Eliminando clave de desinstalación: $($key.Name)"
    Remove-Item -Path $key.PSPath -Recurse -Force
}


# Carpetas comunes donde Opera guarda datos
$operaPaths = @(
    "$env:AppData\Opera Software",
    "$env:LocalAppData\Programs\Opera",
    "$env:ProgramFiles\Opera",
    "$env:ProgramFiles(x86)\Opera"
)

foreach ($path in $operaPaths) {
    if (Test-Path $path) {
        Write-Output "Eliminando carpeta: $path"
        Remove-Item -Path $path -Recurse -Force
    } else {
        Write-Output "No se encontró la carpeta: $path"
    }
}
