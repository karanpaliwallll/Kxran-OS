---
type: walkthrough
status: active
created: 2026-06-12
updated: 2026-06-12
---

# 08 - Automation Workflow

This note explains the lightweight automation added to Kxran-OS.

The goal is to avoid remembering the manual workflow:

1. create project entry once;
2. start a project session;
3. close the session into Kxran-OS;
4. back up the OS to GitHub.

## Beginner Mental Model

There are two folders involved:

```text
Kxran-OS vault:
C:\Codex Shit\Kxran-OS

Your actual project:
C:\Somewhere\My-New-App
```

Kxran-OS stores memory, sessions, status, corrections, and analytics.

Your actual project stores the real code or work files.

The automation connects those two folders.

## Do I Need To Give The Project Path?

Not always.

### Case 1: You Are Already Inside The Project Folder

If the current Codex workspace or terminal is already the project folder, you can speak naturally:

```text
Register this project with Kxran-OS as "My New App".
```

In this case, "this project" means the current folder.

Example current folder:

```text
C:\Projects\My-New-App
```

The agent can use that as the project path.

### Case 2: You Are Not Inside The Project Folder

If you are currently inside Kxran-OS or some other folder, give the path:

```text
Register C:\Projects\My-New-App with Kxran-OS as "My New App".
```

This avoids guessing.

### Case 3: You Are Running The Command Yourself

If you are typing in PowerShell manually, give the full command:

```powershell
& "C:\Codex Shit\Kxran-OS\Scripts\Register-KxranProject.cmd" -ProjectName "My New App" -ProjectPath "C:\Projects\My-New-App"
```

### Simple Rule

Use this rule:

| Situation | What to say |
|---|---|
| Agent is already opened inside the project | `Register this project with Kxran-OS as "Project Name".` |
| Agent is not inside the project | `Register C:\Path\To\Project with Kxran-OS as "Project Name".` |
| You are using PowerShell yourself | Use the full `.cmd` command with `-ProjectPath`. |

## What Happens During Registration?

Registration creates two sides of the connection.

Inside Kxran-OS:

```text
Projects/my-new-app/README.md
Projects/my-new-app/status.md
Projects/my-new-app/sessions.md
```

Inside your actual project:

```text
.kxran-os.json
AGENTS.md
```

`.kxran-os.json` is the machine-readable connector. It tells scripts where Kxran-OS lives and what project key to use.

`AGENTS.md` is the human/agent-readable connector. It tells future agents to use Kxran-OS memory for this project.

After registration, you do not need to remember all the mapping. The connector files do that.

## What Should I Say To Codex?

Use these short prompts.

Register once:

```text
Register this project with Kxran-OS as "My New App".
```

Start work:

```text
Start a Kxran-OS session for this project. Goal: build the login page.
```

Close work:

```text
Close this session into Kxran-OS. Summary: built the login page and fixed form validation.
```

Back up:

```text
Back up Kxran-OS to GitHub.
```

## The Four Commands

All scripts live in `Scripts/`.

### 1. Register A Project

Run this once per external project:

```powershell
& "C:\Codex Shit\Kxran-OS\Scripts\Register-KxranProject.cmd" -ProjectName "Portfolio" -ProjectPath "C:\Projects\portfolio"
```

This creates:

```text
Kxran-OS/Projects/portfolio/README.md
Kxran-OS/Projects/portfolio/status.md
Kxran-OS/Projects/portfolio/sessions.md
C:\Projects\portfolio\.kxran-os.json
C:\Projects\portfolio\AGENTS.md
```

The external `AGENTS.md` gets a Kxran-OS connector block so future agents opening that project know where the OS vault is.

### 2. Start A Session

Run this at the beginning of a coding session:

```powershell
& "C:\Codex Shit\Kxran-OS\Scripts\Start-KxranSession.cmd" -ProjectPath "C:\Projects\portfolio" -Goal "Work on homepage layout"
```

This updates `Sessions/active.md` and prints the read-first checklist.

If you are already inside a registered project folder, you can run:

```powershell
& "C:\Codex Shit\Kxran-OS\Scripts\Start-KxranSession.cmd" -Goal "Work on homepage layout"
```

The script will read `.kxran-os.json` from the current folder.

### 3. Close A Session

Run this after meaningful work:

```powershell
& "C:\Codex Shit\Kxran-OS\Scripts\Close-KxranSession.cmd" -ProjectPath "C:\Projects\portfolio" -Title "Homepage layout" -Summary "Updated hero section and navigation." -Decisions "Use a dark minimal visual style." -MemoryUpdates "Portfolio project prefers minimal UI." -Corrections "Avoid loading full session history."
```

This creates a session note and updates:

- `Sessions/_index.md`
- `Sessions/active.md`
- `Projects/<project>/status.md`
- `Projects/<project>/sessions.md`

### 4. Back Up The OS

Run this when you want to push Kxran-OS to GitHub:

```powershell
& "C:\Codex Shit\Kxran-OS\Scripts\Backup-KxranOS.cmd" -Message "Update Kxran-OS"
```

The `.cmd` wrappers use PowerShell with execution-policy bypass for this script run only. That avoids the common Windows error where local scripts are blocked.

This runs:

```text
git add .
git commit
git push
```

It requires GitHub authentication to be available on your machine.

## Connector File

Each registered external project gets:

```text
.kxran-os.json
```

It stores:

- OS vault path;
- project key;
- project name;
- project status file;
- project sessions file.

This lets the scripts work from inside the external project folder.

## What This Automation Does Not Do Yet

- It does not generate full analytics automatically.
- It does not infer detailed summaries from code changes.
- It does not run as a background service.
- It does not sync secrets safely.

Those can become v2 automation after this workflow is tested.
