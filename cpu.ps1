# Obtener el uso de CPU en porcentaje
$cpuUsage = (Get-Counter '\Processor(_Total)\% Processor Time').CounterSamples[0].CookedValue

# Redondear a 2 decimales
$cpuUsage = [math]::Round($cpuUsage, 2)

# Mostrar resultado
Write-Output "Uso actual de CPU: $cpuUsage%"

# Verificar si supera el 90%
if ($cpuUsage -gt 90) {
    Write-Output "ALERTA: Uso de CPU mayor al 90%."
} else {
    Write-Output "Uso de CPU dentro de los niveles normales."
}
