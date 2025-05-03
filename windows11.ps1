# Rutas origen y destino del archivo ISO con windows 11
$isoOrigen = "\\vmware-host\sharedfolders\Jorge\iso\Windows11.iso"
$isoDestino = "C:\Temp\Windows11.iso"

# Crear carpeta temporal si no existe
if (-not (Test-Path "C:\Temp")) {
    New-Item -Path "C:\Temp" -ItemType Directory | Out-Null
}

# Copiar la ISO
Copy-Item -Path $isoOrigen -Destination $isoDestino -Force

# Montar la ISO
Mount-DiskImage -ImagePath $isoDestino
Start-Sleep -Seconds 5

# Obtener letra de unidad montada
$unidadISO = (Get-Volume | Where-Object { $_.FileSystemLabel -eq "CCCOMA_X64FRE_ES-MX_DV9" }).DriveLetter
if (-not $unidadISO) {
    $unidadISO = (Get-Volume | Where-Object { $_.DriveLetter -and (Get-ChildItem "$($_.DriveLetter):\" -Recurse -ErrorAction SilentlyContinue | Where-Object { $_.Name -eq "setup.exe" }) }).DriveLetter
}
$unidadISOPath = "$unidadISO`:\setup.exe"

# Ejecutar la actualización (manteniendo datos y apps)
Start-Process -FilePath $unidadISOPath -ArgumentList "/auto upgrade /quiet /noreboot /compat ignorewarning" -Wait

# Desmontar la ISO
Dismount-DiskImage -ImagePath $isoDestino

# Reiniciar el equipo
Restart-Computer -Force
