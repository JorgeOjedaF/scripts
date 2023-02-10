# Este script recibe un parametro que es el numero de KB (solo el numero sin el prefijo KB)
# Por ejemplo si el parametro es "890830", el comando que se ejecutaria en la pc seria:
# wusa /uninstall /kb:890830 /forcerestart

wusa /uninstall /kb:$args[0] /forcerestart
