$Shell = New-Object -ComObject ("WScript.Shell")
$Favorite = $Shell.CreateShortcut($env:Public + "\Desktop\faronics.url")
$Favorite.TargetPath = "https://www.faronics.com/es";
$Favorite.Save()