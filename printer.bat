@echo off
:: Instalar impresoras de red sin mostrar ventanas
rundll32 printui.dll,PrintUIEntry /in /q /n \\srvudlaprint01\kioscobn
rundll32 printui.dll,PrintUIEntry /in /q /n \\srvudlaprint01\kiosco_color
exit
