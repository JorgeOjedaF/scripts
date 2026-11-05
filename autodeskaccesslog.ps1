Get-ChildItem "$env:LOCALAPPDATA\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState\DiagOutputDir" |
Sort-Object LastWriteTime -Descending |
Select-Object -First 5 Name, LastWriteTime
