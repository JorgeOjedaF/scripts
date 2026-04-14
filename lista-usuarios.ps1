$admins = Get-LocalGroupMember -Group "Administrators" | Select-Object -ExpandProperty Name

Get-LocalUser | ForEach-Object {
    $user = $_.Name
    $full = "$env:COMPUTERNAME\$user"

    if ($admins -notcontains $full -and $admins -notcontains $user) {
        $user
    }
}
