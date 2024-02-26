# Define Wi-Fi profile parameters
$ProfileName = "LinkTest"
$SSID = "YourWiFiSSID"
$Password = "YourWiFiPassword"

# Create Wi-Fi profile XML
$XmlTemplate = @"
<?xml version="1.0"?>
<WLANProfile xmlns="http://www.microsoft.com/networking/WLAN/profile/v1">
    <name>$ProfileName</name>
    <SSIDConfig>
        <SSID>
            <name>$SSID</name>
        </SSID>
    </SSIDConfig>
    <connectionType>ESS</connectionType>
    <connectionMode>auto</connectionMode>
    <MSM>
        <security>
            <authEncryption>
                <authentication>WPA2PSK</authentication>
                <encryption>AES</encryption>
                <useOneX>false</useOneX>
            </authEncryption>
            <sharedKey>
                <keyType>passPhrase</keyType>
                <protected>false</protected>
                <keyMaterial>$Password</keyMaterial>
            </sharedKey>
        </security>
    </MSM>
</WLANProfile>
"@

# Export Wi-Fi profile XML to a temporary file
$XmlFilePath = Join-Path -Path $env:TEMP -ChildPath "$ProfileName.xml"
$XmlTemplate | Out-File -FilePath $XmlFilePath -Encoding ASCII

# Add the Wi-Fi profile
netsh wlan add profile filename="$XmlFilePath"

# Set the Wi-Fi profile to automatically connect
netsh wlan set profileparameter name="$ProfileName" connectionmode=auto

# Remove the temporary XML file
Remove-Item -Path $XmlFilePath
