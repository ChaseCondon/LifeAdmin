<div align="center">

# LifeAdmin

**Notes · Todos · Habits · Calendar — unified, linked, yours.**

[![CI](https://github.com/ChaseCondon/LifeAdmin/actions/workflows/ci.yml/badge.svg)](https://github.com/ChaseCondon/LifeAdmin/actions/workflows/ci.yml)
[![License: AGPL v3](https://img.shields.io/badge/License-AGPL%20v3-blue.svg)](LICENSE)
[![Kotlin](https://img.shields.io/badge/Kotlin-2.3-purple?logo=kotlin&logoColor=white)](https://kotlinlang.org)
[![Compose Multiplatform](https://img.shields.io/badge/Compose%20Multiplatform-1.10-brightgreen?logo=jetpackcompose&logoColor=white)](https://www.jetbrains.com/compose-multiplatform/)

[![Android](https://img.shields.io/badge/Android-3DDC84?logo=android&logoColor=white)](#)
[![iOS](https://img.shields.io/badge/iOS-000000?logo=apple&logoColor=white)](#)
[![Web](https://img.shields.io/badge/Web-4285F4?logo=googlechrome&logoColor=white)](#)
[![Desktop](https://img.shields.io/badge/Desktop-0078D6?logo=windows11&logoColor=white)](#)

</div>

---

LifeAdmin is an open source, local-first life organisation app for Android, iOS, Web, and Desktop. It combines notes, todos, habits, and a full calendar into a single coherent experience — with deep cross-linking between them, provider-agnostic sync, and no mandatory subscription.

> **Status:** Early development. Not yet available on app stores.

---

## Features

### Four modes, deeply linked

| Mode | Highlights |
|---|---|
| **Notes** | WYSIWYG Markdown editor, folder-organised, inline embeds of todos/events via `@`, backlinks |
| **Todos** | Show everything by default (no date-forced grouping), subtasks, P1–P4 priority, timeline view |
| **Habits** | Boolean, quantity, and timer tracking; streaks; GitHub-style heatmap; habit stacking |
| **Calendar** | Primary calendar experience; CalDAV sync (Google, Fastmail, Nextcloud, any server); week/month/day views; recurring events |

### Projects — cross-cutting containers

Create a Project (e.g. "Home Renovation") and it automatically provisions a folder in Notes, a folder in Todos, a calendar colour category, and a shared tag — all linked, all the same colour.

### Sync — your data, your storage

No proprietary cloud required. Connect your own:

- **WebDAV** — Nextcloud, ownCloud, Koofr, NAS devices
- **Dropbox**
- **Google Drive**
- **OneDrive**
- **S3-compatible** — Backblaze B2, Cloudflare R2, Wasabi
- **iCloud** (iOS/macOS)
- **Local export** — ZIP of Markdown + JSON

Calendar sync uses **CalDAV** — one integration covers Google Calendar, Apple Calendar, Fastmail, Proton, Nextcloud, and any self-hosted CalDAV server.

### Privacy first

- Local-first: the app is fully functional offline
- Your notes never touch our servers — sync goes directly to your chosen storage
- Open source under AGPL v3 — auditable, forkable, community-maintained

---

## Getting Started

### Prerequisites

- [Android Studio](https://developer.android.com/studio) or [IntelliJ IDEA Ultimate](https://www.jetbrains.com/idea/)
- JDK 17+
- For iOS: macOS with Xcode installed
- Run `kdoctor` to verify your environment: `brew install kdoctor && kdoctor`

### Clone and build

```bash
git clone https://github.com/ChaseCondon/LifeAdmin.git
cd LifeAdmin

# Android
./gradlew :composeApp:assembleDebug

# Web (dev server with hot reload)
./gradlew :composeApp:wasmJsBrowserDevelopmentRun --continuous

# Desktop
./gradlew :composeApp:jvmRun
```

For the full local development setup — including Codespaces, JetBrains Gateway, physical device testing, and iOS simulator — see **[docs/LOCAL_DEV.md](docs/LOCAL_DEV.md)**.

---

## Documentation

| Doc | Description |
|---|---|
| [docs/PLAN.md](docs/PLAN.md) | Full product plan — features, architecture, sync strategy, monetisation, roadmap |
| [docs/MOCKUPS.md](docs/MOCKUPS.md) | UI wireframes for key screens in both design directions |
| [docs/LOCAL_DEV.md](docs/LOCAL_DEV.md) | Local dev guide — Codespaces, emulators, physical devices |
| [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) | Project structure, module layout, source sets |

---

## Tech Stack

- **[Kotlin Multiplatform](https://kotlinlang.org/docs/multiplatform.html)** — shared business logic across all platforms
- **[Compose Multiplatform](https://www.jetbrains.com/compose-multiplatform/)** — shared UI across Android, iOS, Web, Desktop
- **[SQLDelight](https://cashapp.github.io/sqldelight/)** — local database *(planned)*
- **[Ktor](https://ktor.io)** — networking for sync backends *(planned)*
- **[Koin](https://insert-koin.io)** — dependency injection *(planned)*
- **[Decompose](https://arkivanov.github.io/Decompose/)** — navigation *(planned)*
- **[Supabase](https://supabase.com)** — auth and user settings backend

---

## Roadmap

**Phase 1 — Core (Android)**  
Notes · Todos · Habits · Today view · Projects · Tags · Linking system · Local storage

**Phase 2 — Calendar + Sync**  
Full calendar (CalDAV) · WebDAV sync · Dropbox sync · Google Drive sync

**Phase 3 — iOS + Web + Pro**  
iOS app · Web app · Product homepage · Pro one-time unlock

**Phase 4 — Polish**  
Widgets · Natural language dates · Import · Weekly review · Tables

See [docs/PLAN.md](docs/PLAN.md) for full detail on each phase.

---

## Contributing

Contributions are welcome. Please read [docs/LOCAL_DEV.md](docs/LOCAL_DEV.md) to set up your environment, then open an issue or pull request.

All contributions must be licensed under AGPL v3.

---

## License

LifeAdmin is licensed under the **GNU Affero General Public License v3.0**.

You are free to use, study, modify, and distribute this software. If you run a modified version as a network service, you must also release your source code under the same licence.

See [LICENSE](LICENSE) for the full text.
