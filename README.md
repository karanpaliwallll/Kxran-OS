---
type: vault-index
status: active
created: 2026-06-12
updated: 2026-06-12
---

# Kxran-OS

Kxran-OS is a local-first Obsidian AI OS. It keeps durable context, project truth, session history, distilled memory, corrections, and weekly analytics in plain Markdown so any AI model or human can use it.

## Read First

For any new AI-agent session, read these files in order:

1. `Context/agent-brief.md`
2. `Context/retrieval-map.md`
3. `Projects/kxran-os/status.md`
4. `Sessions/active.md`

Do not load the full session archive by default. Use indexes first, then retrieve older sessions only when they answer a specific question.

## Main Areas

- `Walkthrough/` explains how the OS works and how to customize it.
- `Context/` stores durable memory and retrieval maps.
- `Projects/` stores project-specific truth.
- `Sessions/` stores chronological AI-agent session records.
- `Analytics/` stores weekly graph-plus-notes reviews.
- `Resources/` stores templates, prompts, and frameworks.
- `Scripts/` stores local automation commands for registering projects, starting sessions, closing sessions, and backing up the vault.
- `Skills/` stores reusable agent workflows.

Project-only implementation notes live in `.project/`. That folder is intentionally separate from the Obsidian OS structure.

## Obsidian Setup

Open this folder as an Obsidian vault. Enable core plugins for Properties, Daily notes, Templates, Bases, Backlinks, Graph view, and File recovery.
