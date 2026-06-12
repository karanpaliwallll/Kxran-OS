---
type: walkthrough
status: active
created: 2026-06-12
updated: 2026-06-12
---

# 05 - Analytics System

Analytics in Kxran-OS are meant to answer one question:

Is the OS making future work better?

## Weekly Analytics Format

Each weekly analytics note should combine:

- minimalist Mermaid graphs;
- compact metrics tables;
- written interpretation;
- next-week fixes.

This keeps analytics readable for humans and useful for agents.

## Three Analytics Areas

### 1. Agent Learning Quality

Tracks whether the agent is actually improving.

Metrics:

- new durable memories;
- corrections logged;
- repeated mistakes;
- stale memories removed;
- new reusable workflows.

### 2. Productivity Output

Tracks what got done.

Metrics:

- sessions completed;
- projects touched;
- decisions made;
- tasks completed;
- open blockers.

### 3. Context Efficiency

Tracks token and context quality.

Metrics:

- average files loaded per session;
- estimated context loaded;
- avoidable context;
- full-history reads avoided;
- compression opportunities.

## Dashboard Shape

The sample note is:

`Analytics/weekly/2026-W24.md`

It has:

1. Snapshot.
2. Learning graph.
3. Context pie chart.
4. Memory flow diagram.
5. Metrics table.
6. What improved.
7. What repeated.
8. Best memory updates.
9. Next week fixes.

## Why Graphs Plus Notes

Graphs make the week easy to scan. Notes explain what the numbers mean.

Tables alone become dry. Graphs alone become vague. The combined format gives both quick understanding and practical next actions.

## Example Review Question

At the end of each week, ask:

> What did the agent learn this week that will make next week cheaper, faster, or less repetitive?

If there is no answer, the OS is collecting history but not improving.
