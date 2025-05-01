:: limpia el cache y gatilla una actualizacion de Windows Defender
:: https://www.microsoft.com/en-us/wdsi/defenderupdates

cd %ProgramFiles%\Windows Defender
MpCmdRun.exe -removedefinitions -dynamicsignatures
MpCmdRun.exe -SignatureUpdate

