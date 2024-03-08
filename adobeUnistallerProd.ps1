# descarga adobeUninstaller y lo ejecuta para desinstalar los productos indicados
# creamos carpeta
New-Item -Path "C:\adobeUninstaller" -ItemType Directory -Force
$url = "https://github.com/JorgeOjedaF/install/raw/main/AdobeUninstaller.exe"
$output = "C:\adobeUninstaller\AdobeUninstaller.exe"
(New-Object System.Net.WebClient).DownloadFile($url, $output)

if ($args.Count -gt 0) {
  #productos puede ser algo asi: PHSP#22.0,ILST#25.0
  #la linea de ejecucion queda asi --products=PHSP#22.0,ILST#25.0
  $productos = $args[0]
  Start-Process -FilePath "C:\adobeUninstaller\AdobeUninstaller.exe" -ArgumentList "--products=$productos" -WindowStyle Hidden
} else {
  # No hay argumentos, se desinstalan todos los productos
  #Start-Process -FilePath "C:\adobeUninstaller\AdobeUninstaller.exe" -ArgumentList "--all" -WindowStyle Hidden
}
