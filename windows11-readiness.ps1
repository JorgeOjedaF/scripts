# Script: Check Windows 11 requirements
Write-Host "=== Windows 11 Requirements Check ===" -ForegroundColor Cyan

# --- CPU ---
$cpu = Get-CimInstance Win32_Processor
$cpuOK = ($cpu.NumberOfCores -ge 2 -and $cpu.MaxClockSpeed -ge 1000 -and [Environment]::Is64BitOperatingSystem)
Write-Host "CPU: $cpuOK - $($cpu.Name) | Cores: $($cpu.NumberOfCores) | Speed: $($cpu.MaxClockSpeed) MHz | 64-bit: $([Environment]::Is64BitOperatingSystem)" -ForegroundColor ($(if ($cpuOK) {'Green'} else {'Red'}))

# --- RAM ---
$ram = (Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB
$ramOK = $ram -ge 4
Write-Host("RAM: $ramOK - {0:N2} GB" -f $ram) -ForegroundColor ($(if ($ramOK) {'Green'} else {'Red'}))

# --- Disk ---
$disk = (Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'").Size / 1GB
$diskOK = $disk -ge 64
Write-Host ("Disk (C:): $diskOK - {0:N2} GB" -f $disk) -ForegroundColor ($(if ($diskOK) {'Green'} else {'Red'}))

# --- TPM ---
$tpm = Get-CimInstance -Namespace "Root\CIMv2\Security\MicrosoftTpm" -ClassName Win32_Tpm -ErrorAction SilentlyContinue
$tpmOK = ($tpm -and $tpm.SpecVersion -match "2.0")
Write-Host "TPM: $tpmOK - $($tpm.SpecVersion)" -ForegroundColor ($(if ($tpmOK) {'Green'} else {'Red'}))

# --- Secure Boot ---
$sb = Confirm-SecureBootUEFI -ErrorAction SilentlyContinue
$sbOK = ($sb -eq $true)
Write-Host "Secure Boot enabled: $sb" -ForegroundColor ($(if ($sbOK) {'Green'} else {'Red'}))

# --- GPU ---
$tempFile = "$env:TEMP\dxdiag_output.txt"
Start-Process -FilePath "dxdiag.exe" -ArgumentList "/t $tempFile" -Wait -WindowStyle Hidden
$dxinfo = Get-Content $tempFile
$dxVersion = ($dxinfo | Select-String "DirectX Version").ToString().Trim()
$gpuName = ($dxinfo | Select-String "Card name").ToString().Trim()

$gpuOK = $dxVersion -match "12"
Write-Host "DirectX: $gpuOK - $gpuName - $dxVersion" -ForegroundColor ($(if ($gpuOK) {'Green'} else {'Red'}))


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
Write-Host ("Screen: $screenOK - {0}x{1} px | Diagonal approx: {2:N1}''" -f $width, $height, $diagonalInches) -ForegroundColor ($(if ($screenOK) {'Green'} else {'Red'}))


# --- Result ---
if ($cpuOK -and $ramOK -and $diskOK -and $tpmOK -and $sbOK -and $gpuOK -and $screenOK) { 
Write-Host "`n This computer meets the requirements for Windows 11" -ForegroundColor Green
} else { 
Write-Host "`n This computer does NOT meet all requirements for Windows 11" -ForegroundColor Red
}
