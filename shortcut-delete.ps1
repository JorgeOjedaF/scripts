# borra el enlace del escritorio
# recibe 1 parametro con el nombre del archivo de enlace, por ejemplo: shortcut-delete.ps1 wikipedia
$Shell = New-Object -ComObject ("WScript.Shell")
$nombre = $args[0]
Remove-Item -Path "$env:Public\Desktop\$nombre.url"
