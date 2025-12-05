CD "C:\Program Files\ESET\ESET Security"
:: obtiene el status actual
ermm.exe get update-status
:: envia la orden de actualizar (debe estar habilitado rmm para que funcione)
ermm.exe start update
:: espera 5 segundos
timeout /t 5 /nobreak
:: obtiene el status actual nuevamente
ermm.exe get update-status
