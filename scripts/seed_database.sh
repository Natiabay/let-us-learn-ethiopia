#!/bin/bash

# Seed Database with Comprehensive Lesson Data
# This script seeds Firestore with all lesson data and knowledge base

echo "🌱 Seeding database with comprehensive lesson data..."

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

# Install dependencies if not already installed
if [ ! -d "node_modules" ]; then
    echo "📦 Installing dependencies..."
    npm install
fi

# Build TypeScript
echo "🔨 Building TypeScript..."
npm run build

# Create a temporary seed script
cat > temp_seed.js << 'EOF'
const admin = require('firebase-admin');
const { seedDatabase } = require('./lib/seed_data');

// Initialize Firebase Admin
admin.initializeApp();

async function runSeed() {
    try {
        console.log('🌱 Starting database seeding...');
        const result = await seedDatabase();
        
        if (result.success) {
            console.log('✅ Database seeded successfully!');
            console.log('📊 Seeded data includes:');
            console.log('   - 50+ lessons for 11 languages');
            console.log('   - Knowledge base for RAG chatbot');
            console.log('   - Language configurations');
            console.log('   - User progress tracking');
        } else {
            console.error('❌ Database seeding failed:', result.error);
            process.exit(1);
        }
    } catch (error) {
        console.error('❌ Error during seeding:', error);
        process.exit(1);
    } finally {
        process.exit(0);
    }
}

runSeed();
EOF

# Run the seed script
echo "🌱 Running database seed script..."
node temp_seed.js

# Clean up
rm temp_seed.js

echo "✅ Database seeding completed!"
echo ""
echo "📊 Your database now contains:"
echo "   - 550+ lessons (50+ per language × 11 languages)"
echo "   - Comprehensive knowledge base for chatbot"
echo "   - Language configurations for all supported languages"
echo "   - User progress tracking structure"
echo ""
echo "🎯 Next steps:"
echo "   1. Test the chatbot with sample queries"
echo "   2. Verify lesson data in Firestore console"
echo "   3. Test payment webhook endpoints"
echo "   4. Configure admin dashboard access"
