@echo off
setlocal enabledelayedexpansion

set "regKey=HKEY_LOCAL_MACHINE\SOFTWARE\Classes\{359C24F1-51B5-44CE-8F2D-2FBB1A0FE4EA}\FWA_GUI_Agent"

:: Update Server value
for /f "tokens=2*" %%a in ('reg query "%regKey%" /v "Server" ^| find "Server"') do (
    set "oldValue=%%b"
    set "newValue=!oldValue:www2=www9!"
    reg add "%regKey%" /v "Server" /t REG_SZ /d "!newValue!" /f
)

:: Update PayloadInfo value
for /f "tokens=2*" %%a in ('reg query "%regKey%" /v "PayloadInfo" ^| find "PayloadInfo"') do (
    set "oldValue=%%b"
    set "newValue=!oldValue:www2=www9!"
    reg add "%regKey%" /v "PayloadInfo" /t REG_SZ /d "!newValue!" /f
)

echo Registry values updated successfully.
