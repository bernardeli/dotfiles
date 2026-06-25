---
name: impact-report
description: Generate executive impact reports for performance reviews by analyzing git history, commits, and PRs
allowed-tools: Bash, Read, Grep, Glob, Skill
---

# Impact Report Generator

## Purpose
Generate comprehensive executive impact reports for performance reviews by analyzing code contributions, git history, commits, and pull request activity. Transform technical changes into business value narratives.

## When to Use
- Preparing for performance reviews
- Creating quarterly or annual impact summaries
- Documenting contributions for promotion packets
- Communicating engineering work to non-technical stakeholders
- Tracking team or individual impact over time

## Required Inputs

Before generating the report, gather:

1. **Timeframe** (required)
   - Specific date range: "Last 14 days", "Q4 2025", "Jan 1 - Mar 31"
   - Git date formats: `--since="2025-01-01" --until="2025-03-31"`

2. **Target Audience** (required)
   - Non-technical stakeholders (focus on business impact)
   - Engineering leadership (balance technical depth with impact)
   - Direct manager (technical details + context)
   - Promotion committee (emphasize scope, complexity, leadership)

3. **Scope** (optional)
   - Specific author: `--author="user@email.com"`
   - Specific branches: main, develop, feature branches
   - Specific paths: frontend, backend, specific services
   - Team vs individual contributions

4. **Additional Context** (optional)
   - Project goals or OKRs for alignment
   - Known major initiatives
   - Team size and role

## Analysis Process

### Step 1: Gather Data Sources

Collect comprehensive data from multiple sources:

#### Git History

```bash
# Get commit history with stats
git log --since="<start-date>" --until="<end-date>" --author="<name>" --pretty=format:"%h|%ad|%s" --date=short --numstat

# Get detailed commit messages
git log --since="<start-date>" --until="<end-date>" --author="<name>" --pretty=format:"%H%n%an%n%ad%n%s%n%b%n---"

# Get PR-style merge commits
git log --since="<start-date>" --until="<end-date>" --author="<name>" --merges --pretty=format:"%s%n%b%n---"

# Get co-authors for collaboration network (git trailers)
git log --since="<start-date>" --until="<end-date>" --author="<name>" --pretty=format:"%an|%ae|%b" | grep -i "co-authored-by"

# Get collaboration network (all authors on same commits)
git log --since="<start-date>" --until="<end-date>" --pretty=format:"%H|%an|%ae" --all
```

#### Basecamp Data (Read-Only)

**IMPORTANT: Only READ from Basecamp, never write or modify data**

Use the basecamp skill to gather additional context about your work:

```bash
# First, load the basecamp skill
/basecamp

# Get cards/todos assigned to you
bc cards list --assigned-to="me" --status="completed" --since="<start-date>"
bc todos list --assigned-to="me" --completed --since="<start-date>"

# Search for relevant project conversations
bc messages search --query="<project-name>" --since="<start-date>"
bc messages search --query="<feature-name>" --since="<start-date>"

# Get project activity to understand context
bc projects list
bc timeline --project-id="<id>" --since="<start-date>"

# Get check-ins or status updates you participated in
bc check-ins list --answered-by="me" --since="<start-date>"

# Get comments you made (for collaboration network and testimonials)
bc comments list --creator="me" --since="<start-date>"

# Search for mentions of your name (testimonials and collaboration)
bc messages search --query="@yourname" --since="<start-date>"
bc comments search --query="@yourname" --since="<start-date>"
```

**What to extract from Basecamp:**
- **Cards/Todos**: Direct work items completed, their descriptions and business context
- **Messages/Conversations**: Stakeholder feedback, problem statements, decision rationale
- **Check-ins**: Regular updates showing progress and blockers overcome
- **Timeline**: Sequence of activities showing project evolution
- **Comments**: Your contributions to discussions, unblocking others, providing technical guidance

**Mapping Basecamp to Impact:**
- Card descriptions often contain the "why" missing from commit messages
- Conversations reveal stakeholder needs and business drivers
- Comments show collaboration and technical leadership
- Completed cards demonstrate scope beyond just code commits
- Mentions and replies show people you unblocked or helped
- "Thank you" messages and positive feedback serve as testimonials

### Step 2: Categorize Contributions

Group changes into business-relevant categories:

**Primary Categories:**
- **User-Facing Features** - New capabilities delivered to end users
- **Platform/Infrastructure** - Scalability, reliability, developer productivity
- **Performance & Optimization** - Speed improvements, resource efficiency
- **Bug Fixes & Stability** - Issue resolution, error handling
- **Technical Debt** - Refactoring, code quality, modernization
- **Security & Compliance** - Vulnerabilities, authentication, data protection
- **Developer Experience** - Tooling, documentation, CI/CD
- **Cross-Functional** - Collaboration, reviews, mentorship

### Step 3: Calculate Impact Scores

For each major contribution, calculate an impact score:

**Impact Score Formula:**
Overall Impact = Average(Complexity, Reach, Innovation)

**Complexity (1-5):**
- 1: Simple bug fix, configuration change
- 2: Standard feature with existing patterns
- 3: Feature requiring new integration or moderate refactoring
- 4: Architectural change, complex algorithm, cross-system integration
- 5: Novel architecture, core platform redesign, multi-team coordination

**Reach (1-5):**
- 1: Single developer or internal tool
- 2: Team-level impact (5-10 people)
- 3: Department-level impact (20-50 people)
- 4: Company-wide impact (100+ people)
- 5: Customer-facing impact (1000s+ users)

**Innovation (1-5):**
- 1: Copy-paste solution, well-established pattern
- 2: Adaptation of existing approach
- 3: Combining techniques in new way
- 4: Novel approach for this codebase
- 5: Industry-novel, research-worthy, paradigm shift

**Scoring Guidelines:**
- Score 4.0-5.0: High impact (promote heavily)
- Score 3.0-3.9: Medium-high impact (highlight)
- Score 2.0-2.9: Medium impact (include in summary)
- Score 1.0-1.9: Low impact (consolidate or omit)

**Example:**
> **API Performance Optimization**
> - Complexity: 4 (Required profiling, algorithm redesign, caching strategy)
> - Reach: 5 (Affects 10K daily active users)
> - Innovation: 3 (Combined existing techniques in novel way)
> - **Overall Impact: 4.0** (High - feature prominently)

### Step 4: Evaluate Impact

For each category, assess:

**Business Impact:**
- What problem did this solve?
- Who benefits? (users, team, company)
- What's the measurable outcome?
- How does this align with company goals?

**Technical Impact:**
- Complexity: Simple fix vs. architectural change
- Scope: Lines changed, files touched, systems affected
- Innovation: Novel approach or standard implementation
- Quality: Test coverage, documentation, maintainability

**Collaboration Impact:**
- Cross-team work
- Code reviews given/received
- Knowledge sharing
- Unblocking others
- Basecamp discussions and decision-making
- Responding to stakeholder questions

### Step 5: Build Collaboration Network

Analyze collaboration patterns from git and Basecamp data:

**From Git:**
- Extract co-authors from commit trailers
- Identify frequent collaborators on same files
- Track reviewers from PR metadata

**From Basecamp:**
- Map @mentions to identify who you helped
- Track conversation threads to find collaboration patterns
- Identify cross-functional partnerships (designers, PMs, other eng teams)

**Network Metrics to Calculate:**
- **Unique collaborators**: Number of distinct people worked with
- **Most frequent partners**: Top 3-5 collaborators
- **Cross-team reach**: Number of different teams/departments
- **Unblock count**: Number of people you helped (via @mentions + "thanks" responses)
- **Knowledge sharing**: Number of explanatory comments, docs, or presentations

**Visualization:**
```markdown
## Collaboration Network
- **Direct collaborators**: 12 engineers across 4 teams
- **Top partners**: Alice (Frontend), Bob (Infrastructure), Carol (Mobile)
- **People unblocked**: 8 (via Basecamp + code reviews)
- **Cross-functional**: Worked with Design, Product, and Data teams
```

### Step 6: Extract Stakeholder Testimonials

Search Basecamp for positive feedback and recognition:

**What to look for:**
- Messages containing "thank you", "thanks", "great work", "appreciate"
- Responses to your comments expressing gratitude
- Praise in project updates or retrospectives
- @mentions acknowledging your help

**How to extract:**
```bash
# Search for gratitude keywords in messages
bc messages search --query="thank you @yourname" --since="<start-date>"
bc messages search --query="thanks @yourname" --since="<start-date>"
bc messages search --query="great work @yourname" --since="<start-date>"

# Review your comments for replies expressing thanks
bc comments list --creator="me" --since="<start-date>" --include-replies
```

**Formatting testimonials:**
> "Thank you for debugging the payment flow issue - saved us hours!" — Sarah (Product)

> "Your explanation of the architecture really helped the team understand the system." — Mike (Engineering)

**Quality over quantity:**
- Select 2-4 most meaningful testimonials
- Choose diverse sources (different teams, seniority levels)
- Prefer specific feedback over generic praise

### Step 7: Build Impact Timeline

Create a visual timeline for the reporting period:

**Timeline Structure:**
```markdown
## Impact Timeline
Q1 2025
├─ January
│  ├─ Week 1-2: Launched User Dashboard (Impact: 4.2) - 5K users
│  └─ Week 3-4: Fixed Critical Auth Bug (Impact: 4.5) - Blocked 200 users
├─ February
│  ├─ Week 1-2: Optimized Database Queries (Impact: 3.8) - 60% faster
│  ├─ Week 3: Led Architecture Review (Impact: 3.5) - Cross-team
│  └─ Week 4: Implemented Caching Layer (Impact: 4.0) - 90% hit rate
└─ March
   ├─ Week 1-3: Built Analytics Pipeline (Impact: 4.3) - Company-wide
   └─ Week 4: Mentored 2 Junior Engineers (Impact: 3.0) - Team growth
```

**Guidelines:**
- Group by month or sprint
- Include impact scores for major items
- Add quantifiable outcomes in parentheses
- Limit to 2-4 items per month (only highlights)
- Use tree structure for visual clarity

### Step 8: Calculate Team Impact Metrics

Quantify your broader team impact beyond code:

**Metrics to Track:**

1. **People Unblocked** (from Basecamp + code reviews)
   - Count @mentions where you provided help
   - Count "thank you" responses to your comments
   - Count blocked PRs you reviewed/approved
   - Target: Identify 5-15 instances

2. **Cross-Team Collaboration Frequency**
   - Teams you worked with (Engineering, Product, Design, etc.)
   - Number of cross-team projects or initiatives
   - Cross-team meetings or sync-ups led/attended
   - Target: 3-5 different teams

3. **Knowledge Sharing Reach**
   - Documentation pages created/updated (track views if possible)
   - Presentations or demos given (audience size)
   - Basecamp explanations (number of people in thread)
   - Pair programming sessions
   - Target: Reach 20-50+ people

**Example Output:**
```markdown
## Team Impact Metrics
- **Unblocked**: 12 people across 3 teams
  - 8 via Basecamp technical guidance
  - 4 via code review approvals
- **Cross-team collaboration**: 4 teams (Frontend, Mobile, Data, Product)
  - Led 2 cross-team architecture discussions
  - Partnered on 3 major initiatives
- **Knowledge sharing**: Reached 40+ people
  - Created 3 docs (150 total views)
  - Gave 2 team presentations (15-20 people each)
  - 8 detailed Basecamp technical explanations
```

### Step 9: Quantify Where Possible

Include relevant metrics:
- User impact: "Improved checkout flow for 10K daily users"
- Performance: "Reduced API latency by 45% (500ms → 275ms)"
- Reliability: "Decreased error rate from 2.3% to 0.1%"
- Efficiency: "Automated process saving 5 hours/week"
- Scale: "Handled 3x traffic increase without infrastructure changes"

**Avoid vanity metrics:**
- Lines of code (unless contextual: "Removed 5K lines through refactor")
- Number of commits (focus on outcomes, not activity)
- Files changed (unless demonstrating scope)

## Report Template

```markdown
# Engineering Impact Report
**Period:** [Timeframe]
**Author:** [Name]
**Audience:** [Stakeholder Type]

---

## Executive Summary

[2-3 sentences capturing the highest-level impact. What was delivered? What problems were solved? What business value was created?]

**Key Highlights:**
- [Major achievement 1 with measurable outcome] (Impact: 4.5)
- [Major achievement 2 with measurable outcome] (Impact: 4.2)
- [Major achievement 3 with measurable outcome] (Impact: 4.0)

**Overall Impact Score: [X.X/5.0]** (Average of top achievements)

---

## Impact Timeline

[Quarter/Period]
├─ [Month 1]
│  ├─ [Achievement 1] (Impact: X.X) - [Outcome]
│  └─ [Achievement 2] (Impact: X.X) - [Outcome]
├─ [Month 2]
│  ├─ [Achievement 3] (Impact: X.X) - [Outcome]
│  └─ [Achievement 4] (Impact: X.X) - [Outcome]
└─ [Month 3]
   ├─ [Achievement 5] (Impact: X.X) - [Outcome]
   └─ [Achievement 6] (Impact: X.X) - [Outcome]

---

## Impact by Category

### 🚀 User-Facing Features
**Impact:** [Business value delivered to users]

- **[Feature Name]** (Impact: X.X)
  *Why:* [Problem solved or opportunity captured]
  *Outcome:* [Measurable result or expected benefit]
  *Scope:* [Technical complexity/scope indicator]
  *Impact Breakdown:* Complexity X, Reach X, Innovation X

### ⚙️ Platform & Infrastructure
**Impact:** [Value to engineering velocity, reliability, or scale]

- **[Initiative Name]**
  *Why:* [Technical or business driver]
  *Outcome:* [Performance, reliability, or efficiency gain]
  *Scope:* [Systems affected, complexity]

### ⚡ Performance & Optimization
**Impact:** [User experience or cost improvements]

- **[Optimization Name]**
  *Why:* [Performance bottleneck or inefficiency]
  *Outcome:* [Measurable improvement with before/after metrics]
  *Scope:* [Approach and effort]

### 🐛 Bug Fixes & Stability
**Impact:** [Reliability improvements and user friction removed]

- **[Issue Category]**
  *Why:* [User impact or business risk]
  *Outcome:* [Resolution and stability metrics]
  *Scope:* [Complexity of root cause and fix]

### 🔧 Technical Debt & Code Quality
**Impact:** [Long-term maintainability and velocity improvements]

- **[Refactoring/Improvement]**
  *Why:* [Pain point or risk being addressed]
  *Outcome:* [Code quality, test coverage, or developer experience improvement]
  *Scope:* [Files refactored, tests added]

### 🔒 Security & Compliance
**Impact:** [Risk mitigation and trust enhancement]

- **[Security Work]**
  *Why:* [Vulnerability or compliance requirement]
  *Outcome:* [Security posture improvement]
  *Scope:* [Systems hardened, audits passed]

### 🤝 Collaboration & Leadership
**Impact:** [Team effectiveness and knowledge sharing]

- Code reviews: [Number] reviews completed, focus areas
- Mentorship: [Specific contributions to team growth]
- Cross-team collaboration: [Examples of partnership]
- Knowledge sharing: [Documentation, presentations, pair programming]
- Basecamp engagement: [Key discussions participated in, decisions influenced, stakeholders unblocked]

---

## Team Impact Metrics

### Collaboration Network
- **Direct collaborators**: [X] engineers across [Y] teams
- **Top partners**: [Name 1] ([Team]), [Name 2] ([Team]), [Name 3] ([Team])
- **Cross-functional reach**: [Teams worked with: Design, Product, Data, etc.]

### People Helped
- **Total unblocked**: [X] people
  - [Y] via Basecamp technical guidance
  - [Z] via code review approvals
  - [W] via pair programming / direct help
- **Examples**: [Brief 1-2 examples of impact]

### Knowledge Sharing Reach
- **Documentation**: [X] docs created/updated ([Y] total views)
- **Presentations**: [X] presentations to [Y] people
- **Basecamp explanations**: [X] detailed technical responses
- **Estimated reach**: [~X people helped through knowledge sharing]

### Stakeholder Testimonials

> "[Testimonial 1 - specific feedback about your work]"
> — [Name], [Role/Team]

> "[Testimonial 2 - specific feedback about collaboration or impact]"
> — [Name], [Role/Team]

> "[Testimonial 3 - optional, if you have strong third example]"
> — [Name], [Role/Team]

---

## Contributions Overview

**Statistics** (for context, not the story):
- Total commits: [X]
- Pull requests: [X] merged, [X] reviewed
- Files modified: [X across Y areas]
- Test coverage: [X% coverage added/maintained]
- Basecamp activity: [X] cards completed, [Y] discussions participated in

**Major Projects:**
1. [Project name] - [One-line outcome]
2. [Project name] - [One-line outcome]

---

## Key Themes & Learnings

[Optional: 2-4 sentences on growth areas, new technologies learned, process improvements driven, or strategic insights gained]

---

## Looking Ahead

[Optional: 1-2 sentences on upcoming work or areas of focus that build on this period's contributions]

---

*Generated from git history spanning [X] commits, [Y] pull requests, and [Z] Basecamp cards/discussions*
```

## Quality Checklist

Before finalizing the report:

- [ ] **No vanity metrics** - Lines of code mentioned only if contextual
- [ ] **Business outcomes emphasized** - Clear "why" for each contribution
- [ ] **Audience-appropriate** - Technical depth matches reader expertise
- [ ] **Quantified impact** - Numbers provided where measurable
- [ ] **Action-oriented language** - "Implemented", "Reduced", "Enabled" not "Worked on"
- [ ] **Categorization logical** - Changes grouped by business value, not git structure
- [ ] **Balanced narrative** - Shows breadth (variety) and depth (complexity)
- [ ] **Context provided** - Complexity and scope clear without being defensive
- [ ] **Collaboration visible** - Individual contributions + team impact shown
- [ ] **Impact scores calculated** - Major contributions have scored impact ratings
- [ ] **Team metrics included** - Unblock count, collaboration network, knowledge sharing quantified
- [ ] **Timeline visual** - Chronological view of achievements included
- [ ] **Testimonials authentic** - Real quotes from stakeholders, not generic praise
- [ ] **Proofread** - Grammar, spelling, formatting polished

## Common Pitfalls to Avoid

1. **Technical jargon overload** for non-technical audiences
2. **Listing commits chronologically** instead of grouping by impact
3. **Focusing on effort** instead of outcomes
4. **Missing the "so what?"** - Always connect technical work to business value
5. **Underselling** - Be factual about complexity and impact
6. **Overselling** - Avoid hyperbole; let results speak
7. **Ignoring collaboration** - Show individual contribution within team context
8. **Generic descriptions** - Be specific about what was built and why

## Tips for Different Audiences

### For Non-Technical Stakeholders
- Lead with business impact
- Minimize technical terminology
- Use analogies for complex concepts
- Emphasize user/customer benefit
- Quantify business metrics (revenue, users, time saved)

### For Engineering Leadership
- Balance technical sophistication with strategic impact
- Highlight architectural decisions and trade-offs
- Show systems thinking and complexity management
- Emphasize scalability, reliability, security
- Demonstrate technical leadership and best practices

### For Promotion Committees
- Emphasize scope, complexity, and ambiguity handled
- Show progression and growth
- Highlight cross-functional leadership
- Demonstrate impact beyond individual contributions
- Connect work to company/org level goals

## Advanced Techniques

### Integrating PR Descriptions
If PRs have rich descriptions:
```bash
gh pr list --author="@me" --state=merged --json title,body,mergedAt --jq '.[] | select(.mergedAt >= "<start-date>" and .mergedAt <= "<end-date>")'
```

Use PR descriptions to extract:
- Problem statements
- Solution approaches
- Testing strategies
- Rollout plans
- Impact measurements

### Cross-Referencing Issues
```bash
gh issue list --author="@me" --state=closed --json title,closedAt,labels
```

Link commits to issues for context on:
- Customer pain points
- Bug severity
- Feature requests
- Technical debt items

### Including Code Review Impact
```bash
gh pr list --reviewed-by="@me" --json title,number,repository
```

Demonstrate:
- Code quality advocacy
- Knowledge sharing
- Risk mitigation
- Team support

### Enriching with Basecamp Context

**CRITICAL: READ-ONLY - Never write or modify Basecamp data**

Cross-reference git commits with Basecamp cards to add business context:

**Example workflow:**
1. Get completed cards: `bc cards list --assigned-to="me" --status="completed"`
2. For each significant card, find related git commits by date or keywords
3. Extract business justification and stakeholder needs from card description
4. Use conversation threads to show problem-solving and collaboration

**Valuable Basecamp signals:**
- **Card descriptions**: Often contain user stories, acceptance criteria, business rationale
- **Message threads**: Show technical discussions, architecture decisions, stakeholder alignment
- **Your comments**: Demonstrate technical expertise, unblocking others, clarifying scope
- **Mentions**: Times you were pulled into discussions as subject matter expert
- **Check-in responses**: Regular progress updates showing consistent delivery

**Example enhancement:**

❌ **From git alone:**
> "Implemented user profile caching"

✅ **Enhanced with Basecamp context:**
> **Improved User Profile Load Performance**
> *Why:* Customer support reported slow profile loads during peak hours (Basecamp card #1234)
> *Outcome:* Implemented Redis caching layer, reduced load time from 2.3s to 180ms (92% improvement)
> *Collaboration:* Worked with infrastructure team on cache invalidation strategy (Basecamp thread: "Profile performance spike")
> *Scope:* Full caching layer with TTL management, monitoring, and graceful fallback

## Example Transformations

### ❌ Weak (Technical Focus)
> "Refactored UserService class, extracted 3 helper methods, added unit tests"

### ✅ Strong (Impact Focus)
> **Improved User Authentication Reliability**
> *Why:* Intermittent login failures affecting 2% of sessions
> *Outcome:* Refactored authentication flow, reduced error rate to 0.1%, added comprehensive test coverage
> *Scope:* Restructured core authentication service with 95% test coverage

---

### ❌ Weak (Activity Focus)
> "Made 47 commits updating the checkout flow"

### ✅ Strong (Outcome Focus)
> **Streamlined E-commerce Checkout Experience**
> *Why:* 18% cart abandonment rate due to complex checkout
> *Outcome:* Redesigned checkout flow to 3 steps (from 7), early metrics show 12% reduction in abandonment
> *Scope:* Full-stack feature spanning payment integration, form validation, and mobile optimization

## Notes

- **Timing**: Generate reports when git history is fresh (weekly/bi-weekly drafts → comprehensive quarterly/annual reports)
- **Iteration**: First draft from git log analysis, second draft adding context and narrative
- **Validation**: Cross-reference with project documentation, team notes, or manager feedback
- **Storage**: Keep reports for year-end reviews and promotion packets

## Running the Skill

1. **Clarify inputs** - Gather timeframe, audience, and scope from user
2. **Load integrations** - Load basecamp skill if Basecamp integration needed: `/basecamp`
3. **Gather git data** - Execute git commands for commits, co-authors, collaboration network
4. **Gather Basecamp data** - Query for cards, todos, messages, discussions, mentions (READ-ONLY)
5. **Gather PR/issue data** - Read PR descriptions if available (via `gh` CLI)
6. **Build collaboration network** - Analyze git co-authors and Basecamp interactions
7. **Extract testimonials** - Search Basecamp for "thank you", praise, recognition
8. **Calculate team metrics** - Count unblocks, cross-team work, knowledge sharing reach
9. **Categorize contributions** - Group by business impact categories
10. **Score impact** - Calculate complexity, reach, innovation for major items
11. **Build timeline** - Create chronological view of achievements
12. **Cross-reference** - Link git commits with Basecamp cards for business context
13. **Generate report** - Follow template with all new sections
14. **Quality check** - Review against expanded checklist
15. **Refine** - Adjust based on audience and context

## Basecamp Safety Notes

**ALWAYS READ-ONLY**: This skill should NEVER:
- Create, update, or delete cards/todos
- Post messages or comments
- Modify project settings
- Change assignments or due dates
- Archive or move items

**ONLY PERMITTED**:
- List and read cards/todos assigned to you
- Search and read messages/conversations
- View timeline and check-ins
- Read project metadata and activity
- Search for @mentions and testimonials
- Read comments and replies
