# Instala una app desde MS Store usando winget. 
# Parametros: Recibe el id de la app de MS Store. Se puede encontrar el id de una app con el comando winget search "NombreApp"
$AppId = $args[0]
$AppId = "9NBLGGH40F2T"

# Ruta del script
$ScriptPath = "$env:ProgramData\InstallWithWinget.ps1"

# Contenido del script que se ejecutará al iniciar sesión
$WingetCommand = @"
winget install --id $AppId --source msstore --silent --accept-package-agreements --accept-source-agreements
Unregister-ScheduledTask -TaskName InstallCompleteAnatomy -Confirm:\$false
Remove-Item -Path '$ScriptPath' -Force
"@

# Guardar el script
Set-Content -Path $ScriptPath -Value $WingetCommand -Encoding UTF8 -Force

# Crear acción, trigger, principal y configuración de la tarea
$Action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-WindowStyle Hidden -ExecutionPolicy Bypass -File `"$ScriptPath`""
$Trigger = New-ScheduledTaskTrigger -AtLogOn
$Principal = New-ScheduledTaskPrincipal -UserId "INTERACTIVE" -LogonType Interactive -RunLevel Highest

# Registrar la tarea
Register-ScheduledTask -TaskName "InstallCompleteAnatomy" -Action $Action -Trigger $Trigger -Principal $Principal -Force

