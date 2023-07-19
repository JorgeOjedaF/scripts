# agregamos la ruta al PATH
$env:Path += ";C:\src\flutter\bin"
# se hace permanente el cambio 
[Environment]::SetEnvironmentVariable("Path", $env:Path, [System.EnvironmentVariableTarget]::Machine)
