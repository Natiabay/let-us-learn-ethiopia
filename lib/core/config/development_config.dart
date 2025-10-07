import 'package:flutter/foundation.dart';

/// Development configuration for API keys and services
/// This file provides fallback configurations for development
class DevelopmentConfig {
  // Development API keys (replace with real keys for testing)
  static const String _devOpenaiKey = 'sk-dev-placeholder-key';
  static const String _devGoogleCloudKey = 'dev-google-cloud-key';
  static const String _devGoogleMapsKey = 'dev-google-maps-key';
  static const String _devGoogleTranslateKey = 'dev-google-translate-key';
  static const String _devTelebirrKey = 'dev-telebirr-key';
  static const String _devSantimpayKey = 'dev-santimpay-key';

  // Get development API key
  static String getOpenaiKey() {
    if (kDebugMode) {
      return _devOpenaiKey;
    }
    throw Exception('OpenAI API key not configured for production');
  }

  static String getGoogleCloudKey() {
    if (kDebugMode) {
      return _devGoogleCloudKey;
    }
    throw Exception('Google Cloud API key not configured for production');
  }

  static String getGoogleMapsKey() {
    if (kDebugMode) {
      return _devGoogleMapsKey;
    }
    throw Exception('Google Maps API key not configured for production');
  }

  static String getGoogleTranslateKey() {
    if (kDebugMode) {
      return _devGoogleTranslateKey;
    }
    throw Exception('Google Translate API key not configured for production');
  }

  static String getTelebirrKey() {
    if (kDebugMode) {
      return _devTelebirrKey;
    }
    throw Exception('Telebirr API key not configured for production');
  }

  static String getSantimpayKey() {
    if (kDebugMode) {
      return _devSantimpayKey;
    }
    throw Exception('SantimPay API key not configured for production');
  }

  // Check if we're in development mode
  static bool get isDevelopmentMode => kDebugMode;

  // Mock responses for development
  static const Map<String, String> mockResponses = {
    'coffee ceremony': '''Ethiopian coffee ceremonies are beautiful cultural traditions! Here's what you should know:

☕ **The Process:**
- Green coffee beans are roasted over hot coals
- The aroma fills the room as beans are ground by hand
- Coffee is brewed in a traditional clay pot called a "jebena"
- Served in small cups with sugar and sometimes salt

🏛️ **Cultural Significance:**
- Symbolizes hospitality and friendship
- Can last 1-2 hours with multiple rounds
- Often includes traditional snacks like popcorn or bread
- A time for community and conversation

📍 **Where to Experience:**
- Traditional restaurants in Addis Ababa
- Local cafes in Lalibela and Gondar
- Many hotels offer coffee ceremonies
- Ask locals for authentic experiences

💡 **Tips:**
- Accept the first cup (it's considered rude to decline)
- Say "Amasegenallo" (thank you) to show appreciation
- Don't rush - enjoy the slow, ceremonial pace
- Try the traditional snacks served alongside

Would you like to know about specific places to experience coffee ceremonies or learn some Amharic phrases to use during the ceremony?''',
    
    'best local food': '''Ethiopian cuisine is absolutely amazing! Here are the must-try dishes:

🍽️ **Signature Dishes:**
- **Injera** - The spongy sourdough flatbread that's the foundation of every meal
- **Doro Wat** - Spicy chicken stew, often called Ethiopia's national dish
- **Kitfo** - Minced raw beef with spices (like Ethiopian tartare)
- **Tibs** - Grilled or sautéed meat with vegetables
- **Shiro** - Thick stew made from ground chickpeas or lentils

🌶️ **Spices & Flavors:**
- **Berbere** - The famous spice blend that gives Ethiopian food its heat
- **Mitmita** - Another spicy blend, often used with kitfo
- **Niter Kibbeh** - Spiced clarified butter used in cooking

📍 **Best Places to Eat:**
- **Addis Ababa**: Yod Abyssinia, Habesha 2000, Kategna
- **Lalibela**: Ben Abeba, Seven Olives Hotel
- **Gondar**: Four Sisters Restaurant, Goha Hotel

💡 **Dining Tips:**
- Eat with your hands using injera to scoop up food
- Share dishes family-style
- Try the honey wine (tej) with your meal
- Don't be afraid of the spice level - it's part of the experience!

Would you like specific restaurant recommendations or help learning how to eat Ethiopian food properly?''',
    
    'places to visit': '''Ethiopia is a treasure trove of incredible destinations! Here are the must-visit places:

🏛️ **Historical Sites:**
- **Lalibela** - The "New Jerusalem" with 11 rock-hewn churches
- **Gondar** - The "Camelot of Africa" with medieval castles
- **Axum** - Ancient capital with obelisks and the Ark of the Covenant
- **Harar** - Walled city with 99 mosques and hyena feeding

🌍 **Natural Wonders:**
- **Simien Mountains** - UNESCO World Heritage with gelada baboons
- **Danakil Depression** - One of the hottest places on Earth
- **Blue Nile Falls** - "Tis Issat" (smoking water)
- **Bale Mountains** - Home to the Ethiopian wolf

🏙️ **Cities:**
- **Addis Ababa** - Capital with museums, markets, and nightlife
- **Bahir Dar** - Lakeside city with monasteries
- **Dire Dawa** - Railway town with unique architecture

🎯 **Unique Experiences:**
- **Omo Valley** - Meet diverse tribal communities
- **Tigray Churches** - Cliff-side monasteries
- **Rift Valley Lakes** - Bird watching and relaxation

📅 **Best Time to Visit:**
- October to March (dry season)
- Avoid July-August (heavy rains)

Would you like detailed information about any specific destination or help planning your itinerary?''',
    
    'learn amharic': '''Learning Amharic will greatly enhance your Ethiopian experience! Here are the basics:

🗣️ **Essential Greetings:**
- **Selam** (ሰላም) - Hello/Peace
- **Tena Yistilign** (ተና ይስጥልኝ) - How are you?
- **Dehna Nesh** (ደህና ነሽ) - I'm fine (to a woman)
- **Dehna Nahu** (ደህና ነሁ) - I'm fine (to a man)
- **Amasegenallo** (አመሰግናለሁ) - Thank you

🍽️ **Food & Dining:**
- **Injera** (እንጀራ) - The traditional bread
- **Wat** (ወጥ) - Stew/sauce
- **Buna** (ቡና) - Coffee
- **Tej** (ጠጅ) - Honey wine
- **Min Ale?** (ምን አለ?) - What is this?

🛒 **Shopping & Numbers:**
- **Sint** (ሲንት) - How much?
- **And** (አንድ) - One
- **Hulatt** (ሁለት) - Two
- **Sost** (ሦስት) - Three

📍 **Getting Around:**
- **Weyne** (ወይኔ) - Where?
- **Min Awedek** (ምን አወደክ?) - What do you want?
- **Aydelem** (አይደለም) - No
- **Awo** (አዎ) - Yes

💡 **Learning Tips:**
- Practice with locals - they love helping!
- Use the Amharic script (Fidel) - it's beautiful
- Start with common phrases
- Don't worry about perfect pronunciation

Would you like to learn more phrases for specific situations like shopping, dining, or asking for directions?''',
    
    'cultural tips': '''Understanding Ethiopian culture will make your visit much more meaningful! Here are important cultural insights:

🤝 **Greetings & Respect:**
- Shake hands with everyone when entering a room
- Use both hands when giving/receiving items
- Remove shoes when entering homes or religious sites
- Stand when elders enter the room

👗 **Dress Code:**
- Dress modestly, especially in religious areas
- Cover shoulders and knees
- Traditional white clothing is appreciated
- Remove hats in churches and mosques

🍽️ **Dining Etiquette:**
- Wash hands before eating (water is provided)
- Eat with your right hand only
- Share food from the same plate
- Don't eat with your left hand
- Wait to be invited to start eating

☕ **Coffee Culture:**
- Never refuse the first cup of coffee
- The ceremony can last 1-2 hours
- Participate in the conversation
- Say "Amasegenallo" (thank you) after each cup

⛪ **Religious Respect:**
- Remove shoes in churches
- Women may need to cover their heads
- Don't point with your finger
- Be quiet and respectful during services

💬 **Communication:**
- Ethiopians are very hospitable
- Direct eye contact shows respect
- Personal questions are common and friendly
- "Inshallah" (God willing) is often used

🎁 **Gift Giving:**
- Bring small gifts from your country
- Flowers are appreciated
- Don't give alcohol to religious people
- Present gifts with both hands

Would you like specific advice for any particular cultural situation or region of Ethiopia?'''
  };

  // Get mock response for development
  static String getMockResponse(String query) {
    final lowerQuery = query.toLowerCase();
    
    for (final entry in mockResponses.entries) {
      if (lowerQuery.contains(entry.key)) {
        return entry.value;
      }
    }
    
    // Default response
    return '''# 🇪🇹 Thank you for your question!

I'm **EthioBot**, your AI guide to Ethiopia! I'm currently in development mode, but I'd be happy to help you with information about Ethiopia.

## Topics I can assist with:

### 🏛️ Culture & History
• Learn about Ethiopian traditions, coffee ceremonies, and historical sites

### 🍽️ Food & Dining  
• Discover amazing Ethiopian cuisine and dining etiquette

### 📍 Places to Visit
• Get recommendations for must-see destinations

### 🗣️ Language
• Learn basic Amharic phrases and pronunciation

### 🎯 Travel Tips
• Practical advice for your Ethiopian journey

To get the full AI experience with real-time responses, please configure your OpenAI API key. In the meantime, feel free to ask me about any of these topics!

**What would you like to know more about?**''';
  }
}

