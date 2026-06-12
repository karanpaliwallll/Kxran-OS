---
type: routing-index
folder: Scripts
status: active
created: 2026-06-12
updated: 2026-06-12
---

# Scripts Routing

This folder contains local automation for Kxran-OS.

Scripts are helpers, not the source of truth. The Markdown files they update remain canonical.

## Main Commands

- `Register-KxranProject.ps1` creates a project entry and optional connector files.
- `Start-KxranSession.ps1` updates active handoff for the current project.
- `Close-KxranSession.ps1` creates a session note and updates indexes.
- `Backup-KxranOS.ps1` commits and pushes vault changes.

Prefer the matching `.cmd` wrappers on Windows. They call PowerShell with execution-policy bypass for that run only.
