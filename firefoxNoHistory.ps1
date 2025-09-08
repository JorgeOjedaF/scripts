$paths = @(
    "C:\Program Files\Mozilla Firefox\distribution",
    "C:\Program Files (x86)\Mozilla Firefox\distribution"
)

foreach ($p in $paths) {
    if (Test-Path (Split-Path $p -Parent)) {
        if (!(Test-Path $p)) {
            New-Item -Path $p -ItemType Directory -Force | Out-Null
        }

        $policiesFile = Join-Path $p "policies.json"

        $policiesContent = @"
{
  "policies": {
    "DisableTelemetry": true,
    "DisableFirefoxStudies": true,
    "DisablePocket": true,
    "DisableFirefoxAccounts": true,
    "DisableFormHistory": true,
    "Preferences": {
      "browser.privatebrowsing.autostart": true
    }
  }
}
"@

        Set-Content -Path $policiesFile -Value $policiesContent -Encoding UTF8
        Write-Host "policies.json creado en $p"
    }
}
