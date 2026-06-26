Get-ChildItem "args[0]" | Get-AuthenticodeSignature | ` Select-Object -Property @{Name=’SignerSerialNumber’;Expression={($_.SignerCertificate.SerialNumber)}}
