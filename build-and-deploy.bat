@echo off
echo ========================================
echo   Tourist Assistive App - Build & Deploy
echo ========================================
echo.

echo Step 1: Building Flutter web app...
flutter clean
flutter pub get
flutter build web --release

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ❌ Build failed! Please check the errors above.
    pause
    exit /b 1
)

echo.
echo ✅ Build completed successfully!
echo.

echo Step 2: Deploying to Vercel...
echo.
echo Make sure you have Vercel CLI installed and logged in:
echo npm install -g vercel
echo vercel login
echo.

vercel --prod

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ❌ Deployment failed! Please check the errors above.
    pause
    exit /b 1
)

echo.
echo ✅ Deployment completed successfully!
echo.
echo Your app is now live on Vercel! 🎉
echo.
pause
