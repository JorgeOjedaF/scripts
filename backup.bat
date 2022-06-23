@ECHO OFF

REM Ejemplo de script para hacer resplados.
REM Solo copio un archivo, pero este script se puede modificar para respaldar carpetas

REM Se crea un log
ECHO %date% %time% - Inicio script >> C:\respaldo.log

REM Si no existe se crea carpeta
IF NOT EXIST C:\CARPETA_RESPALDO\NUL MKDIR C:\CARPETA_RESPALDO\

REM Se respalda
xcopy C:\Windows\win.ini C:\CARPETA_RESPALDO\win.ini* /c /i /k /q /y >> C:\respaldo.log

REM Fin
ECHO %date% %time% - Fin script >> C:\respaldo.log
