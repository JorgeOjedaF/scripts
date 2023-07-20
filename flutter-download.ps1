# creamos carpeta
mkdir C:\src;
# descargamos flutter comprimido
$url = "https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.10.6-stable.zip"
$output = "C:\src\flutter_windows_3.10.6-stable.zip"
(New-Object System.Net.WebClient).DownloadFile($url, $output)
# descomprimimos el zip
Expand-Archive -Path C:\src\flutter_windows_3.10.6-stable.zip -DestinationPath C:\src\
# agregamos la ruta al PATH
$env:Path += ";C:\src\flutter\bin"
# se hace permanente el cambio 
[Environment]::SetEnvironmentVariable("Path", $env:Path, [System.EnvironmentVariableTarget]::Machine)
