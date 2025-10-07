#!/bin/bash
set -e

echo "Building Flutter web app for Vercel..."

# Get dependencies
flutter pub get

# Build web app
flutter build web --release

echo "Build completed! Output in build/web/"
