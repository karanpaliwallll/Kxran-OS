---
type: vault-index
status: active
created: 2026-06-12
updated: 2026-06-14
---

# Kxran-OS

Kxran-OS is a local-first Obsidian AI OS for keeping AI-agent work persistent, searchable, and token-efficient.

It turns an Obsidian vault into a memory layer for coding agents and human work: project truth, session logs, durable memory, corrections, walkthroughs, and weekly analytics all live in plain Markdown.

## Why This Exists

AI agents are useful, but they forget between sessions. Long chats become hard to search, old decisions get buried, and loading every past session wastes context.

Kxran-OS solves that by separating:

- **current truth**: project status and active handoff files;
- **durable memory**: facts, preferences, and reusable lessons;
- **corrections**: mistakes that should change future agent behavior;
- **history**: chronological session logs;
- **reflection**: weekly analytics with graphs and notes.

The result is a vault that any agent can read without needing one specific model, vendor, or app.

## Core Principle

Do not load everything.

Read the current truth first, then retrieve history only when it answers a specific question.

```text
Brief + project status + active handoff
        -> relevant session summaries
        -> older raw history only when needed
```

This keeps the OS useful without turning every session into a huge context dump.

## What Is Inside

| Folder | Purpose |
|---|---|
| `Context/` | Durable memory, corrections, retrieval map, and short agent brief. |
| `Projects/` | Project-specific truth: README, status, and session links. |
| `Sessions/` | Chronological AI-agent session records and active handoff. |
| `Analytics/` | Weekly graph-plus-notes reviews for learning, productivity, and context efficiency. |
| `Walkthrough/` | Human-readable explanation of how the OS works. |
| `Walkthrough/setup/` | New-project setup guide with exact prompts to type. |
| `Scripts/` | Local automation for registration, session start, session closeout, and backup. |
| `Resources/` | Templates, prompts, frameworks, and reusable reference material. |
| `Skills/` | Reusable agent workflows and future playbooks. |
| `Daily/` | Daily notes and lightweight human work logs. |
| `Intelligence/` | Decisions, research, and archived observations. |
| `.project/` | Hidden implementation notes for building this vault. Not part of the public OS sidebar. |

## Read First

For any new AI-agent session inside the vault, read:

1. `Context/agent-brief.md`
2. `Context/retrieval-map.md`
3. `Projects/kxran-os/status.md`
4. `Sessions/active.md`

For humans, start here:

1. `Walkthrough/README.md`
2. `Walkthrough/setup/README.md`
3. `Walkthrough/08-automation-workflow.md`
4. `Analytics/weekly/2026-W24.md`

## Obsidian Setup

Open this repository folder as an Obsidian vault.

Recommended core plugins:

- Properties
- Daily notes
- Templates
- Bases
- Backlinks
- Graph view
- File recovery

The `.obsidian/` folder includes starter config for these basics.

## Link A New Project

If Codex or another agent is already opened inside the project folder, say:

```text
Register this project with Kxran-OS as "Project Name".
```

If the agent is not inside that folder, give the path:

```text
Register C:\Path\To\Project with Kxran-OS as "Project Name".
```

Registration creates:

```text
Kxran-OS/Projects/project-name/README.md
Kxran-OS/Projects/project-name/status.md
Kxran-OS/Projects/project-name/sessions.md
ProjectFolder/.kxran-os.json
ProjectFolder/AGENTS.md
```

After that, future agents opening the project can discover the OS mapping automatically from `.kxran-os.json` and `AGENTS.md`.

## Daily Workflow

Start work:

```text
Start a Kxran-OS session for this project. Goal: describe what I am doing.
```

Work normally in the project.

Close work:

```text
Close this session into Kxran-OS. Summary: describe what changed.
```

Back up:

```text
Back up Kxran-OS to GitHub.
```

## Manual Commands

Use the `.cmd` wrappers on Windows. They run PowerShell with execution-policy bypass for that single script run.

Register:

```powershell
& "C:\Codex Shit\Kxran-OS\Scripts\Register-KxranProject.cmd" -ProjectName "My New App" -ProjectPath "C:\Projects\My-New-App"
```

Start:

```powershell
& "C:\Codex Shit\Kxran-OS\Scripts\Start-KxranSession.cmd" -ProjectPath "C:\Projects\My-New-App" -Goal "Build login page"
```

Close:

```powershell
& "C:\Codex Shit\Kxran-OS\Scripts\Close-KxranSession.cmd" -ProjectPath "C:\Projects\My-New-App" -Title "Login page" -Summary "Built login page."
```

Back up:

```powershell
& "C:\Codex Shit\Kxran-OS\Scripts\Backup-KxranOS.cmd" -Message "Update OS memory"
```

## Analytics

Kxran-OS uses weekly analytics notes that combine:

- Mermaid graphs;
- compact metrics tables;
- written review;
- next-week fixes.

The starter example is:

```text
Analytics/weekly/2026-W24.md
```

It tracks:

- agent learning quality;
- productivity output;
- context efficiency;
- memory updates versus corrections.

## What To Avoid

- Do not copy full chat logs into `Context/`.
- Do not load the full session archive by default.
- Do not treat old session notes as current truth.
- Do not edit `.kxran-os.json` unless the OS path or project path changes.
- Do not push private secrets into a public GitHub repo.

## Current Status

Kxran-OS v1 is implemented, audited, and synced to GitHub.

Latest important additions:

- Obsidian vault structure
- Walkthrough documentation
- new-project setup guide
- project registration automation
- session start and closeout automation
- GitHub backup helper

## License

No license has been added yet. Treat this repository as source-available until a license is chosen.
