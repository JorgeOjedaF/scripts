# Este script detiene el servicio del agente Cloud, renombra el archivo de tareas y levanta el servicio nuevamente

# detiene el servicio
sc stop "FWASvc"

# espera 5 segundos para dar tiempo a que se detenga el servicio
Start-Sleep -Seconds 5

# renombra el archivo
Move-Item -Path "C:\ProgramData\Faronics\StorageSpace\FWA\Tasks.dat" -Destination "C:\ProgramData\Faronics\StorageSpace\FWA\Tasks.old" -Force

# inicia el servicio nuevamente
sc start "FWASvc"
