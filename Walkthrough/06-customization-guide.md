---
type: walkthrough
status: active
created: 2026-06-12
updated: 2026-06-12
---

# 06 - Customization Guide

This note explains how to change Kxran-OS safely.

## Safe Things To Change Anytime

You can edit:

- `Context/memory.md`
- `Context/corrections.md`
- `Context/agent-brief.md`
- project `README.md` files
- project `status.md` files
- templates under `Resources/templates/`
- weekly analytics notes
- walkthrough notes

These are meant to evolve.

## Be Careful Changing

Be careful with:

- `Sessions/_index.md`
- `Sessions/active.md`
- `Context/retrieval-map.md`
- `Projects/<project>/sessions.md`

These files control retrieval and continuity. If they become messy, future agents may load the wrong context.

## How To Add A New Project

1. Create `Projects/<project-slug>/`.
2. Add `README.md`.
3. Add `status.md`.
4. Add `sessions.md`.
5. Link relevant sessions as work happens.

Use `Resources/templates/project-template.md` as the starting point.

## How To Add A New Skill

Create a folder under `Skills/`.

Each skill should explain:

- when to use it;
- inputs needed;
- steps;
- output format;
- examples.

Do not build executable automation until the Markdown process is proven.

## How To Add Sync Later

V1 is local-first. Later options:

- Git backup for version history and portability.
- Obsidian Sync for device sync and version history.
- Both, if private files and secrets are handled carefully.

Before adding sync, review what personal or sensitive context is stored in the vault.

## How To Keep It Token Efficient

- Shorten `Context/agent-brief.md` when it grows too long.
- Move old details from project status into session notes.
- Keep only current truth in `status.md`.
- Use indexes instead of loading full folders.
- Promote only durable lessons into memory.

## When To Add Automation

Consider automation only after a repeated manual workflow is obvious.

Good candidates:

- session closeout;
- weekly analytics generation;
- project kickoff;
- stale memory review;
- correction promotion.

Do not automate a workflow before the manual version is clear.
