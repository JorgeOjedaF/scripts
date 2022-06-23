@ECHO OFF
REM 
REM Copiamos el archivo win.ini a la carpeta de destino.
REM

xcopy "C:\Windows\win.ini" "C:\Respaldo\win.ini*" /c /d /i /k /q /y >> c:\test.txt
