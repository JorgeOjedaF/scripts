# Script PowerShell - Listar aplicaciones instaladas con fecha y versión

Write-Host "=== Aplicaciones instaladas (MSI / EXE / Microsoft Store) ===" -ForegroundColor Cyan

# --- 1. Aplicaciones instaladas por MSI (Win32_Product) ---
$msiApps = Get-CimInstance Win32_Product |
    Select-Object @{n="Nombre";e={$_.Name}},
                  @{n="Version";e={$_.Version}},
                  @{n="FechaInstalacion";e={
                      if ($_.InstallDate) {
                          [datetime]::ParseExact($_.InstallDate,"yyyyMMdd",$null)
                      } else { $null }
                  }},
				  @{n="Origen";e={"MSI"}}

# --- 2. Aplicaciones registradas en el Registro de Windows (32 y 64 bits) ---
$regPaths = @(
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall",
    "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
)

$regApps = foreach ($path in $regPaths) {
    Get-ChildItem $path -ErrorAction SilentlyContinue | ForEach-Object {
        $name = $_.GetValue("DisplayName")
        if ($name) {
            # Intentar recuperar InstallDate del registro
            $fecha = $null
            if ($_.GetValue("InstallDate")) {
                try { $fecha = [datetime]::ParseExact($_.GetValue("InstallDate"),"yyyyMMdd",$null) }
                catch { $fecha = $null }
            }
            # Si no hay fecha, usar carpeta de programa
            $installPath = $_.GetValue("InstallLocation")
            if (-not $fecha -and $installPath -and (Test-Path $installPath)) {
                $fecha = (Get-Item $installPath).CreationTime
            }

            [PSCustomObject]@{
                Nombre           = $name
                Version          = $_.GetValue("DisplayVersion")
                FechaInstalacion = $fecha
				Origen           = "Registro"
            }
        }
    }
}

# --- 3. Aplicaciones de Microsoft Store (UWP) ---
$storeApps = Get-AppxPackage | ForEach-Object {
    $path = $_.InstallLocation
    $fecha = $null
    if (Test-Path $path) {
        $fecha = (Get-Item $path).CreationTime
    }
    [PSCustomObject]@{        
        Nombre           = $_.Name
        Version          = $_.Version
        FechaInstalacion = $fecha
		Origen           = "Microsoft Store"
    }
}

# --- Unir y mostrar ---
$allApps = $msiApps + $regApps + $storeApps | Sort-Object Nombre

$allApps | Format-Table -AutoSize
