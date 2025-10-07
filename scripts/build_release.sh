#!/bin/bash

# Tourist Assistant Ethiopia - Release Build Script
# This script builds the app for production deployment

echo "🇪🇹 Building Tourist Assistant Ethiopia for Release..."

# Clean previous builds
echo "🧹 Cleaning previous builds..."
flutter clean
flutter pub get

echo "✅ Dependencies installed"

# Run tests
echo "🧪 Running tests..."
flutter test
if [ $? -ne 0 ]; then
    echo "❌ Tests failed. Please fix before building release."
    exit 1
fi

echo "✅ All tests passed"

# Build Android APK
echo "🤖 Building Android APK..."
flutter build apk --release --target-platform android-arm64

if [ $? -eq 0 ]; then
    echo "✅ Android APK built successfully"
    echo "📱 APK location: build/app/outputs/flutter-apk/app-release.apk"
else
    echo "❌ Android APK build failed"
    exit 1
fi

# Build Android App Bundle (for Play Store)
echo "📦 Building Android App Bundle..."
flutter build appbundle --release --target-platform android-arm64

if [ $? -eq 0 ]; then
    echo "✅ Android App Bundle built successfully"
    echo "📱 AAB location: build/app/outputs/bundle/release/app-release.aab"
else
    echo "❌ Android App Bundle build failed"
    exit 1
fi

# Build iOS (if on macOS)
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "🍎 Building iOS app..."
    flutter build ios --release --no-codesign
    
    if [ $? -eq 0 ]; then
        echo "✅ iOS app built successfully"
        echo "📱 iOS build location: build/ios/Release-iphoneos/Runner.app"
    else
        echo "❌ iOS build failed"
        exit 1
    fi
else
    echo "ℹ️ Skipping iOS build (not on macOS)"
fi

# Build Web version
echo "🌐 Building Web version..."
flutter build web --release

if [ $? -eq 0 ]; then
    echo "✅ Web version built successfully"
    echo "🌐 Web build location: build/web/"
else
    echo "❌ Web build failed"
    exit 1
fi

echo ""
echo "🎉 Build completed successfully!"
echo ""
echo "📦 Release artifacts:"
echo "   Android APK: build/app/outputs/flutter-apk/app-release.apk"
echo "   Android AAB: build/app/outputs/bundle/release/app-release.aab"
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "   iOS app: build/ios/Release-iphoneos/Runner.app"
fi
echo "   Web: build/web/"
echo ""
echo "🚀 Ready for deployment!"
echo "   - Upload AAB to Google Play Console"
echo "   - Archive iOS app in Xcode and upload to App Store Connect"
echo "   - Deploy web version to hosting platform"
echo ""
echo "📋 Next steps:"
echo "   1. Test release builds on physical devices"
echo "   2. Upload to respective app stores"
echo "   3. Fill out store metadata and descriptions"
echo "   4. Submit for review"




















