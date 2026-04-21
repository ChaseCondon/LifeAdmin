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

## General Behaviour

- Package ID is `dev.chasecondon.lifeadmin` — never suggest changing it
- All four platforms (Android, iOS, Web, Desktop) share one module: `:composeApp`
- GitHub CLI (`gh`) is available — prefer it over manual GitHub instructions where useful
- Supabase is the auth/settings backend; user data syncs to user-chosen storage (WebDAV, Dropbox, etc.)
- License is AGPL v3 — any suggested dependencies must be compatible
- Preferred code style: no unnecessary comments, no speculative abstractions
