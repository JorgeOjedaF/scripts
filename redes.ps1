Get-NetAdapter |
    Where-Object Status -eq 'Up' |
    Select-Object Name, InterfaceDescription, Status, LinkSpeed
