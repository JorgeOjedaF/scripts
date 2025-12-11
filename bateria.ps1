Get-CimInstance -ClassName Win32_Battery |
Select-Object @{Name='%';Expression={$_.EstimatedChargeRemaining}},
              @{Name='Estado de la bateria';Expression={
                switch ($_.BatteryStatus) {
                  1 {'Descargando (BatteryStatus:1)'}
                  2 {'Con acceso a CA, no necesariamente cargando (BatteryStatus:2)'}
                  3 {'Completamente cargada (BatteryStatus:3)'}
                  4 {'Baja (BatteryStatus:4)'}
                  5 {'Crítica (BatteryStatus:5)'}
                  6 {'Cargando (BatteryStatus:6)'}
                  7 {'Cargando - nivel alto (BatteryStatus:7)'}
                  8 {'Cargando - nivel bajo (BatteryStatus:8)'}
                  9 {'Cargando - nivel crítico (BatteryStatus:9)'}
                  10 {'Indefinido (BatteryStatus:10)'}
                  11 {'Parcialmente cargada (BatteryStatus:11)'}
                  default { "Desconocido ($($_.BatteryStatus))" }
                }
              }}

