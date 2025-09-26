Get-WinEvent -LogName Application | Where-Object {$_.ProviderName -Match 'Deep Freeze'} | select -first 1
