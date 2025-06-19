$settings = @{
    servers = @(@{
        address = $args[0]
        port = 30304
    })
}

$settings | ConvertTo-Json -Depth 3 | Out-File "C:\ProgramData\ChaosGroup\Licensing\settings.json" -Encoding UTF8
