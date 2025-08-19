$cpuUsage = Get-CimInstance Win32_Processor | Measure-Object -Property LoadPercentage -Average | Select-Object -ExpandProperty Average
Write-Output "Uso actual de CPU: $cpuUsage%"

if ($cpuUsage -gt 90) {
    Write-Output "ALERTA: Uso de CPU mayor al 90%."
} else {
    Write-Output "Uso de CPU dentro de los niveles normales."
}
