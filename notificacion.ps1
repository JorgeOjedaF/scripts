Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force;
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted;

Install-Module -Name BurntToast -RequiredVersion 0.8.5;

mkdir C:\logo\;
Invoke-WebRequest -Uri https://github.com/JorgeOjedaF/install/raw/main/faronics-logo.png -OutFile C:\logo\faronics-logo.png;
$ToastHeader = New-BTHeader -Id 1 -Title "Faronics";
New-BurntToastNotification -SnoozeAndDismiss -Header $ToastHeader -AppLogo C:\logo\faronics-logo.png -Text "Aviso de nuevo video", 'Vea este video de Faronics';
