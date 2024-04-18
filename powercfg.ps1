#  Creamos un nuevo plan de energía (basado en el plan de alto rendimiento el cual tiene la suspensión desactivada)
$newSchemeGuid = powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61

# Dejamos activo el nuevo plan
powercfg -setactive $newSchemeGuid.substring(19, 36)
# Se usa el substring para sacar el ID, porque el string es de la forma 
# "Power Scheme GUID: f24a93ef-f874-47a3-9dc9-6c23b5210854  (Ultimate Performance)"
