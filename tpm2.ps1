# Script: Verificar requisitos de Windows 11

# --- CPU ---
$cpu = Get-CimInstance Win32_Processor
$cpuOK = ($cpu.NumberOfCores -ge 2 -and $cpu.MaxClockSpeed -ge 1000 -and [Environment]::Is64BitOperatingSystem)

# --- RAM ---
$ramGB = [math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 0)
$ramOK = $ramGB -ge 4

# --- Disk ---
$disk = (Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'").Size / 1GB
$diskOK = $disk -ge 64

# --- TPM ---
$tpm = Get-CimInstance -Namespace "Root\CIMv2\Security\MicrosoftTpm" -ClassName Win32_Tpm -ErrorAction SilentlyContinue
$tpmOK = ($tpm -and $tpm.SpecVersion -match "2.0")

# --- Secure Boot ---
$sb = Confirm-SecureBootUEFI -ErrorAction SilentlyContinue
$sbOK = ($sb -eq $true)

# --- GPU --- Graphics card	Compatible with DirectX 12 or later
$tempFile = "$env:TEMP\dxdiag_output.txt"
Start-Process -FilePath "dxdiag.exe" -ArgumentList "/t $tempFile" -Wait -WindowStyle Hidden
$dxinfo = Get-Content $tempFile
$dxVersion = ($dxinfo | Select-String "DirectX Version").ToString().Trim()
$gpuOK = $dxVersion -match "12"
$gpuNames = ($dxinfo | Select-String "Card name").Line -replace "Card name:\s*", "" | ForEach-Object { $_.Trim() }

# --- Screen (resolution and diagonal ≥ 9'') ---
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$screen = [System.Windows.Forms.Screen]::PrimaryScreen
$width = $screen.Bounds.Width
$height = $screen.Bounds.Height

# Get Windows DPI
$g = [System.Drawing.Graphics]::FromHwnd([IntPtr]::Zero)
$dpiX = $g.DpiX
$g.Dispose()

# Calculate size in inches
$widthInches = $width / $dpiX
$heightInches = $height / $dpiX
$diagonalInches = [math]::Sqrt([math]::Pow($widthInches,2) + [math]::Pow($heightInches,2))

$screenOK = ($height -ge 720 -and $diagonalInches -ge 9)

# --- Resultado ---
if ($cpuOK -and $ramOK -and $diskOK -and $tpmOK -and $sbOK -and $gpuOK -and $screenOK) {
    Write-Host "`n Este equipo cumple los requisitos para Windows 11" -ForegroundColor Green
} else {
    Write-Host "`n Este equipo NO cumple todos los requisitos para Windows 11" -ForegroundColor Red
}

Write-Host "`n === Verificacion de requisitos de Windows 11 ===" -ForegroundColor Cyan

Write-Host "1) CPU: $cpuOK ( $($cpu.Name) | Nucleos: $($cpu.NumberOfCores) | Velocidad: $($cpu.MaxClockSpeed) MHz | 64-bit: $([Environment]::Is64BitOperatingSystem))" -ForegroundColor ($(if ($cpuOK) {'Green'} else {'Red'}))
Write-Host ("2) RAM: $ramOK ( {0:N2} GB)" -f $ram) -ForegroundColor ($(if ($ramOK) {'Green'} else {'Red'}))
Write-Host ("3) Disco (C:): $diskOK ( {0:N2} GB)" -f $disk) -ForegroundColor ($(if ($diskOK) {'Green'} else {'Red'}))
Write-Host "4) TPM: $tpmOK ( $($tpm.SpecVersion))" -ForegroundColor ($(if ($tpmOK) {'Green'} else {'Red'}))
Write-Host "5) Secure Boot habilitado: $sbOK " -ForegroundColor ($(if ($sbOK) {'Green'} else {'Red'}))
Write-Host "6) DirectX: $gpuOK (Card name: " $($gpuNames -join ' | ') $dxVersion ")" -ForegroundColor ($(if ($gpuOK) {'Green'} else {'Red'}))
Write-Host ("7) Pantalla: $screenOK ( {0}x{1} px | Diagonal aprox: {2:N1}'')" -f $width, $height, $diagonalInches) -ForegroundColor ($(if ($screenOK) {'Green'} else {'Red'}))


