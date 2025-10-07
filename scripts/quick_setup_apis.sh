#!/bin/bash

# Quick API Setup Script for Tourist Assistive App
# This script helps you quickly configure Google Maps and OpenAI API keys

echo "============================================"
echo "  Tourist Assistive App - API Setup"
echo "============================================"
echo ""

# Check if running in project directory
if [ ! -f "pubspec.yaml" ]; then
    echo "Error: Please run this script from the project root directory!"
    exit 1
fi

echo "This script will help you configure:"
echo "  1. Google Maps API Key"
echo "  2. OpenAI ChatGPT API Key"
echo ""

# Get Google Maps API Key
read -p "Enter your Google Maps API Key (or press Enter to skip): " GMAPS_KEY

# Get OpenAI API Key
read -p "Enter your OpenAI API Key (or press Enter to skip): " OPENAI_KEY

# Check if local.properties exists
if [ ! -f "android/local.properties" ]; then
    echo "Creating android/local.properties..."
    cat > android/local.properties <<EOF
sdk.dir=$ANDROID_HOME
flutter.sdk=$FLUTTER_ROOT
EOF
fi

# Backup existing local.properties
if [ -f "android/local.properties" ]; then
    echo "Creating backup of local.properties..."
    cp android/local.properties android/local.properties.backup
fi

# Add API keys to local.properties
echo ""
echo "Adding API keys to android/local.properties..."

if [ ! -z "$GMAPS_KEY" ]; then
    echo "GOOGLE_MAPS_API_KEY=$GMAPS_KEY" >> android/local.properties
    echo "✓ Google Maps API Key added"
else
    echo "- Google Maps API Key skipped"
fi

if [ ! -z "$OPENAI_KEY" ]; then
    echo "OPENAI_API_KEY=$OPENAI_KEY" >> android/local.properties
    echo "✓ OpenAI API Key added"
else
    echo "- OpenAI API Key skipped"
fi

# Create .env file for additional configuration
echo ""
echo "Creating .env file for backup configuration..."
cat > .env <<EOF
GOOGLE_MAPS_API_KEY=$GMAPS_KEY
OPENAI_API_KEY=$OPENAI_KEY
EOF
echo "✓ .env file created"

# Add .env to .gitignore if not already there
if ! grep -q "^\.env$" .gitignore 2>/dev/null; then
    echo ".env" >> .gitignore
    echo "*.backup" >> .gitignore
    echo "✓ Added .env to .gitignore"
fi

# Clean and rebuild
echo ""
echo "Cleaning and rebuilding project..."
flutter clean
flutter pub get

echo ""
echo "============================================"
echo "  Setup Complete!"
echo "============================================"
echo ""
echo "Your API keys have been configured:"
if [ ! -z "$GMAPS_KEY" ]; then echo "  ✓ Google Maps API"; fi
if [ ! -z "$OPENAI_KEY" ]; then echo "  ✓ OpenAI ChatGPT API"; fi
echo ""
echo "Next steps:"
echo "  1. Run: flutter run"
echo "  2. Test the Places tab (Google Maps)"
echo "  3. Test the Chat tab (ChatGPT)"
echo ""
echo "Need help? Check COMPLETE_API_SETUP_GUIDE.md"
echo ""

























