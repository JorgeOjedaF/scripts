#Retorna el valor de PayloadInfo en el registro de windows. Esto retorna el servidor DeepFreeze registrado
(Get-ItemProperty 'Registry::HKEY_CLASSES_ROOT\{359C24F1-51B5-44CE-8F2D-2FBB1A0FE4EA}\FWA_GUI_Agent').PayloadInfo
