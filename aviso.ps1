$RegPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"

New-Item -Path $RegPath -Force | Out-Null

Set-ItemProperty -Path $RegPath -Name "legalnoticecaption" -Type String -Value "Aviso Importante de TI"
Set-ItemProperty -Path $RegPath -Name "legalnoticetext" -Type String -Value "Recuerde guardar su información en el drive para su respaldo."
