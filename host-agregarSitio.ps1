Add-Content -Path $env:windir\System32\drivers\etc\hosts -Value "`n127.0.0.1`t$args[0]" -Force
