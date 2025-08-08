#requires -Version 7

# Source centralized logger
. "$PSScriptRoot/../lib-windows/log.ps1"

$configSrc = "$PSScriptRoot/../configs/doom-emacs/.doom.d"
$configDest = "$env:USERPROFILE\.doom.d"
$doomBin = "$env:USERPROFILE\.emacs.d\bin\doom"

# Remove existing config
if (Test-Path $configDest) {
    Log-Action 'REMOVING' "Config at '$configDest'"
    Remove-Item $configDest -Recurse -Force
}

# Copy new config
Log-Action 'COPYING' "'$configSrc' to '$configDest'"
Copy-Item $configSrc $configDest -Recurse -Force
if ($LASTEXITCODE -ne 0) {
    Log-Error 'Failed to copy config.'
    exit 1
}

# Sync Doom Emacs
Log-Action 'SYNCING' 'Doom Emacs packages'
& $doomBin sync
if ($LASTEXITCODE -ne 0) {
    Log-Error 'doom sync failed.'
    exit 1
}

Log-Action 'DONE' 'Doom Emacs config reloaded.'
