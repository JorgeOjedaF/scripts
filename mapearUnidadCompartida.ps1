# Mappea una carpeta compartida a una unidad "U"
New-PSDrive -Persist -Name "U" -PSProvider "FileSystem" -Root "\\vmware-host\Shared Folders\Jorge"
