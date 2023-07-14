'Crea un enlace en el escritorio al sitio faronics.com
Set objShell = WScript.CreateObject("WScript.Shell")
 
'All users Desktop
allUsersDesktop = objShell.SpecialFolders("AllUsersDesktop")
 
'The current users Desktop
usersDesktop = objShell.SpecialFolders("Desktop")
 
'Where to create the new shorcut
Set objShortCut = objShell.CreateShortcut(usersDesktop & "\faronics.url")
 
'What does the shortcut point to
objShortCut.TargetPath = "https://www.faronics.com/es"
 
'Create the shortcut
objShortCut.Save
