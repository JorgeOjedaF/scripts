# URL de descarga de la carpeta Selenium IDE de github de Jorge
$zipUrl = "https://raw.githubusercontent.com/JorgeOjedaF/install/main/SeleniumIDE_3.17.2_0.zip"

# Ruta donde se descargará el archivo zip
$zipPath = "$env:TEMP\SeleniumIDE.zip"

# Descargar el archivo
Invoke-WebRequest -Uri $zipUrl -OutFile $zipPath

# Ruta de la carpeta de extensiones de Chrome
$chromeExtensionPath = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Extensions"

# Crear una carpeta para la extensión
$extensionFolder = "$chromeExtensionPath\selenium-ide"
New-Item -ItemType Directory -Force -Path $extensionFolder

# Ruta a 7z.exe (asegúrate de que 7-Zip esté instalado y disponible)
$sevenZipPath = "C:\Program Files\7-Zip\7z.exe"

# Extraer el archivo .zip con 7-Zip
& $sevenZipPath x $zipPath -o$extensionFolder -y

# Limpiar los archivos temporales
Remove-Item $zipPath

# Ruta completa a Chrome
$chromePath = "C:\Program Files\Google\Chrome\Application\chrome.exe"

# Cargar la extensión en Google Chrome con la ruta completa
$quotedExtensionFolder = "`"$extensionFolder`""
Start-Process $chromePath -ArgumentList "--load-extension=$quotedExtensionFolder"

Write-Host "Selenium IDE ha sido instalada y cargada en Google Chrome."
