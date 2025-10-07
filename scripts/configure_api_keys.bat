@echo off
REM Tourist Assistive App - API Keys Configuration Script for Windows
REM This script helps configure API keys for the application

echo 🔧 Tourist Assistive App - API Keys Configuration
echo ==================================================
echo.

echo This script will help you configure API keys for the Tourist Assistive App.
echo You can skip any service you don't want to configure.
echo.

REM Create .env file if it doesn't exist
if not exist .env (
    echo # Tourist Assistive App - Environment Variables > .env
    echo # Generated on %date% %time% >> .env
    echo. >> .env
)

echo 📋 OpenAI Configuration
echo Description: Required for AI chatbot functionality (GPT-4)
echo.
set /p openai_key="Enter your OpenAI API key (or press Enter to skip): "
if not "%openai_key%"=="" (
    echo ✅ OpenAI API key configured
    echo OPENAI_API_KEY=%openai_key% >> .env
) else (
    echo ⚠️  OpenAI API key skipped
)
echo.

echo 📋 Google Cloud Configuration
echo Description: Required for Text-to-Speech and Speech-to-Text services
echo.
set /p google_cloud_key="Enter your Google Cloud API key (or press Enter to skip): "
if not "%google_cloud_key%"=="" (
    echo ✅ Google Cloud API key configured
    echo GOOGLE_CLOUD_API_KEY=%google_cloud_key% >> .env
) else (
    echo ⚠️  Google Cloud API key skipped
)
echo.

echo 📋 Google Maps Configuration
echo Description: Required for map functionality and location services
echo.
set /p google_maps_key="Enter your Google Maps API key (or press Enter to skip): "
if not "%google_maps_key%"=="" (
    echo ✅ Google Maps API key configured
    echo GOOGLE_MAPS_API_KEY=%google_maps_key% >> .env
) else (
    echo ⚠️  Google Maps API key skipped
)
echo.

echo 📋 Google Translate Configuration
echo Description: Required for translation services
echo.
set /p google_translate_key="Enter your Google Translate API key (or press Enter to skip): "
if not "%google_translate_key%"=="" (
    echo ✅ Google Translate API key configured
    echo GOOGLE_TRANSLATE_API_KEY=%google_translate_key% >> .env
) else (
    echo ⚠️  Google Translate API key skipped
)
echo.

echo 📋 Telebirr Configuration
echo Description: Required for payment processing (Ethiopian payment gateway)
echo.
set /p telebirr_key="Enter your Telebirr API key (or press Enter to skip): "
if not "%telebirr_key%"=="" (
    echo ✅ Telebirr API key configured
    echo TELEBIRR_API_KEY=%telebirr_key% >> .env
) else (
    echo ⚠️  Telebirr API key skipped
)
echo.

echo 📋 SantimPay Configuration
echo Description: Required for payment processing (Ethiopian payment gateway)
echo.
set /p santimpay_key="Enter your SantimPay API key (or press Enter to skip): "
if not "%santimpay_key%"=="" (
    echo ✅ SantimPay API key configured
    echo SANTIMPAY_API_KEY=%santimpay_key% >> .env
) else (
    echo ⚠️  SantimPay API key skipped
)
echo.

echo 🎉 Configuration complete!
echo.
echo 📝 Next steps:
echo 1. Review the .env file that was created
echo 2. Add the .env file to your .gitignore to keep API keys secure
echo 3. Run the app with: flutter run --dart-define-from-file=.env
echo.
echo ⚠️  Security reminder:
echo - Never commit API keys to version control
echo - Keep your .env file secure and private
echo - Use different API keys for development and production
echo.

REM Check if .gitignore exists and add .env if not present
if exist .gitignore (
    findstr /C:".env" .gitignore >nul
    if errorlevel 1 (
        echo. >> .gitignore
        echo # Environment variables >> .gitignore
        echo .env >> .gitignore
        echo ✅ Added .env to .gitignore
    )
) else (
    echo .env > .gitignore
    echo ✅ Created .gitignore with .env
)

echo.
echo 🚀 You're ready to run the Tourist Assistive App!
echo Use: flutter run --dart-define-from-file=.env
pause

