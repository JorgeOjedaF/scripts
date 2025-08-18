@ECHO OFF
IF NOT EXIST C:\FTS_OFFICE MKDIR C:\FTS_OFFICE
IF NOT EXIST C:\FTS_OFFICE\setup.exe powershell.exe -command "& {Invoke-WebRequest -Uri "https://faronicsinternational.s3.eu-west-2.amazonaws.com/OfficeSetupMerton.exe" -OutFile "c:\FTS_OFFICE\OfficeSetupMerton.exe"};"
IF NOT EXIST C:\FTS_OFFICE\configuration.xml powershell.exe -command "& {Invoke-WebRequest -Uri "https://raw.githubusercontent.com/JorgeOjedaF/install/refs/heads/main/OfficeConfigMerton.xml" -OutFile "c:\FTS_OFFICE\OfficeConfigMerton.xml"};"
C:\FTS_OFFICE\OfficeSetupMerton.exe /configure C:\FTS_OFFICE\OfficeConfigMerton.xml
