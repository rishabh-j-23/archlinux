#requires -Version 7

# Source centralized logger
. "$PSScriptRoot/../lib-windows/log.ps1"

# Helper: Check if a command exists
function Test-Command {
    param([string]$Command)
    $null -ne (Get-Command $Command -ErrorAction SilentlyContinue)
}

# Check for Git
if (-not (Test-Command git)) {
    Log-Error 'Git is not installed or not in PATH.'
    exit 1
}

# Check for Emacs, install if missing
$emacsRoot = "$env:USERPROFILE\emacs"
$emacsBin = "$emacsRoot\bin"
$emacsExe = "$emacsBin\emacs.exe"

if (-not (Test-Command emacs)) {
    Log-Action 'INSTALLING' 'Emacs not found. Downloading and installing Emacs...'
    $emacsZipUrl = 'https://ftp.gnu.org/gnu/emacs/windows/emacs-29/emacs-29.3_1-x86_64.zip'
    $emacsZip = "$env:TEMP\emacs-portable.zip"
    Invoke-WebRequest -Uri $emacsZipUrl -OutFile $emacsZip
    if ($LASTEXITCODE -ne 0 -or -not (Test-Path $emacsZip)) {
        Log-Error 'Failed to download Emacs portable zip.'
        exit 1
    }
    if (Test-Path $emacsRoot) {
        Log-Action 'REMOVING' "Old Emacs at '$emacsRoot'"
        Remove-Item $emacsRoot -Recurse -Force
    }
    Log-Action 'EXTRACTING' "Emacs to '$emacsRoot'"
    Expand-Archive -Path $emacsZip -DestinationPath $emacsRoot
    if ($LASTEXITCODE -ne 0 -or -not (Test-Path $emacsExe)) {
        Log-Error 'Failed to extract Emacs.'
        exit 1
    }
    # Add Emacs bin to PATH for current session
    $env:PATH = "$emacsBin;$env:PATH"
    Log-Action 'INSTALLING' 'Emacs installed and PATH updated for this session.'
}

# Check again for Emacs
if (-not (Test-Command emacs)) {
    Log-Error 'Emacs is not installed or not in PATH after attempted install.'
    exit 1
}

$doomDir = "$env:USERPROFILE\.emacs.d"
$configSrc = "$PSScriptRoot/../configs/doom-emacs/.doom.d"
$configDest = "$env:USERPROFILE\.doom.d"
$doomBin = "$doomDir\bin\doom"

# Clone Doom Emacs if not present
if (-not (Test-Path $doomDir)) {
    Log-Action 'INSTALLING' "Cloning Doom Emacs to '$doomDir'"
    git clone --depth 1 https://github.com/doomemacs/doomemacs $doomDir
    if ($LASTEXITCODE -ne 0) {
        Log-Error 'Failed to clone Doom Emacs.'
        exit 1
    }
}

# Copy config
if (Test-Path $configDest) {
    Log-Action 'REMOVING' "Config at '$configDest'"
    Remove-Item $configDest -Recurse -Force
}
Log-Action 'COPYING' "'$configSrc' to '$configDest'"
Copy-Item $configSrc $configDest -Recurse -Force
if ($LASTEXITCODE -ne 0) {
    Log-Error 'Failed to copy config.'
    exit 1
}

# Install Doom Emacs if not already installed
if (-not (Test-Path $doomBin)) {
    Log-Action 'INSTALLING' 'Running doom install'
    & $doomBin install --no-config
    if ($LASTEXITCODE -ne 0) {
        Log-Error 'doom install failed.'
        exit 1
    }
}

# Sync and upgrade Doom packages
Log-Action 'SYNCING' 'Doom Emacs packages'
& $doomBin sync
if ($LASTEXITCODE -ne 0) {
    Log-Error 'doom sync failed.'
    exit 1
}
Log-Action 'UPGRADING' 'Doom Emacs packages'
& $doomBin upgrade
if ($LASTEXITCODE -ne 0) {
    Log-Error 'doom upgrade failed.'
    exit 1
}

Log-Action 'DONE' 'Doom Emacs setup complete.'
