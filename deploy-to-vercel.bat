@echo off
echo ========================================
echo   ETHIOPIAN TOURIST APP - VERCEL DEPLOY
echo ========================================
echo.

echo Step 1: Building Flutter Web App...
flutter build web --release
if %errorlevel% neq 0 (
    echo ERROR: Flutter build failed!
    pause
    exit /b 1
)

echo.
echo Step 2: Deploying to Vercel...
echo.
echo IMPORTANT: You need to:
echo 1. Go to https://vercel.com/new
echo 2. Import from GitHub: Natiabay/let-us-learn-ethiopia
echo 3. Set Framework Preset to "Other"
echo 4. Set Root Directory to "./"
echo 5. Set Build Command to: "flutter build web --release"
echo 6. Set Output Directory to: "build/web"
echo 7. Click Deploy
echo.
echo OR use Vercel CLI:
echo 1. Run: vercel login
echo 2. Run: vercel --prod
echo.

echo Build completed successfully!
echo Your app is ready in: build/web/
echo.
pause
