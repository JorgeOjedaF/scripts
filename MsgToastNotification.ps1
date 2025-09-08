# instalamos el modulo BurntToast confiando en el repositorio
Install-Module -Name BurntToast -Force -Scope CurrentUser
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted -ErrorAction SilentlyContinue

# Mensaje
New-BurntToastNotification -Text $args[0]
