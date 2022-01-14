New-Item -Path "c:\" -Name "CAD" -ItemType "directory"
powershell -Command {C:\Users\User\Downloads\AutoCAD_2021_English_Win_64bit_dlm.sfx.exe -suppresslaunch -d "C:\CAD"}
Start-Sleep -s 240
powershell -Command {C:\CAD\AutoCAD_2021_English_Win_64bit_dlm\Setup.exe /W /Q /I .\setup.ini}
