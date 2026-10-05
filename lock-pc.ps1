# LockWorkStation, equivalente a presionar Win + L.
Add-Type '[DllImport("user32.dll")] public static extern bool LockWorkStation();' -Name Win32 -Namespace Lock; [Lock.Win32]::LockWorkStation()
