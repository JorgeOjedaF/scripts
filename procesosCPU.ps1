# Muestra el porcentaje de uso de CPU de los procesos
Get-CimInstance Win32_PerfFormattedData_PerfProc_Process | 
    Select-Object Name, IDProcess, PercentProcessorTime | 
    Where-Object { $_.Name -notlike "_Total" } | 
    Format-Table -AutoSize
