# URL de descarga del archivo .crx de Selenium IDE
# $crxUrl = "https://clients2.google.com/service/update2/crx?response=redirect&prodversion=96.0&x=id%3Dmooikfkahbdckldjjndioackbalphokd%26installsource%3Dondemand%26uc"
$crxUrl = "https://github.com/JorgeOjedaF/install/raw/main/mooikfkahbdckldjjndioackbalphokd-3.17.2-Crx4Chrome.com.crx"

# Ruta donde se descargará el archivo
$downloadPath = "$env:TEMP\SeleniumIDE.crx"

# Descargar el archivo .crx
Invoke-WebRequest -Uri $crxUrl -OutFile $downloadPath

# Ruta de la carpeta de extensiones de Chrome (ajusta según la configuración del usuario)
$chromeExtensionPath = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Extensions"

# Crear una carpeta para la extensión
$extensionFolder = "$chromeExtensionPath\selenium-ide"
New-Item -ItemType Directory -Force -Path $extensionFolder

# Extraer el contenido del archivo .crx (necesitarás herramientas adicionales como 7zip o alguna librería .NET)
Expand-Archive -Path $downloadPath -DestinationPath $extensionFolder -Force

# Limpiar el archivo descargado
# Remove-Item $downloadPath

# Opcional: Abrir Chrome con la extensión activada
Start-Process "chrome.exe" --args "--load-extension=$extensionFolder"
