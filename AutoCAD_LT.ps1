# CREA 2 carpetas
mkdir C:\DescargaAutoCad;
mkdir C:\CAD;

# descarga el archivo al computador en carpeta de descarga
Invoke-WebRequest -Uri https://raw.githubusercontent.com/JorgeOjedaF/install/main/AutoCAD_LT_2023_English_11mb.exe -OutFile C:\DescargaAutoCad\AutoCAD_LT_2023_English_11mb.exe;

# ejecuta archivo para descomprimir en la carpeta CAD
powershell -Command {C:\DescargaAutoCad\AutoCAD_LT_2023_English_11mb.exe -suppresslaunch -d "C:\CAD"}
