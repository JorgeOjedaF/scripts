# Verificar si Chrome está instalado en el sistema
$chromePath = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe').'(default)'
if ([string]::IsNullOrEmpty($chromePath)) {
    Write-Host "Google Chrome no está instalado en este sistema."
    exit
}

# Ruta al archivo de configuración de Chrome
$chromeConfigPath = "$($chromePath)\..\..\" + "User Data\Default\Preferences"

# Leer el archivo de configuración JSON
$chromeConfig = Get-Content -Path $chromeConfigPath | Out-String | ConvertFrom-Json

# Cambiar el buscador predeterminado (en este caso, a ecosia)
$chromeConfig['default_search_provider']['search_url'] = "https://www.ecosia.org/search?method=index&q={searchTerms}"

# Guardar los cambios en el archivo de configuración
$chromeConfig | ConvertTo-Json -Depth 100 | Set-Content -Path $chromeConfigPath

Write-Host "El buscador predeterminado de Google Chrome se ha cambiado a ecosia."
