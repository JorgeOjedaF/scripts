$log = "C:\Test\args.txt"

"Fecha: $(Get-Date)" | Out-File $log -Append
"Cantidad de argumentos: $($args.Count)" | Out-File $log -Append

for ($i = 0; $i -lt $args.Count; $i++) {
    "Arg[$i] = <$($args[$i])>" | Out-File $log -Append
}

"----------------------------------------" | Out-File $log -Append
