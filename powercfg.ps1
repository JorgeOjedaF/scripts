# Creamos un nuevo plan de energía (basado en el plan "Alto rendimiento" el cual tiene la suspensión desactivada)
$newSchemeGuid = powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61

# Dejamos activo el nuevo plan
powercfg -setactive $newSchemeGuid
