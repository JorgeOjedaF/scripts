$adminGroup = Get-LocalGroup | Where-Object { $_.SID -eq "S-1-5-32-544" }
$admins = Get-LocalGroupMember -Group $adminGroup.Name | Select-Object -ExpandProperty Name

Get-LocalUser | ForEach-Object {
    $user = $_.Name
    $full = "$env:COMPUTERNAME\$user"

    if ($admins -notcontains $full -and $admins -notcontains $user) {
        $user
    }
}
