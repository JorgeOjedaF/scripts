# Instala una app desde MS Store usando winget. 
# Parametros: Recibe el id de la app de MS Store. Se puede encontrar el id de una app con el comando winget search "NombreApp"
winget install --id $args[0] --source msstore --silent --accept-package-agreements --accept-source-agreements
