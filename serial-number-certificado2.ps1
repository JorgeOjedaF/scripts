Get-ChildItem "$args[0]" | Get-AuthenticodeSignature | Select-Object @{Name='SignerSerialNumber';Expression={$_.SignerCertificate.SerialNumber}}
