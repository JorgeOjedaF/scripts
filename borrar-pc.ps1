# Borra completamente una PC, incluso sobreescribe el espacio libre para prevenir recuperar datos
# Use esto solo en caso de computador perdido o robado
# usa el metodo doWipeProtected

$namespace = "root\cimv2\mdm\dmmap"

$instance = Get-CimInstance `
    -Namespace $namespace `
    -ClassName MDM_RemoteWipe `
    -Filter "ParentID='./Vendor/MSFT' and InstanceID='RemoteWipe'"

if (-not $instance) {
    throw "No se encontró la instancia MDM_RemoteWipe."
}

$session = New-CimSession

$params = New-Object Microsoft.Management.Infrastructure.CimMethodParametersCollection
$param = [Microsoft.Management.Infrastructure.CimMethodParameter]::Create(
    "param", "", "String", "In"
)
$params.Add($param)

try {
    $result = $session.InvokeMethod(
        $namespace,
        $instance,
        "doWipeProtectedMethod",
        $params
    )
    $result
}
finally {
    $session.Dispose()
}
