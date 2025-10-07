#!/bin/bash

# Tourist Assistive App - API Keys Configuration Script
# This script helps configure API keys for the application

echo "🔧 Tourist Assistive App - API Keys Configuration"
echo "=================================================="
echo ""

# Function to prompt for API key
prompt_api_key() {
    local service_name=$1
    local env_var=$2
    local description=$3
    
    echo "📋 $service_name Configuration"
    echo "Description: $description"
    echo ""
    
    read -p "Enter your $service_name API key (or press Enter to skip): " api_key
    
    if [ ! -z "$api_key" ]; then
        echo "✅ $service_name API key configured"
        echo "export $env_var=\"$api_key\"" >> .env
    else
        echo "⚠️  $service_name API key skipped"
    fi
    echo ""
}

# Create .env file if it doesn't exist
if [ ! -f .env ]; then
    echo "# Tourist Assistive App - Environment Variables" > .env
    echo "# Generated on $(date)" >> .env
    echo "" >> .env
fi

echo "This script will help you configure API keys for the Tourist Assistive App."
echo "You can skip any service you don't want to configure."
echo ""

# OpenAI API Key
prompt_api_key "OpenAI" "OPENAI_API_KEY" "Required for AI chatbot functionality (GPT-4)"

# Google Cloud API Key
prompt_api_key "Google Cloud" "GOOGLE_CLOUD_API_KEY" "Required for Text-to-Speech and Speech-to-Text services"

# Google Maps API Key
prompt_api_key "Google Maps" "GOOGLE_MAPS_API_KEY" "Required for map functionality and location services"

# Google Translate API Key
prompt_api_key "Google Translate" "GOOGLE_TRANSLATE_API_KEY" "Required for translation services"

# Telebirr API Key
prompt_api_key "Telebirr" "TELEBIRR_API_KEY" "Required for payment processing (Ethiopian payment gateway)"

# SantimPay API Key
prompt_api_key "SantimPay" "SANTIMPAY_API_KEY" "Required for payment processing (Ethiopian payment gateway)"

echo "🎉 Configuration complete!"
echo ""
echo "📝 Next steps:"
echo "1. Review the .env file that was created"
echo "2. Add the .env file to your .gitignore to keep API keys secure"
echo "3. Run the app with: flutter run --dart-define-from-file=.env"
echo ""
echo "⚠️  Security reminder:"
echo "- Never commit API keys to version control"
echo "- Keep your .env file secure and private"
echo "- Use different API keys for development and production"
echo ""

# Check if .gitignore exists and add .env if not present
if [ -f .gitignore ]; then
    if ! grep -q "^\.env$" .gitignore; then
        echo "" >> .gitignore
        echo "# Environment variables" >> .gitignore
        echo ".env" >> .gitignore
        echo "✅ Added .env to .gitignore"
    fi
else
    echo ".env" > .gitignore
    echo "✅ Created .gitignore with .env"
fi

echo ""
echo "🚀 You're ready to run the Tourist Assistive App!"
echo "Use: flutter run --dart-define-from-file=.env"

