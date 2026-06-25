---
name: changelog
description: >
  Generate a Lookout changelog entry for a given PR or branch.
  Use when the user says "changelog", "write a changelog entry",
  "changelog for this PR", or gives a branch/PR and asks what to write.
---

Generate a changelog entry for the given PR or branch.

## Steps

1. **Identify the changes.** If the user gave a PR number, run `gh pr view <number> --json title,body,commits` and `gh pr diff <number>`. If they gave a branch name, run `git log main..<branch> --oneline` and `git diff main..<branch>`. If you're on a feature branch with no argument, use the current branch vs `main`.

2. **Determine the type tag** for each user-visible change:
   - `[Added]` — new capability or UI element users didn't have before
   - `[Changed]` — existing behaviour modified, copy updated, UI adjusted
   - `[Fixed]` — bug or incorrect behaviour corrected
   - `[Removed]` — feature, field, or option taken away
   - `[Internal]` — engineering-only, no user-facing effect (use sparingly; omit if it's not worth telling anyone)

3. **Write the entries.** One bullet per distinct user-visible change. Follow these rules:
   - Plain English, present tense: "Staff can now…", "The X field now…", "Fixed a bug where…"
   - Heuristic: **how would you explain this to a care manager sitting next to you?** Not an engineer.
   - No technical jargon (no model names, class names, migration names, column names).
   - No PR numbers or branch names in the text.
   - Keep each line short — one sentence if possible.
   - Group closely related sub-changes with an indent under the parent bullet (rare).

4. **Output the result** in this exact format, ready to paste into Notion:

```
## <YYYY-MM-DD>
- [Type] Description of change.
- [Type] Description of another change.
```

Use today's date. If there are no user-facing changes (purely internal), say so briefly and skip the entry or use `[Internal]`.

## Examples of good entries

```
- [Fixed] The count shown in the tab bar for excluded invoices in SAH claims now matches the number of lines shown.
- [Added] Staff can now reorder items within a care plan category by dragging them into a new order.
- [Changed] Care plan events now open in a new tab, keeping you on the care plan page instead of navigating away.
- [Removed] HCP statement settings have been removed from the finance settings section.
- [Fixed] Fixed a bug where intake surveys would freeze when answering the last few questions.
```

## What to avoid

- Technical descriptions: ~~"Added `excluded_from_claiming` boolean to `InvoiceLine` model"~~
- Vague filler: ~~"Various improvements to the UI"~~
- Engineer-speak: ~~"Refactored the billing run worker to handle edge cases"~~
- Mentioning the PR, branch, or ticket number in the entry text
