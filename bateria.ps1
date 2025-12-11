Get-CimInstance -ClassName Win32_Battery |
Select-Object @{Name='Carga%';Expression={$_.EstimatedChargeRemaining}},
              @{Name='BatteryStatus';Expression={$_.BatteryStatus}},
              @{Name='Estado de la bateria';Expression={
                switch ($_.BatteryStatus) {
                  1 {'Descargando'}
                  2 {'Con acceso a CA (no necesariamente cargando)'}
                  3 {'Completamente cargada'}
                  4 {'Baja'}
                  5 {'Crítica'}
                  6 {'Cargando'}
                  7 {'Cargando - nivel alto'}
                  8 {'Cargando - nivel bajo'}
                  9 {'Cargando - nivel crítico'}
                  10 {'Indefinido'}
                  11 {'Parcialmente cargada'}
                  default { "Desconocido ($($_.BatteryStatus))" }
                }
              }}

