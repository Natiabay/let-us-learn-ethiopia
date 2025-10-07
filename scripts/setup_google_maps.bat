@echo off
echo ========================================
echo   Google Maps API Setup for Tourist App
echo ========================================
echo.

echo This script will help you configure Google Maps API keys.
echo.

echo Step 1: Create Google Cloud Project
echo -----------------------------------
echo 1. Go to: https://console.cloud.google.com/
echo 2. Create a new project or select existing one
echo 3. Enable billing for the project
echo.
pause

echo Step 2: Enable Required APIs
echo -----------------------------
echo Enable these APIs in Google Cloud Console:
echo - Maps JavaScript API (for web)
echo - Maps SDK for Android (for Android)
echo - Maps SDK for iOS (for iOS)
echo - Places API (for location search)
echo - Geocoding API (for address conversion)
echo - Directions API (for navigation)
echo.
echo Go to: APIs & Services > Library
echo.
pause

echo Step 3: Create API Keys
echo ----------------------
echo Create these API keys in Google Cloud Console:
echo.
echo For Web:
echo - Go to APIs & Services > Credentials
echo - Create Credentials > API Key
echo - Name: "Web Maps API Key"
echo - Restrict to HTTP referrers: localhost:*, 127.0.0.1:*
echo.
echo For Android:
echo - Create another API key
echo - Name: "Android Maps API Key"
echo - Restrict to Android apps
echo - Package name: com.yourcompany.tourist_assistive_app
echo.
echo For iOS:
echo - Create another API key
echo - Name: "iOS Maps API Key"
echo - Restrict to iOS apps
echo - Bundle identifier: com.yourcompany.tourist_assistive_app
echo.
pause

echo Step 4: Configure API Keys
echo -------------------------
echo Enter your API keys below:
echo.

set /p WEB_KEY="Enter Web API Key: "
set /p ANDROID_KEY="Enter Android API Key: "
set /p IOS_KEY="Enter iOS API Key: "

echo.
echo Creating configuration files...

REM Create environment configuration
echo class EnvironmentConfig {
echo   // Google Maps API Keys
echo   static const String _googleMapsWebKey = '%WEB_KEY%';
echo   static const String _googleMapsAndroidKey = '%ANDROID_KEY%';
echo   static const String _googleMapsIOSKey = '%IOS_KEY%';
echo   
echo   static String getGoogleMapsKey() {
echo     if (kIsWeb) {
echo       return _googleMapsWebKey;
echo     } else if (Platform.isAndroid) {
echo       return _googleMapsAndroidKey;
echo     } else if (Platform.isIOS) {
echo       return _googleMapsIOSKey;
echo     }
echo     return '';
echo   }
echo } > lib\core\config\google_maps_config.dart

echo.
echo Configuration files created!
echo.

echo Step 5: Update Android Configuration
echo -------------------------------------
echo Add this to android/app/src/main/AndroidManifest.xml:
echo.
echo ^<meta-data
echo     android:name="com.google.android.geo.API_KEY"
echo     android:value="%ANDROID_KEY%"/^>
echo.

echo Step 6: Update iOS Configuration
echo ------------------------------
echo Add this to ios/Runner/AppDelegate.swift:
echo.
echo import GoogleMaps
echo GMSServices.provideAPIKey("%IOS_KEY%")
echo.

echo Step 7: Update Web Configuration
echo --------------------------------
echo Add this to web/index.html:
echo.
echo ^<script src="https://maps.googleapis.com/maps/api/js?key=%WEB_KEY%&libraries=places"^>^</script^>
echo.

echo ========================================
echo   Google Maps Setup Complete!
echo ========================================
echo.
echo Next steps:
echo 1. Update your AndroidManifest.xml with the Android API key
echo 2. Update your iOS AppDelegate.swift with the iOS API key
echo 3. Update your web/index.html with the Web API key
echo 4. Run 'flutter clean' and 'flutter pub get'
echo 5. Test the app with real Google Maps!
echo.
pause




























