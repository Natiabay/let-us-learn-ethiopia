#!/bin/bash

# Deploy Cloud Functions for Tourist Amharic Tutor App
# This script deploys all Cloud Functions to Firebase

echo "🚀 Deploying Cloud Functions for Tourist Amharic Tutor App..."

# Check if Firebase CLI is installed
if ! command -v firebase &> /dev/null; then
    echo "❌ Firebase CLI is not installed. Please install it first:"
    echo "npm install -g firebase-tools"
    exit 1
fi

# Check if user is logged in
if ! firebase projects:list &> /dev/null; then
    echo "❌ Not logged in to Firebase. Please login first:"
    echo "firebase login"
    exit 1
fi

# Navigate to functions directory
cd functions

# Install dependencies
echo "📦 Installing dependencies..."
npm install

# Build TypeScript
echo "🔨 Building TypeScript..."
npm run build

# Deploy functions
echo "🚀 Deploying functions..."
firebase deploy --only functions

# Deploy Firestore rules
echo "📋 Deploying Firestore rules..."
firebase deploy --only firestore:rules

# Deploy Firestore indexes
echo "📊 Deploying Firestore indexes..."
firebase deploy --only firestore:indexes

# Deploy Storage rules
echo "💾 Deploying Storage rules..."
firebase deploy --only storage

echo "✅ Deployment completed successfully!"
echo ""
echo "🔗 Your Cloud Functions are now available at:"
echo "   - Chatbot: https://us-central1-YOUR_PROJECT_ID.cloudfunctions.net/chatbot"
echo "   - Payment Webhook: https://us-central1-YOUR_PROJECT_ID.cloudfunctions.net/paymentWebhook"
echo "   - Admin: https://us-central1-YOUR_PROJECT_ID.cloudfunctions.net/admin"
echo "   - Embeddings: https://us-central1-YOUR_PROJECT_ID.cloudfunctions.net/embeddings"
echo ""
echo "📝 Next steps:"
echo "   1. Update your Flutter app to use the new Cloud Functions URLs"
echo "   2. Configure API keys in Firebase Functions config"
echo "   3. Test the payment webhooks with Telebirr/CBE"
echo "   4. Seed the database with lesson data"
