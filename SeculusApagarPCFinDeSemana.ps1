# Este script crea una tarea programada que apagara la computadora cuando el usuario se loguea un dia Sabado o Domingo
# La tarea programada, llamada ApagarPCLoginWeekend, ejecuta el script1 Mensaje.ps1, el cual muestra el mensaje al usuario y luego, ejecuta el script ApagaPC.ps1, 
# El script ApagaPC.ps1 espera un minuto y luego apaga la PC
# La razon de usar 2 scripts es porque si fuera 1 solo script, el usuario podria detener la ejecución al cerrar la ventana de powershell.
# Observacion: 
# Caso de borde: Si el usuario no cierra la sesion el viernes, podria trabajar el dia sabado porque no ha iniciado sesion. 
# Para evitar eso, se agrega una segunda tarea programada ApagarPCSabado para que se ejecute cada sabado a las 00:01 horas

# Crea una carpeta (oculta) donde se crean los script Mensaje y ApagaPC
$rutaCarpeta = "C:\ScriptFaronics"
$rutaMensaje = "$rutaCarpeta\Mensaje.ps1"
$rutaApagaPC = "$rutaCarpeta\ApagaPC.ps1"
$carpeta = New-Item -Path $rutaCarpeta -ItemType Directory -Force
$carpeta.Attributes = [System.IO.FileAttributes]::Hidden

# Crea el script1 Mensaje.ps1
$contenidoScript1 = @"
	# Mostrar mensaje al usuario
	Add-Type -AssemblyName System.Windows.Forms
	`$mensaje = "Esta computadora se apagara en 1 minuto porque esta prohibido su uso Sabado o Domingo"
	[System.Windows.Forms.MessageBox]::Show(`$mensaje, "Advertencia", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Exclamation)
	# Ejecutar el script de apagar la computadora
	Start-Process PowerShell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File $rutaApagaPC" -WindowStyle Hidden
"@
$contenidoScript1 | Out-File -FilePath $rutaMensaje -Encoding UTF8

# Crea el script2 ApagaPC.ps1
$contenidoScript2 = @"
	# Obtiene la fecha actual
	`$fechaActual = Get-Date

	# Verifica si es fin de semana (sabado o domingo)
	if (`$fechaActual.DayOfWeek -eq 'Monday' -or `$fechaActual.DayOfWeek -eq 'Sunday') {
		# Programa el apagado de la computadora despues de un x segundos, x ej 300 segundos = 5 minutos
		`$tiempoEspera = 60
		
		# Espera el tiempo especificado
		Start-Sleep -Seconds `$tiempoEspera

		# Apaga la computadora
		Stop-Computer -Force
	}
"@
$contenidoScript2 | Out-File -FilePath $rutaApagaPC -Encoding UTF8

# Crea la accion, el trigger (iniciar sesion) y el nombre de la tarea
$accion = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-NoProfile -ExecutionPolicy Bypass -File $rutaMensaje -WindowStyle Hidden"
$trigger = New-ScheduledTaskTrigger -AtLogon
$tarea = "ApagarPCLoginWeekend"
$principal = New-ScheduledTaskPrincipal -UserID "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount -RunLevel Highest

# Crea la tarea programada para el Login
Register-ScheduledTask -Action $accion -Trigger $trigger -TaskName $tarea -Principal $principal -Description "Apaga la PC al iniciar sesion si es Sabado o Domingo"

# Crea la tarea programada para los sabados a las 00:01
$Stt = New-ScheduledTaskTrigger -Weekly -WeeksInterval 1 -DaysOfWeek Saturday -At 00:01
$Stn = "ApagarPCSabado"
Register-ScheduledTask  -Action $accion -Trigger $Stt -TaskName $Stn -Principal $principal -Description "Apaga la PC cada Sabado a las 00:01 horas"
