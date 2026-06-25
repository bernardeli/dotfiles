---
name: triage-tasks
description: >
  Fetch and prioritise tasks from a Basecamp card column, ordered P1 > P2 > P3 > P4 > untagged.
  Use when the user wants to see what to work on next from a Basecamp board column.
  Args: a Basecamp column URL. If omitted, ask the user for one.
---

Fetch and display a prioritised task list from a Basecamp card column.

## Steps

1. **Get the column URL.** Use the URL passed as args, or ask the user if none was given.

2. **Parse the URL and fetch cards.**
   ```bash
   basecamp url parse "<url>" --json
   basecamp cards list --column <recording_id> --in <project_id> --json
   ```

3. **Extract priority from title.** Each card title starts with `P1`, `P2`, `P3`, or `P4` (case-insensitive, may be followed by ` - ` or `-`). Cards without a priority tag go last.

4. **Sort:** P1 first, then P2, P3, P4, then untagged. Within each tier, preserve the original order (newest first from the API).

5. **Output a clean numbered list** grouped by priority tier:

```
## P1 (2)
1. [Card title without Pn prefix] — #<id> · <age>
2. ...

## P2 (5)
3. ...

## P3 (14)
...
```

- Strip the priority prefix from display titles (e.g. `P3 - FGF - Fix X` → `FGF - Fix X`)
- Show card ID so it can be passed to other skills
- Show age (e.g. "3 days ago", "Jun 3")
- If a tier has no cards, omit it

6. **Summary line** at the end: `X cards total — Y actionable (P1–P3), Z low-priority (P4)`
