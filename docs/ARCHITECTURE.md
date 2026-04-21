# Architecture

LifeAdmin is a **Kotlin Multiplatform** project using **Compose Multiplatform** for shared UI
across Android, iOS, Web (WebAssembly), and Desktop (JVM).

---

## Project Structure

```
LifeAdmin/
├── composeApp/                  # The single shared module
│   └── src/
│       ├── commonMain/          # Shared code — all platforms
│       │   └── kotlin/dev/chasecondon/lifeadmin/
│       ├── androidMain/         # Android-specific implementations
│       ├── iosMain/             # iOS-specific implementations
│       ├── jvmMain/             # Desktop (JVM) entry point + implementations
│       ├── wasmJsMain/          # Web (WebAssembly) implementations
│       └── commonTest/          # Shared tests
├── iosApp/                      # Xcode project — iOS entry point
│   └── iosApp/
│       ├── ContentView.swift    # SwiftUI wrapper for Compose UI
│       └── iOSApp.swift         # App entry point
├── docs/                        # Project documentation
├── .devcontainer/               # GitHub Codespaces configuration
├── .github/workflows/           # CI/CD pipelines
└── gradle/
    └── libs.versions.toml       # Centralised dependency version catalogue
```

---

## Module Layout

There is a single Gradle module: `:composeApp`.

All platform targets (Android, iOS, Web, Desktop) are configured within this module.
Shared business logic and UI live in `commonMain`. Platform-specific code (APIs, entry
points, platform implementations of `expect`/`actual` declarations) lives in the
corresponding platform source sets.

### Source Sets

| Source set | Compiled for | Typical content |
|---|---|---|
| `commonMain` | All platforms | Business logic, ViewModels, shared UI composables, `expect` declarations |
| `androidMain` | Android | `MainActivity`, Android-specific `actual` implementations |
| `iosMain` | iOS | `MainViewController`, iOS-specific `actual` implementations |
| `jvmMain` | Desktop | `main.kt` entry point, desktop `actual` implementations |
| `wasmJsMain` | Web (WASM) | Web `actual` implementations |
| `commonTest` | All platforms | Shared unit tests |

---

## Planned Architecture

The domain layer will follow **MVI (Model-View-Intent)** with a clean separation:

```
UI Layer (Compose)
    ↓ Intent / Events
ViewModel (shared in commonMain)
    ↓ Use Cases
Domain Layer (pure Kotlin, no platform deps)
    ↓ Repositories (interfaces)
Data Layer
    ├── Local:  SQLDelight (commonMain)
    └── Remote: Ktor (sync backends, CalDAV, Supabase)
```

### Key Libraries (planned)

| Library | Role |
|---|---|
| SQLDelight | Local database — type-safe SQL, reactive queries via Flow |
| Ktor | HTTP client — sync backends, CalDAV, Supabase auth |
| Koin | Dependency injection |
| Decompose | Navigation + lifecycle management across platforms |
| kotlinx-datetime | Date/time handling (KMP-native) |
| kotlinx.serialization | JSON serialisation for sync payloads |

---

## Platform Targets

### Android
- Entry: `androidMain/kotlin/.../MainActivity.kt`
- Min SDK: 24 (Android 7.0)
- Compile/Target SDK: 36
- Material You dynamic colour via `DynamicColors.applyToActivitiesIfAvailable()`

### iOS
- Entry: `iosApp/iosApp/iOSApp.swift` → `ContentView.swift` → `MainViewController` (Kotlin)
- Targets: `iosArm64` (physical devices), `iosSimulatorArm64` (simulator)
- Build via Xcode or Android Studio on macOS only

### Web
- Entry: `wasmJsMain` compiled to WebAssembly
- Renders via Compose to a browser `<canvas>` element
- Build: `./gradlew :composeApp:wasmJsBrowserDistribution`
- Dev server: `./gradlew :composeApp:wasmJsBrowserDevelopmentRun --continuous`

### Desktop (JVM)
- Entry: `jvmMain/kotlin/.../main.kt`
- Build: `./gradlew :composeApp:jvmRun`
- Packaged distributions: DMG (macOS), MSI (Windows), DEB (Linux)

---

## Adaptive Layout Strategy

The same Compose code renders across all screen sizes using `WindowSizeClass`:

| Screen size | Navigation | Layout pattern |
|---|---|---|
| Compact (phone) | Bottom navigation bar | Single column |
| Medium (tablet / web) | Navigation Rail | Two-column panels |
| Expanded (desktop) | Navigation Drawer (persistent) | Three-column / master-detail |

---

## Data Model

Every item (note, todo, habit, calendar event, tag, project) has a UUID. A universal `links`
table connects any two items:

```sql
CREATE TABLE link (
    source_id   TEXT NOT NULL,
    source_type TEXT NOT NULL,  -- NOTE | TODO | HABIT | EVENT | PROJECT | TAG
    target_id   TEXT NOT NULL,
    target_type TEXT NOT NULL,
    link_type   TEXT NOT NULL,  -- REFERENCES | PARENT | BLOCKS | TRIGGERED_BY
    created_at  INTEGER NOT NULL
);
```

This enables the backlinks system — any item can show what references it without requiring
the referencing item to store a list of its targets.

---

## Sync Architecture

```
Local SQLDelight DB  (source of truth — always offline-capable)
    │
    ├── App data (notes, todos, habits)
    │       → user-chosen backend via pluggable SyncProvider interface
    │         (WebDAV, Dropbox, Google Drive, OneDrive, S3, iCloud)
    │
    └── Calendar events
            → CalDAV (open standard — covers Google, Apple, Fastmail, Nextcloud, any)
```

Sync backend credentials are stored encrypted in the user's Supabase account, not locally.
Conflict resolution is last-write-wins per field (each field has its own `updated_at`).

---

## Further Reading

- [docs/PLAN.md](PLAN.md) — full product plan and feature spec
- [docs/LOCAL_DEV.md](LOCAL_DEV.md) — how to build and run locally
- [docs/MOCKUPS.md](MOCKUPS.md) — UI wireframes
