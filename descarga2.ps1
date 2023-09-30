# recibe como parametro la ruta a descarga por ejemplo: https://www.7-zip.org/a/7z2301-x64.exe
$url = $args[0]

# calcula el nombre del archivo (lo que viene despues del ultimo "/")
$arr = $url.Split("/")
$nombreArchivo = $arr[$arr.Length-1]
$output = $env:Public + "\Desktop\" + $nombreArchivo

# descarga el archivo y lo deja en el escritorio
(New-Object System.Net.WebClient).DownloadFile($url, $output)	
