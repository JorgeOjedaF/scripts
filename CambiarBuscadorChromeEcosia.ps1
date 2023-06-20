# Define the registry key path
$regKeyPath = "HKCU:\Software\Policies\Google\Chrome"

# Check if the registry key exists, create it if necessary
if (-not (Test-Path $regKeyPath)) {
    New-Item -Path $regKeyPath -Force | Out-Null
}

# Set the search engine preference
Set-ItemProperty -Path $regKeyPath -Name "DefaultSearchProviderEnabled" -Value 1
Set-ItemProperty -Path $regKeyPath -Name "DefaultSearchProviderSearchURL" -Value "https://www.ecosia.org/search?method=index&q={searchTerms}"
Set-ItemProperty -Path $regKeyPath -Name "DefaultSearchProviderName" -Value "Ecosia"

# Refresh Chrome policies
$refreshPolicyKeyPath = "HKLM:\SOFTWARE\Policies\Google\Chrome"
if (Test-Path $refreshPolicyKeyPath) {
    Remove-Item -Path $refreshPolicyKeyPath -Force | Out-Null
}
