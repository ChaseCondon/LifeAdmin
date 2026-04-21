#!/bin/bash
set -e

echo "==> Setting up LifeAdmin KMP environment..."

# Accept all Android SDK licenses
yes | sdkmanager --licenses > /dev/null 2>&1 || true

# Install required Android SDK components
echo "==> Installing Android SDK components..."
sdkmanager \
  "platform-tools" \
  "cmdline-tools;latest" \
  "platforms;android-36" \
  "build-tools;35.0.0" \
  > /dev/null

echo "==> Android SDK ready."

# Make gradlew executable
if [ -f "./gradlew" ]; then
  chmod +x ./gradlew

  # Pre-download Gradle wrapper
  ./gradlew --version --quiet

  # Pre-warm dependency cache in background so first build is faster
  echo "==> Pre-warming Gradle dependency cache (background)..."
  ./gradlew :composeApp:dependencies --quiet > /dev/null 2>&1 &
fi

# Install ktlint for code formatting checks
echo "==> Installing ktlint..."
curl -sSLO https://github.com/pinterest/ktlint/releases/latest/download/ktlint \
  && chmod +x ktlint \
  && sudo mv ktlint /usr/local/bin/

echo "==> Dev environment ready."
echo ""
echo "Useful commands:"
echo "  ./gradlew :composeApp:assembleDebug          — build Android debug APK"
echo "  ./gradlew :composeApp:testDebugUnitTest       — run Android unit tests"
echo "  ./gradlew :composeApp:wasmJsBrowserDistribution — build web bundle"
echo "  ./gradlew :composeApp:jvmRun                 — run desktop app"
echo "  ./gradlew :composeApp:jvmTest                — run desktop/common tests"
echo "  ktlint --format '**/*.kt'                    — format Kotlin files"
