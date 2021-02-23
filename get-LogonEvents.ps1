<#
.Synopsis
   Frägt SecurityEvents ab
.DESCRIPTION
   Dieses Skript kann verwendet werden um Anmelde bezogene Events aus dem Eventlog abzufragen
.PARAMETER EventId
   Mögliche Werte:
   4624 Anmeldung
   4625 fehlgeschlagene Anmeldung
   4634 Abmeldung
.EXAMPLE
   Get-LogonEvents.ps1 -EventId 4624

    Index Time          EntryType   Source                 InstanceID Message
 ----- ----          ---------   ------                 ---------- -------
 17881 Feb 23 13:48  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
 17879 Feb 23 13:48  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
 17877 Feb 23 13:47  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
 17874 Feb 23 13:47  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
 17871 Feb 23 13:47  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
 17868 Feb 23 13:46  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
 17865 Feb 23 13:46  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
 17861 Feb 23 13:45  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
 17857 Feb 23 13:45  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
 17854 Feb 23 13:45  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....

 Mit diesem Parameter frägt das Skript das Anmdele Event (ID 4624) vom localhost vom Security log und gibt die akutellesten 10 aus

.EXAMPLE
   Ein weiteres Beispiel für die Verwendung dieses Cmdlets
#>
[cmdletBinding()]
param(
[ValidateScript({Test-NetConnection -ComputerName $PSItem -CommonTCPPort WinRM -InformationLevel Quiet})]
[string]$ComputerName = "localhost",

[Parameter(Mandatory=$true)]
[ValidateSet(4624,4625,4634)]
[int]$EventId,

[ValidateRange(5,10)]
[int]$Newest = 5
)

$Newest = 3

Write-Verbose -Message "Zeitpunkt vor Abfrage. Es wurde folgenden EventID verwendet: $EventId"

Get-EventLog -LogName Security -ComputerName $ComputerName | Where-Object EventID -eq $EventId | Select-Object -First $Newest

