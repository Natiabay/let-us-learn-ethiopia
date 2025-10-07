@echo off
echo ========================================
echo   Tourist Assistive App - Auto Deploy Setup
echo ========================================
echo.

echo This script will help you set up automatic deployment to Vercel.
echo.

echo Step 1: Vercel Setup
echo --------------------
echo 1. Go to https://vercel.com and sign in
echo 2. Click "New Project"
echo 3. Import your GitHub repository: Natiabay/let-us-learn-Ethiopia-flutter
echo 4. Vercel will auto-detect Flutter settings
echo.

echo Step 2: Get Vercel Credentials
echo ------------------------------
echo After importing your project:
echo 1. Go to Project Settings ^> General
echo 2. Copy the "Project ID"
echo 3. Go to Settings ^> Tokens
echo 4. Create a new token and copy it
echo 5. Note your Team/Organization ID
echo.

echo Step 3: Configure GitHub Secrets
echo --------------------------------
echo Go to: https://github.com/Natiabay/let-us-learn-Ethiopia-flutter/settings/secrets/actions
echo.
echo Add these secrets:
echo - VERCEL_TOKEN: Your Vercel API token
echo - VERCEL_PROJECT_ID: Your Vercel project ID
echo - VERCEL_ORG_ID: Your Vercel organization ID
echo.

echo Step 4: Test Deployment
echo -----------------------
echo 1. Make a small change to your code
echo 2. Commit and push to main branch
echo 3. Check GitHub Actions tab for deployment progress
echo 4. Your app will be live on Vercel automatically!
echo.

echo ========================================
echo   Setup Complete!
echo ========================================
echo.
echo Your app will now automatically deploy to Vercel
echo every time you push to the main branch.
echo.
echo Check the Actions tab in your GitHub repository
echo to monitor deployment progress.
echo.
pause
