#crea un usuario local como administrador. Recibe como parametros el usuario y contraseña, separados por un espacio
New-LocalUser -AccountNeverExpires:$true -Password ( ConvertTo-SecureString -AsPlainText -Force $args[1]) -Name $args[0] | Add-LocalGroupMember -SID S-1-5-32-544
