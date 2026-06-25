---
name: draft-pr
description: >
  Create a draft GitHub PR for a completed worktree fix. Formats the description with
  a Basecamp task link, fills the PR template, and requests a Copilot review.
  Use after a task has been fixed and committed. Args: any combination of branch name,
  worktree path, Basecamp card URL, or card ID — or just ask the user.
---

Create a draft PR for a completed fix.

## Inputs

Accept any of the following — alone or in combination:

| What the user gives | How to resolve it |
|---|---|
| A worktree branch name (e.g. `worktree-agent-ae8192c1704dbb712`) | Use directly as `--head` |
| A worktree path (e.g. `.claude/worktrees/agent-ae8192c1704dbb712`) | Extract branch with `git -C <path> branch --show-current` |
| A Basecamp card URL | Parse with `basecamp url parse` |
| A Basecamp card ID (e.g. `9999636852`) | Fetch with `basecamp cards show` — infer project 45526395 if not specified |
| A task description or title | Search for matching worktrees with `git worktree list` and match by branch name pattern or commit message |
| Nothing | List open worktrees (`git worktree list`), show them, and ask the user which one |

If the Basecamp card can't be determined from what the user gave, check the commit message on the branch — agents always embed the card URL in the commit body. Extract it with:
```bash
git -C <worktree_path> log --format=%B -n 5 | grep "basecamp.com"
```

## Steps

### 1. Gather context

```bash
# Get the diff and commits vs main
git -C <worktree_path> log main..HEAD --oneline
git -C <worktree_path> diff main --stat
```

Also fetch the Basecamp card to get the clean title and description:
```bash
basecamp url parse "<card_url>" --json
basecamp cards show <id> --in <project_id> --md
```

### 2. Derive the PR title

- Take the card title, strip the priority prefix (`P1 -`, `P2 -`, `P3 -`, `P4 -`) and any leading/trailing whitespace
- Strip customer name prefixes if they're noise (e.g. `FGF -`, `Prestige -`) unless they're meaningful for scoping
- Keep it under 72 characters
- Imperative mood: "Fix X", "Prevent Y", "Allow Z"

### 3. Format the Basecamp link

```
:basecamp: [<clean card title>](<card_url>)
```

Example:
```
:basecamp: [Error deleting Membership custom attributes](https://3.basecamp.com/3653596/buckets/45526395/card_tables/cards/9999636852)
```

### 4. Write the PR body

Fill the Lookout PR template. Keep checklist items that are applicable; delete the rest.

```markdown
## Highlights
- :basecamp: [<clean title>](<card_url>)
- <1–3 bullets summarising what changed and why>

## Discussion
<Root cause in plain English. What was wrong, why it was wrong, how it's fixed.
Forward context if useful — e.g. "the same pattern exists in X, consider fixing there too".>

## Checklist
- [ ] Potential security issues have been considered
- [ ] Checked for dead code left after refactoring
<keep only applicable items>
```

### 5. Push and open the draft PR

```bash
# Push the worktree branch
git -C <worktree_path> push -u origin <branch>

# Create draft PR and capture the URL
PR_URL=$(gh pr create \
  --title "<title>" \
  --body "$(cat <<'EOF'
<body>
EOF
)" \
  --draft \
  --head <branch> \
  --base main)

# Extract the PR number and add Copilot as reviewer automatically
# Copilot is a Bot — --reviewer on gh pr create won't work; must use the API
PR_NUMBER=$(echo "$PR_URL" | grep -oE '[0-9]+$')
gh api repos/thelookoutway/lookout/pulls/${PR_NUMBER}/requested_reviewers \
  -X POST \
  --field "reviewers[]=copilot-pull-request-reviewer[bot]"
```

> Always add Copilot via `gh api` immediately after creating the PR — capture the PR number from the URL returned by `gh pr create` and run the reviewer call unconditionally. The correct reviewer slug is `copilot-pull-request-reviewer[bot]`, not `github-copilot`.

### 6. Output

Print the PR URL and a one-line summary of what it fixes.
