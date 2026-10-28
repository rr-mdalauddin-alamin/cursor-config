# Cursor Learning Environment — setup

Share **learning-curriculum-mentor** rule + skill across **all cloud agents** by linking this repo as a Cursor Environment.

## 1. Create GitHub repo

```bash
cd cursor-learning-config   # this folder
git init
git add .
git commit -m "Add shared learning curriculum environment"
git remote add origin git@github.com:YOUR_USER/cursor-learning-config.git
git push -u origin main
```

## 2. Cursor Dashboard → Environment

1. Open [Cursor Dashboard](https://cursor.com/dashboard) → **Cloud Agents** → **Environments** (or **Environment** settings).
2. **New environment** (or edit an existing one).
3. **Add repository:** `https://github.com/YOUR_USER/cursor-learning-config`
4. Paste **environment.json** from this repo (or let Cursor read it from the repo root).

### environment.json (copy if needed)

```json
{
  "build": {
    "dockerfile": "Dockerfile"
  },
  "install": "bash scripts/install-learning-curriculum.sh"
}
```

- **`install`** runs on environment **build** (copies rule + skill into the snapshot). No **`start`** — curriculum files are baked at build time; reopen the agent or rebuild after rule/skill changes.

5. **Trigger a build** and wait until it succeeds (green).
6. Name the environment e.g. **`Learning Curriculum`**.

## 3. Start learning cloud agents

For Git, Docker, SQL, etc.:

1. **New Cloud Agent**
2. Select environment **`Learning Curriculum`**
3. First message: `Learn Docker — use curriculum rule`

The agent should find:

- `~/.cursor/rules/learning-curriculum-mentor.mdc`
- `~/.cursor/skills/learning-curriculum-mentor/SKILL.md`

## 4. Verify on a fresh agent

Ask the agent to run:

```bash
ls -la ~/.cursor/rules/learning-curriculum-mentor.mdc
ls -la ~/.cursor/skills/learning-curriculum-mentor/SKILL.md
```

## 5. Update curriculum everywhere

1. Edit `.mdc` or `SKILL.md` in this repo → push to `main`
2. **Rebuild** the environment (or rely on `start` sync on next boot)

## Repo layout

```text
cursor-learning-config/
├── environment.json
├── Dockerfile
├── scripts/
│   ├── install-learning-curriculum.sh
│   └── sync-cursor-learning.sh   # legacy; same as install
└── .cursor/
    ├── rules/
    │   └── learning-curriculum-mentor.mdc
    └── skills/
        └── learning-curriculum-mentor/
            └── SKILL.md
```

## Canvases (per subject)

Roadmap **canvases** are account-scoped (not in this repo). Each topic agent creates its own `{Subject} Mastery Roadmap` canvas; Git example:

https://cursor.com/canvas/store-bfd5e21c-1b3b-4688-8d65-67ff7a4cbb59/4a86e6e5-f54a-431e-829f-6df0bc19a058

## Optional: User Rules backup

Paste `USER-RULES-SNIPPET.md` into **Customize → Rules → User Rules** so local + cloud agents still get triggers if environment is not selected.
