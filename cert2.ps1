mkdir C:\CERT2;
Invoke-WebRequest -Uri https://raw.githubusercontent.com/JorgeOjedaF/install/main/Fortinet_CA_SSL.cer -OutFile C:\CERT2\Fortinet_CA_SSL.cer;
Import-Certificate -FilePath "C:\CERT2\Fortinet_CA_SSL.cer" -CertStoreLocation Cert:\LocalMachine\Root
