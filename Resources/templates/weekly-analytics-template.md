---
type: template
template_for: weekly-analytics
created: 2026-06-12
updated: 2026-06-12
---

# Weekly Analytics - YYYY-Www

## Snapshot

## Learning Graph

```mermaid
xychart-beta
  title "Agent Learning Quality"
  x-axis ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
  y-axis "Count" 0 --> 10
  bar "Useful Memories" [0, 0, 0, 0, 0, 0, 0]
  line "Corrections" [0, 0, 0, 0, 0, 0, 0]
```

## Context Efficiency

```mermaid
pie title Context Loaded This Week
  "Useful context" : 0
  "Repeated context" : 0
  "Avoidable context" : 0
```

## Memory Flow

```mermaid
flowchart LR
  A["Raw sessions"] --> B["Session summaries"]
  B --> C["Project status"]
  B --> D["Memory updates"]
  B --> E["Corrections"]
  C --> F["Next session context"]
  D --> F
  E --> F
```

## Metrics

| Area | Metric | Value |
|---|---|---:|
| Learning | New durable memories | 0 |
| Learning | Corrections logged | 0 |
| Learning | Repeated mistakes | 0 |
| Learning | Stale memories removed | 0 |
| Productivity | Sessions completed | 0 |
| Productivity | Projects touched | 0 |
| Productivity | Decisions made | 0 |
| Productivity | Tasks completed | 0 |
| Context | Estimated context loaded | 0 |
| Context | Avoidable context | 0 |
| Context | Avg files loaded/session | 0 |
| Context | Full-history reads avoided | 0 |

## What Improved

## What Repeated

## Best Memory Updates

## Next Week Fixes
