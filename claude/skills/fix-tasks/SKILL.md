---
name: fix-tasks
description: >
  Spin up parallel isolated worktree agents to investigate and fix a list of tasks simultaneously.
  Each agent commits using the git-commit skill with the Basecamp card URL in the message.
  Use when the user provides a list of Basecamp card IDs or URLs to work on.
---

Spin up one worktree agent per task and work on all of them in parallel.

## Input

The user provides a list of tasks — either:
- Basecamp card IDs (e.g. `9519879233 9999636852`)
- Basecamp card URLs
- Output from the `triage-tasks` skill

If card details aren't already in context, fetch each card first:
```bash
basecamp cards show <id> --in <project_id> --md
```

## For each task, spawn an Agent with these settings:
- `isolation: "worktree"` — each agent gets its own branch, no conflicts
- Include in the prompt:
  1. Full card title and description (so the agent understands the problem)
  2. Basecamp card URL (for the commit message)
  3. Root cause analysis if already known
  4. These fixed instructions (copy verbatim into every agent prompt — do not omit the git warning):

```
## Git discipline
You are in an isolated worktree on its own branch. NEVER commit to `main`. Only stage and commit to the current branch. Before committing, verify with `git branch --show-current` that you are NOT on `main`.

## Codebase context
- Rails app (Ruby, PostgreSQL, Sidekiq). Frontend: esbuild, TypeScript, Stimulus, Turbo, TailwindCSS.
- Mounts architecture: lightweight Rails engines in `app/mounts/` (admin/, care/, clinical/, finance/, etc.)
- Uses `acts_as_tenant` for company-scoped data
- Run `mspec` to test modified files; `rspec spec/path/to/file_spec.rb` for specific specs
- Do not read `.env*` files or anything in `.gitignore`
- Prefer editing existing files over creating new ones
- No comments unless the WHY is non-obvious

## After fixing
1. Run affected specs to confirm they pass
2. Invoke the `git-commit` skill to stage and commit
3. Include the Basecamp card URL in the commit message body
```

## During execution

- Launch all agents in a **single message** so they run concurrently
- Report each one as it finishes: what changed, which files, commit SHA
- If an agent hits a connection error, resume it with SendMessage

## After all agents complete

Tell the user: all tasks committed, ready for PRs. Suggest running `/draft-pr` for each worktree branch, or `/care-delivery` to do it automatically.
