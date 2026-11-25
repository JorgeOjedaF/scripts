# Busca el log de error de una instalación fallida de un KB que recibe como parametro, por ejemplo KB5071959
$KB = $args[0]

$Events = Get-WinEvent -FilterHashtable @{
    LogName      = "System"
    ProviderName  = "Microsoft-Windows-WindowsUpdateClient"
    Id            = 20
} -MaxEvents 1000 -ErrorAction SilentlyContinue

$Events |
    Where-Object { $_.Message -match [regex]::Escape($KB) } |
    Select-Object TimeCreated,
                  Id,
                  LevelDisplayName,
                  Message |
    Format-List
