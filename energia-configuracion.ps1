# Función para mostrar los valores actuales
function Mostrar-ConfiguracionEnergia {
    Write-Host "`n--- Estado actual de configuración de energía ---" -ForegroundColor Cyan
    Write-Host "Hibernación: $(if ((powercfg -a) -notmatch 'Hibernate') { 'Deshabilitada' } else { 'Habilitada' })"
    
    $valores = @{
        "Suspensión (DC)"     = powercfg -query SCHEME_CURRENT SUB_SLEEP STANDBYIDLE | Select-String -Pattern "Power Setting Index: 0x(\w+)" | Select-Object -First 1
        "Suspensión (AC)"     = powercfg -query SCHEME_CURRENT SUB_SLEEP STANDBYIDLE | Select-String -Pattern "Power Setting Index: 0x(\w+)" | Select-Object -Last 1
        "Apagar disco (DC)"   = powercfg -query SCHEME_CURRENT SUB_DISK DISKIDLE | Select-String -Pattern "Power Setting Index: 0x(\w+)" | Select-Object -First 1
        "Apagar disco (AC)"   = powercfg -query SCHEME_CURRENT SUB_DISK DISKIDLE | Select-String -Pattern "Power Setting Index: 0x(\w+)" | Select-Object -Last 1
        "Pantalla (DC)"       = powercfg -query SCHEME_CURRENT SUB_VIDEO VIDEOIDLE | Select-String -Pattern "Power Setting Index: 0x(\w+)" | Select-Object -First 1
        "Pantalla (AC)"       = powercfg -query SCHEME_CURRENT SUB_VIDEO VIDEOIDLE | Select-String -Pattern "Power Setting Index: 0x(\w+)" | Select-Object -Last 1
    }

    foreach ($clave in $valores.Keys) {
        $hex = ($valores[$clave] -replace '.*0x', '')
        $dec = [convert]::ToInt32($hex, 16)
        Write-Host "$clave: $dec minutos"
    }
}

# Mostrar configuración antes
Mostrar-ConfiguracionEnergia
