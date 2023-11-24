<#
Este script bloquea a usuarios locales para permitir que usen la computadora solo en el horario del grupo al que pertenecen

Se tienen 3 listas
Lista1: usuarios y su computadora, por ejemplo PC1=usuario1, PC2=usuario2, etc
Lista2: Usuarios de cada grupo, por ejemplo: Grupo1 = usuario01, usuario02,... Grupo2 = usuario11, usuario12, usuario13, usuario20, etc
Lista3: Horarios de cada grupo, por ejemplo Grupo1 = M-F, 07:00-17:00, Grupo2 = M-F, 07:00-17:00, etc

El script hace lo siguiente:
Recupera el nombre de la computadora donde se ejecuta el script
Con el nombre de la computadora, busca el usuario en la Lista 1
Con el usuario, busca su grupo en la Lista 2
Con el grupo, busca el horario en la Lista 3
Realiza el bloqueo del usuario en la PC en el horario definido.
El comando que se ejecuta es algo similar a esto: net user Usuario2 /time:M-F,06:00-17:00
#> 

# Lista 1: Usuarios y su computadora
$listaUsuarios = @{
    'DEMOLATAM-WIN-1' = 'Usuario2'
    'DEMOLATAM-WIN-2' = 'User'
}

# Lista 2: Usuarios de cada grupo
$grupoUsuarios = @{
	'Grupo1' = 'Usuario2', 'usuario02', 'usuario03', 'usuario10'
	'Grupo2' = 'usuario11', 'usuario12', 'usuario13', 'usuario20'
}

# Lista 3: Horarios de cada grupo
$horarios = @{
	'Grupo1'  = 'M-F,06:00-17:00'
	'Grupo2'  = 'M-F,07:00-18:00'
	'Grupo3'  = 'M-F,07:00-13:00'
	'Grupo4'  = 'M-F,07:00-15:00'
	'Grupo5'  = 'M-F,07:00-18:00'
	'Grupo6'  = 'M-F,08:00-19:00'
	'Grupo7'  = 'M-F,08:00-19:00'
	'Grupo8'  = 'M-F,08:00-16:00'
	'Grupo9'  = 'M-F,10:00-18:00'
	'Grupo10' = 'M-F,11:00-19:00'
	'Grupo11' = 'M-Sa,07:00-17:00'
	'Grupo12' = 'M-F,12:00-18:00'
}

# Recupera el nombre de la computadora
$nombreComputadora = $env:COMPUTERNAME
# Busca el usuario a bloquear en la Lista 1
$usuario = $listaUsuarios[$nombreComputadora]

if ($usuario -ne $null) {
    # Busca el grupo del usuario en la Lista 2
    $grupo = $grupoUsuarios.GetEnumerator() | Where-Object { $_.Value -contains $usuario } | Select-Object -ExpandProperty Key

    if ($grupo -ne $null) {

        # Busca el horario del grupo en la Lista 3
        $horario = $horarios[$grupo]

        if ($horario -ne $null) {
			# Realiza el bloqueo del usuario en el horario definido
			net user $usuario /time:$horario
			Write-Host "El usuario $usuario ha sido bloqueado en la PC $nombreComputadora durante el horario $horario."
        } else {
            Write-Host "No se encontró un horario para el grupo $grupo."
        }
    } else {
        Write-Host "No se encontró un grupo para el usuario $usuario."
    }
} else {
    Write-Host "No se encontró un usuario para la PC $nombreComputadora."
}
