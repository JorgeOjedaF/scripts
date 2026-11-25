# Inventario Windows update

$Session  = New-Object -ComObject Microsoft.Update.Session
$Searcher = $Session.CreateUpdateSearcher()

# 1. Obtener historial completo
$HistoryCount = $Searcher.GetTotalHistoryCount()
$History = $Searcher.QueryHistory(0, $HistoryCount)

# 2. Consultar actualizaciones instaladas
$Installed = $Searcher.Search("IsInstalled=1").Updates

# 3. Consultar actualizaciones pendientes
$Pending = $Searcher.Search("IsInstalled=0 and IsHidden=0").Updates

# 4. Crear indice de actualizaciones actuales
$CurrentUpdates = @{}

foreach ($Update in @($Installed) + @($Pending)) {

    $ID = $Update.Identity.UpdateID
    $Revision = $Update.Identity.RevisionNumber
    $Key = "$ID|$Revision"

    $CurrentUpdates[$Key] = $Update
}

# 5. Agrupar historial por UpdateID y RevisionNumber
$HistoryGroups = $History | Group-Object {
    "$($_.UpdateIdentity.UpdateID)|$($_.UpdateIdentity.RevisionNumber)"
}

$Report = @()
$Seen = @{}

foreach ($Group in $HistoryGroups) {

    $Entries = @($Group.Group)

    $FirstEntry = $Entries[0]
    $ID = $FirstEntry.UpdateIdentity.UpdateID
    $Revision = $FirstEntry.UpdateIdentity.RevisionNumber
    $Key = "$ID|$Revision"

    $Seen[$Key] = $true

    # Obtener metadata actual
    $Update = $CurrentUpdates[$Key]

    $Title = $FirstEntry.Title
    $ReleaseDate = $null
    $Category = "No disponible"
    $CurrentStatus = "No disponible"

    if ($Update) {

        $Title = $Update.Title
        $ReleaseDate = $Update.LastDeploymentChangeTime

        $Category = ($Update.Categories |
            ForEach-Object { $_.Name }) -join ", "

        if ($Update.IsInstalled) {
            $CurrentStatus = "Instalado"
        }
        else {
            $CurrentStatus = "Pendiente de instalar"
        }
    }

    # Ordenar operaciones de instalacion
    $InstallEvents = @(
        $Entries |
        Where-Object { $_.Operation -eq 1 } |
        Sort-Object Date -Descending
    )

    # Ultimo intento de instalacion
    $LastAttempt = $InstallEvents | Select-Object -First 1

    # Ultima instalacion exitosa
    $SuccessfulInstall = $InstallEvents |
        Where-Object { $_.ResultCode -eq 2 -or $_.ResultCode -eq 3 } |
        Select-Object -First 1

    # Ultimo intento fallido
    $LastFailure = $InstallEvents |
        Where-Object { $_.ResultCode -eq 4 } |
        Select-Object -First 1

    # Contar intentos
    $Attempts = $InstallEvents.Count
    $Failures = @(
        $InstallEvents | Where-Object { $_.ResultCode -eq 4 }
    ).Count

    # Estado general
    if ($CurrentStatus -eq "Instalado") {

        $Status = "Instalado"

    }
    elseif ($LastAttempt -and $LastAttempt.ResultCode -eq 4) {

        $Status = "Fallido"

    }
    elseif ($CurrentStatus -eq "Pendiente de instalar") {

        $Status = "Pendiente de instalar"

    }
    elseif ($LastFailure) {

        $Status = "Fallido - No aparece como aplicable actualmente"

    }
    else {

        $Status = "Sin estado actual"
    }

    # Obtener codigo de error
    $ErrorCode = ""
    $FailureReason = ""

    if ($LastFailure) {

        $HR = [int]$LastFailure.HResult

        $UnsignedHR = [BitConverter]::ToUInt32(
            [BitConverter]::GetBytes($HR), 0
        )

        $ErrorCode = "0x{0:X8}" -f $UnsignedHR

        $Exception = [Runtime.InteropServices.Marshal]::GetExceptionForHR($HR)

        if ($Exception) {
            $FailureReason = $Exception.Message
        }
    }

    # Extraer numero KB
    $KB = ""

    if ($Title -match "KB\d+") {
        $KB = $Matches[0]
    }

    # Agregar registro
    $Report += [PSCustomObject]@{

        Title          = $Title
        KB             = $KB
        ReleaseDate    = $ReleaseDate
        InstallDate    = if ($SuccessfulInstall) {
                             $SuccessfulInstall.Date
                         } else { $null }

        LastAttempt    = if ($LastAttempt) {
                             $LastAttempt.Date
                         } else { $null }

        Category       = $Category
        Status         = $Status
        CurrentStatus  = $CurrentStatus

        LastResult     = if ($LastAttempt) {
                             $LastAttempt.ResultCode
                         } else { $null }

        Attempts       = $Attempts
        Failures       = $Failures
        ErrorCode      = $ErrorCode
        FailureReason  = $FailureReason

        UpdateID       = $ID
        RevisionNumber = $Revision
    }
}

# 6. Agregar actualizaciones actuales sin historial
foreach ($Update in @($Installed) + @($Pending)) {

    $ID = $Update.Identity.UpdateID
    $Revision = $Update.Identity.RevisionNumber
    $Key = "$ID|$Revision"

    if (-not $Seen.ContainsKey($Key)) {

        $Category = ($Update.Categories |
            ForEach-Object { $_.Name }) -join ", "

        $Status = if ($Update.IsInstalled) {
            "Instalado"
        }
        else {
            "Pendiente de instalar"
        }

        $KB = ""
        if ($Update.Title -match "KB\d+") {
            $KB = $Matches[0]
        }

        $Report += [PSCustomObject]@{

            Title          = $Update.Title
            KB             = $KB
            ReleaseDate    = $Update.LastDeploymentChangeTime
            InstallDate    = $null
            LastAttempt    = $null
            Category       = $Category
            Status         = $Status
            CurrentStatus  = $Status
            LastResult     = $null
            Attempts       = 0
            Failures       = 0
            ErrorCode      = ""
            FailureReason  = ""
            UpdateID       = $ID
            RevisionNumber = $Revision
        }
    }
}

# 7. Mostrar resumen
Write-Host "`n====================================="
Write-Host " WINDOWS UPDATE - RESUMEN"
Write-Host "====================================="

Write-Host "Registros historicos: $HistoryCount"
Write-Host "Actualizaciones instaladas: $($Installed.Count)"
Write-Host "Actualizaciones pendientes: $($Pending.Count)"
Write-Host "Registros del reporte: $($Report.Count)"

Write-Host "`nESTADOS:"

$Report | Group-Object Status |
    Select-Object Name, Count |
    Format-Table -AutoSize

# 8. Mostrar reporte
$Report |
    Sort-Object Title |
    Format-Table KB, Status, InstallDate, Category -AutoSize

# 9. Exportar CSV
$CSV = "$env:USERPROFILE\Desktop\WindowsUpdate_reporte.csv"

$Report |
    Sort-Object Title |
    Export-Csv -Path $CSV -NoTypeInformation -Encoding UTF8

Write-Host "`nReporte generado:"
Write-Host $CSV
