@echo off
echo Instalando V-Ray para Revit... (asume que los instaladores ya estan en la PC)
vray_71000_revit_win_x64.exe --quiet --accept-license --gui=0

echo Instalando V-Ray para Rhino...
vray_71000_rhino_win_x64.exe --quiet --accept-license --gui=0

echo Instalando V-Ray para SketchUp...
vray_71000_sketchup_win.exe --quiet --accept-license --gui=0

echo Instalando V-Ray para 3ds Max...
vray_adv_71000_max2026_x64.exe --quiet --accept-license --gui=0

echo Instalación completada.
pause
