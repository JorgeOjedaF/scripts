$policiesPath = "C:\Program Files\Mozilla Firefox\distribution"
if (!(Test-Path $policiesPath)) {
    New-Item -Path $policiesPath -ItemType Directory -Force
}

$policiesFile = Join-Path $policiesPath "policies.json"

$policiesContent = @"
{
  "policies": {
    "DisableTelemetry": true,
    "DisableFirefoxStudies": true,
    "Preferences": {
      "browser.privatebrowsing.autostart": true,
      "places.history.enabled": false,
      "browser.formfill.enable": false
    }
  }
}
"@

Set-Content -Path $policiesFile -Value $policiesContent -Encoding UTF8
