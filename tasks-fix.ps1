# Este script detiene el servicio del agente Cloud, renombra el archivo de tareas y levanta el servicio nuevamente

# detiene el servicio
# Stop-Service -Name "FWASvc" -Force -ErrorAction Stop
sc stop "FWASvc"

# espera hasta que el servicio se detenga. verifica que el servicio exista, y un maximo de intentos para evitar loop infinito.
$maxIntentos = 30
$intento = 0
$servicioObj = Get-Service -Name "FWASvc" -ErrorAction SilentlyContinue
while ($true) {

    if (-not $servicioObj) {
        Write-Error "El servicio no existe"
        break
    }

    # Se detuvo, seguimos
    if ($servicioObj.Status -eq "Stopped") {
        break
    }

    if ($intento -ge $maxIntentos) {
        Write-Error "Se alcanzó el máximo de intentos"
        break
    }

    Start-Sleep -Seconds 1
    $intento++
    $servicioObj.Refresh()
}

# renombra el archivo
Move-Item -Path "C:\ProgramData\Faronics\StorageSpace\FWA\Tasks.dat" -Destination "C:\ProgramData\Faronics\StorageSpace\FWA\Tasks.old" -Force

#start
Start-Service -Name "FWASvc"
