#!/bin/bash
set -e

# Download and setup Flutter
curl -fL https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.22.2-stable.tar.xz -o flutter.tar.xz
tar -xf flutter.tar.xz
rm flutter.tar.xz

# Add Flutter to PATH
export PATH="$PATH:$(pwd)/flutter/bin"

# Fix Git ownership issues
git config --global --add safe.directory $(pwd)/flutter

# Configure Flutter
flutter config --no-analytics

# Get dependencies
flutter pub get

# Build web app
flutter build web --release --base-href /
