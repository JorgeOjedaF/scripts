#cambia la contraseña usuario local
$UserAccount = Get-LocalUser -Name "jorge"
$UserAccount | Set-LocalUser -Password ( ConvertTo-SecureString -AsPlainText -Force $args[0])
