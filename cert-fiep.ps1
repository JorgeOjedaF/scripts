If(!(test-path -PathType container "C:\FIEP"))
{
      New-Item -ItemType Directory -Path "C:\FIEP"
}
Invoke-WebRequest -Uri https://raw.githubusercontent.com/JorgeOjedaF/install/main/Certificado%20Rede%20Educacional%20-%20Fortinet.crt -OutFile C:\FIEP\CertFiep.crt;
Import-Certificate -FilePath "C:\FIEP\CertFiep.crt" -CertStoreLocation Cert:\LocalMachine\Root
