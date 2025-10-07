@echo off
SETLOCAL
REM Tourist Assistive App - API Key Setup Script
echo.
echo =====================================================
echo   Tourist Assistive App - API Key Setup
echo =====================================================
echo.
echo This script will help you configure API keys for the app.
echo The app will work without API keys (using development mode),
echo but some features will be limited.
echo.
echo =====================================================
echo   API Key Setup Options
echo =====================================================
echo.
echo 1. OpenAI API Key (Required for AI Chatbot)
echo    - Get from: https://platform.openai.com/account/api-keys
echo    - Cost: Pay-per-use (very affordable)
echo    - Features: Full AI chatbot functionality
echo.
echo 2. Google Cloud API Key (Optional for Voice Services)
echo    - Get from: https://console.cloud.google.com/apis/credentials
echo    - Cost: Free tier available
echo    - Features: Voice recognition and synthesis
echo.
echo 3. Google Maps API Key (Optional for Location Services)
echo    - Get from: https://console.cloud.google.com/apis/credentials
echo    - Cost: Free tier available
echo    - Features: Maps and location services
echo.
echo 4. Payment APIs (Optional for Payment Processing)
echo    - Telebirr and SantimPay integration
echo    - Features: Real payment processing
echo.
echo =====================================================
echo   Quick Setup
echo =====================================================
echo.
echo To run the app with API keys, use this command:
echo.
echo flutter run --dart-define=OPENAI_API_KEY="your-key-here"
echo.
echo Or for multiple keys:
echo.
echo flutter run ^
echo   --dart-define=OPENAI_API_KEY="your-openai-key" ^
echo   --dart-define=GOOGLE_CLOUD_API_KEY="your-google-key" ^
echo   --dart-define=GOOGLE_MAPS_API_KEY="your-maps-key"
echo.
echo =====================================================
echo   Development Mode (No API Keys Required)
echo =====================================================
echo.
echo The app works perfectly in development mode without any API keys!
echo Just run: flutter run
echo.
echo Features available in development mode:
echo - AI chatbot with comprehensive knowledge base
echo - All Ethiopian cultural information
echo - Travel guides and recommendations
echo - Language learning content
echo - Mock payment processing
echo.
echo =====================================================
echo   Ready to Run
echo =====================================================
echo.
echo The app is ready to run! Choose your option:
echo.
echo 1. Run in development mode (no API keys needed)
echo 2. Set up API keys for full functionality
echo.
SET /P CHOICE="Enter your choice (1 or 2): "
echo.
IF "%CHOICE%"=="1" (
    echo Running app in development mode...
    flutter run
) ELSE IF "%CHOICE%"=="2" (
    echo.
    echo =====================================================
    echo   API Key Configuration
    echo =====================================================
    echo.
    SET /P OPENAI_KEY="Enter your OpenAI API Key (or press Enter to skip): "
    SET /P GOOGLE_CLOUD_KEY="Enter your Google Cloud API Key (or press Enter to skip): "
    SET /P GOOGLE_MAPS_KEY="Enter your Google Maps API Key (or press Enter to skip): "
    echo.
    echo Running app with configured API keys...
    IF NOT "%OPENAI_KEY%"=="" (
        IF NOT "%GOOGLE_CLOUD_KEY%"=="" (
            IF NOT "%GOOGLE_MAPS_KEY%"=="" (
                flutter run --dart-define=OPENAI_API_KEY="%OPENAI_KEY%" --dart-define=GOOGLE_CLOUD_API_KEY="%GOOGLE_CLOUD_KEY%" --dart-define=GOOGLE_MAPS_API_KEY="%GOOGLE_MAPS_KEY%"
            ) ELSE (
                flutter run --dart-define=OPENAI_API_KEY="%OPENAI_KEY%" --dart-define=GOOGLE_CLOUD_API_KEY="%GOOGLE_CLOUD_KEY%"
            )
        ) ELSE (
            flutter run --dart-define=OPENAI_API_KEY="%OPENAI_KEY%"
        )
    ) ELSE (
        flutter run
    )
) ELSE (
    echo Invalid choice. Running in development mode...
    flutter run
)
echo.
echo Press any key to exit.
pause > NUL
ENDLOCAL
















































