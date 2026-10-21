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
Write-Host "Start-Process"

"Inicio: $(Get-Date)" |
    Out-File "$env:TEMP\ejecucion.log" -Append

try {
    $p = Start-Process -FilePath $exe -PassThru -ErrorAction Stop
    "PID: $($p.Id)" |
        Out-File "$env:TEMP\ejecucion.log" -Append

    Wait-Process -Id $p.Id -Timeout 60 -ErrorAction Stop

    $p.Refresh()
    "Terminado: $(Get-Date), ExitCode: $($p.ExitCode)" |
        Out-File "$env:TEMP\ejecucion.log" -Append
}
catch {
    Write-Host "error: $($_.Exception.Message)"
    "Error: $(Get-Date) - $($_.Exception.Message)" |
        Out-File "$env:TEMP\ejecucion.log" -Append
}
