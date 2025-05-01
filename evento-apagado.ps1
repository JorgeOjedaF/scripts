#muestra los ultimos 5 eventos de apagado
Get-WinEvent -FilterHashtable @{
    LogName = 'System'
    ID = 1074
} | Sort-Object TimeCreated -Descending | Select-Object -First 5 | Format-List TimeCreated, Message
