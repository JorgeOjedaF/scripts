Write-Output "Inicio del script"
Write-Output "Archivo: $($args[0])"
Write-Output (Get-AuthenticodeSignature "$args[0]").SignerCertificate.SerialNumber
