# Claude Code — Project Instructions

## Project Context
LifeAdmin is a Kotlin Multiplatform / Compose Multiplatform life organisation app targeting
Android, iOS, Web, and Desktop. Key docs: `docs/PLAN.md`, `docs/ARCHITECTURE.md`, `docs/LOCAL_DEV.md`.

## Scratchpad Processing

Check `docs/SCRATCHPAD.md` for unprocessed entries (anything not marked `[processed]`) at these moments:
- At the start of every session, before responding to the first message
- After completing any significant block of work (feature implemented, setup task finished, etc.)
- Whenever the user mentions the scratchpad or asks for ideas to be captured

For each unprocessed idea:
1. Expand it into a structured entry in `docs/FUTURE_FEATURES.md` using the template below
2. Mark the original scratchpad line `[processed]` — do not delete it

Do this silently. Only mention it if you actually processed something new, in which case a
single brief note is fine ("Processed 2 scratchpad items → FUTURE_FEATURES.md").

### FUTURE_FEATURES.md entry template

```
## [Feature name]

**Scope:** [Small / Medium / Large — estimated effort]
**Phase:** [Which roadmap phase this fits, or "Post-roadmap"]
**Free / Pro:** [Available in free tier / Pro only / Depends on implementation]

### Description
[What the feature does and why it's useful]

### Considerations
[Edge cases, UX decisions, technical constraints, open questions]

### Relevant Libraries
[Any existing KMP/Android/iOS libraries that could help]

### Integration Points
[Which existing modes/features this connects to — Notes, Todos, Habits, Calendar, Projects, Sync]
```

## GitHub Project — Kanban Management

Project number: **3**, owner: **ChaseCondon**
Project URL: https://github.com/users/ChaseCondon/projects/3

Move issues through the kanban automatically as work progresses. Do this silently — no need to narrate it.

| Status | When |
|--------|------|
| **Todo** | Issue exists, no work started |
| **In Refinement** | Actively planning or designing |
| **Developing** | Code is being written |
| **Testing** | Implemented, verifying behaviour |
| **Blocked** | Stalled on external dependency or decision |
| **Staged** | Deployed to staging, pending production |
| **Released** | Merged to main, deployed to production |
| **Dropped** | Won't implement |

### Moving an issue

```bash
# 1. Get the project item ID for an issue number
ITEM_ID=$(gh project item-list 3 --owner ChaseCondon --format json \
  | jq -r '.items[] | select(.content.number == ISSUE_NUMBER) | .id')

# 2. Set the status
gh project item-edit \
  --id "$ITEM_ID" \
  --field-id PVTSSF_lAHOANchwc4BVRzgzhQusxY \
  --single-select-option-id OPTION_ID \
  --project-id PVT_kwHOANchwc4BVRzg
```

**Status option IDs:**
- Todo: `f75ad846`
- In Refinement: `47fc9ee4`
- Developing: `96b788c9`
- Testing: `364fe249`
- Blocked: `6bdc940a`
- Staged: `004beabb`
- Released: `98236657`
- Dropped: `c2836a5c`

**Phase field ID:** `PVTSSF_lAHOANchwc4BVRzgzhQutno`
**Priority field ID:** `PVTSSF_lAHOANchwc4BVRzgzhQutog`
**Platform field ID:** `PVTSSF_lAHOANchwc4BVRzgzhQv1wM` (Global: `22d97abd`, Android: `0492952c`, iOS: `72f6f294`, Web: `88ce8769`, Desktop: `937e46d3`)

## Tools Available

### Supabase MCP (`supabase-staging`, `supabase-production`)
Two MCP servers are configured — prefer **`supabase-staging`** for all development work. Use `supabase-production` (read-only) only when you need to inspect live data.

With these servers you can: inspect schema, run queries, check RLS policies, verify migrations landed correctly.

Default to staging. Never write to production via MCP.

### Supabase CLI
Use for migrations and schema management:
```bash
supabase db diff --schema public          # diff local schema vs remote
supabase db push                          # push migrations to staging
supabase migration new <name>             # create a new migration file
```
Link a project: `supabase link --project-ref lmcyvcwmyxmqzivycqyt` (staging)

### Wrangler (Cloudflare CLI)
Use for Pages management and troubleshooting deployments:
```bash
wrangler pages deployment list --project-name lifeadmin
wrangler pages deployment list --project-name lifeadmin-staging
```

### GitHub CLI (`gh`)
Already configured globally. Use for all repo, issue, PR, secret, and project operations.

## General Behaviour

- Package ID is `dev.chasecondon.lifeadmin` — never suggest changing it
- All four platforms (Android, iOS, Web, Desktop) share one module: `:composeApp`
- GitHub CLI (`gh`) is available — prefer it over manual GitHub instructions where useful
- Supabase is the auth/settings backend; user data syncs to user-chosen storage (WebDAV, Dropbox, etc.)
- License is AGPL v3 — any suggested dependencies must be compatible
- Preferred code style: no unnecessary comments, no speculative abstractions
