$Apps = @(
    "Microsoft.XboxApp",
    "Microsoft.XboxGamingOverlay"
)

foreach ($App in $Apps) {
    Get-AppxPackage -AllUsers -Name $App |
        Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue

    Get-AppxProvisionedPackage -Online |
        Where-Object DisplayName -eq $App |
        Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue
}
