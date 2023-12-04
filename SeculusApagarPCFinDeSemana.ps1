# Este script apaga la computadora cuando el usuario se loguea un dia Sabado o Domingo
# Para eso, se crea una tarea programada llamada ApagarPCFinDeSemana que se ejecuta en cada Login.
# La tarea programada ejecutara el script Mensaje.ps1, que luego de mostrar el mensaje, ejecuta el script (sin ventana) ApagarPC.ps1, que apagara la PC despues de 1 minuto
# Para que tome efeco este script, debiera cerrarse la sesion del usuario.

# Crea una carpeta (oculta) donde se crean los script Mensaje y ApagarPC
$rutaCarpeta = "C:\Script5"
$rutaScript1 = "$rutaCarpeta\Mensaje.ps1"
$rutaScript2 = "$rutaCarpeta\ApagarPC.ps1"
$carpeta = New-Item -Path $rutaCarpeta -ItemType Directory -Force
$carpeta.Attributes = [System.IO.FileAttributes]::Hidden

# Crea el script1 Mensaje.ps1
$contenidoScript1 = @"
	# Mostrar mensaje al usuario
	Add-Type -AssemblyName System.Windows.Forms
	`$mensaje = "Esta computadora se apagara en 1 minuto porque esta prohibido su uso Sabado o Domingo"
	[System.Windows.Forms.MessageBox]::Show(`$mensaje, "Advertencia", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Exclamation)
	# Ejecutar el script de apagar la computadora
	Start-Process PowerShell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File C:\Script\ApagarPC.ps1" -WindowStyle Hidden
"@
$contenidoScript1 | Out-File -FilePath $rutaScript1 -Encoding UTF8

# Crea el script2 ApagarPC.ps1
$contenidoScript2 = @"
	# Obtiene la fecha actual
	`$fechaActual = Get-Date

	# Verifica si es fin de semana (sábado o domingo)
	if (`$fechaActual.DayOfWeek -eq 'Monday' -or `$fechaActual.DayOfWeek -eq 'Sunday') {
		# Programa el apagado de la computadora después de un x segundos, x ej 300 segundos = 5 minutos
		`$tiempoEspera = 60
		
		# Espera el tiempo especificado
		Start-Sleep -Seconds `$tiempoEspera

		# Apaga la computadora
		Stop-Computer -Force
	}
"@
$contenidoScript2 | Out-File -FilePath $rutaScript2 -Encoding UTF8

# Crea la accion, el trigger (iniciar sesion) y el nombre de la tarea
$accion = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-NoProfile -ExecutionPolicy Bypass -File $rutaScript1 -WindowStyle Hidden"
$trigger = New-ScheduledTaskTrigger -AtLogon
$tarea = "ApagarPCFinDeSemana"

# Crear la tarea programada
Register-ScheduledTask -Action $accion -Trigger $trigger -TaskName $tarea -Description "Muestra mensaje y apaga la PC si el usuario inicia sesion un fin de semana"
