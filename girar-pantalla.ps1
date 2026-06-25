Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class Display {

    [StructLayout(LayoutKind.Sequential, CharSet=CharSet.Ansi)]
    public struct DEVMODE {
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst=32)]
        public string dmDeviceName;
        public short dmSpecVersion;
        public short dmDriverVersion;
        public short dmSize;
        public short dmDriverExtra;
        public int dmFields;

        public int dmPositionX;
        public int dmPositionY;

        public int dmDisplayOrientation;
        public int dmDisplayFixedOutput;

        public short dmColor;
        public short dmDuplex;
        public short dmYResolution;
        public short dmTTOption;
        public short dmCollate;

        [MarshalAs(UnmanagedType.ByValTStr, SizeConst=32)]
        public string dmFormName;

        public short dmLogPixels;
        public int dmBitsPerPel;
        public int dmPelsWidth;
        public int dmPelsHeight;

        public int dmDisplayFlags;
        public int dmDisplayFrequency;

        public int dmICMMethod;
        public int dmICMIntent;
        public int dmMediaType;
        public int dmDitherType;
        public int dmReserved1;
        public int dmReserved2;

        public int dmPanningWidth;
        public int dmPanningHeight;
    }

    [DllImport("user32.dll")]
    public static extern int EnumDisplaySettings(string deviceName, int modeNum, ref DEVMODE devMode);

    [DllImport("user32.dll")]
    public static extern int ChangeDisplaySettingsEx(string lpszDeviceName, ref DEVMODE lpDevMode, IntPtr hwnd, int dwflags, IntPtr lParam);

    public const int ENUM_CURRENT_SETTINGS = -1;

    public const int DM_DISPLAYORIENTATION = 0x80;
    public const int CDS_UPDATEREGISTRY = 0x01;

    public const int DMDO_DEFAULT = 0;
    public const int DMDO_90 = 1;
    public const int DMDO_180 = 2;
    public const int DMDO_270 = 3;
}
"@

function Set-ScreenRotation {
    param(
        [ValidateSet(0,90,180,270)]
        [int]$Angle
    )

    $orientation = switch ($Angle) {
        0   { [Display]::DMDO_DEFAULT }
        90  { [Display]::DMDO_90 }
        180 { [Display]::DMDO_180 }
        270 { [Display]::DMDO_270 }
    }

    $dm = New-Object Display+DEVMODE
    $dm.dmSize = [System.Runtime.InteropServices.Marshal]::SizeOf($dm)

    [Display]::EnumDisplaySettings($null, [Display]::ENUM_CURRENT_SETTINGS, [ref]$dm)

    $dm.dmDisplayOrientation = $orientation
    $dm.dmFields = [Display]::DM_DISPLAYORIENTATION

    [Display]::ChangeDisplaySettingsEx($null, [ref]$dm, [IntPtr]::Zero, [Display]::CDS_UPDATEREGISTRY, [IntPtr]::Zero)
}

# Ejemplo:
Set-ScreenRotation -Angle 90
