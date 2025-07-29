# ID de la aplicación
$AppId = "9NBLGGH40F2T"

# Ruta al script que se ejecutará
$ScriptPath = "$env:ProgramData\InstallWithWinget.ps1"

# Contenido del script que se ejecutará al iniciar sesión
$ScriptContent = @"
winget install --id $AppId --source msstore --silent --accept-package-agreements --accept-source-agreements
schtasks /Delete /TN InstallCompleteAnatomy /F
Remove-Item -Path `"$ScriptPath`" -Force
"@

# Guardar el script
Set-Content -Path $ScriptPath -Value $ScriptContent -Encoding UTF8 -Force

# Crear tarea programada sin asignar usuario explícito, ni ejecutar como admin
Start-Process -FilePath schtasks.exe -ArgumentList @(
    "/Create",
    "/TN", "InstallCompleteAnatomy",
    "/TR", "`"powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File `"$ScriptPath`"`"",
    "/SC", "ONLOGON",
    "/F"
) -NoNewWindow -Wait
