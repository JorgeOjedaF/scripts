# Script: Verificar requisitos de Windows 11

Write-Host "=== Verificacion de requisitos de Windows 11 ===" -ForegroundColor Cyan

# --- CPU ---
$cpu = Get-CimInstance Win32_Processor
$cpuOK = ($cpu.NumberOfCores -ge 2 -and $cpu.MaxClockSpeed -ge 1000 -and [Environment]::Is64BitOperatingSystem)
Write-Host "CPU: $cpuOK - $($cpu.Name) | Nucleos: $($cpu.NumberOfCores) | Velocidad: $($cpu.MaxClockSpeed) MHz | 64-bit: $([Environment]::Is64BitOperatingSystem)" `
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
$tempFile = "$env:TEMP\dxdiag_output.txt"
Start-Process -FilePath "dxdiag.exe" -ArgumentList "/t $tempFile" -Wait -WindowStyle Hidden
$dxinfo = Get-Content $tempFile
$dxVersion = ($dxinfo | Select-String "DirectX Version").ToString()
$gpuName = ($dxinfo | Select-String "Card name").ToString()

$gpuOK = $dxVersion -match "12"
Write-Host "GPU: $gpuName"
Write-Host "DirectX: $gpuOK - $dxVersion" -ForegroundColor ($(if ($gpuOK) {'Green'} else {'Red'}))


# --- Pantalla ---
Add-Type -AssemblyName System.Windows.Forms
$screen = [System.Windows.Forms.Screen]::PrimaryScreen
$width = $screen.Bounds.Width
$height = $screen.Bounds.Height

$screenOK = ($width -ge 1280 -and $height -ge 720)
Write-Host "Pantalla: $screenOK - ${width}x${height}" -ForegroundColor ($(if ($screenOK) {'Green'} else {'Red'}))


# --- Resultado ---
if ($cpuOK -and $ramOK -and $diskOK -and $tpmOK -and $sbOK -and $gpuOK -and $screenOK) {
    Write-Host "`n Este equipo cumple los requisitos para Windows 11" -ForegroundColor Green
} else {
    Write-Host "`n Este equipo NO cumple todos los requisitos para Windows 11" -ForegroundColor Red
}
