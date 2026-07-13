$Path = "C:\ProgramData\StartLayout.json"

@'
{
  "pinnedList": []
}
'@ | Out-File $Path -Encoding utf8


$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer"

New-Item -Path $RegPath -Force | Out-Null

Set-ItemProperty `
    -Path $RegPath `
    -Name "ConfigureStartPins" `
    -Value $Path


Stop-Process -Name StartMenuExperienceHost -Force
