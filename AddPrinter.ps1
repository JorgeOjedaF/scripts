# This command adds a printer with name mxdw2 to the local computer. The mxdw printer uses the Microsoft XPS Document Writer v4 driver and the portprompt: port.
# The portprompt: port prompts for a file name to save the XPS document when printing to the XPS printer
Add-Printer -Name "mxdw 2" -DriverName "Microsoft XPS Document Writer v4" -PortName "portprompt:"



# Another Example
# This command adds a printer by specifying the name of a print server and a shared printer on that server.
# Add-Printer -ConnectionName \\printServer\printerName

# Remove printer
# Remove-Printer -Name “mxdw 2”
