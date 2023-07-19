mkdir C:\src;
Invoke-WebRequest -Uri https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.10.6-stable.zip -OutFile C:\src\flutter_windows_3.10.6-stable.zip;
Expand-Archive -Path C:\src\flutter_windows_3.10.6-stable.zip -DestinationPath C:\src\
