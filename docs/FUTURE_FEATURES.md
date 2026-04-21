# Future Features

Expanded feature ideas drawn from the scratchpad. Each entry has been fleshed out with
scope, considerations, library suggestions, and integration notes.

See `docs/PLAN.md` for the active roadmap. Features here are candidates for future phases
or post-roadmap additions — not yet scheduled.

---

## Obsidian Sync

**Scope:** Medium
**Phase:** Post-roadmap
**Free / Pro:** Pro only

### Description
Allow users to sync their LifeAdmin notes with an Obsidian vault. Since LifeAdmin's linking system was inspired by Obsidian's graph view, users who rely on Obsidian for deep note-taking could mirror their LifeAdmin notes into their vault and link to them from within Obsidian. This bridges lightweight daily organisation (LifeAdmin) with deep knowledge management (Obsidian).

### Considerations
- Obsidian stores notes as plain `.md` files on disk or in a cloud-synced folder (iCloud, Dropbox, etc.) — no proprietary API, which simplifies integration
- One-way (LifeAdmin → Obsidian) is simpler and lower risk than two-way sync; two-way would require conflict resolution
- LifeAdmin's internal links (UUID-based) would need to be translated to Obsidian `[[wikilink]]` format — a lossy but readable mapping
- Users would point LifeAdmin at their vault folder (via the existing WebDAV/filesystem sync); notes could land in a dedicated `LifeAdmin/` subfolder
- Obsidian frontmatter could carry LifeAdmin metadata (UUID, tags, project, creation date) to allow round-trip identification
- Mobile vault path discovery is the trickiest part — Obsidian on iOS uses iCloud; Android uses local storage or Obsidian Sync

### Relevant Libraries
- No special library needed — Obsidian vault is just a directory of `.md` files
- Existing WebDAV/file sync infrastructure can be reused for writing to a vault path
- `okio` (already in KMP stack) handles cross-platform file I/O

### Integration Points
- Notes (primary source of synced content)
- Sync settings (vault path configuration, sync direction toggle)
- Projects (could sync project hub as an Obsidian index note with wikilinks to all linked notes)
- Links system (internal LifeAdmin links translated to Obsidian wikilinks in exported notes)

