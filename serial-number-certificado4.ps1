if ($args.Count -gt 0)
{
    $file = $args[0]

    Write-Output "Archivo: $file"

    if (Test-Path $file)
    {
        $sig = Get-AuthenticodeSignature $file
        $hash1 = Get-FileHash $file -Algorithm SHA1
        $hash = Get-FileHash $file -Algorithm SHA256

        Write-Output "Status: $($sig.Status)"

        if ($sig.SignerCertificate)
        {
            Write-Output "Subject: $($sig.SignerCertificate.Subject)"
            Write-Output "Serial: $($sig.SignerCertificate.SerialNumber)"
        }
        else
        {
            Write-Output "SignerCertificate = NULL"
        }

        Write-Output "SHA1: $($hash1.Hash)"
        Write-Output "SHA256: $($hash.Hash)"
    }
    else
    {
        Write-Output "El archivo NO existe"
    }
}
