# creamos carpeta
mkdir C:\src;
# descargamos flutter comprimido
$url = "https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.10.6-stable.zip"
$output = "C:\src\flutter_windows_3.10.6-stable.zip"
(New-Object System.Net.WebClient).DownloadFile($url, $output)
# descomprimimos el zip
Expand-Archive -Path C:\src\flutter_windows_3.10.6-stable.zip -DestinationPath C:\src\
# ejecutamos el bat para agregar al PATH
& C:\src\flutter_windows_3.10.6-stable\flutter\flutter_console.bat
