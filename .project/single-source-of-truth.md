---
type: project-operating-doc
status: active
created: 2026-06-12
updated: 2026-06-12
---

# Single Source Of Truth

This file defines where facts live for the Kxran-OS implementation project and which file wins when information conflicts.

## Truth Precedence

Use this order from strongest to weakest:

1. Explicit user instruction in the current conversation.
2. `.project/context-status-progress.md`.
3. Project status files, especially `Projects/<project>/status.md`.
4. Durable memory in `Context/memory.md` and `Context/agent-brief.md`.
5. Corrections in `Context/corrections.md`.
6. Project README files.
7. Session summaries.
8. Raw session logs and old notes.

If an old session conflicts with current project status, current project status wins.

## Canonical Locations

- Project intent: `.project/what-we-are-trying-to-build.md`
- Build method: `.project/how-we-are-going-to-build.md`
- Truth rules: `.project/single-source-of-truth.md`
- Current progress: `.project/context-status-progress.md`
- Short always-load vault context: `Context/agent-brief.md`
- Durable memory: `Context/memory.md`
- Corrections and behavior changes: `Context/corrections.md`
- Global session index: `Sessions/_index.md`
- Current handoff: `Sessions/active.md`
- Project truth: `Projects/<project>/README.md` and `Projects/<project>/status.md`
- Weekly analytics: `Analytics/weekly/YYYY-Www.md`

## Write Rules

- New facts that should persist across projects go to `Context/memory.md`.
- Mistakes, corrections, and future behavior changes go to `Context/corrections.md`.
- Project state goes to the relevant project `status.md`.
- Historical narrative goes to a session note.
- Metrics and reflection go to weekly analytics.
