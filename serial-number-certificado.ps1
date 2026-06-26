(Get-AuthenticodeSignature "$args[0]").SignerCertificate.SerialNumber | Out-String
