Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force;
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted;

Install-Module -Name BurntToast -RequiredVersion 0.8.5;

$heroimage = New-BTImage -Source 'https://github.com/JorgeOjedaF/install/raw/main/faronics-logo.png' -HeroImage
$Text1 = New-BTText -Content  "Mensaje de Deploy"
$Text2 = New-BTText -Content "Vea este video de Faronics. Por favor seleccione si desea Ver Video o Posponer."
$Button = New-BTButton -Content "Posponer" -snooze -id 'SnoozeTime'
$Button2 = New-BTButton -Content "Ver Video" -Arguments "ToastReboot:" -ActivationType Protocol
$5Min = New-BTSelectionBoxItem -Id 5 -Content '5 minutes'
$10Min = New-BTSelectionBoxItem -Id 10 -Content '10 minutes'
$1Hour = New-BTSelectionBoxItem -Id 60 -Content '1 hour'
$4Hour = New-BTSelectionBoxItem -Id 240 -Content '4 hours'
$1Day = New-BTSelectionBoxItem -Id 1440 -Content '1 day'
$Items = $5Min, $10Min, $1Hour, $4Hour, $1Day
$SelectionBox = New-BTInput -Id 'SnoozeTime' -DefaultSelectionBoxItemId 10 -Items $Items
$action = New-BTAction -Buttons $Button, $Button2 -inputs $SelectionBox
$Binding = New-BTBinding -Children $text1, $text2 -HeroImage $heroimage
$Visual = New-BTVisual -BindingGeneric $Binding
$Content = New-BTContent -Visual $Visual -Actions $action
Submit-BTNotification -Content $Content
