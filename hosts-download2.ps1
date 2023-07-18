# descarga un archivo hosts con sitios bloquedos y reemplaza el existente
Invoke-WebRequest -Uri https://raw.githubusercontent.com/JorgeOjedaF/install/main/hosts2 -OutFile C:\Windows\System32\drivers\etc\hosts;
