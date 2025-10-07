#!/bin/bash

echo "========================================"
echo "  Building Flutter Web App for Vercel"
echo "========================================"
echo

echo "Step 1: Cleaning previous build..."
flutter clean

echo
echo "Step 2: Getting dependencies..."
flutter pub get

echo
echo "Step 3: Building web app..."
flutter build web --release

if [ $? -ne 0 ]; then
    echo
    echo "❌ Build failed! Please check the errors above."
    exit 1
fi

echo
echo "✅ Build completed successfully!"
echo
echo "Your Flutter web app is now built in the 'build/web' folder."
echo
echo "Next steps:"
echo "1. Commit and push the build/web folder to GitHub"
echo "2. Deploy to Vercel (it will use the pre-built files)"
echo
echo "Vercel Settings:"
echo "- Framework Preset: Other"
echo "- Build Command: (leave empty)"
echo "- Install Command: (leave empty)"
echo "- Output Directory: build/web"
echo
