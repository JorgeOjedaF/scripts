# URL de descarga del archivo .crx de Selenium IDE de github de Jorge
$crxUrl = "https://github.com/JorgeOjedaF/install/raw/main/mooikfkahbdckldjjndioackbalphokd-3.17.2-Crx4Chrome.com.crx"

# URL para descargar el archivo .crx de Selenium IDE
$crxUrl = "https://clients2.google.com/service/update2/crx?response=redirect&prodversion=96.0&x=id%3Dmooikfkahbdckldjjndioackbalphokd%26installsource%3Dondemand%26uc"

# Ruta donde se descargará el archivo .crx
$downloadPath = "$env:TEMP\SeleniumIDE.crx"
$zipPath = "$env:TEMP\SeleniumIDE.zip"

# Descargar el archivo .crx
Invoke-WebRequest -Uri $crxUrl -OutFile $downloadPath

# Abrir el archivo en modo binario
$fs = [System.IO.File]::OpenRead($downloadPath)

# Crear un nuevo archivo .zip (sin los primeros 16 bytes)
$fsOut = [System.IO.File]::Create($zipPath)
$fs.Seek(16, [System.IO.SeekOrigin]::Begin) | Out-Null  # Saltar los primeros 16 bytes

# Copiar el resto del archivo .crx al nuevo archivo .zip
$buffer = New-Object byte[] 4096
$bytesRead = 0
do {
    $bytesRead = $fs.Read($buffer, 0, $buffer.Length)
    if ($bytesRead -gt 0) {
        $fsOut.Write($buffer, 0, $bytesRead)
    }
} while ($bytesRead -gt 0)

# Cerrar los archivos
$fs.Close()
$fsOut.Close()

# Ruta de la carpeta de extensiones donde se extraerá el contenido
$extensionFolder = "$env:TEMP\SeleniumIDE"

# Crear la carpeta de destino para la extensión
New-Item -ItemType Directory -Force -Path $extensionFolder

# Ruta a 7z.exe (asegúrate de que 7-Zip esté instalado y disponible)
$sevenZipPath = "C:\Program Files\7-Zip\7z.exe"

# Extraer el archivo .zip con 7-Zip
& $sevenZipPath x $zipPath -o$extensionFolder -y

# Limpiar los archivos temporales
Remove-Item $zipPath

# Ruta completa a Chrome
$chromePath = "C:\Program Files\Google\Chrome\Application\chrome.exe"  # Cambia esta ruta si Chrome está en otro lugar

# Cargar la extensión en Google Chrome con la ruta completa
$quotedExtensionFolder = "`"$extensionFolder`""
Start-Process $chromePath -ArgumentList "--load-extension=$quotedExtensionFolder"

Write-Host "Selenium IDE ha sido instalada y cargada en Google Chrome."
