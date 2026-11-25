# Obtiene informacion de los parches de Windows (Title, ReleaseDate, InstallDate, Category, Status, ErrorCode, FailureReason)

$Session  = New-Object -ComObject Microsoft.Update.Session
$Searcher = $Session.CreateUpdateSearcher()

# Consultar historial una sola vez
$HistoryCount = $Searcher.GetTotalHistoryCount()
$History = $Searcher.QueryHistory(0, $HistoryCount)

# Buscar actualizaciones instaladas
$Installed = $Searcher.Search("IsInstalled=1").Updates

# Buscar actualizaciones aplicables que no están instaladas
$Pending = $Searcher.Search("IsInstalled=0 and IsHidden=0").Updates

# Crear indice del historial por UpdateID
$HistoryIndex = @{}

foreach ($Entry in $History) {
    if ($Entry.Operation -ne 1) { continue }

    $ID = $Entry.UpdateIdentity.UpdateID

    if (-not $HistoryIndex.ContainsKey($ID) -or
        $Entry.Date -gt $HistoryIndex[$ID].Date) {

        $HistoryIndex[$ID] = $Entry
    }
}

$Report = foreach ($Update in @($Installed) + @($Pending)) {

    $ID = $Update.Identity.UpdateID
    $IsInstalled = $Update.IsInstalled

    $InstallDate = $null
    $Status = ""
    $FailureReason = ""
    $ErrorCode = ""

    if ($IsInstalled) {

        $Status = "Instalado"

        if ($HistoryIndex.ContainsKey($ID)) {
            $Entry = $HistoryIndex[$ID]

            if ($Entry.ResultCode -eq 2 -or
                $Entry.ResultCode -eq 3) {
                $InstallDate = $Entry.Date
            }
        }
    }
    else {

        if ($HistoryIndex.ContainsKey($ID)) {

            $Entry = $HistoryIndex[$ID]

            if ($Entry.ResultCode -eq 4) {

                $Status = "Fallido"

                $HR = [int]$Entry.HResult
                $ErrorCode = "0x" + [BitConverter]::ToString(
                    [BitConverter]::GetBytes($HR)
                ).Replace("-", "")

                $Exception = [Runtime.InteropServices.Marshal]::GetExceptionForHR($HR)

                if ($Exception) {
                    $FailureReason = $Exception.Message
                }
            }
            else {
                $Status = "Pendiente de instalar"
            }
        }
        else {
            $Status = "Pendiente de instalar"
        }
    }

    $Categories = ($Update.Categories |
        ForEach-Object { $_.Name }) -join ", "

    [PSCustomObject]@{
        Title          = $Update.Title
        ReleaseDate    = $Update.LastDeploymentChangeTime
        InstallDate    = $InstallDate
        Category       = $Categories
        Status         = $Status
        ErrorCode      = $ErrorCode
        FailureReason  = $FailureReason
        UpdateID       = $ID
        RevisionNumber = $Update.Identity.RevisionNumber
    }
}

# Mostrar resultados
$Report |
    Select-Object Title, ReleaseDate, InstallDate, Category,
                 Status, ErrorCode, FailureReason | Format-List
