#!/bin/bash

# Simple Flutter web deployment script for Vercel
echo "Starting Flutter web build..."

# Install dependencies
flutter pub get

# Build for web
flutter build web --release

echo "Build completed successfully!"
