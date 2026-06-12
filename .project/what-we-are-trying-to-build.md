---
type: project-operating-doc
status: active
created: 2026-06-12
updated: 2026-06-12
---

# What We Are Trying To Build

Kxran-OS is a model-agnostic AI operating system built around an Obsidian vault. The project goal is to create a durable working environment where AI agents and humans can preserve context, session history, project truth, memory, corrections, and analytics without depending on one model or vendor.

## Purpose

This project exists because AI agents are mostly stateless between sessions. Kxran-OS should give future agents a reliable way to understand:

- what the user is building;
- which projects are active;
- what decisions are already settled;
- what mistakes were corrected before;
- what context should be loaded first;
- what history should stay archived unless specifically needed.

## Success Criteria

Kxran-OS is working when:

- a new agent can start with a short context load instead of a long manual briefing;
- project status is clear without reading every old chat;
- old sessions are searchable but not automatically loaded;
- durable lessons are promoted into memory and corrections files;
- weekly analytics show what improved, what repeated, and what should change next;
- the vault remains useful to Codex, Claude, Gemini, ChatGPT, Cursor, local models, and humans.

## Non-Goals For V1

- Do not build a custom Obsidian plugin.
- Do not add MCP automation yet.
- Do not depend on a single AI vendor.
- Do not use raw session logs as the primary source of truth.
- Do not load full history by default.
