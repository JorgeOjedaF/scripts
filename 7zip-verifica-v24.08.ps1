# Define the minimum safe version
$SafeVersion = [Version]"24.08"

# Retrieve installed 7-Zip version from the registry
$RegistryPath = "HKLM:\SOFTWARE\7-Zip"
$Version = Get-ItemProperty -Path $RegistryPath -Name "Path" -ErrorAction SilentlyContinue

if ($Version) {
    $ExePath = Join-Path $Version.Path "7z.exe"
    if (Test-Path $ExePath) {
        $FileVersion = (Get-Command $ExePath).FileVersionInfo.FileVersion
        $InstalledVersion = [Version]$FileVersion

        if ($InstalledVersion -lt $SafeVersion) {
            Write-Output "Vulnerable 7-Zip version detected: $InstalledVersion"
        } else {
            Write-Output "7-Zip version $InstalledVersion is up to date."
        }
    } else {
        Write-Output "7z.exe not found at the expected location."
    }
} else {
    Write-Output "7-Zip is not installed on this system."
}

# fuente: https://www.vicarius.io/vsociety/posts/cve-2024-11477-detect-vulnerable-7zip
