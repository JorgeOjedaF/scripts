$RegKeyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP"

$DesktopPath = "DesktopImagePath"
$DesktopStatus = "DesktopImageStatus"
$DesktopUrl = "DesktopImageUrl"

$StatusValue = "1"

$url = "https://raw.githubusercontent.com/JorgeOjedaF/install/main/MerryChristmas-1920.jpg"
$DesktopImageValue = "C:\Fondo\MerryChristmas-1920.jpg"
$directory = "C:\Fondo\"

New-Item -Path $directory -ItemType directory -Force

$wc = New-Object System.Net.WebClient
$wc.DownloadFile($url, $DesktopImageValue)

if (!(Test-Path $RegKeyPath))
{
Write-Host "Creating registry path $($RegKeyPath)."
New-Item -Path $RegKeyPath -Force | Out-Null
}

New-ItemProperty -Path $RegKeyPath -Name $DesktopStatus -Value $StatusValue -PropertyType DWORD -Force | Out-Null
New-ItemProperty -Path $RegKeyPath -Name $DesktopPath -Value $DesktopImageValue -PropertyType STRING -Force | Out-Null
New-ItemProperty -Path $RegKeyPath -Name $DesktopUrl -Value $DesktopImageValue -PropertyType STRING -Force | Out-Null

RUNDLL32.EXE USER32.DLL, UpdatePerUserSystemParameters 1, True
