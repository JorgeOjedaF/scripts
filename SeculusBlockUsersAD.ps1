<#
Realiza el bloqueo de todos los usuarios de la lista $grupos en el horario del grupo al que pertenece.
Este script SE DEBE ejecutar en una pc que tenga comuicacion con el domain controler.
El script hace algo como esto: 
	net user jojeda /domain /time:M-F,06:00-17:00
Para desbloquear el usuario, se puede usar esta sintaxis: 
	net user jojeda /domain /Time:all

#> 

# lista de grupos, horarios y usuarios. 
# TODO: Se debe modificar la lista de los usuarios de cada grupos
$grupos = @(
    @{
        Nombre    = 'Grupo1'
        Horario   = 'M-F,06:00-17:00'
        Usuarios  = @('usuario1', 'usuario2', 'usuario3', 'usuario4')
    },
    @{
        Nombre    = 'Grupo2'
        Horario   = 'M-F,07:00-18:00'
        Usuarios  = @('usuario11', 'usuario12', 'usuario13', 'usuario14')
    },
    @{
        Nombre    = 'Grupo3'
        Horario   = 'M-F,07:00-13:00'
        Usuarios  = @('usuario21', 'usuario22', 'usuario23', 'usuario24')
    },
    @{
        Nombre    = 'Grupo4'
        Horario   = 'M-F,07:00-15:00'
        Usuarios  = @()  # agregar usuarios
    },
    @{
        Nombre    = 'Grupo5'
        Horario   = 'M-F,07:00-18:00'
        Usuarios  = @()  # agregar usuarios
    },
    @{
        Nombre    = 'Grupo6'
        Horario   = 'M-F,08:00-19:00'
        Usuarios  = @()  # agregar usuarios
    },
    @{
        Nombre    = 'Grupo7'
        Horario   = 'M-F,08:00-19:00'
        Usuarios  = @()  # agregar usuarios
    },
    @{
        Nombre    = 'Grupo8'
        Horario   = 'M-F,08:00-16:00'
        Usuarios  = @()  # agregar usuarios
    },
    @{
        Nombre    = 'Grupo9'
        Horario   = 'M-F,10:00-18:00'
        Usuarios  = @()  # agregar usuarios
    },
    @{
        Nombre    = 'Grupo10'
        Horario   = 'M-F,11:00-19:00'
        Usuarios  = @()  # agregar usuarios
    },
    @{
        Nombre    = 'Grupo11'
        Horario   = 'M-Sa,07:00-17:00'
        Usuarios  = @()  # agregar usuarios
    },
    @{
        Nombre    = 'Grupo12'
        Horario   = 'M-F,12:00-18:00'
        Usuarios  = @()  # agregar usuarios
    }
)

# Recorre cada grupo para bloquear todos sus usuarios en el horario que le corresponde
foreach ($grupo in $grupos) {
	Write-Host "Grupo: $($grupo.Nombre)"

	# Bloquea cada usuario de ese grupo en el horario que le corresponde
	foreach($usuario in $grupo.Usuarios) {
		if ($usuario -ne $null) {
			$horario = $grupo.Horario
			if ($horario -ne $null) {
				Write-Host "Se va a bloquear el usuario: $usuario en el horario: $horario."
				net user $usuario /domain /time:$horario
			} else {
				Write-Host "No se encontró un horario para el grupo $($grupo.Nombre)"
			}
		} else {
			Write-Host "No se encontraron usuarios en el grupo $($grupo.Nombre)"
		}
	}
}
