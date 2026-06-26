Write-Output "Inicio"

Write-Output "Args: $($args.Count)"

if ($args.Count -gt 0)
{
    Write-Output "Archivo: $($args[0])"

    if (Test-Path $args[0])
    {
        Write-Output "El archivo existe"

        $sig = Get-AuthenticodeSignature $args[0]

        Write-Output "Status: $($sig.Status)"

        if ($null -eq $sig.SignerCertificate)
        {
            Write-Output "SignerCertificate = NULL"
        }
        else
        {
            Write-Output "Subject: $($sig.SignerCertificate.Subject)"
            Write-Output "Serial: $($sig.SignerCertificate.SerialNumber)"
        }
    }
    else
    {
        Write-Output "El archivo NO existe"
    }
}
else
{
    Write-Output "No se recibieron argumentos"
}

Write-Output "Fin"
