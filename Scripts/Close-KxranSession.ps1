param(
  [string]$ProjectKey = "",
  [string]$ProjectPath = "",
  [string]$Title = "",
  [string]$Summary = "",
  [string]$Decisions = "",
  [string]$MemoryUpdates = "",
  [string]$Corrections = "",
  [int]$TasksCompleted = 0,
  [switch]$Push
)

$ErrorActionPreference = "Stop"

function Write-Utf8NoBom {
  param([string]$Path, [string]$Content)
  $encoding = New-Object System.Text.UTF8Encoding($false)
  [System.IO.File]::WriteAllText($Path, $Content, $encoding)
}

function Convert-ToSlug {
  param([string]$Value)
  $slug = $Value.ToLowerInvariant() -replace '[^a-z0-9]+', '-'
  $slug = $slug.Trim('-')
  if ([string]::IsNullOrWhiteSpace($slug)) { return "session" }
  return $slug
}

function Read-Connector {
  param([string]$Path)
  $connectorPath = Join-Path $Path ".kxran-os.json"
  if (Test-Path -LiteralPath $connectorPath) {
    return Get-Content -Raw -LiteralPath $connectorPath | ConvertFrom-Json
  }
  return $null
}

function Insert-TableRow {
  param([string]$Path, [string]$Row)
  $content = Get-Content -Raw -LiteralPath $Path
  if ($content -match '\|---\|---\|---\|---\|') {
    $updated = $content -replace '(\|---\|---\|---\|---\|\r?\n)', "`${1}$Row`r`n"
  } else {
    $updated = $content.TrimEnd() + "`r`n" + $Row + "`r`n"
  }
  Write-Utf8NoBom $Path $updated
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

if ([string]::IsNullOrWhiteSpace($Title)) { $Title = "$ProjectKey session" }
if ([string]::IsNullOrWhiteSpace($Summary)) { $Summary = "Session closed. Add details if needed." }

$today = Get-Date -Format "yyyy-MM-dd"
$year = Get-Date -Format "yyyy"
$month = Get-Date -Format "MM"
$slug = Convert-ToSlug $Title
$sessionDir = Join-Path $osRoot "Sessions\$year\$month"
New-Item -ItemType Directory -Force -Path $sessionDir | Out-Null
$sessionRel = "Sessions/$year/$month/$today-$slug.md"
$sessionPath = Join-Path $osRoot ($sessionRel -replace '/', [IO.Path]::DirectorySeparatorChar)
if (Test-Path -LiteralPath $sessionPath) {
  $time = Get-Date -Format "HHmmss"
  $sessionRel = "Sessions/$year/$month/$today-$slug-$time.md"
  $sessionPath = Join-Path $osRoot ($sessionRel -replace '/', [IO.Path]::DirectorySeparatorChar)
}

$memoryCount = if ([string]::IsNullOrWhiteSpace($MemoryUpdates)) { 0 } else { 1 }
$correctionCount = if ([string]::IsNullOrWhiteSpace($Corrections)) { 0 } else { 1 }
$decisionText = if ([string]::IsNullOrWhiteSpace($Decisions)) { "- None recorded." } else { "- $Decisions" }
$memoryText = if ([string]::IsNullOrWhiteSpace($MemoryUpdates)) { "- None recorded." } else { "- $MemoryUpdates" }
$correctionText = if ([string]::IsNullOrWhiteSpace($Corrections)) { "- None recorded." } else { "- $Corrections" }

$session = @"
---
type: session
date: $today
agent: unknown
model: unknown
project: $ProjectKey
status: complete
memory_updates: $memoryCount
corrections: $correctionCount
tasks_completed: $TasksCompleted
tokens_estimated: unknown
---

# $today - $Title

## Goal

Continue work on ``$ProjectKey``.

## Context Used

- ``Context/agent-brief.md``
- ``Context/retrieval-map.md``
- ``Projects/$ProjectKey/status.md``
- ``Sessions/active.md``

## Work Done

$Summary

## Decisions

$decisionText

## Mistakes And Corrections

$correctionText

## Memory Updates

$memoryText

## Follow-Ups

- Review ``Projects/$ProjectKey/status.md`` before the next session.
"@
Write-Utf8NoBom $sessionPath $session

$projectStatusPath = Join-Path $osRoot "Projects\$ProjectKey\status.md"
$projectSessionsPath = Join-Path $osRoot "Projects\$ProjectKey\sessions.md"
$globalIndexPath = Join-Path $osRoot "Sessions\_index.md"
if (-not (Test-Path -LiteralPath $projectStatusPath)) { throw "Missing project status: $projectStatusPath" }
if (-not (Test-Path -LiteralPath $projectSessionsPath)) { throw "Missing project sessions index: $projectSessionsPath" }

$projectRow = "| $today | ``$sessionRel`` | $Summary | complete |"
Insert-TableRow $projectSessionsPath $projectRow

$globalRow = "| $today | $ProjectKey | ``$sessionRel`` | unknown | complete | #session |"
Insert-TableRow $globalIndexPath $globalRow

$statusText = Get-Content -Raw -LiteralPath $projectStatusPath
$statusText = $statusText -replace 'updated: \d{4}-\d{2}-\d{2}', "updated: $today"
if ($statusText -match '## Current State') {
  $statusText = $statusText -replace '(## Current State\r?\n\r?\n)', "`${1}Last session closed on $today. $Summary`r`n`r`n"
}
Write-Utf8NoBom $projectStatusPath $statusText

$activePath = Join-Path $osRoot "Sessions\active.md"
$active = @"
---
type: active-session-handoff
status: closed
project: $ProjectKey
created: $today
updated: $today
---

# Active Session

## Current Focus

No active session. Last closed session was for ``$ProjectKey``.

## Latest Session

- Session: ``$sessionRel``
- Summary: $Summary

## Read Next

1. ``Projects/$ProjectKey/status.md``
2. ``Projects/$ProjectKey/sessions.md``
3. ``$sessionRel`` only if details are needed.
"@
Write-Utf8NoBom $activePath $active

if ($Push) {
  & (Join-Path $PSScriptRoot "Backup-KxranOS.ps1") -Message "Update Kxran-OS session for $ProjectKey"
}

Write-Host "Closed Kxran-OS session for '$ProjectKey'."
Write-Host "Created: $sessionRel"
Write-Host "Updated:"
Write-Host "- Sessions/_index.md"
Write-Host "- Projects/$ProjectKey/sessions.md"
Write-Host "- Projects/$ProjectKey/status.md"
Write-Host "- Sessions/active.md"
