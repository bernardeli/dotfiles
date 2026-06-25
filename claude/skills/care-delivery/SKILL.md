---
name: care-delivery
description: >
  Full care delivery engineering workflow: triage a Basecamp column, pick tasks to fix,
  spin up parallel agents, then open draft PRs for each completed fix.
  Use when the user wants to run the end-to-end workflow from a Basecamp board.
  Args: optional Basecamp column URL. Defaults to the care delivery backlog column.
---

Run the full care delivery engineering workflow.

## Default column

If no URL is provided in args, use:
```
https://3.basecamp.com/3653596/buckets/45526395/card_tables/columns/9466081690
```

## Workflow

### Step 1 — Triage

Invoke the `triage-tasks` skill with the column URL. This fetches and sorts all cards by P1 > P2 > P3 > P4.

### Step 2 — Select tasks

Present the prioritised list to the user and ask:

> "Which tasks should I work on? You can say 'top 4', name specific card IDs, or describe what you want."

If the user already specified tasks (passed as args or earlier in conversation), skip the prompt.

**Confidence filter:** only accept tasks where you're confident a fix is tractable from the codebase alone — i.e., it's a code bug or well-scoped feature, not a data fix, configuration change, or investigation-only ticket. Flag uncertain ones and ask the user.

### Step 3 — Fix tasks in parallel

Invoke the `fix-tasks` skill with the selected task list. This spins up one worktree agent per task, all running in parallel.

Wait for all agents to complete. Report each result as it arrives.

### Step 4 — Open draft PRs

For each successfully committed worktree, invoke the `draft-pr` skill. Run these sequentially (each needs a push + API call).

Each PR gets:
- A clean title (no Pn prefix)
- Basecamp link in Highlights: `:basecamp: [title](url)`
- Copilot assigned as reviewer
- Draft status

### Step 5 — Summary

Print a table:

| Task | PR | Status |
|------|----|--------|
| [Clean title](basecamp_url) | [#NNN](pr_url) | ✅ Draft open |
| [Clean title](basecamp_url) | — | ⚠️ Fix failed — needs investigation |

## Error handling

- If a `fix-tasks` agent fails or hits a connection error, resume it with SendMessage before moving to Step 4
- If `draft-pr` fails to add Copilot reviewer, still open the PR and note it in the summary
- If a task turns out to be non-tractable mid-investigation, the agent should say so — skip the PR step and flag it in the summary
