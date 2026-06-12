---
type: corrections-ledger
status: active
created: 2026-06-12
updated: 2026-06-12
load: targeted
---

# Corrections Ledger

Use this file for mistakes, repeated issues, and behavior changes that future agents should apply.

## Active Corrections

| Date | Correction | Future Behavior |
|---|---|---|
| 2026-06-12 | Analytics should not be tables only. | Weekly analytics must combine minimalist Mermaid graphs, compact metrics, and written notes. |
| 2026-06-12 | Loading all history by default is token-expensive. | Read source-of-truth files and recent summaries first; search older sessions only when needed. |

## Correction Promotion Rule

If the same correction appears twice, turn it into a clear rule in either `Context/agent-brief.md`, `.project/how-we-are-going-to-build.md`, or the relevant project status file.
