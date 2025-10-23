@echo off
echo 🚀 Tourist Assistant Ethiopia - Automated Deployment Script
echo ============================================================
echo.

REM Check if Flutter is installed
flutter --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Flutter is not installed or not in PATH
    pause
    exit /b 1
)

echo ✅ Flutter detected
echo.

REM Clean and get dependencies
echo 🧹 Cleaning project...
flutter clean
echo.

echo 📦 Getting dependencies...
flutter pub get
echo.

REM Build for all platforms
echo 🔨 Building releases...
echo.

echo 📱 Building Android APK...
flutter build apk --release --build-name=1.0.0 --build-number=1
if errorlevel 1 (
    echo ❌ Android APK build failed
    pause
    exit /b 1
)
echo ✅ Android APK built successfully

echo.
echo 📱 Building Android App Bundle...
flutter build appbundle --release --build-name=1.0.0 --build-number=1
if errorlevel 1 (
    echo ❌ Android App Bundle build failed
    pause
    exit /b 1
)
echo ✅ Android App Bundle built successfully

echo.
echo 🌐 Building Web...
flutter build web --release
if errorlevel 1 (
    echo ❌ Web build failed
    pause
    exit /b 1
)
echo ✅ Web build completed successfully

echo.
echo 🎉 All builds completed successfully!
echo.
echo 📁 Build outputs:
echo    APK: build\app\outputs\flutter-apk\app-release.apk
echo    AAB: build\app\outputs\bundle\release\app-release.aab
echo    Web: build\web\
echo.
echo 🚀 Ready for deployment!
echo.
pause




























