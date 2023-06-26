#create the folder if does not exist
If(!(test-path -PathType container "C:\FIEP"))
{
      New-Item -ItemType Directory -Path "C:\FIEP"
}
#download the cettificate to that folder
Invoke-WebRequest -Uri https://raw.githubusercontent.com/JorgeOjedaF/install/main/Certificado%20Rede%20Educacional%20-%20Fortinet.crt -OutFile C:\FIEP\CertFiep.crt;
#import the certificate into a certificate store
Import-Certificate -FilePath "C:\FIEP\CertFiep.crt" -CertStoreLocation Cert:\LocalMachine\Root
