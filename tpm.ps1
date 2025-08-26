$tpm = Get-CimInstance -Namespace "Root\CIMv2\Security\MicrosoftTpm" -ClassName Win32_Tpm

if ($tpm -and $tpm.SpecVersion -match "2.0") {
    Write-Output "✅ Este equipo tiene TPM 2.0"
} elseif ($tpm) {
    Write-Output "⚠️ TPM presente pero NO es 2.0 (Versión: $($tpm.SpecVersion))"
} else {
    Write-Output "❌ No se detecta TPM en este equipo"
}
