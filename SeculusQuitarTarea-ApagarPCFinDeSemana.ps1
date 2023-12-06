$tarea = "ApagarPCLoginWeekend"
# Elimina la tarea si ya existia del Login
if(Get-ScheduledTask -TaskName $tarea -ErrorAction Ignore) { 
	Unregister-ScheduledTask -TaskName $tarea -Confirm:$false
} 

$Stn = "ApagarPCSabado"
# Elimina la tarea programada para los sabados a las 00:01
if(Get-ScheduledTask -TaskName $Stn -ErrorAction Ignore) { 
	Unregister-ScheduledTask -TaskName $Stn -Confirm:$false
}
