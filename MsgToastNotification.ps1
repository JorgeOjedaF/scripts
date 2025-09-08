# instalamos el modulo BurntToast si no esta instalado, confiando en el repositorio
if (-not (Get-Module -ListAvailable -Name BurntToast)) {
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted -ErrorAction SilentlyContinue
    Install-PackageProvider -Name NuGet -Force -Scope CurrentUser
    Install-Module -Name BurntToast -Force -Scope CurrentUser
}

# Aseguramos que C:\Temp exista
$folder = "C:\Temp"
if (-not (Test-Path $folder)) {
    New-Item -Path $folder -ItemType Directory -Force | Out-Null
}

# Crear script temporal para la notificación
$UserId = "$env:UserDomain\$env:UserName"
$scriptPath = "C:\Temp\toast_temp.ps1"
$scriptContent = @"
Import-Module BurntToast
New-BurntToastNotification -Text '$args[0]'
"@
$scriptContent | Out-File -FilePath $scriptPath -Encoding UTF8

# Crear tarea programada para ejecutarse inmediatamente
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-ExecutionPolicy Bypass -File `"$scriptPath`""
$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date).AddSeconds(2)
$principal = New-ScheduledTaskPrincipal -UserId $UserId -LogonType Interactive -RunLevel Limited

Register-ScheduledTask -TaskName "MsgToast" -Action $action -Trigger $trigger -Principal $principal -Force

# Iniciar la tarea de inmediato
Start-ScheduledTask -TaskName "MsgToast"

# Opcional: eliminar la tarea y el script después de ejecutarse
Start-Sleep -Seconds 10
Unregister-ScheduledTask -TaskName "MsgToast" -Confirm:$false
Remove-Item -Path $scriptPath -Force

