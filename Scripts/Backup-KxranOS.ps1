param(
  [string]$Message = ""
)

$ErrorActionPreference = "Stop"
$osRoot = Split-Path -Parent $PSScriptRoot
Set-Location $osRoot

if (-not (Test-Path -LiteralPath ".git")) {
  throw "This vault is not a Git repository."
}

$changes = git status --short
if ([string]::IsNullOrWhiteSpace($changes)) {
  Write-Host "No Kxran-OS changes to back up."
  exit 0
}

if ([string]::IsNullOrWhiteSpace($Message)) {
  $Message = "Update Kxran-OS"
}

git add .
git commit -m $Message
git push

Write-Host "Kxran-OS backed up to GitHub."
