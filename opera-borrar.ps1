# Borra del registro Opera
$paths = @(
  "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall",
  "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall",
  "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall",
  "HKCU:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
)
foreach ($path in $paths) {
    if (Test-Path $path) {
        Get-ChildItem $path |
        ForEach-Object { Get-ItemProperty $_.PsPath } |
        Where-Object { $_.DisplayName -like "Opera*" } |
        ForEach-Object {
            Write-Host "Eliminando entrada de registro: $($_.DisplayName)"
            Remove-Item $_.PsPath -Recurse -Force
        }
    }
}

# Borra las carpetas de Opera
$folders = @(
  "$env:LOCALAPPDATA\Programs\Opera",
  "$env:LOCALAPPDATA\Programs\Opera GX",
  "$env:APPDATA\Opera Software",
  "$env:PROGRAMFILES\Opera",
  "$env:PROGRAMFILES(x86)\Opera"
)

foreach ($folder in $folders) {
    if (Test-Path $folder) {
        Write-Host "Eliminando carpeta: $folder"
        Remove-Item $folder -Recurse -Force
    }
}

# Borra los accesos directos
$shortcuts = @(
  "$env:PUBLIC\Desktop\Opera.lnk",
  "$env:PUBLIC\Desktop\Opera GX.lnk",
  "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Opera.lnk",
  "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Opera GX.lnk"
)

foreach ($shortcut in $shortcuts) {
    if (Test-Path $shortcut) {
        Write-Host "Eliminando acceso directo: $shortcut"
        Remove-Item $shortcut -Force
    }
}

Write-Host " Limpieza de Opera completada."
