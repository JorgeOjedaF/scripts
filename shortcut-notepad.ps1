#crea un enlace lnk en el escritorio a la aplicacion notepad.exe
$TargetPath = "$env:SystemRoot\System32\notepad.exe"
$ShortcutFile = "$env:Public\Desktop\Notepad.lnk"
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($ShortcutFile)
$Shortcut.TargetPath = $TargetPath
$Shortcut.Save()
