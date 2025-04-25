# descarga el archivo en la carpeta temporal
$url = "https://javadl.oracle.com/webapps/download/AutoDL?BundleId=252044_8a1589aa0fe24566b4337beee47c2d29"
$output = $env:TEMP + "\jre-8u451-windows-x64.exe"
(New-Object System.Net.WebClient).DownloadFile($url, $output)

Start-Process -FilePath $output -ArgumentList "/s" -Wait
