# $domain = "google.com"
$domain = $args[0]
$tcp = [Net.Sockets.TcpClient]::new($domain, 443)
$ssl = [Net.Security.SslStream]::new($tcp.GetStream(), $false, ({ $true }))
$ssl.AuthenticateAsClient($domain)

$cert = [Security.Cryptography.X509Certificates.X509Certificate2]::new($ssl.RemoteCertificate)

$cert | Select-Object Subject, Issuer, NotBefore, NotAfter,
@{Name="DiasRestantes";Expression={($_.NotAfter - (Get-Date)).Days}}

$ssl.Dispose()
$tcp.Dispose()
