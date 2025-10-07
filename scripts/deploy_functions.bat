@echo off
REM Deploy Cloud Functions for Tourist Amharic Tutor App
REM This script deploys all Cloud Functions to Firebase

echo 🚀 Deploying Cloud Functions for Tourist Amharic Tutor App...

REM Check if Firebase CLI is installed
firebase --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Firebase CLI is not installed. Please install it first:
    echo npm install -g firebase-tools
    pause
    exit /b 1
)

REM Check if user is logged in
firebase projects:list >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Not logged in to Firebase. Please login first:
    echo firebase login
    pause
    exit /b 1
)

REM Navigate to functions directory
cd functions

REM Install dependencies
echo 📦 Installing dependencies...
call npm install

REM Build TypeScript
echo 🔨 Building TypeScript...
call npm run build

REM Deploy functions
echo 🚀 Deploying functions...
firebase deploy --only functions

REM Deploy Firestore rules
echo 📋 Deploying Firestore rules...
firebase deploy --only firestore:rules

REM Deploy Firestore indexes
echo 📊 Deploying Firestore indexes...
firebase deploy --only firestore:indexes

REM Deploy Storage rules
echo 💾 Deploying Storage rules...
firebase deploy --only storage

echo ✅ Deployment completed successfully!
echo.
echo 🔗 Your Cloud Functions are now available at:
echo    - Chatbot: https://us-central1-YOUR_PROJECT_ID.cloudfunctions.net/chatbot
echo    - Payment Webhook: https://us-central1-YOUR_PROJECT_ID.cloudfunctions.net/paymentWebhook
echo    - Admin: https://us-central1-YOUR_PROJECT_ID.cloudfunctions.net/admin
echo    - Embeddings: https://us-central1-YOUR_PROJECT_ID.cloudfunctions.net/embeddings
echo.
echo 📝 Next steps:
echo    1. Update your Flutter app to use the new Cloud Functions URLs
echo    2. Configure API keys in Firebase Functions config
echo    3. Test the payment webhooks with Telebirr/CBE
echo    4. Seed the database with lesson data

pause
