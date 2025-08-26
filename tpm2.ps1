# Script: Verificar requisitos de Windows 11

Write-Host "=== Verificacion de requisitos de Windows 11 ===" -ForegroundColor Cyan

# --- CPU ---
$cpu = Get-CimInstance Win32_Processor
$cpuOK = ($cpu.NumberOfCores -ge 2 -and $cpu.MaxClockSpeed -ge 1000 -and [Environment]::Is64BitOperatingSystem)
Write-Host "CPU: $cpuOK - $($cpu.Name) | Núcleos: $($cpu.NumberOfCores) | Velocidad: $($cpu.MaxClockSpeed) MHz | 64-bit: $([Environment]::Is64BitOperatingSystem)" `
    -ForegroundColor ($(if ($cpuOK) {'Green'} else {'Red'}))

# --- RAM ---
$ram = (Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB
$ramOK = $ram -ge 4
Write-Host ("RAM: $ramOK - {0:N2} GB" -f $ram) -ForegroundColor ($(if ($ramOK) {'Green'} else {'Red'}))

# --- Disco ---
$disk = (Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'").Size / 1GB
$diskOK = $disk -ge 64
Write-Host ("Disco (C:): $diskOK - {0:N2} GB" -f $disk) -ForegroundColor ($(if ($diskOK) {'Green'} else {'Red'}))

# --- TPM ---
$tpm = Get-CimInstance -Namespace "Root\CIMv2\Security\MicrosoftTpm" -ClassName Win32_Tpm -ErrorAction SilentlyContinue
$tpmOK = ($tpm -and $tpm.SpecVersion -match "2.0")
Write-Host "TPM: $tpmOK - $($tpm.SpecVersion)" -ForegroundColor ($(if ($tpmOK) {'Green'} else {'Red'}))

# --- Secure Boot ---
$sb = Confirm-SecureBootUEFI -ErrorAction SilentlyContinue
$sbOK = ($sb -eq $true)
Write-Host "Secure Boot habilitado: $sbOK - $sb" -ForegroundColor ($(if ($sbOK) {'Green'} else {'Red'}))

# --- GPU ---
$gpu = Get-CimInstance Win32_VideoController
$gpuOK = $gpu.VideoProcessor -match "DirectX 12"
Write-Host "GPU: $gpuOK - $($gpu.Name) | Procesador de video: $($gpu.VideoProcessor)" -ForegroundColor ($(if ($gpuOK) {'Green'} else {'Red'}))

# --- Pantalla ---
$screen = Get-CimInstance Win32_DesktopMonitor | Where-Object { $_.ScreenWidth -ne $null -and $_.ScreenHeight -ne $null }
$screenOK = ($screen.ScreenWidth -ge 1280 -and $screen.ScreenHeight -ge 720 -and (($screen.ScreenWidth/96) -ge 9))
Write-Host "Pantalla: $screenOK - $($screen.ScreenWidth)x$($screen.ScreenHeight)" -ForegroundColor ($(if ($screenOK) {'Green'} else {'Red'}))

# --- Resultado ---
if ($cpuOK -and $ramOK -and $diskOK -and $tpmOK -and $sbOK -and $gpuOK -and $screenOK) {
    Write-Host "`n Este equipo cumple los requisitos para Windows 11" -ForegroundColor Green
} else {
    Write-Host "`n Este equipo NO cumple todos los requisitos para Windows 11" -ForegroundColor Red
}
