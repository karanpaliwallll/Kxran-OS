param(
  [Parameter(Mandatory = $true)]
  [string]$ProjectName,

  [string]$ProjectPath = "",

  [string]$ProjectKey = ""
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
  if ([string]::IsNullOrWhiteSpace($slug)) {
    throw "Could not create a project key from '$Value'. Pass -ProjectKey explicitly."
  }
  return $slug
}

function Write-TextIfMissing {
  param([string]$Path, [string]$Content)
  if (-not (Test-Path -LiteralPath $Path)) {
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $Path) | Out-Null
    Write-Utf8NoBom $Path $Content
    return $true
  }
  return $false
}

$osRoot = Split-Path -Parent $PSScriptRoot
if ([string]::IsNullOrWhiteSpace($ProjectKey)) {
  $ProjectKey = Convert-ToSlug $ProjectName
} else {
  $ProjectKey = Convert-ToSlug $ProjectKey
}

$today = Get-Date -Format "yyyy-MM-dd"
$projectDir = Join-Path $osRoot "Projects\$ProjectKey"
New-Item -ItemType Directory -Force -Path $projectDir | Out-Null

$readmePath = Join-Path $projectDir "README.md"
$statusPath = Join-Path $projectDir "status.md"
$sessionsPath = Join-Path $projectDir "sessions.md"

$readme = @"
---
type: project
status: active
owner: user
created: $today
updated: $today
---

# $ProjectName

## Overview

This project is registered with Kxran-OS.

## Current Status

See ``status.md``.

## Read First

1. ``README.md``
2. ``status.md``
3. ``sessions.md``
4. ``Sessions/active.md``

## Key Resources

- External project path: $ProjectPath

## Next Steps

- Start a session with ``Scripts/Start-KxranSession.ps1``.
- Close meaningful sessions with ``Scripts/Close-KxranSession.ps1``.
"@

$status = @"
---
type: project-status
project: $ProjectKey
status: active
created: $today
updated: $today
truth: canonical
---

# $ProjectName Status

## Current State

Registered with Kxran-OS on $today.

## Completed

- Project entry created.

## In Progress

- First real work session not logged yet.

## Next Actions

1. Start a Kxran-OS session.
2. Work in the external project folder.
3. Close the session into Kxran-OS.
"@

$sessions = @"
---
type: project-session-index
project: $ProjectKey
status: active
created: $today
updated: $today
---

# $ProjectName Sessions

| Date | Session | Summary | Status |
|---|---|---|---|

Only open older sessions when the project status does not answer the question.
"@

$created = @()
if (Write-TextIfMissing $readmePath $readme) { $created += "Projects/$ProjectKey/README.md" }
if (Write-TextIfMissing $statusPath $status) { $created += "Projects/$ProjectKey/status.md" }
if (Write-TextIfMissing $sessionsPath $sessions) { $created += "Projects/$ProjectKey/sessions.md" }

if (-not [string]::IsNullOrWhiteSpace($ProjectPath)) {
  $resolvedProjectPath = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($ProjectPath)
  if (-not (Test-Path -LiteralPath $resolvedProjectPath -PathType Container)) {
    throw "ProjectPath does not exist or is not a folder: $resolvedProjectPath"
  }

  $connector = [ordered]@{
    osVault = $osRoot
    projectKey = $ProjectKey
    projectName = $ProjectName
    projectPath = $resolvedProjectPath
    statusFile = "Projects/$ProjectKey/status.md"
    sessionsFile = "Projects/$ProjectKey/sessions.md"
    created = $today
    updated = $today
  }
  $connectorPath = Join-Path $resolvedProjectPath ".kxran-os.json"
  Write-Utf8NoBom $connectorPath ($connector | ConvertTo-Json -Depth 4)
  $created += "$resolvedProjectPath/.kxran-os.json"

  $agentsPath = Join-Path $resolvedProjectPath "AGENTS.md"
  $block = @"
<!-- BEGIN KXRAN-OS CONNECTOR -->
## Kxran-OS Memory

Use Kxran-OS as the memory layer for this project.

- OS vault: ``$osRoot``
- Project key: ``$ProjectKey``
- Project name: ``$ProjectName``

At session start, run:

````powershell
& "$osRoot\Scripts\Start-KxranSession.cmd" -ProjectPath "$resolvedProjectPath" -Goal "<what you are doing>"
````

At session closeout, run:

````powershell
& "$osRoot\Scripts\Close-KxranSession.cmd" -ProjectPath "$resolvedProjectPath" -Title "<session title>" -Summary "<what changed>"
````

Read first:

1. ``$osRoot\Context\agent-brief.md``
2. ``$osRoot\Context\retrieval-map.md``
3. ``$osRoot\Projects\$ProjectKey\README.md``
4. ``$osRoot\Projects\$ProjectKey\status.md``
5. ``$osRoot\Sessions\active.md``

Do not load full session history by default.
<!-- END KXRAN-OS CONNECTOR -->
"@

  if (Test-Path -LiteralPath $agentsPath) {
    $existing = Get-Content -Raw -LiteralPath $agentsPath
    if ($existing -match '(?s)<!-- BEGIN KXRAN-OS CONNECTOR -->.*?<!-- END KXRAN-OS CONNECTOR -->') {
      $updated = [regex]::Replace($existing, '(?s)<!-- BEGIN KXRAN-OS CONNECTOR -->.*?<!-- END KXRAN-OS CONNECTOR -->', $block)
    } else {
      $updated = $existing.TrimEnd() + "`r`n`r`n" + $block + "`r`n"
    }
    Write-Utf8NoBom $agentsPath $updated
  } else {
    Write-Utf8NoBom $agentsPath ("# Project Instructions`r`n`r`n" + $block + "`r`n")
  }
  $created += "$resolvedProjectPath/AGENTS.md"
}

Write-Host "Registered project '$ProjectName' as '$ProjectKey'."
if ($created.Count -gt 0) {
  Write-Host "Created/updated:"
  $created | ForEach-Object { Write-Host "- $_" }
} else {
  Write-Host "Project files already existed; no OS project files overwritten."
}
