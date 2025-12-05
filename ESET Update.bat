CD "C:\Program Files\ESET\ESET Security"
:: obtiene el status actual
ermm.exe get update-status
:: envia la orden de actualizar (debe estar habilitado rmm para que funcione)
ermm.exe start update
:: hace un ping para esperar 5 segundos
ping 127.0.0.1 -n 5 >nul
:: obtiene el status actual nuevamente
ermm.exe get update-status
