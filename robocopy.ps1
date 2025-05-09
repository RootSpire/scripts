# Dieses Script spiegelt die Daten von einem Quellverzeichnis in ein Zielverzeichnis.


$directories = @{
    "D:\ArchivZone" = "\\Servername\ArchivZone"
}


$timestamp = Get-Date -Format "yyyy-MM-dd-HH-mm-ss"
$logFile = ".\log_$timestamp.txt"


foreach ($source in $directories.Keys) {
    $target = $directories[$source]

    if (-not (Test-Path $source)) {
      $errorMessage = "Fehler: Quellverzeichnis '$source' existiert nicht."
      Write-Host $errorMessage
      Add-Content -Path $logFile -Value $errorMessage
      continue
    }

    robocopy $source $target /MIR /copyall /secfix /timfix /v /log:$logFile /ts /fp /tee
}


Write-Host "Skript wurde ausgeführt. Ergebnisse finden Sie in der $logFile."
Read-Host -Prompt "Drücken Sie die Eingabetaste, um die Sitzung zu schließen."