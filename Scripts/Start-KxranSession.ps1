param(
  [string]$ProjectKey = "",
  [string]$ProjectPath = "",
  [string]$Goal = "Continue project work"
)

$ErrorActionPreference = "Stop"

function Write-Utf8NoBom {
  param([string]$Path, [string]$Content)
  $encoding = New-Object System.Text.UTF8Encoding($false)
  [System.IO.File]::WriteAllText($Path, $Content, $encoding)
}

function Read-Connector {
  param([string]$Path)
  $connectorPath = Join-Path $Path ".kxran-os.json"
  if (Test-Path -LiteralPath $connectorPath) {
    return Get-Content -Raw -LiteralPath $connectorPath | ConvertFrom-Json
  }
  return $null
}

$osRoot = Split-Path -Parent $PSScriptRoot
$connector = $null
if (-not [string]::IsNullOrWhiteSpace($ProjectPath)) {
  $resolvedProjectPath = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($ProjectPath)
  $connector = Read-Connector $resolvedProjectPath
} else {
  $resolvedProjectPath = (Get-Location).Path
  $connector = Read-Connector $resolvedProjectPath
}

if ($connector -ne $null) {
  $ProjectKey = $connector.projectKey
}
if ([string]::IsNullOrWhiteSpace($ProjectKey)) {
  throw "ProjectKey was not provided and no .kxran-os.json connector was found."
}

$today = Get-Date -Format "yyyy-MM-dd"
$now = Get-Date -Format "yyyy-MM-dd HH:mm"
$projectStatus = Join-Path $osRoot "Projects\$ProjectKey\status.md"
if (-not (Test-Path -LiteralPath $projectStatus)) {
  throw "Kxran-OS project status not found: $projectStatus. Run Register-KxranProject.ps1 first."
}

$activePath = Join-Path $osRoot "Sessions\active.md"
$active = @"
---
type: active-session-handoff
status: active
project: $ProjectKey
created: $today
updated: $today
---

# Active Session

## Current Focus

$Goal

## Project

- Project key: ``$ProjectKey``
- External path: ``$resolvedProjectPath``
- Started: $now

## Read First

1. ``Context/agent-brief.md``
2. ``Context/retrieval-map.md``
3. ``Projects/$ProjectKey/README.md``
4. ``Projects/$ProjectKey/status.md``
5. ``Projects/$ProjectKey/sessions.md``

## Session Rule

Read only the latest 1-3 relevant session summaries by default. Search older sessions only for a specific decision, blocker, bug, or historical question.

## Closeout Command

````powershell
& "$osRoot\Scripts\Close-KxranSession.cmd" -ProjectKey "$ProjectKey" -Title "<session title>" -Summary "<what changed>"
````
"@
Write-Utf8NoBom $activePath $active

Write-Host "Kxran-OS session started for '$ProjectKey'."
Write-Host "Read first:"
Write-Host "- $osRoot\Context\agent-brief.md"
Write-Host "- $osRoot\Context\retrieval-map.md"
Write-Host "- $osRoot\Projects\$ProjectKey\README.md"
Write-Host "- $osRoot\Projects\$ProjectKey\status.md"
Write-Host "- $osRoot\Sessions\active.md"
