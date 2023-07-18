# agrega un sitio web al archivo host para bloquerlo, por ejemplo tinder.com
Add-Content -Path $env:windir\System32\drivers\etc\hosts -Value "`n127.0.0.1 tinder.com" -Force
