@echo off
REM Seed Database with Comprehensive Lesson Data
REM This script seeds Firestore with all lesson data and knowledge base

echo 🌱 Seeding database with comprehensive lesson data...

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

REM Install dependencies if not already installed
if not exist node_modules (
    echo 📦 Installing dependencies...
    call npm install
)

REM Build TypeScript
echo 🔨 Building TypeScript...
call npm run build

REM Create a temporary seed script
echo const admin = require('firebase-admin'); > temp_seed.js
echo const { seedDatabase } = require('./lib/seed_data'); >> temp_seed.js
echo. >> temp_seed.js
echo // Initialize Firebase Admin >> temp_seed.js
echo admin.initializeApp(); >> temp_seed.js
echo. >> temp_seed.js
echo async function runSeed() { >> temp_seed.js
echo     try { >> temp_seed.js
echo         console.log('🌱 Starting database seeding...'); >> temp_seed.js
echo         const result = await seedDatabase(); >> temp_seed.js
echo. >> temp_seed.js
echo         if (result.success) { >> temp_seed.js
echo             console.log('✅ Database seeded successfully!'); >> temp_seed.js
echo             console.log('📊 Seeded data includes:'); >> temp_seed.js
echo             console.log('   - 50+ lessons for 11 languages'); >> temp_seed.js
echo             console.log('   - Knowledge base for RAG chatbot'); >> temp_seed.js
echo             console.log('   - Language configurations'); >> temp_seed.js
echo             console.log('   - User progress tracking'); >> temp_seed.js
echo         } else { >> temp_seed.js
echo             console.error('❌ Database seeding failed:', result.error); >> temp_seed.js
echo             process.exit(1); >> temp_seed.js
echo         } >> temp_seed.js
echo     } catch (error) { >> temp_seed.js
echo         console.error('❌ Error during seeding:', error); >> temp_seed.js
echo         process.exit(1); >> temp_seed.js
echo     } finally { >> temp_seed.js
echo         process.exit(0); >> temp_seed.js
echo     } >> temp_seed.js
echo } >> temp_seed.js
echo. >> temp_seed.js
echo runSeed(); >> temp_seed.js

REM Run the seed script
echo 🌱 Running database seed script...
node temp_seed.js

REM Clean up
del temp_seed.js

echo ✅ Database seeding completed!
echo.
echo 📊 Your database now contains:
echo    - 550+ lessons (50+ per language × 11 languages)
echo    - Comprehensive knowledge base for chatbot
echo    - Language configurations for all supported languages
echo    - User progress tracking structure
echo.
echo 🎯 Next steps:
echo    1. Test the chatbot with sample queries
echo    2. Verify lesson data in Firestore console
echo    3. Test payment webhook endpoints
echo    4. Configure admin dashboard access

pause
