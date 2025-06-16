#cambia la contraseña usuario local
$UserAccount = Get-LocalUser -Name $args[0]
$UserAccount | Set-LocalUser -Password ( ConvertTo-SecureString -AsPlainText -Force $args[1])
