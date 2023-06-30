#crea un usuario local como administrador. Recibe como parametros el usuario y contraseña, separados por un espacio
#New-LocalUser -AccountNeverExpires:$true -Password ( ConvertTo-SecureString -AsPlainText -Force 'Password123!') -Name 'nwcaluser' | Add-LocalGroupMember -Group administrators
New-LocalUser -AccountNeverExpires:$true -Password ( ConvertTo-SecureString -AsPlainText -Force $args[1]) -Name $args[0] | Add-LocalGroupMember -Group administrators
