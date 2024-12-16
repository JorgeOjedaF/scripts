# Script para mostrar procesos en salida estándar
Get-Process | Select-Object Name, Id, CPU, StartTime | Format-Table -AutoSize
