# Centralized logging functions for Windows PowerShell scripts
# Usage: . "$PSScriptRoot/log.ps1" in your scripts

function Log-Action {
    param(
        [string]$Action,
        [string]$Message
    )
    Write-Host ("$Action`:: $Message")
}

function Log-Error {
    param(
        [string]$Message
    )
    Write-Host ("ERROR :: $Message") -ForegroundColor Red
}

function Log-Success {
    param(
        [string]$Action,
        [string]$Message
    )
    Write-Host ("$Action`:: SUCCESS $Message") -ForegroundColor Green
}

function Log-Warning {
    param(
        [string]$Message
    )
    Write-Host ("WARNING :: $Message") -ForegroundColor Yellow
}
