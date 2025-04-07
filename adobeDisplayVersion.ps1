#Busca cualquier aplicacion que contenga Adobe y despliega su version
Get-ItemProperty HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object { $_.DisplayName -like "*Adobe*" } | Select-Object DisplayName, DisplayVersion
