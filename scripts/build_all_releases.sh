#!/bin/bash

# Tourist Assistant Ethiopia - Automated Deployment Script
echo "🚀 Tourist Assistant Ethiopia - Automated Deployment Script"
echo "============================================================"
echo

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed or not in PATH"
    exit 1
fi

echo "✅ Flutter detected"
echo

# Clean and get dependencies
echo "🧹 Cleaning project..."
flutter clean
echo

echo "📦 Getting dependencies..."
flutter pub get
echo

# Build for all platforms
echo "🔨 Building releases..."
echo

echo "📱 Building Android APK..."
if flutter build apk --release --build-name=1.0.0 --build-number=1; then
    echo "✅ Android APK built successfully"
else
    echo "❌ Android APK build failed"
    exit 1
fi

echo
echo "📱 Building Android App Bundle..."
if flutter build appbundle --release --build-name=1.0.0 --build-number=1; then
    echo "✅ Android App Bundle built successfully"
else
    echo "❌ Android App Bundle build failed"
    exit 1
fi

echo
echo "🌐 Building Web..."
if flutter build web --release; then
    echo "✅ Web build completed successfully"
else
    echo "❌ Web build failed"
    exit 1
fi

echo
echo "🎉 All builds completed successfully!"
echo
echo "📁 Build outputs:"
echo "   APK: build/app/outputs/flutter-apk/app-release.apk"
echo "   AAB: build/app/outputs/bundle/release/app-release.aab"  
echo "   Web: build/web/"
echo
echo "🚀 Ready for deployment!"
echo























