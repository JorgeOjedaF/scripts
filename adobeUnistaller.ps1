# descarga adobeUninstaller y lo ejecuta para borrar todos los productos adobe
# creamos carpeta
New-Item -Path "C:\adobeUninstaller" -ItemType Directory -Force
$url = "https://github.com/JorgeOjedaF/install/raw/main/AdobeUninstaller.exe"
$output = "C:\adobeUninstaller\AdobeUninstaller.exe"
(New-Object System.Net.WebClient).DownloadFile($url, $output)
Start-Process -FilePath "C:\adobeUninstaller\AdobeUninstaller.exe" -ArgumentList "--all" -WindowStyle Hidden
