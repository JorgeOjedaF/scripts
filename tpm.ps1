if ((Get-Tpm).SpecVersion -match "2.0") {
    Write-Output "✅ Este equipo tiene TPM 2.0"
} else {
    Write-Output "❌ Este equipo NO tiene TPM 2.0"
}
