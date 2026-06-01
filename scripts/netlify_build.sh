#!/usr/bin/env bash
set -euo pipefail

echo "=== Starting Netlify Flutter build ==="

# Where to install Flutter
FLUTTER_DIR="$HOME/flutter"

# Clone Flutter SDK (stable channel) if not already present
if [ ! -d "$FLUTTER_DIR" ]; then
  echo "Cloning Flutter SDK (this may take a minute)..."
  git clone --depth 1 https://github.com/flutter/flutter.git -b stable "$FLUTTER_DIR"
else
  echo "Flutter SDK already present, updating..."
  cd "$FLUTTER_DIR"
  git pull --ff-only || true
  cd - > /dev/null
fi

# Add Flutter to PATH
export PATH="$FLUTTER_DIR/bin:$PATH"

# Show Flutter version
echo "Flutter version:"
flutter --version

# Enable web support
echo "Enabling web support..."
flutter config --enable-web

# Precache web artifacts (speeds up builds)
echo "Precaching web artifacts..."
flutter precache --web

# Get dependencies
echo "Running flutter pub get..."
flutter pub get

# Build the web app
echo "Building Flutter web app..."
flutter build web --release

echo "=== Flutter web build completed successfully ==="
