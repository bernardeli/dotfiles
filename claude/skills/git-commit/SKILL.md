---
name: git-commit
description: >
  Git commit conventions: logical splitting, why-focused messages, no noise.
  Use when user says "commit", "split into commits", "write a commit message",
  or asks how to stage and commit changes.
---

Stage and commit changes following these conventions.

## Splitting commits

- Each commit must be a single cohesive concern — one reason to exist
- As few commits as possible, but not so few that unrelated changes are mixed
- Never mix: features, bug fixes, refactors, spec changes for different concerns
- Specs for a change go in the same commit as the change itself
- Never create WIP, fixup, plan, or "fix linting" commits — fold mistakes into
  the relevant commit with `git commit --amend` or interactive rebase

## Commit message format

**Title (first line):**
- Imperative mood: "Allow X", "Fix Y", "Remove Z" — not "Added", "Fixes"
- Max 72 characters
- No trailing period
- No conventional-commits prefix (`feat:`, `fix:`) unless the project uses it

**Body:**
- Blank line between title and body
- Explain **why**, not what or how — the diff already shows what changed
- Wrap at 72 characters
- Use `-` bullets for lists

**Trailers:**
- No `Co-authored-by` lines unless the user explicitly asks for one
- No AI attribution lines

## What never goes in a message

- Restatement of the diff ("add X method to Y class")
- "This commit...", "I", "we"
- Implementation details that are obvious from the code
- "Fix linting", "address review feedback" as standalone commits

## Examples

❌ Bad — describes what, not why:
```
Add destroy action to CarePlanProposalsController

Added route, controller action and view button for deleting proposals.
```

✅ Good — explains why the change exists:
```
Allow care plan drafts to be deleted from proposals page

Admins need a way to discard a generated draft without publishing it,
so the member's care plan workflow doesn't get stuck on unwanted proposals.
```

❌ Bad — noise commit:
```
fix linting
```

✅ Good — folded into the original commit via amend or rebase.
