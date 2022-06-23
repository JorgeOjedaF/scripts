@ECHO OFF
REM 
REM Copiamos el archivo win.ini a la carpeta de destino.
REM

REM Check for the existance of the log file, if it does not exist create it. 
IF NOT EXIST c:\test.txt ECHO %date% %time% - Se crea el archivo > c:\test.txt
ECHO %date% %time% - Se ejecuta el script >> c:\test.txt
xcopy C:\Windows\win.ini C:\Respaldo\win.ini* /c /d /i /k /q /y >> c:\test.txt
