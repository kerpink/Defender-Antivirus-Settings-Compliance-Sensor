Defender Antivirus Settings Compliance
<#
.SYNOPSIS
Custom compliance script to report key Defender Antivirus settings in pipe-delimited format

.DESCRIPTION
This script checks several Defender Antivirus settings, compares them to expected values, and outputs their compliance status.

.OUTPUTS
Pipe-delimited string: Setting Name|Expected Value|Actual Value|Compliant|Compliance Status|Description|Source

.COMPONENT
Microsoft Intune
#>

# Retrieve Defender settings
$Status = Get-MpComputerStatus
$Prefs = Get-MpPreference
$Source = "PowerShell"

# Extract actual values
$TamperProtection = $Status.IsTamperProtected
$CloudProtection = $Prefs.MAPSReporting
$RealTimeProtection = $Status.RealTimeProtectionEnabled
$AntivirusEnabled = $Status.AntivirusEnabled
$CloudBlockLevel = $Prefs.CloudBlockLevel
$CloudExtendedTimeout = $Prefs.CloudExtendedTimeout
$NetworkProtection = $Prefs.EnableNetworkProtection -in 1,2

# Define compliance logic and expected values
$results = @()

function Add-Result {
    param (
        [string]$Name,
        [string]$Expected,
        [string]$Actual,
        [bool]$Compliant,
        [string]$Description
    )
    $Status = if ($Compliant) { "Compliant" } else { "Non-Compliant" }
    Write-Output "$Name|$Expected|$Actual|$Compliant|$Status|$Description|$Source"
}

Add-Result "Tamper Protection" "True" "$TamperProtection" ($TamperProtection -eq $true) "Prevents unauthorized changes to Defender"
Add-Result "Cloud Protection" "2" "$CloudProtection" ($CloudProtection -eq 2) "Advanced cloud protection"
Add-Result "Realtime Protection" "True" "$RealTimeProtection" ($RealTimeProtection -eq $true) "Real-time protection against threats"
Add-Result "Antivirus Enabled" "True" "$AntivirusEnabled" ($AntivirusEnabled -eq $true) "Antivirus protection is enabled"
Add-Result "Cloud Block Level" "≥2" "$CloudBlockLevel" ($CloudBlockLevel -ge 2) "High blocking level"
Add-Result "Cloud Block Extended Timeout" "50" "$CloudExtendedTimeout" ($CloudExtendedTimeout -le 50) "Acceptable timeout"
Add-Result "Network Protection" "True" "$($NetworkProtection)" ($NetworkProtection) "Network protection is enabled"
