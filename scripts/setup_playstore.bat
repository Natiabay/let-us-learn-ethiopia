@echo off
echo ========================================
echo Tourist Assistive App - Play Store Setup
echo ========================================
echo.

echo [1/5] Setting up API keys for production...
echo Please enter your API keys when prompted:
echo.

set /p OPENAI_API_KEY="Enter OpenAI API Key: "
set /p GOOGLE_CLOUD_API_KEY="Enter Google Cloud API Key: "
set /p GOOGLE_MAPS_API_KEY="Enter Google Maps API Key: "
set /p TELEBIRR_API_KEY="Enter Telebirr API Key: "
set /p SANTIMPAY_API_KEY="Enter SantimPay API Key: "
set /p GOOGLE_TRANSLATE_API_KEY="Enter Google Translate API Key: "

echo.
echo [2/5] Creating environment configuration...
echo OPENAI_API_KEY=%OPENAI_API_KEY% > .env
echo GOOGLE_CLOUD_API_KEY=%GOOGLE_CLOUD_API_KEY% >> .env
echo GOOGLE_MAPS_API_KEY=%GOOGLE_MAPS_API_KEY% >> .env
echo TELEBIRR_API_KEY=%TELEBIRR_API_KEY% >> .env
echo SANTIMPAY_API_KEY=%SANTIMPAY_API_KEY% >> .env
echo GOOGLE_TRANSLATE_API_KEY=%GOOGLE_TRANSLATE_API_KEY% >> .env

echo.
echo [3/5] Building release APK...
flutter clean
flutter pub get
flutter build apk --release

echo.
echo [4/5] Building App Bundle for Play Store...
flutter build appbundle --release

echo.
echo [5/5] Play Store optimization complete!
echo.
echo Generated files:
echo - build/app/outputs/flutter-apk/app-release.apk
echo - build/app/outputs/bundle/release/app-release.aab
echo.
echo Next steps:
echo 1. Upload app-release.aab to Google Play Console
echo 2. Fill in store listing details
echo 3. Add screenshots and app icon
echo 4. Set up pricing and distribution
echo 5. Submit for review
echo.
echo Press any key to exit...
pause > nul































