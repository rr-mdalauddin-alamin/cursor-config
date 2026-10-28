---
name: learning-curriculum-mentor
description: Build phased mastery roadmaps as Cursor canvases matching Git Mastery Roadmap. Use when the user wants to learn or master a subject, asks for a curriculum/roadmap/mentor plan, or says "Learn X — use curriculum rule", "use curriculum rule", or "mastery roadmap" (Docker, SQL, Rust, Git, etc.).
---

# Learning curriculum mentor

Turn **"Learn {subject}"** into a **Git-style Mastery Roadmap canvas** plus chat mentoring. You are the **primary mentor**; write for a **new grad** (plain language, defined terms, longer explanations OK).

Synced on cloud agents via the **cursor-learning-config** environment (`~/.cursor/rules` + `~/.cursor/skills`).

## When this skill applies

- `Learn Docker — use curriculum rule`
- `Learn SQL — use curriculum rule`
- `use curriculum rule` + any topic
- Roadmap / curriculum / mentor plan / mastery path requests

## Before you build a canvas

1. Read **`~/.cursor/skills-cursor/canvas/SKILL.md`** (WriteCanvas rules, `cursor/canvas` only, no raw `react`).
2. Skim **`~/.cursor/rules/learning-curriculum-mentor.mdc`** for the content contract (section order, voice).
3. **Reference implementation:** Git Mastery Roadmap canvas (same UX). Clone `TOPICS[]`, `PHASES[]`, sidebar nav, `contentPad`, checkpoint reveal state, difficulty legend at sidebar bottom.

## Workflow

### Step 1 — Scope the subject

- Parse subject from the user message (e.g. Docker from `Learn Docker — use curriculum rule`).
- Unless they specify depth, plan **4–5 phases**, **12–20 topics**, mix of Foundational / Intermediate / Advanced.
- Reply briefly in chat: phases + topic titles (bullet list). Then build the canvas unless they asked to review the outline first.

### Step 2 — Author topic content

For **every** topic, fill all fields in beginner mentor voice:

| Field | Notes |
|--------|--------|
| `summary` | One plain-language line |
| `conceptExplained` | Full concept; define terms; example |
| `analogy` | Mental model callout body |
| `visualAscii` | Optional but preferred for core topics |
| `commands[]` | `{ cmd, desc }` — snippets/CLI/SQL as appropriate |
| `labSteps[]` | Runnable in `~/learn-lab-{slug}` (e.g. `~/learn-lab-docker`) |
| `checkpoints[]` | ≥2 `{ question, answer }` |
| `tip?` / `pitfall?` | When useful |

**How to use this topic** (UI): same text for all topics unless customized:

> Run the hands-on lab → answer checkpoints without looking → reveal answers → then Mark as Mastered. In chat: `Checkpoint: {topic title}` for a live quiz.

Render as **`Callout` tone="info" title="How to use this topic"** immediately after the topic header row, before Concept.

### Step 3 — Build the canvas

- Call **`WriteCanvas`** with `title: "{Subject} Mastery Roadmap"` and full `.canvas.tsx` source.
- **Imports:** only from `cursor/canvas` (`useState`, `useEffect`, `Stack`, `Row`, `H1`, `H2`, `H3`, `Text`, `Code`, `Pill`, `Callout`, `Divider`, `Table`, `Button`, `useHostTheme`, etc.).
- **Layout:** full-width header (title + progress) → body row → sidebar (`paddingTop: contentPad`) + scrollable main (`padding: contentPad`).
- **Main panel section order per topic:** header → How to use → Divider → Concept → Analogy callout → Visual → Key Commands table → Hands-on lab → Checkpoints (reveal buttons) → Tip/Pitfall grid → Next topic pill.
- **Difficulty colors** (reference): Foundational `#4CAF7D`, Intermediate `#F0A500`, Advanced `#E05C5C`, Mastered `#4CAF7D`.
- Return the canvas **url** from WriteCanvas as a markdown link.

### Step 4 — Mentor in chat

After the canvas exists:

- Offer **Phase 1, topic 1** lab or `Checkpoint: {first topic}`.
- On `Checkpoint: {title}`: quiz without showing answers first; optionally ask for lab output.
- Never click Mark as Mastered for the user.

## Updating an existing roadmap

- `WriteCanvas` with same `canvas_id` and full new `contents`.
- Preserve layout and section order; add topics or deepen Concept/analogy in beginner voice.

## Lab directory convention

```bash
mkdir -p ~/learn-lab-{slug} && cd ~/learn-lab-{slug}
```

Use `{slug}` = lowercase subject (docker, sql, rust). Mention this path in every topic's lab intro line.

## Checklist before shipping canvas

- [ ] Every topic has How to use, Concept, Analogy, Visual (where it helps), Commands, Lab, ≥2 Checkpoints
- [ ] Concept + Analogy are new-grad friendly (no unexplained jargon)
- [ ] Sidebar legend at **bottom**; phase 1 header aligns with topic H2 (`contentPad = 24`)
- [ ] WriteCanvas succeeded; user got canvas link
- [ ] Chat ends with clear next step (e.g. "Open Phase 1 → … or say Checkpoint: …")
