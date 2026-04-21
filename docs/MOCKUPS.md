# UI Mockups — Wireframes

ASCII wireframes for key screens in both design directions.
These are layout and hierarchy references, not final pixel designs.

---

## Design Language Comparison

### Option A — Material You
Card-heavy, elevated surfaces, FAB, rounded containers, strong color fills.
Fast to implement with Compose. Will feel "Android" to some iOS users.
Material 3 dynamic color works beautifully on Android API 31+.

### Option B — Custom Design Language (recommended)
No cards — flat rows with typographic hierarchy. Color as accent (left stripe, dot,
icon tint) rather than fill. More information-dense. Distinctive enough to feel
"this app" rather than "another Material app." Comparable to Linear, Craft, Bear.

---

## Screen 1: Today View

### Material You
```
┌─────────────────────────────────────────┐
│  ≡  Good morning                   🔍  │  ← top app bar, dynamic color surface
│     Saturday, 19 April                  │
│                                         │
│  ╭─────────────────────────────────╮    │  ← tonal card (primary container)
│  │  ✦  Focus today                 │    │
│  │                                 │    │
│  │  Design the onboarding flow  ○  │    │
│  ╰─────────────────────────────────╯    │
│                                         │
│  ╭─────────────────────────────────╮    │  ← secondary card
│  │  📅  Today's schedule           │    │
│  │  ───────────────────────────    │    │
│  │  ●  9:00   Team standup        │    │  ● = calendar color dot
│  │  ●  11:00  Doctor appointment  │    │
│  │  ●  14:00  Design review       │    │
│  ╰─────────────────────────────────╯    │
│                                         │
│  ╭─────────────────────────────────╮    │
│  │  ☑  Due today                  │    │
│  │  ───────────────────────────    │    │
│  │  ○  Review Q2 OKRs      [P1]  │    │
│  │  ○  Call dentist   [overdue]  │    │  [overdue] = red pill
│  │  ○  Buy groceries       [P3]  │    │
│  ╰─────────────────────────────────╯    │
│                                         │
│  ╭─────────────────────────────────╮    │
│  │  ◈  Habits                     │    │
│  │  ───────────────────────────    │    │
│  │  ✓  Exercise           🔥 12   │    │
│  │  ○  Read                🔥  5  │    │
│  │  ○  Meditate            🔥  0  │    │
│  ╰─────────────────────────────────╯    │
│                              ╭────╮     │
│                              │ +  │     │  ← FAB, bottom right
│                              ╰────╯     │
├─────────────────────────────────────────┤
│  🏠 Today  📝 Notes  ☑ Todos  ◈  📅   │  ← Material bottom nav
└─────────────────────────────────────────┘
```

### Custom Design Language
```
┌─────────────────────────────────────────┐
│  Today                             🔍  │  ← minimal header, no background fill
│  Saturday, 19 April                     │
├─────────────────────────────────────────┤
│                                         │
│  FOCUS                                  │  ← small caps label
│  ▍  Design the onboarding flow     ○   │  ← left accent stripe, inline check
│                                         │
├─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─┤  ← subtle divider, not full line
│                                         │
│  CALENDAR                               │
│  ▍  9:00   Team standup   [Work]       │  ← stripe color = calendar color
│  ▍  11:00  Doctor appt    [Health]     │
│  ▍  14:00  Design review  [Work]       │
│                                         │
├─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─┤
│                                         │
│  TODOS                                  │
│  ○  Review Q2 OKRs              P1     │
│  ○  Call dentist            overdue    │  ← "overdue" in red, no pill
│  ○  Buy groceries               P3     │
│                                         │
├─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─┤
│                                         │
│  HABITS                                 │
│  ✓  Exercise                    🔥 12  │
│  ○  Read                        🔥  5  │
│  ○  Meditate                    🔥  0  │
│                                         │
└─────────────────────────────────────────┘
  Today   Notes   Todos   Habits   Cal    ← tab bar (plainer than Material nav)
```

**Key differences visible here:**
- Material: cards create visual "chunks", FAB floats over content, nav has icons+labels inside pill
- Custom: dividers create rhythm, left stripe conveys color/category, nav is minimal, denser info

---

## Screen 2: Todos — List View (All todos, no date filter)

### Material You
```
┌─────────────────────────────────────────┐
│  ←  Home Renovation              ⋮  🔍 │
│                                         │
│  ╭─ All ──╮ ╭─ Active ─╮ ╭─ Done ──╮  │  ← filter chips
│  ╰────────╯ ╰──────────╯ ╰─────────╯  │
│                                         │
│  ╭─────────────────────────────────╮    │
│  │  ○  Get contractor quotes  [P1] │    │
│  │     Due 25 Apr · 3 subtasks     │    │
│  ╰─────────────────────────────────╯    │
│  ╭─────────────────────────────────╮    │
│  │  ○  Order kitchen tiles    [P2] │    │
│  │     Due 30 Apr · no subtasks    │    │
│  ╰─────────────────────────────────╯    │
│  ╭─────────────────────────────────╮    │
│  │  ○  Book structural survey [P1] │    │
│  │     Due 22 Apr · overdue        │    │  ← overdue shown as metadata
│  ╰─────────────────────────────────╯    │
│  ╭─────────────────────────────────╮    │
│  │  ○  Paint colour samples   [P3] │    │
│  │     No due date                 │    │  ← no date = not buried
│  ╰─────────────────────────────────╯    │
│  ╭─────────────────────────────────╮    │
│  │  ○  Measure kitchen units  [P2] │    │
│  │     No due date                 │    │
│  ╰─────────────────────────────────╯    │
│                                         │
│                              ╭────╮     │
│                              │ +  │     │
│                              ╰────╯     │
├─────────────────────────────────────────┤
│  🏠 Today  📝 Notes  ☑ Todos  ◈  📅   │
└─────────────────────────────────────────┘
```

### Custom Design Language
```
┌─────────────────────────────────────────┐
│  ←  Home Renovation        List  ⋮  🔍 │  ← "List" shows current view
│  All · Active · Done                    │  ← plain text tabs, not chips
├─────────────────────────────────────────┤
│                                         │
│  ○  Get contractor quotes               │
│     P1 · Due 25 Apr · 3 subtasks       │  ← metadata line below title
│                                         │
│  ○  Book structural survey              │
│     P1 · Due 22 Apr · overdue          │  ← overdue in red inline
│                                         │
│  ○  Order kitchen tiles                 │
│     P2 · Due 30 Apr                    │
│                                         │
│  ○  Measure kitchen units               │
│     P2 · No date                       │  ← no date, not hidden or deprioritised
│                                         │
│  ○  Paint colour samples                │
│     P3 · No date                       │
│                                         │
│  ○  Agree payment schedule              │
│     P1 · No date                       │
│                                         │
│  + Add todo                             │  ← inline add, no FAB required
│                                         │
└─────────────────────────────────────────┘
  Today   Notes   Todos   Habits   Cal
```

**Key difference:** No date-based grouping in either design. All todos visible, due date is just
metadata shown on the row. User sees the full scope of the project at a glance.

---

## Screen 3: Calendar — Week View

### Material You
```
┌─────────────────────────────────────────┐
│  ←  April 2026                    ⋮    │
│                                         │
│  Mo  Tu  We  Th  Fr  Sa  Su            │
│  13  14  15  16  17 [18] 19            │  [18] = selected/today
│                                         │
│       8  ───────────────────────────   │
│          │ Team standup          │      │  ← work calendar (blue)
│       9  │ 9:00 – 9:30           │      │
│          ╰───────────────────────╯      │
│      10  ───────────────────────────   │
│      11  ╭───────────────────────╮     │
│          │ Doctor appt           │      │  ← health calendar (green)
│      12  │ 11:00 – 12:00         │      │
│          ╰───────────────────────╯      │
│      13  ───────────────────────────   │
│      14  ╭───────────────────────╮     │
│          │ Design review         │      │  ← work calendar (blue)
│      15  │ 14:00 – 15:30         │      │
│          ╰───────────────────────╯      │
│      16  ───────────────────────────   │
│      17  ───────────────────────────   │
│                              ╭────╮    │
│                              │ +  │    │
│                              ╰────╯    │
├─────────────────────────────────────────┤
│  🏠 Today  📝 Notes  ☑ Todos  ◈  📅   │
└─────────────────────────────────────────┘
```

### Custom Design Language
```
┌─────────────────────────────────────────┐
│  April 2026                       ⋮    │
│  Week  Month  Day                       │  ← plain text view switcher
├─────────────────────────────────────────┤
│  Mo  Tu  We  Th  Fr  Sa  Su            │
│  13  14  15  16  17  18  19            │
│                           ↑ today      │
├─────────────────────────────────────────┤
│                                         │
│   8  ─────────────────────────────     │
│   9  ▍ Team standup  9:00–9:30         │  ← left stripe = calendar color
│      ─────────────────────────────     │
│  10                                     │
│  11  ▍ Doctor appt  11:00–12:00        │  ← different color stripe
│  12  ▍                                 │
│      ─────────────────────────────     │
│  13                                     │
│  14  ▍ Design review  14:00–15:30      │
│  15  ▍                                 │
│      ─────────────────────────────     │
│  16                                     │
│  17  ○ Pay rent  [todo overlay]        │  ← todo with due date shown as overlay
│                                         │
│  + New event                            │
└─────────────────────────────────────────┘
  Today   Notes   Todos   Habits   Cal
```

---

## Screen 4: Notes — Editor

### Material You
```
┌─────────────────────────────────────────┐
│  ←  Home Renovation notes        ⋮  ✓ │
│                                         │
│  ╭─────────────────────────────────╮    │
│  │  B  I  S  H1  H2  ⁝  @  •  ≡  │    │  ← formatting toolbar, Material style
│  ╰─────────────────────────────────╯    │
│                                         │
│  Kitchen plan                           │  ← H1 rendered, no # visible
│  ─────────────────────────────────     │
│                                         │
│  Measurements confirmed by surveyor.    │
│  Need to finalise tile choice before    │
│  contractor visit.                      │
│                                         │
│  ## Tile options                        │  ← H2 rendered
│                                         │
│  - Porcelain 60×60 (preferred)          │  ← list rendered
│  - Ceramic 30×30 (budget option)        │
│                                         │
│  ╭─────────────────────────────────╮    │  ← linked todo inline embed
│  │  ☑ Order kitchen tiles    [P2]  │    │
│  │  Home Renovation · Due 30 Apr   │    │
│  ╰─────────────────────────────────╯    │
│                                         │
│  ─────────────────────────────────     │
│  Linked items (2)  ›  Backlinks (1) ›  │
└─────────────────────────────────────────┘
```

### Custom Design Language
```
┌─────────────────────────────────────────┐
│  ←  Home Renovation notes      ⋮  ✓   │
├─────────────────────────────────────────┤
│  B  I  S  H1  H2  @  —  •  ≡  ···     │  ← minimal toolbar, no card
├─────────────────────────────────────────┤
│                                         │
│  Kitchen plan                           │  ← H1: larger weight, no # shown
│                                         │
│  Measurements confirmed by surveyor.    │
│  Need to finalise tile choice before    │
│  contractor visit.                      │
│                                         │
│  Tile options                           │  ← H2: medium weight
│                                         │
│  ·  Porcelain 60×60 (preferred)        │  ← rendered bullet
│  ·  Ceramic 30×30 (budget option)      │
│                                         │
│  ▍ Order kitchen tiles · P2 · 30 Apr   │  ← linked todo, left stripe style
│                                         │
│  ─────────────────────────────────     │
│  2 linked items  ·  1 backlink          │
│                                         │
└─────────────────────────────────────────┘
  Today   Notes   Todos   Habits   Cal
```

---

## Screen 5: Projects — Hub View

This screen is the same conceptually for both design languages.
Shown in Custom style:

```
┌─────────────────────────────────────────┐
│  ←  Home Renovation              ⋮     │
│  ▍  [project color strip across top]   │
├─────────────────────────────────────────┤
│  Notes  Todos  Habits  Events  All      │  ← filter tabs
├─────────────────────────────────────────┤
│                                         │
│  📝  NOTES                              │
│  Kitchen plan               19 Apr      │
│  Contractor notes           15 Apr      │
│                                         │
│  ☑  TODOS                              │
│  ○  Get contractor quotes   P1  25 Apr  │
│  ○  Book structural survey  P1  overdue │
│  ○  Order kitchen tiles     P2  30 Apr  │
│  ✓  Initial measurements        done   │
│                                         │
│  📅  UPCOMING                           │
│  ▍  Contractor visit  Mon 21 Apr 10:00  │
│  ▍  Survey appt       Wed 23 Apr 14:00  │
│                                         │
│  ◈  HABITS                              │
│  ○  Morning run              🔥 12     │  ← assigned to this project
│  ✓  Evening stretch          🔥  4     │  ← inline check-in from hub
│                                         │
└─────────────────────────────────────────┘
  Today   Notes   Todos   Habits   Cal
```

---

## Screen 6: Habits Dashboard

### Custom Design Language
```
┌─────────────────────────────────────────┐
│  Habits                         ⋮  +   │
├─────────────────────────────────────────┤
│  Today: Sat 19 Apr · 1 of 3 done       │
├─────────────────────────────────────────┤
│                                         │
│  MORNING                                │  ← habit stack group
│                                         │
│  ✓  Exercise                    🔥 12  │
│     Daily · done                        │
│                                         │
│  ○  Meditate                    🔥  0  │
│     Daily · tap to check in            │  ← tap anywhere on row
│                                         │
│  ○  Cold shower                 🔥  3  │
│     Daily · tap to check in            │
│                                         │
├─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─┤
│                                         │
│  EVENING                                │
│                                         │
│  ○  Read                        🔥  5  │
│     Daily · tap to check in            │
│                                         │
│  ○  Journal                     🔥  1  │
│     Daily · tap to check in            │
│                                         │
└─────────────────────────────────────────┘
  Today   Notes   Todos   Habits   Cal
```

### Habit Detail (heatmap view)
```
┌─────────────────────────────────────────┐
│  ←  Exercise                      ⋮   │
├─────────────────────────────────────────┤
│  🔥 12 day streak  ·  Best: 34 days    │
│  87% last 30 days  ·  91% last 90 days  │
├─────────────────────────────────────────┤
│                                         │
│  Jan ▁▁▃▅▅▇▇█▇▅▃▃▅▇█▇▅▃▁▁▃▅▅▇▇█▇▅▃  │  ← heatmap row
│  Feb ▃▅▇█▇▅▃▁▁▃▅▇▇█▇▅▃▁▁▁▃▅▇▇█▇▅       │
│  Mar ▁▁▃▅▅▇▇█▇▅▃▃▅▇█▇▅▃▁▁▃▅▅▇▇█▇▅▃▁  │
│  Apr ▅▇▇█▇▅▃▁▁▃▅▅▇▇█▇▅▃▁                │
│                                         │
│  (tap any cell for that day's detail)   │
│                                         │
├─────────────────────────────────────────┤
│                                         │
│  RECENT                                 │
│  ✓  Sat 19 Apr                         │
│  ✗  Fri 18 Apr                         │
│  ✓  Thu 17 Apr                         │
│  ✓  Wed 16 Apr                         │
│                                         │
└─────────────────────────────────────────┘
```

---

## Navigation: Project Access Pattern

Projects are accessible from any mode without leaving it:

```
┌─────────────────────────────────────────┐
│  Todos                     [Projects ▾] │  ← dropdown/sheet trigger in header
├─────────────────────────────────────────┤
│                                         │
│  All projects                      +   │
│                                         │
│  ▍ Home Renovation     4 todos         │  ← colored left stripe per project
│  ▍ Job Search          7 todos         │
│  ▍ Health              2 todos         │
│  ── General            5 todos         │  ← General has no color stripe
│                                         │
└─────────────────────────────────────────┘
```

Tapping a project navigates into that project's todo list.
The same sheet appears in Notes (showing note counts) and in Calendar (as a filter).

---

## Summary: Which Design Direction?

| | Material You | Custom Language |
|---|---|---|
| Build speed | Faster (built-in components) | Slower (more custom work) |
| Android feel | Native, excellent | Premium, distinctive |
| iOS feel | Feels "Android" to some users | Platform-neutral, accepted |
| Information density | Lower (card padding) | Higher (flat rows) |
| Visual identity | Generic Material | Distinctive, ownable |
| Differentiation | Low | High |

**Recommendation:** Start with Material You for Phase 1 (Android only) to ship faster.
Migrate toward the custom design language in Phase 3 when building iOS — that's the phase
where platform-feel actually matters to real users.

---

## Screen 7: Settings

Settings structure is the same conceptually for both design languages. Shown in Custom style.

### Settings Home
```
┌─────────────────────────────────────────┐
│  ←  Settings                            │
├─────────────────────────────────────────┤
│                                         │
│  ╭──────────────────────────────────╮   │
│  │  Chase Condon                    │   │  ← account card at top
│  │  chase@email.com  ·  Pro  ✓     │   │
│  ╰──────────────────────────────────╯   │
│                                         │
│  Account                           ›   │
│  Sync                              ›   │
│  Notifications                     ›   │
│  Appearance                        ›   │
│  About & open source               ›   │
│                                         │
└─────────────────────────────────────────┘
```

### Settings → Sync
```
┌─────────────────────────────────────────┐
│  ←  Sync                                │
├─────────────────────────────────────────┤
│                                         │
│  APP DATA                               │
│  Notes, Todos, Habits                   │
│                                         │
│  ▍ Dropbox                             │
│     chase@email.com                     │
│     Last synced: 2 minutes ago          │
│     [Sync now]  [Change]  [Disconnect]  │
│                                         │
├─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─┤
│                                         │
│  CALENDARS (CalDAV)                     │
│                                         │
│  [●]  Work                              │
│       Google Calendar · via CalDAV      │  ← colour dot = calendar colour
│       Default for new events  ✓        │
│                                [···]   │
│                                         │
│  [●]  Personal                          │
│       Fastmail · via CalDAV             │
│                                [···]   │
│                                         │
│  + Add calendar account                 │
│                                         │
├─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─┤
│                                         │
│  LOCAL BACKUP                           │
│  Export all data as ZIP    [Export]     │
│                                         │
└─────────────────────────────────────────┘
```

### Add App Data Sync Backend (sheet)
```
┌─────────────────────────────────────────┐
│  Choose sync backend              ✕    │
├─────────────────────────────────────────┤
│                                         │
│  ○  Dropbox                            │
│  ○  Google Drive                       │
│  ○  OneDrive                           │
│  ○  WebDAV  (Nextcloud, Koofr, NAS…)  │
│  ○  S3-compatible  (B2, R2, Wasabi…)  │
│  ○  iCloud  (iOS/Mac only)             │
│                                         │
│  Each option stores data in your own   │
│  account. We never see your files.     │
│                                         │
└─────────────────────────────────────────┘
```

### Add Calendar Account (sheet)
```
┌─────────────────────────────────────────┐
│  Add calendar account             ✕    │
├─────────────────────────────────────────┤
│                                         │
│  Server URL                            │
│  ┌──────────────────────────────────┐  │
│  │  https://caldav.example.com      │  │
│  └──────────────────────────────────┘  │
│                                         │
│  Username                              │
│  ┌──────────────────────────────────┐  │
│  │                                  │  │
│  └──────────────────────────────────┘  │
│                                         │
│  Password / app-specific password      │
│  ┌──────────────────────────────────┐  │
│  │  ••••••••••                      │  │
│  └──────────────────────────────────┘  │
│                                         │
│  Common providers:                      │
│  [Google]  [iCloud]  [Fastmail]         │
│  (pre-fills known CalDAV URLs)          │
│                                         │
│                  [Test & Connect]       │
└─────────────────────────────────────────┘
```

Note: "Common providers" buttons just pre-fill the known CalDAV URL for that service — the
user still provides their own credentials. No proprietary API dependency.
