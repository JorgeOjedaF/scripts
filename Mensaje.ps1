# msg solo funciona en windows 10
# msg.exe * $args[0]

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.MessageBox]::Show($args[0])
