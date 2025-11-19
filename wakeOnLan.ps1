param(
    [Parameter(Mandatory = $true)]
    [string]$mac,
    [string]$broadcast = "255.255.255.255",
    [int]$port = 9
)

# Convertir MAC en bytes
$macBytes = $mac.Split(":","-") | ForEach-Object { [Convert]::ToByte($_,16) }

# Crear Magic Packet
$packet = [byte[]](,0xFF * 6 + ($macBytes * 16))

# Enviar por UDP
$client = New-Object System.Net.Sockets.UdpClient
$client.Connect($broadcast, $port)
$client.Send($packet, $packet.Length)
$client.Close()

Write-Host "Magic Packet enviado a $mac por $broadcast:$port"
