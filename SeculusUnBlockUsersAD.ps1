<#

Realiza el desbloqueo de todos los usuarios de la lista $grupos
Este script se debe ejecutar en una pc que tenga comuicacion con el domain controler.
El script hace algo como esto: 
	net user jojeda /domain /time:all
Este script deshace lo que hizo el script SeculusBlockUsersAD.ps1
#> 

# lista de grupos, horarios y usuarios. 
# TODO: Se debe modificar la lista de los usuarios de cada grupos
$grupos = @(
    @{
        Nombre    = 'Grupo1'
        Usuarios  = @('usuario1', 'usuario2', 'usuario3', 'usuario4')
    },
    @{
        Nombre    = 'Grupo2'
        Usuarios  = @('usuario11', 'usuario12', 'usuario13', 'usuario14')
    },
    @{
        Nombre    = 'Grupo3'
        Usuarios  = @('usuario21', 'usuario22', 'usuario23', 'usuario24')
    },
    @{
        Nombre    = 'Grupo4'
        Usuarios  = @()  # agregar usuarios
    },
    @{
        Nombre    = 'Grupo5'
        Usuarios  = @()  # agregar usuarios
    },
    @{
        Nombre    = 'Grupo6'
        Usuarios  = @()  # agregar usuarios
    },
    @{
        Nombre    = 'Grupo7'
        Usuarios  = @()  # agregar usuarios
    },
    @{
        Nombre    = 'Grupo8'
        Usuarios  = @()  # agregar usuarios
    },
    @{
        Nombre    = 'Grupo9'
        Usuarios  = @()  # agregar usuarios
    },
    @{
        Nombre    = 'Grupo10'
        Usuarios  = @()  # agregar usuarios
    },
    @{
        Nombre    = 'Grupo11'
        Usuarios  = @()  # agregar usuarios
    },
    @{
        Nombre    = 'Grupo12'
        Usuarios  = @()  # agregar usuarios
    }
)

# Recorre cada grupo para bloquear todos sus usuarios en el horario que le corresponde
foreach ($grupo in $grupos) {
	Write-Host "Grupo: $($grupo.Nombre)"

	# Bloquea cada usuario de ese grupo en el horario que le corresponde
	foreach($usuario in $grupo.Usuarios) {
		Write-Host "Se va a desbloquear el usuario: $usuario"
		net user $usuario /domain /time:all
	}
}
