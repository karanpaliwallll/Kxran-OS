---
type: setup-guide
status: active
created: 2026-06-12
updated: 2026-06-12
---

# Setup - Link A New Project To Kxran-OS

Use this guide whenever you start a new project and want Kxran-OS to remember it.

The goal is simple:

1. Register the project once.
2. Start a Kxran-OS session when you begin work.
3. Close the session when meaningful work is done.
4. Back up Kxran-OS when you want the memory saved to GitHub.

## The Mental Model

There are always two places:

```text
Your project folder:
C:\Projects\My-New-App

Your OS vault:
C:\Codex Shit\Kxran-OS
```

Your project folder contains the real project files.

Kxran-OS contains the memory layer:

- project status;
- session logs;
- active handoff;
- durable memory;
- corrections;
- analytics.

Registration connects the two.

## Step 1 - Open The Project Folder

Open the actual project folder in Codex.

Example:

```text
C:\Projects\My-New-App
```

If Codex is already working inside that folder, you do not need to type the full path.

## Step 2 - Register The Project Once

If Codex is already inside the project folder, type:

```text
Register this project with Kxran-OS as "My New App".
```

If Codex is not inside the project folder, type:

```text
Register C:\Projects\My-New-App with Kxran-OS as "My New App".
```

## What Registration Creates

Inside Kxran-OS:

```text
Projects/my-new-app/README.md
Projects/my-new-app/status.md
Projects/my-new-app/sessions.md
```

Inside your project:

```text
.kxran-os.json
AGENTS.md
```

`.kxran-os.json` is the machine-readable connector.

`AGENTS.md` tells future agents: this project uses Kxran-OS for memory.

## Step 3 - Start A Session

When you begin work, type:

```text
Start a Kxran-OS session for this project. Goal: build the login page.
```

Use any goal that describes the session.

Examples:

```text
Start a Kxran-OS session for this project. Goal: fix the mobile navbar.
```

```text
Start a Kxran-OS session for this project. Goal: continue checkout flow from where we left off.
```

The session start updates:

```text
Kxran-OS/Sessions/active.md
```

That file tells the agent what to read first.

## Step 4 - Work Normally

After the session is started, work normally in the project folder.

You do not need to say "store this in Obsidian" after every small change.

The important thing is to close the session when meaningful work is done.

## Step 5 - Close The Session

At the end, type:

```text
Close this session into Kxran-OS. Summary: built the login page and fixed form validation.
```

Better closeout prompt:

```text
Close this session into Kxran-OS.
Summary: built the login page and fixed form validation.
Decisions: use email/password first, OAuth later.
Memory updates: this project uses a minimal dark UI.
Corrections: do not load full session history unless needed.
Tasks completed: 3.
```

Closeout updates:

```text
Sessions/YYYY/MM/YYYY-MM-DD-session-title.md
Sessions/_index.md
Sessions/active.md
Projects/my-new-app/status.md
Projects/my-new-app/sessions.md
```

## Step 6 - Back Up Kxran-OS

When you want to save OS changes to GitHub, type:

```text
Back up Kxran-OS to GitHub.
```

Or, if you are running it yourself:

```powershell
& "C:\Codex Shit\Kxran-OS\Scripts\Backup-KxranOS.cmd" -Message "Update OS memory"
```

## Full Beginner Workflow

Use this exact sequence for any new project:

```text
Register this project with Kxran-OS as "Project Name".
```

```text
Start a Kxran-OS session for this project. Goal: describe what I am doing.
```

Work normally.

```text
Close this session into Kxran-OS. Summary: describe what changed.
```

```text
Back up Kxran-OS to GitHub.
```

## When Do I Need To Give The Path?

Use this rule:

| Situation | Prompt |
|---|---|
| Codex is already inside the project folder | `Register this project with Kxran-OS as "Project Name".` |
| Codex is not inside the project folder | `Register C:\Path\To\Project with Kxran-OS as "Project Name".` |
| You are typing in PowerShell yourself | Use the full `.cmd` command with `-ProjectPath`. |

## How The Project Appears In Obsidian

After registration, open Obsidian and go to:

```text
Projects/project-name/
```

You will see:

- `README.md`: what the project is;
- `status.md`: current truth;
- `sessions.md`: links to relevant sessions.

As you work, the graph grows because sessions, project files, memory, corrections, and analytics link together.

## What To Avoid

- Do not manually copy full chat logs into `Context/`.
- Do not load every old session by default.
- Do not edit `.kxran-os.json` unless the project path or OS path changes.
- Do not push private secrets to GitHub.
- Do not skip session closeout if the session had meaningful progress.

## Manual Command Reference

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
