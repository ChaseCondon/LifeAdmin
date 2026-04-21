# Local Development Guide

This project uses **GitHub Codespaces** as the primary development environment, allowing seamless
switching between machines without committing in-progress work. All building, Gradle, and
compilation runs in the Codespace. IDE UIs run locally via JetBrains Gateway.

---

## How It Works

```
Windows Desktop  ──┐
                   ├── JetBrains Gateway ──→  GitHub Codespace  (code + builds live here)
MacBook Air M1  ───┘
                   └── VS Code (Codespace) ──→  same Codespace  (Claude Code terminal)
```

Both connections see the same filesystem. Uncommitted changes persist in the Codespace between
sessions. Close on one machine, open on another — everything is exactly where you left it.

---

## One-Time Setup

### 1. Create the Codespace

1. Go to the GitHub repo → green **Code** button → **Codespaces** tab
2. Click **Create codespace on main**
3. First build takes ~10 minutes (installs Android SDK, pre-warms Gradle)
4. Subsequent starts take ~30 seconds

> **Recommended specs:** In Codespace settings, set machine type to **4-core / 16GB RAM**.
> KMP + Gradle builds are memory-hungry. The default 2-core/8GB will be slow.

### 2. JetBrains Gateway — Install on Each Machine

Download and install **JetBrains Gateway** from the [JetBrains Toolbox](https://www.jetbrains.com/toolbox-app/)
(it's included, or install Gateway standalone).

**First connection (do this on each machine):**
1. Open JetBrains Gateway
2. Sign in to GitHub when prompted
3. Under **Codespaces**, find your `LifeAdmin` Codespace
4. Click **Connect** → choose **IntelliJ IDEA Ultimate** as the IDE
5. Gateway installs the IntelliJ backend inside the Codespace (first time: ~5 minutes)
6. The IntelliJ window opens — this is your dev IDE running against the Codespace

**Subsequent connections:** Open Gateway → click the Codespace → it opens immediately.

### 3. VS Code — Connect for Claude Code

VS Code has native Codespaces support. This runs alongside Gateway simultaneously — VS Code
is your Claude Code terminal, IntelliJ is your dev IDE.

1. Install VS Code if not already installed
2. Install the **GitHub Codespaces** extension (`GitHub.codespaces`) in VS Code
3. Open Command Palette (`Cmd/Ctrl+Shift+P`) → `Codespaces: Connect to Codespace`
4. Select your LifeAdmin Codespace
5. VS Code opens a window connected to the same Codespace
6. Open the integrated terminal — this shell runs inside the Codespace
7. Run `claude` in that terminal to start Claude Code with full access to the project

**Both Gateway (IntelliJ) and VS Code can be open simultaneously** — they share the same
Codespace filesystem. IntelliJ for writing code, VS Code terminal for Claude Code.

---

## Daily Workflow

**Starting a session:**
1. Open JetBrains Gateway → connect to Codespace → IntelliJ opens
2. Open VS Code → connect to same Codespace → run `claude` in terminal
3. Work as normal — the Codespace persists all changes

**Switching machines:**
1. Close Gateway and VS Code on the current machine (no commit needed)
2. Open Gateway on the other machine → connect to same Codespace
3. Everything is exactly where you left it

**Stopping when done:**
- Just close the windows. The Codespace stays running for ~30 minutes of inactivity then
  suspends automatically (data is preserved).
- Or: explicitly stop it in GitHub → Codespaces dashboard to avoid burning free hours.

---

## Running on Android Emulator

> **Emulators cannot run inside the Codespace** (no GPU/KVM support). Run them locally.

### Setup (one-time per machine)

**MacBook:**
1. Open Android Studio (local install, not via Gateway)
2. Device Manager → Create Device → choose Pixel 8 Pro
3. System Image: **ARM 64** (required for M1 — x86 images won't run on Apple Silicon)
4. Finish and start the emulator

**Windows Desktop:**
1. Open Android Studio (local install)
2. Device Manager → Create Device → choose Pixel 8 Pro
3. System Image: **x86_64** (use the most recent API 36 image)
4. Enable Hyper-V in Windows Features if prompted (better than HAXM for modern Windows)
5. Finish and start the emulator

### Running the app on a local emulator

When working via JetBrains Gateway, the IDE backend is in the Codespace but the build target
(APK) needs to reach your local emulator. Two options:

**Option A — Build in Codespace, install manually (simplest):**
```bash
# In Codespace terminal (VS Code or Gateway terminal)
./gradlew :composeApp:assembleDebug

# The APK is at:
# composeApp/build/outputs/apk/debug/composeApp-debug.apk
# Gateway makes this file accessible locally — drag to emulator or:
adb install composeApp/build/outputs/apk/debug/composeApp-debug.apk
```

**Option B — Configure ADB port forwarding through Gateway:**
JetBrains Gateway can forward local ADB connections to the Codespace. In IntelliJ (via Gateway):
1. Go to **Settings → Build, Execution, Deployment → Android SDK**
2. Verify the SDK path is detected
3. In the **Device Manager** panel, local emulators may appear if ADB forwarding is active
4. If not detected: run `adb start-server` locally and `adb devices` to confirm the emulator
   is visible, then reconnect Gateway

This is finicky — Option A is more reliable for now.

---

## Running on iOS Simulator

> **iOS simulator is MacBook only.** Xcode requires macOS; the Codespace is Linux.

### Setup (MacBook only, one-time)

1. Xcode must be installed and opened at least once
2. Accept Xcode license: `sudo xcodebuild -license accept`
3. Install iOS simulators via Xcode → Settings → Platforms → iOS

### Running the iOS app

iOS builds cannot run from the Codespace. For iOS work:

**Option A — Local Android Studio on Mac:**
1. Open Android Studio locally (not via Gateway) with the project checked out locally
2. Select an iOS Simulator target in the run configuration
3. Build and run — Android Studio invokes the KMP iOS framework + Xcode

**Option B — Xcode directly:**
1. Open `iosApp/iosApp.xcodeproj` in Xcode
2. Select a simulator in the toolbar
3. Run — Xcode builds the KMP framework as part of the build

**Keeping local code in sync with Codespace:**
Since iOS work is local, you need to pull Codespace changes before building iOS:
```bash
# On MacBook terminal (not in Codespace)
cd ~/path/to/LifeAdmin
git pull origin main    # or your working branch
```
Commit and push from Codespace when you want to pick up those changes locally.

---

## Running on Physical Devices

### Galaxy S23 Ultra (Android)

#### Setup — Enable Wireless Debugging (one-time)

1. On the S23 Ultra: **Settings → About Phone** → tap Build Number 7 times
2. **Settings → Developer Options** → enable **USB Debugging** and **Wireless Debugging**
3. Tap **Wireless Debugging** → **Pair device with pairing code**

#### Connect via Wi-Fi (same network as dev machine)

```bash
# On your dev machine (local terminal or Codespace terminal)
# Step 1: Pair (one-time per device/network)
adb pair <device-ip>:<pairing-port>
# Enter the pairing code shown on the phone

# Step 2: Connect
adb connect <device-ip>:5555

# Verify
adb devices
```

The IP and port are shown in **Developer Options → Wireless Debugging**.

> **From Codespace:** Direct wireless ADB from Codespace to your phone won't work unless
> both are on the same network. The easiest solution is to build the APK in the Codespace and
> install it via the phone or via a locally-running `adb` session.
>
> **With Tailscale (advanced):** Install Tailscale on the S23 Ultra and the Codespace.
> They appear on the same virtual network, enabling `adb connect <tailscale-ip>:5555` from
> the Codespace directly.

#### Install APK from Codespace build

```bash
# Build in Codespace
./gradlew :composeApp:assembleDebug

# Copy APK to local machine (Gateway makes Codespace files accessible)
# Then install locally:
adb install -r composeApp/build/outputs/apk/debug/composeApp-debug.apk
```

### iPad Pro (iOS)

iOS device testing requires the MacBook with Xcode.

#### Setup (one-time)

1. On iPad: **Settings → Privacy & Security → Developer Mode** → enable
2. Connect iPad to MacBook via USB
3. Open Xcode → trust the device when prompted
4. For wireless: **Window → Devices and Simulators** → select iPad → **Connect via Network**

#### Run on iPad

1. In Xcode or Android Studio (local on Mac), select the iPad as the run target
2. Build and run — the app installs wirelessly after initial USB pairing

---

## Web App (Dev Server)

The web app can be run as a dev server directly in the Codespace. The port is forwarded
automatically to your local browser.

```bash
# In Codespace terminal
./gradlew :composeApp:wasmJsBrowserDevelopmentRun --continuous

# Gateway / VS Code Codespaces will show a notification:
# "Port 8080 is now available" → click "Open in Browser"
# Or manually open: http://localhost:8080
```

The `--continuous` flag enables hot reload — Compose Hot Reload is included in the project,
so UI changes reflect in the browser without a full rebuild.

---

## Useful Gradle Commands

```bash
# Build
./gradlew :composeApp:assembleDebug              # Android debug APK
./gradlew :composeApp:assembleRelease            # Android release APK
./gradlew :composeApp:wasmJsBrowserDistribution  # Web production bundle
./gradlew :composeApp:jvmRun                     # Run desktop app (needs local display)

# Test
./gradlew :composeApp:testDebugUnitTest          # Android unit tests
./gradlew :composeApp:jvmTest                    # Desktop / common tests

# Dev server
./gradlew :composeApp:wasmJsBrowserDevelopmentRun --continuous  # Web with hot reload

# Clean
./gradlew clean

# Check all
./gradlew build
```

---

## Codespace Management

```bash
# List your Codespaces (in any terminal with gh CLI)
gh codespace list

# SSH into Codespace directly (alternative to Gateway)
gh codespace ssh --codespace <name>

# Stop a Codespace to preserve free hours
gh codespace stop --codespace <name>
```

Codespace usage is free for GitHub personal accounts up to 60 hours/month on 2-core,
or 30 hours/month on 4-core. Upgrade to GitHub Pro (~$4/month) for 90 hours on 4-core.
