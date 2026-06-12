---
type: project-operating-doc
status: active
created: 2026-06-12
updated: 2026-06-12
---

# How We Are Going To Build

Build Kxran-OS as a local-first Markdown system first. Prefer simple, inspectable files over custom automation until the workflow proves itself.

## Agent Startup Routine

For normal Kxran-OS implementation work:

1. Read `.project/what-we-are-trying-to-build.md`.
2. Read `.project/single-source-of-truth.md`.
3. Read `.project/context-status-progress.md`.
4. Read `Context/agent-brief.md`.
5. Read the relevant project `README.md` and `status.md`.
6. Read `Sessions/active.md`.

Older sessions are retrieved by targeted search through `Sessions/_index.md` or `Projects/<project>/sessions.md`.

## Session Closeout Routine

At the end of each meaningful AI-agent session:

- create or update one session note under `Sessions/YYYY/MM/`;
- update `Sessions/_index.md`;
- update `Sessions/active.md`;
- update the related project `status.md`;
- promote durable lessons to `Context/memory.md`;
- promote mistakes and behavior changes to `Context/corrections.md`;
- add analytics-ready counts when possible.

## Token Efficiency Rules

- Read indexes before archives.
- Prefer current status files over old session logs.
- Load summaries before raw transcripts.
- Do not paste large historical context unless it is directly relevant.
- If older facts conflict, use `.project/single-source-of-truth.md` to decide precedence.
- Keep `Context/agent-brief.md` short enough to load every session.
