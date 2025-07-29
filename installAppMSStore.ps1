# ID de la aplicación
$AppId = "9NBLGGH40F2T"

# Ruta al script que se ejecutará al iniciar sesión
$ScriptPath = "$env:ProgramData\InstallWithWinget.ps1"

# Contenido del script
$ScriptContent = @"
winget install --id $AppId --source msstore --silent --accept-package-agreements --accept-source-agreements
schtasks /Delete /TN InstallCompleteAnatomy /F
del `"$ScriptPath`"
"@

# Guardar script
Set-Content -Path $ScriptPath -Value $ScriptContent -Encoding UTF8 -Force

# Crear la tarea con schtasks.exe para que se ejecute al iniciar sesión del usuario
schtasks /Create /TN InstallCompleteAnatomy /TR "powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File `"$ScriptPath`"" /SC ONLOGON /RL HIGHEST /F
