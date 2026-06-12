---
type: walkthrough
status: active
created: 2026-06-12
updated: 2026-06-12
---

# 02 - Folder By Folder

This note explains every visible folder in the vault.

## Analytics

`Analytics/` stores weekly reviews of how the OS and agents are improving.

Use it to answer:

- Did the agent remember useful context?
- What mistakes repeated?
- How much context was wasted?
- Which projects moved forward?
- What should change next week?

Key files:

- `Analytics/index.md` lists analytics notes.
- `Analytics/weekly/2026-W24.md` is the starter dashboard.

## Context

`Context/` stores durable memory and retrieval instructions.

This is one of the most important folders because it tells future agents what should persist beyond one session.

Key files:

- `agent-brief.md`: short context that can be loaded every session.
- `memory.md`: durable facts, preferences, and long-term decisions.
- `corrections.md`: mistakes and behavior changes.
- `retrieval-map.md`: where to look before opening too much history.
- `AGENTS.md`: routing instructions for this folder.

Do not dump raw chat logs into `Context/`. Promote only the lessons that are still useful.

## Daily

`Daily/` stores day-level human notes.

Daily notes are useful for:

- what happened today;
- rough logs;
- personal notes;
- high-level daily focus.

They are not the canonical project status. If a daily note conflicts with a project `status.md`, the project status wins.

## Intelligence

`Intelligence/` stores research, decisions, market notes, and archived observations.

Suggested use:

- `decisions/`: durable decisions and why they were made.
- `research/`: notes from research, docs, web pages, or product analysis.
- `archive/`: inactive material that should not be loaded by default.

## Projects

`Projects/` stores active and future project truth.

Each project should have:

- `README.md`: what the project is;
- `status.md`: current state and next actions;
- `sessions.md`: relevant session links.

Project `status.md` is the current truth for that project.

## Resources

`Resources/` stores reusable material:

- templates;
- prompts;
- frameworks;
- examples;
- reference docs.

This folder supports work, but it usually is not the source of truth unless a project file points to it.

## Sessions

`Sessions/` stores chronological AI-agent sessions.

Sessions are saved once under:

`Sessions/YYYY/MM/YYYY-MM-DD-title.md`

The folder also includes:

- `_index.md`: global session lookup.
- `active.md`: current handoff.
- `AGENTS.md`: session rules.

Raw sessions are archives. They help answer history questions, but they are not startup context.

## Skills

`Skills/` stores reusable agent workflows.

For example, later this could include:

- a weekly analytics review skill;
- a session closeout skill;
- a project kickoff skill;
- a content writing skill;
- a research synthesis skill.

V1 does not require executable custom skills. Markdown instructions are enough.

## Walkthrough

`Walkthrough/` explains the OS itself.

This folder is for humans and future collaborators. It explains how to understand, use, and modify Kxran-OS.

## Hidden Project Docs

There is also a hidden `.project/` folder. It is not part of the Obsidian OS structure.

That folder stores implementation notes for building this specific vault:

- what we are trying to build;
- how we are building it;
- single source of truth;
- project context, status, and progress.

Keep `.project/` separate from the visible Obsidian knowledge system.
