@echo off
:: Quick API Setup Script for Tourist Assistive App
:: This script helps you quickly configure Google Maps and OpenAI API keys

echo ============================================
echo   Tourist Assistive App - API Setup
echo ============================================
echo.

:: Check if running in project directory
if not exist "pubspec.yaml" (
    echo Error: Please run this script from the project root directory!
    pause
    exit /b 1
)

echo This script will help you configure:
echo   1. Google Maps API Key
echo   2. OpenAI ChatGPT API Key
echo.

:: Get Google Maps API Key
set /p GMAPS_KEY="Enter your Google Maps API Key (or press Enter to skip): "

:: Get OpenAI API Key
set /p OPENAI_KEY="Enter your OpenAI API Key (or press Enter to skip): "

:: Check if local.properties exists
if not exist "android\local.properties" (
    echo Creating android\local.properties...
    echo sdk.dir=%LOCALAPPDATA%\Android\sdk > android\local.properties
    echo flutter.sdk=%FLUTTER_ROOT% >> android\local.properties
)

:: Backup existing local.properties
if exist "android\local.properties" (
    echo Creating backup of local.properties...
    copy android\local.properties android\local.properties.backup >nul
)

:: Add API keys to local.properties
echo.
echo Adding API keys to android\local.properties...

if not "%GMAPS_KEY%"=="" (
    echo GOOGLE_MAPS_API_KEY=%GMAPS_KEY% >> android\local.properties
    echo ✓ Google Maps API Key added
) else (
    echo - Google Maps API Key skipped
)

if not "%OPENAI_KEY%"=="" (
    echo OPENAI_API_KEY=%OPENAI_KEY% >> android\local.properties
    echo ✓ OpenAI API Key added
) else (
    echo - OpenAI API Key skipped
)

:: Create .env file for additional configuration
echo.
echo Creating .env file for backup configuration...
echo GOOGLE_MAPS_API_KEY=%GMAPS_KEY% > .env
echo OPENAI_API_KEY=%OPENAI_KEY% >> .env
echo ✓ .env file created

:: Clean and rebuild
echo.
echo Cleaning and rebuilding project...
call flutter clean
call flutter pub get

echo.
echo ============================================
echo   Setup Complete!
echo ============================================
echo.
echo Your API keys have been configured:
if not "%GMAPS_KEY%"=="" echo   ✓ Google Maps API
if not "%OPENAI_KEY%"=="" echo   ✓ OpenAI ChatGPT API
echo.
echo Next steps:
echo   1. Run: flutter run
echo   2. Test the Places tab (Google Maps)
echo   3. Test the Chat tab (ChatGPT)
echo.
echo Need help? Check COMPLETE_API_SETUP_GUIDE.md
echo.
pause
























