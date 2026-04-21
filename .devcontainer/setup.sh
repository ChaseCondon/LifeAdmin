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

# Install ktlint
echo "==> Installing ktlint..."
curl -sSLO https://github.com/pinterest/ktlint/releases/latest/download/ktlint \
  && chmod +x ktlint \
  && sudo mv ktlint /usr/local/bin/

# Install Supabase CLI
echo "==> Installing Supabase CLI..."
SUPABASE_VERSION=$(curl -s https://api.github.com/repos/supabase/cli/releases/latest | grep '"tag_name"' | cut -d'"' -f4 | tr -d 'v')
curl -sL "https://github.com/supabase/cli/releases/latest/download/supabase_linux_amd64.tar.gz" \
  | sudo tar -xz -C /usr/local/bin supabase

# Install Wrangler (Cloudflare Pages/Workers CLI)
echo "==> Installing Wrangler..."
npm install -g wrangler --silent

# Configure Claude Code MCP servers if secrets are available
echo "==> Configuring Claude Code MCP..."
mkdir -p ~/.claude

# Build MCP config — PAT enables Supabase Management API access
# Service role keys used for Supabase CLI operations
cat > ~/.claude/settings.json << 'SETTINGS_EOF'
{
  "mcpServers": {
    "supabase-staging": {
      "command": "npx",
      "args": [
        "-y", "@supabase/mcp-server-supabase@latest",
        "--supabase-url", "https://lmcyvcwmyxmqzivycqyt.supabase.co",
        "--service-role-key", "SUPABASE_SERVICE_ROLE_STAGING_PLACEHOLDER"
      ]
    },
    "supabase-production": {
      "command": "npx",
      "args": [
        "-y", "@supabase/mcp-server-supabase@latest",
        "--supabase-url", "https://cfahazxllrykcrjfecsk.supabase.co",
        "--service-role-key", "SUPABASE_SERVICE_ROLE_PROD_PLACEHOLDER",
        "--read-only"
      ]
    }
  }
}
SETTINGS_EOF

# Substitute real secrets from Codespace environment if available
if [ -n "$SUPABASE_SERVICE_ROLE_STAGING" ]; then
  sed -i "s/SUPABASE_SERVICE_ROLE_STAGING_PLACEHOLDER/$SUPABASE_SERVICE_ROLE_STAGING/" ~/.claude/settings.json
fi
if [ -n "$SUPABASE_SERVICE_ROLE_PROD" ]; then
  sed -i "s/SUPABASE_SERVICE_ROLE_PROD_PLACEHOLDER/$SUPABASE_SERVICE_ROLE_PROD/" ~/.claude/settings.json
fi

echo "==> Dev environment ready."
echo ""
echo "Useful commands:"
echo "  ./gradlew :composeApp:assembleDebug               — build Android debug APK"
echo "  ./gradlew :composeApp:testDebugUnitTest            — run Android unit tests"
echo "  ./gradlew :composeApp:wasmJsBrowserDistribution   — build web bundle"
echo "  ./gradlew :composeApp:jvmRun                      — run desktop app"
echo "  ./gradlew :composeApp:jvmTest                     — run desktop/common tests"
echo "  ktlint --format '**/*.kt'                         — format Kotlin files"
echo "  supabase --help                                   — Supabase CLI"
echo "  wrangler --help                                   — Cloudflare Wrangler CLI"
