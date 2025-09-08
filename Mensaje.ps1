# msg solo funciona en windows 10
# msg.exe * $args[0]

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.MessageBox]::Show($args[0])

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.MessageBox]::Show(
    $args[0],
    "Mensaje desde Faronics Cloud",
    [System.Windows.Forms.MessageBoxButtons]::OK,
    [System.Windows.Forms.MessageBoxIcon]::Information,
    [System.Windows.Forms.MessageBoxDefaultButton]::Button1,
    [System.Windows.Forms.MessageBoxOptions]::ServiceNotification
)
