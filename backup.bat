@ECHO OFF

REM EJEMPLO DE SCRIPT DE RESPLADOS:
REM 1) Se crea un archivo de log con la hora
REM 2) Se crea carpeta de destino si no existe (El destino debiera ser un servidor de archivos, en este ejemplo se deja en la misma maquina)
REM 3) Se hace el respaldo y se guarda el resultado en el archivo de log. Se puede agregar el argumento /d para que solo copie si hay cambios
REM 4) Se escribe la hora en el archivo de log

ECHO %date% %time% - Inicio >> C:\respaldo.log
IF NOT EXIST C:\CARPETA_RESPALDO\NUL MKDIR C:\CARPETA_RESPALDO\
xcopy C:\Windows\system32\drivers\etc C:\CARPETA_RESPALDO\* /c /e /h /i /k /q /r /s /x /y >> C:\respaldo.log
ECHO %date% %time% - Fin >> C:\respaldo.log
