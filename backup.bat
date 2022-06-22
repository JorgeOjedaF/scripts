@ECHO OFF
REM 
REM Copiamos el archivo win.ini a la carpeta de destino.
REM

xcopy "C:\Windows\win.ini" "\\vmware-host\Shared Folders\Jorge\Respaldo" /c /d /i /k /q /y
