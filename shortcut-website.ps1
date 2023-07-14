# crea un enlace en el escritorio a un sitio web, para todos los usuarios
# recibe 2 parametros el nombre del enlace y el sitio web, por ejemplo shortcut-website.ps1 faronics https://www.faronics.com/es
$Shell = New-Object -ComObject ("WScript.Shell")
$nombre = $args[0]
$sitio = $args[1]
$Favorite = $Shell.CreateShortcut($env:Public + "\Desktop\" + $nombre +".url")
$Favorite.TargetPath = $sitio
$Favorite.Save()
