# Recibe como parametro la url, algo como "https://servidor.com/DeepFreezeCleanUp.zip"
$url = $args[0]
$zip = "$env:TEMP\archivo.zip"
$destino = "$env:TEMP\archivo_extraido"
$exe = Join-Path $destino "DeepFreezeCleanUp.exe"

Write-Host "url: $url"

# Descargar el ZIP
Invoke-WebRequest -Uri $url -OutFile $zip -ErrorAction Stop

# Extraer el ZIP
Expand-Archive -Path $zip -DestinationPath $destino -Force -ErrorAction Stop

# Verificar y ejecutar el EXE
if (Test-Path $exe) {
    Write-Host "Start-Process"
    Start-Process -FilePath $exe -Wait
    Write-Host "ok"
} else {
    throw "No se encontró DeepFreezeCleanUp.exe en la ubicación esperada: $exe"
}
