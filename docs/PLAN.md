# Life Admin App — Plan

**Stack:** Kotlin Multiplatform + Compose Multiplatform  
**Targets:** Android, iOS, Web, Desktop (JVM)  
**Model:** Local-first, user-owned sync storage, provider-agnostic  
**Package ID:** `dev.chasecondon.lifeadmin`  

---

## Core Philosophy

Four first-class modes — Notes, Todos, Habits, Calendar — that operate independently but link deeply.
Every item has a universal ID. Anything can reference anything else. A unified **Today** view
synthesizes them into a daily picture without forcing date-centric thinking onto individual modes.

**Projects** act as cross-cutting containers: one named, colored entity that simultaneously owns
a folder in each mode, a calendar color category, and a shared tag — so "Home Renovation" is one
thing, not four separate organizational decisions.

---

## Navigation Structure

Navigation adapts to screen size using `WindowSizeClass`:

| Screen | Navigation component | Layout |
|---|---|---|
| Phone (Compact) | Bottom navigation bar | Single column |
| Tablet / Web (Medium) | Navigation Rail (left sidebar) | Two-column |
| Desktop (Expanded) | Navigation Drawer (persistent) | Three-column / master-detail |

Modes are the same across all sizes: **[Today] [Notes] [Todos] [Habits] [Calendar]**  
Projects accessible from any mode via header or sidebar section.

- **Today** is the home/default screen
- Each mode retains its own internal navigation independently
- Global FAB on mobile; inline "New" button in sidebar on larger layouts
- Global search: cross-type, accessible from any screen

---

## Today View (Home Screen)

The one screen that brings everything together:

- Calendar events for today (synced from Google/Apple)
- Todos due today + overdue (compact list, tap to expand)
- Habits to check in today (inline check-off without leaving this screen)
- Pinned notes
- Focus block — one manually-chosen item to prioritize today

> Today is a *view*, not the default mental model. It shows you a slice of things that happen
> to be relevant today. Each individual mode maintains its own organizational logic.

---

## Projects (Cross-Cutting Containers)

A Project is a named, colored, global container that spans all four modes simultaneously.
This is the primary tool for organizing "life areas" or "ongoing initiatives" that involve
notes, tasks, habits, and scheduled time all at once.

### What a Project provisions automatically

| Mode | What's created |
|---|---|
| Notes | A folder named `[Project Name]` |
| Todos | A project/folder named `[Project Name]` |
| Habits | A filterable group — habits can be assigned to a project |
| Calendar | A color category `[Project Name]` with the project's color |
| All modes | An auto-tag `#project-slug` applied to all items within the project |

### Project Hub view

A dedicated view per project showing all linked items across all modes in one place:
- All notes in the project folder
- All todos in the project folder
- All habits assigned to this project (with inline check-in for today's habits)
- All calendar events in this color category / tagged with this project

### Behavior
- Any item can be assigned to a project at creation time or later
- Items not assigned to a project land in **General** (the default)
- Projects appear in a "Projects" list accessible from any mode's navigation header
- A project's color is consistent across all four modes — the same blue follows you everywhere
- Projects can be archived (hidden but not deleted)

### Example projects
- **"Job Search"** → notes (interview prep), todos (application tasks), calendar (interview slots)
- **"Home Renovation"** → notes (plans/specs), todos (contractor tasks), calendar (appointments)
- **"Health"** → habits (exercise, sleep), todos (medical appointments to book), calendar (GP visits)

---

## Notes

### Structure
- Folder-organized with nesting (folder → subfolder → note)
- Default folder: **General** (uncategorized, no "Inbox" concept)
- Project folders created automatically when a Project is created
- Archive (soft delete — notes never permanently lost without confirmation)

### Editor — WYSIWYG Markdown
Notes are **stored internally as Markdown** (portable plain text, easy to sync/export)
but displayed in the editor as **live rendered rich text**. You type `**bold**` and it
immediately renders as **bold** — the syntax disappears. A raw-markdown toggle lets
power users view/edit the source directly.

This gives:
- Portability of Markdown (export to any tool, readable as plain text)
- Polish of a rich text editor (no syntax clutter while writing)
- Future-proof storage format (if the app dies, your notes are just `.md` files)

Supported formatting:
- Headings (H1–H3), bold, italic, strikethrough
- Bullet lists, numbered lists, checkboxes (renders as interactive toggles)
- Inline code, code blocks with syntax highlighting
- Blockquotes
- Horizontal rules
- Images (stored as attachments, referenced in Markdown)
- Links (to URLs and to other items via `@`)

### Linking
- Inline item embeds via `@` — link/embed any todo, habit, or calendar event in note body
- Note templates (e.g. "Weekly Review" with pre-filled headings)
- Pin notes within folders
- Word count / read time shown in editor toolbar
- Linked items panel per note — outgoing links
- Backlinks panel — what other items reference this note
- Tags (shared cross-type tag system — see Tags section)

### Future
- Table support
- Web clipper / web snipping
- Private / encrypted notes

---

## Todos

### Core View — Show Everything
The primary todo screen shows **all todos** across a folder/project, regardless of date.
Date is metadata, not an organizational axis. Users should see the full scope of a project
without filtering by when things are due.

### Structure
- Folder / project organized (project folders created automatically from Projects)
- Subtasks (one level deep initially; recursive later)
- Priority levels: P1–P4
- Due date + optional time
- Recurring todos (separate from habits — "pay rent monthly" is a todo, not a habit)
- Quick add from anywhere via FAB
- Pin todos within a project

### Views (user-switchable)
| View | Description |
|---|---|
| **List** (default) | All todos in the selected folder, no date filtering |
| **Timeline / Upcoming** | Chronological: Overdue / Today / This Week / Later |
| **Kanban** *(future)* | Column-based board view |

### Linking
- Link to notes, habits, calendar events
- Todos with due dates optionally shown as overlays on Calendar view

### Notifications
- Reminder at due date/time
- Optional lead-time reminders (e.g. 1 day before)
- Overdue badge on app icon

---

## Habits

### Structure
- Frequency: daily, specific days of week, X times per week/month
- Completion types:
  - Boolean (did it / didn't)
  - Quantity (ran X km, drank X glasses of water)
  - Timer (meditated for X minutes)
- **Habit stacking** — group habits into routines (morning / evening sequence)
- **Missed day grace** — option to allow 1 missed day without breaking streak

### Tracking
- Current streak + best streak per habit
- GitHub-style heatmap (year view + month zoom)
- Stats: completion rate over 7d / 30d / 90d / all-time
- Habits appear on Calendar as daily markers

### Linking
- Link habits to notes and todos
- Optionally assign habits to a Project
- Habits visible in Today view for daily check-in

---

## Calendar

The **primary calendar experience**, not a companion layer. This is where you interact with
your schedule day-to-day. External calendar services handle sharing and existing event history;
this app is where you live.

### Core Features
- **Views:** Month, Week (default), Day/Agenda
- **Full event creation/editing:** title, description, location, start/end time, all-day toggle, color, recurrence
- **Recurring events:** daily / weekly / monthly / yearly / custom (RRULE support)
- **Multiple calendar display:** show/hide individual calendars (Work, Personal, etc.) with their colors
- **Event invites:** view and respond to invitations (accept/decline) via CalDAV sync
- **Offline access:** all events stored locally, edits sync when connection available
- **Event search:** search across all synced events
- **Drag to reschedule** in week/day view
- **Color categories:** Project colors propagate here automatically; manual color assignment also supported

### Sync — CalDAV (open standard)

**CalDAV** is the open calendar protocol. One implementation in the app covers all providers:

| Provider | Notes |
|---|---|
| Google Calendar | CalDAV endpoint available |
| Apple iCloud Calendar | CalDAV endpoint available |
| Fastmail | CalDAV supported |
| Proton Calendar | CalDAV on paid plans |
| Nextcloud | CalDAV built in |
| Any self-hosted CalDAV server | Supported |

Multiple CalDAV accounts can be added simultaneously (e.g. work Google Calendar + personal Fastmail).
Deletions always require explicit user confirmation.

### Overlay Mode
- Toggle showing todos-with-due-dates on the calendar grid
- Toggle showing habit check-in status on the calendar grid
- Toggle showing Project color coding across all events
- Tap a day → bottom sheet: events + due todos + habit status for that day

### Linking
- Event detail shows linked notes / todos / habits
- Create a linked todo or note directly from an event detail screen
- Events can be assigned to a Project (applying project color category)

---

## Cross-Cutting Systems

### Universal Linking

Every item (note, todo, habit, event, folder, tag, project) has a UUID. A `links` table connects any two:

```
link(source_id, source_type, target_id, target_type, link_type)
link_types: REFERENCES | PARENT | BLOCKS | TRIGGERED_BY
```

Every detail screen includes:
- **Linked items** — outgoing links you created
- **Backlinks** — items that reference this one
- **Quick link button** — fuzzy search across all types to attach anything to anything

### Tags

A flat, cross-type tagging system. Tags cut across all four modes.

- Tag a note, todo, habit, and calendar event all with `#project-x`
- **Tag browser screen** shows all items of any type with that tag in one view
- Folders organize *within* a type; tags organize *across* types; Projects organize *across everything*
- Tags can have assigned colors
- Project creation auto-generates a matching tag (e.g. Project "Home Reno" → tag `#home-reno`)

### Notifications & Reminders

A unified reminder engine across all item types:
- Todos: reminder at due date/time, optional lead-time (1hr, 1 day before)
- Habits: daily reminder at user-set time per habit
- Calendar events: configurable lead-time (5min, 15min, 1hr, 1 day)
- Single settings page for all notification preferences

### General / Uncategorized

Each mode has a **General** folder as the default catch-all. No "Inbox" concept.
Items land in General unless the user specifies a folder/project at creation time.

---

## Design System

See [MOCKUPS.md](MOCKUPS.md) for visual wireframes of both design approaches.

### Two Design Options Under Consideration

**Option A — Material You (Android-first feel)**  
Built on Material 3, using Dynamic Color on Android. Card-heavy, elevated surfaces, large FAB,
strong use of color fills. Fastest to implement with Compose. Will feel somewhat "Android" to
iOS users, which is a known complaint about Material apps on iOS.

**Option B — Custom Design Language (recommended)**  
A distinctive visual identity built on Material 3 primitives but not slavishly Material.
Inspired by apps like Linear and Craft that feel premium everywhere without being native anywhere.
More information-dense, typographic hierarchy over card elevation, color as accent rather than fill.

### Platform Adaptation (applies to both options)

| Element | Android | iOS |
|---|---|---|
| Navigation | Material bottom nav | Tab bar (iOS-native feel) |
| Date/time pickers | Material | Native iOS pickers via `expect/actual` |
| Back gesture | System back | iOS swipe-back |
| Bottom sheets | Material | iOS-style sheets |
| Dialogs | Material dialogs | iOS-style alerts |
| Scroll physics | Android feel | iOS momentum scrolling |

### Theming
- Material You dynamic color on Android (API 31+)
- Static curated color themes on iOS and Web
- True dark mode with OLED-black option (Android)
- Per-mode accent tinting to aid orientation
- Project colors propagate consistently across all four modes

---

## Technical Architecture

### Stack

```
┌──────────────────────────────────────────────────────┐
│             Compose Multiplatform UI                 │
│          (Android / iOS / Web / Desktop)             │
├──────────────────────────────────────────────────────┤
│              Shared Domain Layer (KMP)               │
│    ViewModels · Use Cases · Repositories             │
├──────────────┬───────────────┬───────────────────────┤
│  SQLDelight  │     Ktor      │   Platform Impls      │
│  (local DB)  │ (sync / APIs) │  (notifications,      │
│              │               │   EventKit, IAP)      │
└──────────────┴───────────────┴───────────────────────┘
```

**Pattern:** MVI (unidirectional data flow) — clean fit for Compose's reactive model.

### Key Libraries

| Purpose | Library | Notes |
|---|---|---|
| Database | **SQLDelight** (Cash App) | KMP-first, type-safe SQL, reactive queries via Flow |
| Networking | **Ktor** (JetBrains) | KMP HTTP — Google Calendar API, Drive sync |
| Serialization | **kotlinx.serialization** | JetBrains, KMP-native |
| Date/Time | **kotlinx-datetime** | JetBrains, KMP-native |
| DI | **Koin** | Lightweight, KMP + Compose support |
| Navigation | **Decompose** (Arkivanov) | Best KMP navigation — lifecycle-aware, back stack across platforms |
| Settings/Prefs | **multiplatform-settings** (russhwolf) | Key-value storage across platforms |
| Rich Text Editor | **compose-richtext** (halilibo) | Compose-native, actively maintained |
| Markdown Rendering | **multiplatform-markdown-renderer** | KMP markdown → Compose |
| Image Loading | **Coil 3** | Fully KMP as of v3 |
| Calendar UI | **kizitonwose/Calendar** | Best maintained Compose calendar library |
| Heatmap / Charts | **Koalaplot** | KMP-compatible charting |
| Permissions | **MOKO Permissions** | KMP permissions |
| Logging | **Kermit** (TouchLab) | KMP structured logging |
| UUID | **uuid** (benasher44) | KMP UUID generation |
| IAP management | **RevenueCat** | Cross-platform purchase state, no custom backend needed |

---

## Account & Sync Architecture

### Core Principle: Identity ≠ Storage

The fundamental mistake to avoid: using a sync provider (Google, Dropbox) as the user's identity.
That creates ecosystem lock-in — "to use the web app, you need Google." Instead:

- **Identity** (who you are) → handled by a thin account backend (Supabase)
- **Storage** (where your data lives) → user's chosen sync backend, separate concern

A user can authenticate with email and password, sync data via Dropbox, and add their Fastmail
CalDAV account — no Google or Apple required anywhere in that flow.

### Account Backend — Supabase

[Supabase](https://supabase.com) is an open source Firebase alternative built on PostgreSQL.

**What it stores (per user account):**
- Profile (name, email, avatar)
- Encrypted sync backend credentials (Dropbox token, WebDAV URL+password, etc.)
- App settings and preferences
- Pro purchase status (verified via RevenueCat)

**What it does NOT store:** actual notes, todos, habits, or calendar data. That lives in the user's chosen storage backend.

**Why Supabase:**
- Open source and self-hostable — aligns with the app's ethos
- Free tier: 500MB database, **50,000 MAU**, full auth system included
- Supports email/password auth + optional OAuth via Google, GitHub, Apple (as convenient SSO, never required)
- PostgreSQL underneath — portable, not a proprietary format
- Production-grade, used by serious indie and mid-size products

### Calendar Sync — CalDAV (open standard)

**CalDAV** is the open calendar protocol. One integration in the app covers all providers:

| Provider | CalDAV support |
|---|---|
| Google Calendar | Yes |
| Apple iCloud Calendar | Yes |
| Fastmail | Yes |
| Proton Calendar | Yes (paid plans) |
| Nextcloud | Yes |
| Any self-hosted CalDAV server | Yes |

Multiple CalDAV accounts can be connected simultaneously (e.g. work Google Calendar + personal Fastmail).

**Which calendar do new events sync back to?**  
Each CalDAV account has a configurable **default calendar** for events created in the app
(e.g. "Personal" within a Google account). The event creation screen always shows a
**calendar picker** with all connected calendars colour-coded, so the user can override per event.
Setting: Sync → Calendars → "Default calendar for new events."

### App Data Sync — Pluggable Storage Backends

One active app data backend at a time (multiple would create conflicts). User selects and connects one:

| Backend | Protocol | Best for |
|---|---|---|
| **Nextcloud / ownCloud** | WebDAV | Self-hosters, privacy-first users |
| **Any WebDAV server** | WebDAV | NAS (Synology, QNAP), Koofr, Box, pCloud |
| **Dropbox** | Dropbox API | Cross-platform, reliable, good web support |
| **OneDrive** | Microsoft Graph API | Windows / Microsoft ecosystem |
| **S3-compatible** | S3 API | Backblaze B2, Cloudflare R2, Wasabi, MinIO |
| **Google Drive** | Drive API (`drive.appdata`) | Google ecosystem users |
| **iCloud** | CloudKit | iOS/Mac only |
| **Local export** | ZIP of Markdown + JSON | Manual backup, offline-only users |

WebDAV is the highest-leverage implementation — one protocol unlocks Nextcloud, Koofr, Box,
NAS devices, and many others simultaneously.

### Full Sync Flow

```
Local SQLDelight DB  (always source of truth, fully offline capable)
    │
    ├── Identity / settings
    │       Supabase (free tier) — auth, encrypted sync tokens, preferences, Pro status
    │
    ├── App data (notes, todos, habits)
    │       User-chosen backend: WebDAV / Dropbox / OneDrive / Google Drive / S3 / iCloud
    │       Credentials stored encrypted in Supabase account
    │
    └── Calendar events
            CalDAV — open standard, covers Google / Apple / Fastmail / Nextcloud / any
            Multiple CalDAV accounts supported simultaneously
```

### Conflict Resolution

Last-write-wins **per field**, not per record. Each field carries its own `updated_at` timestamp.
Editing a note's title on mobile and its body on web simultaneously preserves both changes.

### Pro Purchase

| Concern | Handled by |
|---|---|
| Pro purchase (Android) | Google Play IAP |
| Pro purchase (iOS) | App Store IAP |
| Cross-platform purchase state | RevenueCat → synced to Supabase user record |

---

## Monetization

### Model: Open Source + One-Time Pro Unlock

| Tier | Price | What's included |
|---|---|---|
| **Free** | £0 | Full Notes, Todos, Habits, Calendar — local only, single device |
| **Pro** | £15–20 one-time IAP | Google Drive sync, iCloud sync, multi-device, Projects, advanced features |

### Why This Works
- No server infrastructure = no per-user ongoing cost
- User pays Google/Apple for storage (they already have it)
- One-time IAP is a strong value proposition vs. any subscription competitor
- RevenueCat (free tier covers early stage) handles cross-platform purchase state
- Open source builds trust and community — the code being visible doesn't bypass IAP

### License
**AGPL v3** (GNU Affero General Public License v3):
- A proper OSI-approved open source license — the community will trust it and audit it freely
- Anyone can fork it, but their fork must also be AGPL (no proprietary forks)
- Anyone running it as a hosted service must also release their server-side source code
- IAP is platform-enforced (Apple/Google) regardless of license — AGPL doesn't undermine it
- Used by apps in exactly this space: Nextcloud, Bitwarden, Standard Notes, Joplin

No lawyer needed for standard OSI licenses — add an `AGPL-3.0` `LICENSE` file to the repo, done.
A lawyer becomes relevant only if adding a commercial dual-license tier later (e.g. offering
enterprises an exception to AGPL copyleft for a fee — a real revenue stream worth exploring eventually).

### Supporting Development
- Optional tip IAP (£2 / £5 / £10) for users who want to support ongoing work
- GitHub Sponsors as a parallel channel for open source contributors

### Future Subscription Consideration
If server-side features are added (real-time collaboration, shared projects, web clipper backend),
introduce an *optional* subscription **alongside** the existing Pro price — never replacing it.
Users who paid once keep everything they paid for.

---

## Web Presence & Hosting

### Architecture

The Compose for Web output is a **static bundle** (HTML + JavaScript + WebAssembly) — just files,
no server runtime needed. This keeps hosting essentially free.

```
Cloudflare Pages (or GitHub Pages)
    ├── /           → static marketing site (Astro recommended)
    └── /app/*      → Compose for Web WASM bundle (the actual app)

Supabase (free tier, hosted separately)
    └── Auth, user settings, encrypted sync tokens

User's chosen storage backend
    └── All actual notes/todos/habits data
```

**Total hosting cost: ~£0/month until meaningful scale (50k+ MAU on Supabase free tier).**

### Static Hosting — Cloudflare Pages (recommended) or GitHub Pages

Both are free and deploy directly from the GitHub repo.

**Cloudflare Pages** is slightly preferable:
- Faster global CDN (matters for WASM bundles which can be large)
- Handles large file sizes better than GitHub Pages
- Cloudflare Workers available if a small server-side function is ever needed
- Still deploys from GitHub automatically on push

**GitHub Pages** works fine and is simpler — start here if Cloudflare feels like extra setup.
Migrating later is trivial.

### Marketing Site

Served from the same static host at `/` (or a separate subdomain if preferred).
Recommended stack: **Astro** — fast, minimal, perfect for content sites, deploys as pure static HTML.

Content:
- Feature overview with screenshots / demo
- Pricing — Pro unlock, one-time £15–20, what's included
- Roadmap — public, linked to GitHub milestones
- Changelog
- Open source / GitHub link and contributor guide
- Login / sign up → `/app`

### Web App

Served from the same host at `/app`. User logs in via Supabase auth (email/password or
optional OAuth SSO). App then connects to their configured sync backend to load their data.
Functionally equivalent to the mobile app — same Compose Multiplatform codebase, same features.

### Why Not Firebase / AWS

- **Firebase** is Google — ironic given the app's ecosystem-neutral ethos. Firestore pricing
  also penalises read-heavy apps badly at scale.
- **AWS** is powerful but expensive, complex, and oriented toward enterprise scale. Not the
  right default for an indie product.
- **Supabase** gives everything Firebase offers with open source DNA, better pricing, and
  PostgreSQL portability. It's the right choice here.

---

## MVP Scope

### Phase 1 — Core (Android only)
- [ ] Notes: WYSIWYG Markdown editor, folders, General default, pin, archive
- [ ] Todos: folder/project list (show all, no date filter by default), subtasks, due dates, priority, timeline view as secondary
- [ ] Habits: boolean + quantity types, streaks, heatmap
- [ ] Today view: events + todos due today + habit check-ins + focus block
- [ ] Projects: cross-cutting containers with auto-provisioned folders + color + tag
- [ ] Tags: cross-type tagging with color, tag browser
- [ ] Notifications: unified reminder engine for todos, habits
- [ ] Linking system: universal IDs, link picker, linked items + backlinks panel
- [ ] Local storage only (SQLDelight)
- [ ] Material You theming + dark mode

### Phase 2 — Calendar + Sync
- [ ] Calendar: full primary experience (month/week/day, recurring events, invites, search, drag-reschedule)
- [ ] CalDAV calendar sync (covers Google Calendar, iCloud, Fastmail, Nextcloud, etc.)
- [ ] WebDAV app data sync (covers Nextcloud, Koofr, NAS devices, Box)
- [ ] Dropbox sync
- [ ] Google Drive sync (`drive.appdata` scope)
- [ ] Local ZIP export / import
- [ ] Recurring todos
- [ ] Kanban board view for todos

### Phase 3 — iOS + Web + Pro
- [ ] iOS via Compose Multiplatform
- [ ] Platform-adaptive UI elements (pickers, gestures, nav patterns)
- [ ] Web app (storage-provider OAuth auth, no custom backend)
- [ ] Product homepage (marketing site, roadmap, changelog)
- [ ] OneDrive sync
- [ ] S3-compatible storage sync (Backblaze B2, Cloudflare R2, etc.)
- [ ] Pro IAP unlock via RevenueCat

### Phase 4 — Polish & Power
- [ ] Android home screen widgets (habit streak, today todos, next event)
- [ ] Natural language date parsing ("next Friday at 3pm")
- [ ] Import: Todoist JSON, Google Keep JSON, Markdown files
- [ ] Focus / Pomodoro timer on todos
- [ ] Weekly review view
- [ ] Table support in notes

### Phase 5 — Future
- [ ] Dedicated desktop apps (macOS, Windows, Linux)
- [ ] Encryption at rest / in transit
- [ ] Private / password-protected notes
- [ ] Web clipper
- [ ] Developer API

---

## Open Questions / Decisions to Revisit

- **iOS UI strategy:** Full Compose Multiplatform UI (faster to build, less native feel) vs. SwiftUI
  shell sharing only KMP business logic (most work, best iOS feel). Start with CMP — the gap is
  closing fast and it's the right default unless iOS feel becomes a blocker.
- **Collaboration:** Shared todos/projects between users requires a server. Defer until Pro userbase
  justifies the infrastructure cost. When added, this would be the trigger for an optional subscription.
- **App name:** TBD. Shortlist: Cadence, Helm, Folio, Ordo, Meridian. Update README badge URLs and `projectName` in deploy-web.yml when decided.
- **License:** AGPL v3 (settled).

---

## Technical Decisions — Reference

### Android SDK Versions
The KMP wizard generated these values in `gradle/libs.versions.toml` — already set correctly:
```toml
android-compileSdk = "36"
android-minSdk = "24"      # Android 7.0 — covers ~99% of active devices
android-targetSdk = "36"
```
Material You dynamic colour (`DynamicColors.applyToActivitiesIfAvailable()`) gracefully applies
only on API 31+ — older devices get the static theme automatically, no conditional logic needed.

### UI Layout Strategy — Adaptive Compose
Use Compose Multiplatform for all targets (Android, iOS, Web, Desktop). Do NOT create a
separate React frontend — adaptive layouts in Compose handle the difference:

| Screen size | Navigation | Layout |
|---|---|---|
| Phone (Compact) | Bottom navigation bar | Single column |
| Tablet / Web (Medium) | Navigation Rail (left sidebar) | Two-column panels |
| Desktop (Expanded) | Navigation Drawer (persistent sidebar) | Three-column / master-detail |

`WindowSizeClass` drives this — one codebase, genuinely different layouts per screen size.

### Naming — What Can Be Changed Later
| Thing | Rename easy? | Notes |
|---|---|---|
| GitHub repo name | Yes | GitHub auto-redirects old URLs |
| Supabase project name | Yes | URL changes, update one config constant |
| App display name | Yes | Just a string in configs |
| Android package ID | **No** | Permanent once on Play Store. Choose carefully. |
| iOS bundle ID | **No** | Permanent once on App Store. Choose carefully. |

Use a real name for package ID from the start (e.g. `com.yourname.cadence`), even if the
repo and everything else is still called `life-admin-app`.

---

## Project Setup Checklist

Tasks to complete after generating the KMP project. Not all need to be done immediately —
grouped by when they're needed.

### Day 1 — Before Pushing to GitHub

See [LOCAL_DEV.md](LOCAL_DEV.md) for the full Codespaces + JetBrains Gateway setup guide.

- [x] **KMP project generated** — `dev.chasecondon.lifeadmin`, all targets included
- [x] **Docs moved** to `docs/` folder
- [x] **`.devcontainer/`** created (devcontainer.json + setup.sh)
- [x] **GitHub Actions workflows** created (ci.yml + deploy-web.yml)

- [ ] **Create GitHub repository** (public — it's open source)
  - Add `LICENSE` file: paste [AGPL-3.0 text](https://www.gnu.org/licenses/agpl-3.0.txt)
  - Initial commit and push (ensure `.devcontainer/` is included)

- [ ] **Create Codespace** — GitHub repo → Code → Codespaces → Create on main
  - Set machine type to **4-core / 16GB** in Codespace settings
  - Wait for first build (~10 min), verify it completes without errors

- [ ] **Connect JetBrains Gateway** on both machines (see LOCAL_DEV.md)

- [ ] **Connect VS Code** to Codespace on both machines for Claude Code terminal

- [ ] **Verify Android build** runs from Codespace:
  ```bash
  ./gradlew :composeApp:assembleDebug
  ```

- [ ] **Verify web build** runs from Codespace:
  ```bash
  ./gradlew :composeApp:wasmJsBrowserDistribution
  ```

### GitHub Actions — Add These Workflow Files

**`.github/workflows/ci.yml`** — runs on every pull request:
```yaml
name: CI
on:
  pull_request:
  push:
    branches: [main]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-java@v4
        with:
          java-version: '17'
          distribution: 'temurin'
      - name: Cache Gradle
        uses: actions/cache@v4
        with:
          path: |
            ~/.gradle/caches
            ~/.gradle/wrapper
          key: gradle-${{ hashFiles('**/*.gradle.kts') }}
      - run: ./gradlew test
      - run: ./gradlew lint
      - run: ./gradlew assembleDebug
```

**`.github/workflows/deploy-web.yml`** — builds in GitHub Actions, deploys to Cloudflare Pages:
```yaml
name: Deploy Web
on:
  push:
    branches: [main]
  pull_request:       # PR deploys get a unique preview URL from Cloudflare
jobs:
  deploy:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      deployments: write
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-java@v4
        with:
          java-version: '17'
          distribution: 'temurin'
      - name: Cache Gradle
        uses: actions/cache@v4
        with:
          path: |
            ~/.gradle/caches
            ~/.gradle/wrapper
          key: gradle-${{ hashFiles('**/*.gradle.kts') }}
      - run: ./gradlew wasmJsBrowserDistribution
      - uses: cloudflare/pages-action@v1
        with:
          apiToken: ${{ secrets.CLOUDFLARE_API_TOKEN }}
          accountId: ${{ secrets.CLOUDFLARE_ACCOUNT_ID }}
          projectName: life-admin-app        # your Cloudflare Pages project name
          directory: composeApp/build/dist/wasmJs/productionExecutable
          gitHubToken: ${{ secrets.GITHUB_TOKEN }}   # enables PR preview URL comments
```

**Required secrets** (add in GitHub repo → Settings → Secrets):
- `CLOUDFLARE_API_TOKEN` — create in Cloudflare dashboard → My Profile → API Tokens
- `CLOUDFLARE_ACCOUNT_ID` — found in Cloudflare dashboard right sidebar

**First-time Cloudflare setup:**
1. Cloudflare dashboard → Pages → Create application → **Direct Upload** (not Git integration —
   GitHub Actions handles the Git side)
2. Create project named `life-admin-app` (or your app name)
3. Get Account ID and create API token with "Cloudflare Pages — Edit" permissions
4. Add both as GitHub secrets

All CI/CD logic stays in GitHub Actions. Cloudflare is just the CDN/hosting target.
PR preview URLs are posted automatically as comments on pull requests.

### Supabase Setup (needed before implementing auth/sync)

- [ ] Create account at [supabase.com](https://supabase.com)
- [ ] New project — choose a region close to your primary users (Europe West for UK)
- [ ] In SQL Editor, run the schema:

```sql
create table profiles (
  id uuid references auth.users primary key,
  display_name text,
  avatar_url text,
  pro_status boolean default false,
  updated_at timestamptz default now()
);

create table sync_configs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users not null,
  backend_type text not null,
  encrypted_credentials jsonb not null,
  created_at timestamptz default now()
);

create table app_settings (
  user_id uuid references auth.users primary key,
  settings jsonb default '{}',
  updated_at timestamptz default now()
);

alter table profiles enable row level security;
alter table sync_configs enable row level security;
alter table app_settings enable row level security;

create policy "own profile" on profiles for all using (auth.uid() = id);
create policy "own sync configs" on sync_configs for all using (auth.uid() = user_id);
create policy "own settings" on app_settings for all using (auth.uid() = user_id);
```

- [ ] Authentication → Email sign-in: confirm enabled
- [ ] Optionally enable GitHub OAuth (Settings → Auth → Providers)
- [ ] Settings → API → copy and save:
  - **Project URL** (e.g. `https://xxxx.supabase.co`)
  - **anon/public key**
  - Store these as constants in the app (not in source control — use a local `.env` or secrets file)

### RevenueCat Setup (needed before shipping Pro — Phase 3)

- [ ] Create account at [revenuecat.com](https://revenuecat.com)
- [ ] Connect Google Play Console developer account
- [ ] Connect App Store Connect account
- [ ] Define Pro product as a **non-consumable one-time purchase**
- [ ] Set up webhook: RevenueCat → Supabase Edge Function → update `profiles.pro_status = true`
- [ ] Save RevenueCat API keys

### Dev Tools — Adopt Early

| Tool | Type | Install | When |
|---|---|---|---|
| **IntelliJ IDEA Ultimate** | Desktop app (IDE) | JetBrains Toolbox (have subscription) | Day 1 — Codespace backend via Gateway |
| **JetBrains Gateway** | Desktop app | JetBrains Toolbox | Day 1 — connects to Codespace |
| **Scrcpy** | CLI / desktop | `brew install scrcpy` (Mac) · `winget install Genymobile.scrcpy` (Windows) | Day 1 — mirror S23 Ultra on desktop |
| **ktlint** | CLI + CI step | Pre-installed in devcontainer · binary in CI | Phase 1 — code style enforcement |
| **LeakCanary** | Gradle dependency | `debugImplementation "com.squareup.leakcanary:leakcanary-android:..."` | Phase 1 — memory leak detection |
| **detekt** | Gradle plugin + CI step | `id("io.gitlab.arturbosch.detekt")` in build.gradle | Phase 1 — static analysis |
| **Bruno** | Desktop app | [usebruno.com](https://usebruno.com) | Phase 2 — test CalDAV/WebDAV/Supabase APIs |
| **Figma** | Web app + desktop app | [figma.com](https://figma.com) | Phase 2 — proper UI mockups |
| **Sentry** | SDK dependency + web dashboard | `implementation "io.sentry:sentry-kotlin-multiplatform:..."` | Phase 3 — error tracking |
| **GitHub Projects** | Web app (github.com) | Built into GitHub repo | Ongoing — issue & milestone tracking |

**IDE strategy:**
- Use **IntelliJ IDEA Ultimate** as the primary IDE (via JetBrains Gateway → Codespace)
- It handles all KMP targets better than Android Studio for a multi-target project
- Android Studio can still be used locally for Android-specific work if preferred
- Both can open the same project

**AI assistant strategy:**
- **JetBrains AI** (with Claude models configured in settings): inline completion, fix-this-error, generate unit test, commit message — fast, IDE-integrated tasks
- **Claude Code**: architecture decisions, multi-file feature implementation, debugging complex issues, anything requiring reasoning across the whole codebase

---

### Cloudflare Pages (alternative to GitHub Pages — do when deploying web)

- [ ] Create account at [cloudflare.com](https://cloudflare.com) (free)
- [ ] Pages → Create application → Connect to Git → select repo
- [ ] Build settings:
  - Build command: `./gradlew wasmJsBrowserDistribution`
  - Output directory: `composeApp/build/dist/wasmJs/productionExecutable`
- [ ] Deploys automatically on every push to `main`
- [ ] PR preview URLs enabled by default
