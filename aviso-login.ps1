# Este script muestra un mensaje antes de mostrar la ventana de login al usuario
# Espera recibir un parametro con el texto a mostrar, si no viene usa un texto por defecto
$Mensaje = if ($args.Count -gt 0) { $args[0] } else { "Recuerde guardar su informacion en el drive para su respaldo." }

$RegPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
New-Item -Path $RegPath -Force | Out-Null
Set-ItemProperty -Path $RegPath -Name "legalnoticecaption" -Type String -Value "Aviso Importante"
Set-ItemProperty -Path $RegPath -Name "legalnoticetext" -Type String -Value $Mensaje

# ahora cierra todas las sesiones
$sesiones = quser 2>$null | Select-Object -Skip 1
foreach ($linea in $sesiones) {
    if ($linea -match "Active") {
        $partes = $linea -split '\s+'
        $id = $partes[2]
        logoff $id
    }
}
