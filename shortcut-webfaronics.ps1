# crea un enlace en el escritorio al sitio de faronics, para todos los usuarios
$Shell = New-Object -ComObject ("WScript.Shell")
$Favorite = $Shell.CreateShortcut($env:Public + "\Desktop\faronics.url")
$Favorite.TargetPath = "https://www.faronics.com/es";
$Favorite.Save()
