# Este script crea una tarea programada que apagara la computadora cuando el usuario se loguea un dia Sabado o Domingo
# La tarea programada, llamada ApagarPCLoginWeekend, ejecuta el script Apagado.ps1, el cual muestra el mensaje al usuario y luego apaga la PC
# Observacion: 
# Caso de borde: Si el usuario no cierra la sesion el viernes, podria trabajar el dia sabado porque no ha iniciado sesion. 
# Para evitar eso, se agrega una segunda tarea programada ApagarPCSabado para que se ejecute cada sabado a las 00:01 horas

# Crea una carpeta (oculta) donde se crean el script Mensaje
$rutaCarpeta = "C:\ScriptFaronics"
$rutaApagado = "$rutaCarpeta\Apagado.ps1"
$rutaLogs = "$rutaCarpeta\log.txt"
$carpeta = New-Item -Path $rutaCarpeta -ItemType Directory -Force
$carpeta.Attributes = [System.IO.FileAttributes]::Hidden

# Crea el script1 Apagado.ps1
$scriptApagado = @"
	"Apagado.ps1: `$(Get-Date)" >> $rutaLogs

	# Obtiene la fecha actual
	`$fechaActual = Get-Date

	# Verifica si es fin de semana (sabado o domingo)
	if (`$fechaActual.DayOfWeek -eq 'Saturday' -or `$fechaActual.DayOfWeek -eq 'Sunday') {
		# Mostrar mensaje al usuario
		msg.exe * /TIME:15 "Esta computadora se apagara en 1 minuto porque esta prohibido su uso Sabado o Domingo"

  		# Programa el apagado de la computadora despues de 60 segundos, x ej 300 segundos = 5 minutos
		Start-Sleep -Seconds 60

		# Apaga la computadora
		Stop-Computer -Force
	}

"@
$scriptApagado | Out-File -FilePath $rutaApagado -Encoding UTF8

# Crea la accion, el trigger (iniciar sesion) y el nombre de la tarea
$accion = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-NoProfile -ExecutionPolicy Bypass -File $rutaApagado"
$trigger = New-ScheduledTaskTrigger -AtLogon
$tarea = "ApagarPCLoginWeekend"
$principal = New-ScheduledTaskPrincipal -UserID "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount -RunLevel Highest

# Elimina la tarea si ya existia, para permitir ejecutar mas de una vez el script
if(Get-ScheduledTask -TaskName $tarea -ErrorAction Ignore) { 
	Unregister-ScheduledTask -TaskName $tarea -Confirm:$false
} 

# Crea la tarea programada para el Login
Register-ScheduledTask -Action $accion -Trigger $trigger -TaskName $tarea -Principal $principal -Description "Apaga la PC al iniciar sesion si es Sabado o Domingo"

# Crea la tarea programada para los sabados a las 00:01
$Stt = New-ScheduledTaskTrigger -Weekly -WeeksInterval 1 -DaysOfWeek Saturday -At 00:01
$Stn = "ApagarPCSabado"
# Elimina la tarea si ya existia, para permitir ejecutar mas de una vez el script
if(Get-ScheduledTask -TaskName $Stn -ErrorAction Ignore) { 
	Unregister-ScheduledTask -TaskName $Stn -Confirm:$false
} 
Register-ScheduledTask  -Action $accion -Trigger $Stt -TaskName $Stn -Principal $principal -Description "Apaga la PC cada Sabado a las 00:01 horas"
