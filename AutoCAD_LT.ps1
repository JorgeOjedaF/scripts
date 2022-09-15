# CREA carpeta
mkdir C:\DescargaAutoCad;

# descarga el archivo al computador en carpeta de descarga
Invoke-WebRequest -Uri https://raw.githubusercontent.com/JorgeOjedaF/install/main/AutoCAD_LT_2023_English_11mb.exe -OutFile C:\DescargaAutoCad\AutoCAD_LT_2023_English_11mb.exe;

# CREA carpeta
mkdir C:\CAD2;

# ejecuta archivo para descomprimir en la carpeta CAD2
powershell -Command {C:\DescargaAutoCad\AutoCAD_LT_2023_English_11mb.exe -suppresslaunch -d "C:\CAD2"}
