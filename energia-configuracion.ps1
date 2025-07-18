# Función para mostrar los valores actuales
function Mostrar-ConfiguracionEnergia {
    Write-Host "`n--- Estado actual de configuración de energía ---" -ForegroundColor Cyan

    $hibernacionDisponible = powercfg -a | Select-String "Hibernación"
    Write-Host "Hibernación: $(if ($hibernacionDisponible) { 'Habilitada' } else { 'Deshabilitada' })"

    $valores = @{
        "Suspensión (DC)"     = @{ Sub = "SUB_SLEEP";   Setting = "STANDBYIDLE"; DC = $true  }
        "Suspensión (AC)"     = @{ Sub = "SUB_SLEEP";   Setting = "STANDBYIDLE"; DC = $false }
        "Apagar disco (DC)"   = @{ Sub = "SUB_DISK";    Setting = "DISKIDLE";    DC = $true  }
        "Apagar disco (AC)"   = @{ Sub = "SUB_DISK";    Setting = "DISKIDLE";    DC = $false }
        "Pantalla (DC)"       = @{ Sub = "SUB_VIDEO";   Setting = "VIDEOIDLE";   DC = $true  }
        "Pantalla (AC)"       = @{ Sub = "SUB_VIDEO";   Setting = "VIDEOIDLE";   DC = $false }
    }

    foreach ($clave in $valores.Keys) {
        $subgrupo = $valores[$clave].Sub
        $config = $valores[$clave].Setting
        $dc = $valores[$clave].DC

        try {
            $salida = powercfg -query SCHEME_CURRENT $subgrupo $config
            $linea = $salida | Where-Object { $_ -match "Power Setting Index" } 
            $index = if ($dc) { $linea[0] } else { $linea[-1] }

            if ($index -match "0x(\w+)") {
                $hex = $matches[1]
                $dec = [convert]::ToInt32($hex, 16)
                Write-Host "$clave: $dec minutos"
            } else {
                Write-Host "$clave: No se pudo obtener el valor" -ForegroundColor Yellow
            }
        } catch {
            Write-Host "$clave: Error al obtener la configuración" -ForegroundColor Red
        }
    }
}

# Mostrar configuración antes
Mostrar-ConfiguracionEnergia
