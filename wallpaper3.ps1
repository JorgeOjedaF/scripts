# Ruta de la imagen del fondo de pantalla
$imagenFondo = "C:\wallpaper\img3.jpg"

# Cargar el módulo necesario para cambiar el fondo de pantalla
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class Wallpaper {
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@

# Definir constantes para cambiar el fondo de pantalla
$SPI_SETDESKWALLPAPER = 0x0014
$SPIF_UPDATEINIFILE = 0x01
$SPIF_SENDCHANGE = 0x02

# Cambiar el fondo de pantalla
[Wallpaper]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $imagenFondo, $SPIF_UPDATEINIFILE -bor $SPIF_SENDCHANGE)

#reinicia la computadora
Restart-Computer -Force
