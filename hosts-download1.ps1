# descarga un archivo hosts (limpio) y reemplaza el existente
Invoke-WebRequest -Uri https://raw.githubusercontent.com/JorgeOjedaF/install/main/hosts -OutFile C:\Windows\System32\drivers\etc\hosts;
