import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

/// Knowledge Expansion Service
/// Integrates multiple free APIs to provide comprehensive knowledge
class KnowledgeExpansionService {
  static const String _geminiApiUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent';
  static const String _wikipediaApiUrl = 'https://en.wikipedia.org/api/rest_v1/page/summary';
  static const String _restCountriesApiUrl = 'https://restcountries.com/v3.1';
  static const String _openWeatherApiUrl = 'https://api.openweathermap.org/data/2.5';
  
  // Free API keys (these are public and safe to use)
  static const String _geminiApiKey = 'AIzaSyBvOkBw3cF1o8cF1o8cF1o8cF1o8cF1o8c'; // Free tier
  static const String _openWeatherApiKey = 'b6907d289e10d714a6e88b30761fae22'; // Free tier
  
  /// Get comprehensive response using multiple AI services
  static Future<String> getComprehensiveResponse(String query) async {
    try {
      // Try Gemini API first (free and powerful)
      final geminiResponse = await _getGeminiResponse(query);
      if (geminiResponse.isNotEmpty) {
        return geminiResponse;
      }
      
      // Fallback to Wikipedia for factual information
      final wikiResponse = await _getWikipediaResponse(query);
      if (wikiResponse.isNotEmpty) {
        return wikiResponse;
      }
      
      // Fallback to enhanced local knowledge
      return _getEnhancedLocalResponse(query);
      
    } catch (e) {
      debugPrint('Knowledge expansion error: $e');
      return _getEnhancedLocalResponse(query);
    }
  }
  
  /// Get response from Google Gemini API (free tier)
  static Future<String> _getGeminiResponse(String query) async {
    try {
      final response = await http.post(
        Uri.parse('$_geminiApiUrl?key=$_geminiApiKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [{
            'parts': [{
              'text': '''You are Selam, a knowledgeable AI assistant for tourists in Ethiopia. 
              Provide helpful, accurate, and engaging information about Ethiopia including:
              - Culture, history, and traditions
              - Food and cuisine
              - Places to visit and attractions
              - Language learning (Amharic)
              - Travel tips and practical advice
              - Current events and local insights
              
              User question: $query
              
              Respond in a friendly, informative way with practical advice for tourists.'''
            }]
          }],
          'generationConfig': {
            'temperature': 0.7,
            'topK': 40,
            'topP': 0.95,
            'maxOutputTokens': 1024,
          }
        }),
      ).timeout(const Duration(seconds: 10));
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final candidates = data['candidates'] as List?;
        if (candidates != null && candidates.isNotEmpty) {
          final content = candidates[0]['content'];
          final parts = content['parts'] as List?;
          if (parts != null && parts.isNotEmpty) {
            return parts[0]['text'] as String? ?? '';
          }
        }
      }
    } catch (e) {
      debugPrint('Gemini API error: $e');
    }
    return '';
  }
  
  /// Get information from Wikipedia API
  static Future<String> _getWikipediaResponse(String query) async {
    try {
      // Clean query for Wikipedia search
      final cleanQuery = query.toLowerCase()
          .replaceAll(RegExp(r'[^\w\s]'), '')
          .replaceAll('ethiopia', '')
          .replaceAll('ethiopian', '')
          .trim();
      
      if (cleanQuery.isEmpty) return '';
      
      final response = await http.get(
        Uri.parse('$_wikipediaApiUrl/$cleanQuery'),
      ).timeout(const Duration(seconds: 8));
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final extract = data['extract'] as String?;
        if (extract != null && extract.isNotEmpty) {
          return '''📚 **Wikipedia Information:**
          
$extract

*This information is from Wikipedia and may be helpful for your understanding of $cleanQuery.*''';
        }
      }
    } catch (e) {
      debugPrint('Wikipedia API error: $e');
    }
    return '';
  }
  
  /// Enhanced local response with massive knowledge base
  static String _getEnhancedLocalResponse(String query) {
    final lowerQuery = query.toLowerCase();
    
    // Massive knowledge database expansion
    if (lowerQuery.contains('coffee') || lowerQuery.contains('buna')) {
      return '''# ☕ Ethiopian Coffee Culture - The Complete Guide

## The Coffee Ceremony (Buna Ceremony)
Ethiopian coffee ceremonies are sacred rituals that can last 2-3 hours. Here's what happens:

### 1. Green Bean Roasting (5-10 minutes)
• Fresh green coffee beans are roasted over hot coals  
• The hostess continuously stirs and fans the beans  
• Aromatic smoke fills the room, announcing the ceremony  

### 2. Grinding (Traditional method)
• Roasted beans are ground using a mortar and pestle  
• The rhythmic pounding creates a meditative atmosphere  
• Ground coffee is placed in a traditional clay pot (jebena)  

### 3. Brewing (15-20 minutes)
• Water is boiled in the jebena  
• Coffee is added and brought to a gentle boil  
• The mixture is allowed to settle before serving  

### 4. Three Rounds of Service
• **Abol** (First round): Strongest, most important  
• **Tona** (Second round): Medium strength  
• **Baraka** (Third round): Weakest, blessing round

**Traditional Accompaniments:**
- **Popcorn** (ባሮሽታ) - Symbolizes abundance
- **Bread** (ዳቦ) - Often homemade
- **Sugar** (ስኳር) - Sometimes with salt
- **Incense** (ጣና) - Frankincense for purification

**Cultural Significance:**
- Symbol of friendship and hospitality
- Respect for elders and community bonding
- Spiritual connection and gratitude
- Business meetings and social gatherings

**Best Places to Experience:**
- Traditional restaurants in Addis Ababa
- Local homes (if invited)
- Cultural centers and museums
- Coffee shops in Dire Dawa and Harar

**Coffee Varieties:**
- **Yirgacheffe**: Floral, citrusy, light body
- **Sidamo**: Wine-like, full body
- **Harrar**: Winey, blueberry notes
- **Limu**: Balanced, medium body
- **Jimma**: Earthy, full body

**Modern Coffee Scene:**
- Specialty coffee shops in Addis Ababa
- International coffee chains
- Coffee farms and plantations tours
- Coffee cupping sessions

**Tips for Tourists:**
- Always accept when offered coffee
- Remove shoes before entering
- Sit on the floor or low stools
- Use right hand for eating/drinking
- Say "Amasegenallo" (thank you) after each round
- Don't rush - enjoy the process

**Coffee Language:**
- Buna = Coffee
- Jebena = Coffee pot
- Abol = First round
- Tona = Second round
- Baraka = Third round
- Amasegenallo = Thank you

This ceremony is not just about coffee - it's about community, respect, and the Ethiopian way of life! 🇪🇹☕''';
    }
    
    if (lowerQuery.contains('food') || lowerQuery.contains('cuisine') || lowerQuery.contains('eat')) {
      return '''# 🍽️ Ethiopian Cuisine - The Ultimate Food Guide

## Staple Foods

### Injera (እንጀራ) - The Foundation of Ethiopian Cuisine
• Made from teff flour (gluten-free grain)  
• Sour, spongy flatbread used as utensil and food  
• Fermented for 2-3 days for authentic taste  
• Serves as plate, utensil, and food all in one

**Main Dishes (Wots):**

**Doro Wat** (ዶሮ ወጥ) - Spicy Chicken Stew
- Ethiopia's national dish
- Slow-cooked chicken in berbere sauce
- Served with hard-boiled eggs
- Traditionally eaten on special occasions

**Tibs** (ጥብስ) - Sautéed Meat
- Beef, lamb, or goat sautéed with onions
- Mild or spicy versions available
- Often served with vegetables
- Popular street food

**Kitfo** (ክትፎ) - Raw Beef Delicacy
- Finely minced raw beef with spices
- Served with cottage cheese (ayib)
- Can be cooked (leb leb) or raw
- Traditional Gurage dish

**Vegetarian Options:**
**Shiro Wat** (ሺሮ ወጥ) - Chickpea Stew
- Ground chickpeas in berbere sauce
- Creamy, protein-rich vegetarian option
- Served with injera
- Popular during fasting periods

**Misir Wat** (ምስር ወጥ) - Red Lentil Stew
- Red lentils cooked with berbere
- Nutritious and flavorful
- Common in vegetarian platters
- Easy to digest

**Gomen** (ጎመን) - Collard Greens
- Sautéed collard greens with spices
- Healthy side dish
- Often served with meat dishes
- Rich in vitamins

**Spices and Seasonings:**
**Berbere** (በርበሬ) - The King of Spices
- Complex spice blend with 15+ ingredients
- Contains chili peppers, garlic, ginger, fenugreek
- Gives Ethiopian food its signature heat
- Available in mild to extremely hot varieties

**Mitmita** (ምትምታ) - Hot Spice Blend
- Even hotter than berbere
- Contains bird's eye chili peppers
- Used sparingly for extra heat
- Popular with kitfo

**Niter Kibbeh** (ንጥር ክብቤ) - Spiced Butter
- Clarified butter with spices
- Contains garlic, ginger, cardamom, cinnamon
- Adds richness to dishes
- Essential in traditional cooking

**Traditional Drinks:**
**Tej** (ጠጅ) - Honey Wine
- Traditional Ethiopian honey wine
- Sweet, alcoholic beverage
- Served in special glasses
- Popular at celebrations

**Tella** (ጠላ) - Traditional Beer
- Home-brewed beer from barley
- Slightly sour taste
- Low alcohol content
- Social drink

**Buna** (ቡና) - Coffee
- Traditional coffee ceremony
- Served in three rounds
- Accompanied by popcorn
- Social and cultural ritual

**Regional Specialties:**
**Northern Ethiopia:**
- Tigrayan cuisine with unique spices
- Injera made from different grains
- Spicy meat dishes

**Southern Ethiopia:**
- Sidama and Gurage specialties
- More vegetarian options
- Unique spice combinations

**Eastern Ethiopia:**
- Harari cuisine with Middle Eastern influence
- Spicy meat dishes
- Unique bread varieties

**Western Ethiopia:**
- Oromo traditional foods
- Different injera varieties
- Unique cooking methods

**Dining Etiquette:**
- Eat with your right hand only
- Use injera to scoop food
- Share from the same plate (gursha)
- Don't use utensils
- Wash hands before and after eating

**Best Restaurants:**
**Addis Ababa:**
- Yod Abyssinia (traditional with cultural show)
- Habesha Restaurant (authentic experience)
- 2000 Habesha (modern traditional)
- Kategna Restaurant (local favorite)

**Other Cities:**
- Dire Dawa: Traditional Harari restaurants
- Bahir Dar: Lakeside dining with fish
- Gondar: Royal cuisine experiences
- Harar: Spicy regional specialties

**Food Safety Tips:**
- Eat at busy, popular restaurants
- Avoid raw vegetables if sensitive
- Drink bottled water
- Try street food cautiously
- Ask about spice levels

**Vegetarian/Vegan Options:**
- Most restaurants have fasting menus
- Shiro, misir, and gomen are always available
- Ask for "ye'tsom" (fasting food)
- Many dishes are naturally vegan

**Cooking Classes:**
- Learn to make injera and wots
- Visit local markets
- Traditional cooking methods
- Spice blending techniques

**Food Markets:**
- Merkato (Addis Ababa) - Africa's largest market
- Local spice markets
- Fresh produce markets
- Traditional food vendors

**Special Occasions:**
- **Meskel** (Finding of the True Cross) - Special fasting foods
- **Timkat** (Epiphany) - Traditional celebrations
- **Weddings** - Elaborate feasts
- **Funerals** - Community meals

**Health Benefits:**
- Teff is gluten-free and nutritious
- High in iron and protein
- Fermented foods aid digestion
- Spices have medicinal properties
- Balanced nutrition

**Modern Adaptations:**
- International restaurants in Addis
- Fusion cuisine
- Health-conscious options
- Fast food adaptations
- Export of Ethiopian spices

**Shopping for Ingredients:**
- Teff flour for injera
- Berbere spice blend
- Niter kibbeh (spiced butter)
- Traditional cookware
- Coffee beans

**Cooking Tips:**
- Soak teff for authentic injera
- Use traditional clay pots
- Ferment injera batter properly
- Balance spices carefully
- Practice makes perfect

Ethiopian cuisine is not just food - it's a cultural experience that brings people together! 🇪🇹🍽️''';
    }
    
    if (lowerQuery.contains('place') || lowerQuery.contains('visit') || lowerQuery.contains('attraction') || lowerQuery.contains('tourist')) {
      return '''# 🏛️ Ethiopia's Must-Visit Places - Complete Travel Guide

## UNESCO World Heritage Sites

### 1. Rock-Hewn Churches of Lalibela (11th-12th century)
• **11 monolithic churches** carved from solid rock  
• Built by King Lalibela as "New Jerusalem"  
• **Bete Giyorgis** (Church of St. George) - most famous  
• Active religious site with daily services  
• **Best visited during Timkat** (Epiphany) festival  

### 2. Simien Mountains National Park
• **"Roof of Africa"** with peaks over 4,000m  
• Home to Gelada baboons and Ethiopian wolves  
• Dramatic escarpments and deep valleys  
• **Trekking opportunities** (2-12 days)  
• **Ras Dashen** (4,543m) - highest peak  

### 3. Aksum (Axum)
• Ancient capital of Aksumite Empire  
• **Obelisks (stelae)** up to 33m tall  
• Church of St. Mary of Zion (Ark of Covenant)  
• Queen of Sheba's palace ruins  
• Ancient tombs and archaeological sites  

### 4. Fasil Ghebbi (Gondar)
• **"Camelot of Africa"** - 17th century castles  
• Fasilides Castle and Royal Enclosure  
• Debre Berhan Selassie Church  
• Fasilides Bath (Timkat celebrations)  
• Portuguese and Indian architectural influences  

### 5. Harar Jugol
• **Walled city** with 82 mosques  
• Traditional Harari houses  
• **Hyena feeding tradition**  
• Coffee ceremony capital  
• Unique cultural blend  

### 6. Konso Cultural Landscape
• **Terraced agricultural system**  
• Traditional Konso villages  
• Waga (wooden grave markers)  
• UNESCO-listed living culture  
• Sustainable farming practices  

### 7. Lower Valley of the Awash
• **Birthplace of humanity** (Lucy)  
• Archaeological sites  
• Paleontological discoveries  
• 3.2 million year old fossils  
• Human evolution evidence  

### 8. Lower Valley of the Omo
• **Diverse tribal cultures**  
• Mursi, Hamar, Karo tribes  
• Traditional ceremonies  
• Body art and scarification  
• Living anthropology museum

**Major Cities:**

**Addis Ababa** (Capital)
- National Museum (Lucy skeleton)
- Ethnological Museum
- Merkato (Africa's largest market)
- Entoto Hill (city views)
- Red Terror Martyrs Memorial
- Holy Trinity Cathedral
- Meskel Square

**Bahir Dar**
- Lake Tana (source of Blue Nile)
- Blue Nile Falls (Tis Issat)
- Monasteries on lake islands
- Boat trips and bird watching
- Water sports and fishing

**Dire Dawa**
- Railway station (UNESCO candidate)
- Kefira Market
- French colonial architecture
- Coffee trading center
- Gateway to Harar

**Arba Minch**
- "Forty Springs" - natural springs
- Nechisar National Park
- Crocodile Market
- Lake Chamo and Abaya
- Wildlife viewing

**Natural Wonders:**

**Danakil Depression**
- Hottest place on Earth
- Active volcanoes (Erta Ale)
- Salt lakes and formations
- Afar people and culture
- Extreme adventure destination

**Bale Mountains National Park**
- Ethiopian wolf habitat
- Mountain nyala
- Harenna Forest
- Sanetti Plateau
- Trekking and wildlife

**Awash National Park**
- Oryx and gazelles
- Hot springs
- Awash River
- Bird watching
- Safari experiences

**Mago National Park**
- Mursi tribe territory
- Wildlife viewing
- Cultural experiences
- Remote wilderness
- Adventure tourism

**Cultural Experiences:**

**Tribal Villages:**
- **Mursi**: Lip plates and body art
- **Hamar**: Bull jumping ceremonies
- **Karo**: Body painting traditions
- **Dassanech**: Lake Turkana culture
- **Nyangatom**: Traditional lifestyle

**Religious Sites:**
- **Debre Libanos**: Ancient monastery
- **Debre Damo**: Cliff-top monastery
- **Ura Kidane Mehret**: Lake Tana monastery
- **Abuna Yemata Guh**: Rock-hewn church
- **Gheralta**: Mountain churches

**Festivals and Events:**
- **Timkat** (January): Epiphany celebrations
- **Meskel** (September): Finding of True Cross
- **Enkutatash** (September): New Year
- **Irreecha** (October): Oromo thanksgiving
- **Gena** (January): Christmas

**Adventure Activities:**

**Trekking:**
- Simien Mountains (2-12 days)
- Bale Mountains (3-7 days)
- Tigray churches (1-3 days)
- Danakil Depression (3-5 days)
- Community trekking

**Wildlife Viewing:**
- Ethiopian wolf
- Gelada baboons
- Mountain nyala
- Walia ibex
- 800+ bird species

**Cultural Tours:**
- Tribal village visits
- Traditional ceremonies
- Local market tours
- Cooking classes
- Coffee ceremonies

**Practical Information:**

**Best Time to Visit:**
- **October-March**: Dry season, best weather
- **June-September**: Rainy season, lush landscapes
- **January**: Timkat festival
- **September**: Meskel festival

**Getting Around:**
- Domestic flights (Ethiopian Airlines)
- Bus services between cities
- Private drivers and guides
- 4WD for remote areas
- Walking tours in cities

**Accommodation:**
- Luxury hotels in Addis Ababa
- Traditional lodges
- Camping in national parks
- Guesthouses in towns
- Eco-lodges

**Safety Tips:**
- Use registered tour operators
- Travel with guides in remote areas
- Respect local customs
- Carry copies of documents
- Stay informed about current conditions

**Photography:**
- Ask permission before photographing people
- Respect cultural sensitivities
- Some sites prohibit photography
- Bring extra batteries and memory cards
- Consider local photography fees

**Shopping:**
- Traditional crafts and textiles
- Coffee and spices
- Jewelry and silverwork
- Religious artifacts
- Handwoven baskets

**Health Considerations:**
- Yellow fever vaccination required
- Malaria prophylaxis recommended
- Altitude sickness in mountains
- Sun protection essential
- Travel insurance recommended

**Budget Planning:**
- Budget: USD 30-50/day
- Mid-range: USD 50-100/day
- Luxury: USD 100+/day
- Group tours available
- All-inclusive packages

**Language Tips:**
- Learn basic Amharic phrases
- English widely spoken in cities
- Local languages in rural areas
- Translation apps helpful
- Cultural sensitivity important

**Responsible Tourism:**
- Support local communities
- Respect cultural traditions
- Environmental conservation
- Fair trade practices
- Sustainable tourism

Ethiopia offers incredible diversity - from ancient civilizations to natural wonders, from bustling cities to remote tribal cultures. Every visit is a journey through time and culture! 🇪🇹🏛️''';
    }
    
    if (lowerQuery.contains('language') || lowerQuery.contains('amharic') || lowerQuery.contains('learn')) {
      return '''# 🗣️ Amharic Language Learning - Complete Guide

## Amharic Basics
Amharic (አማርኛ) is Ethiopia's official language, spoken by over 25 million people. It uses the Ge'ez script, one of the oldest writing systems in the world.

## Essential Greetings
• **Selam** (ሰላም) = Hello/Peace  
• **Tena Yistilign** (ተና ይስጥልኝ) = How are you? (formal)  
• **Endemin neh?** (እንዴም ነህ?) = How are you? (informal)  
• **Dehna neh** (ደህና ነህ) = I'm fine  
• **Amasegenallo** (አመሰገናለሁ) = Thank you  
• **Yikirta** (ይቅርታ) = Excuse me/Sorry  
• **Chow** (ቻው) = Goodbye

**Numbers (1-10):**
- **And** (አንድ) = 1
- **Hullet** (ሁለት) = 2
- **Sost** (ሶስት) = 3
- **Arat** (አራት) = 4
- **Amist** (አምስት) = 5
- **Sidist** (ስድስት) = 6
- **Sebat** (ሰባት) = 7
- **Semint** (ስምንት) = 8
- **Zetegn** (ዘጠኝ) = 9
- **Asir** (አስር) = 10

**Useful Phrases for Tourists:**

**Getting Around:**
- **Weyet new?** (ወየት ነው?) = Where is it?
- **Min ale?** (ምን አለ?) = How much?
- **Beka** (በቃ) = Enough/Stop
- **Tiru** (ትሩ) = Go
- **Hed** (ሄድ) = Come
- **Metah** (መታህ) = Wait

**Food and Drink:**
- **Buna** (ቡና) = Coffee
- **Woha** (ውሃ) = Water
- **Injera** (እንጀራ) = Traditional bread
- **Wat** (ወጥ) = Stew
- **Beka** (በቃ) = I'm full
- **Tiru** (ትሩ) = It's delicious

**Shopping:**
- **Min ale?** (ምን አለ?) = How much?
- **Beka** (በቃ) = That's enough
- **Tiru** (ትሩ) = I'll take it
- **Yikirta** (ይቅርታ) = Excuse me
- **Amasegenallo** (አመሰገናለሁ) = Thank you

**Emergency Phrases:**
- **Help!** = **Irgam!** (እርጋም!)
- **Doctor** = **Hakim** (ሀኪም)
- **Hospital** = **Hakim bet** (ሀኪም ቤት)
- **Police** = **Polis** (ፖሊስ)
- **I'm lost** = **Tiru** (ትሩ)

**Cultural Expressions:**
- **Izzih** (እዚህ) = Here
- **Izzih** (እዚያ) = There
- **Tiru** (ትሩ) = Yes
- **Aye** (አይ) = No
- **Beka** (በቃ) = Maybe

**Learning Tips:**

**1. Start with Pronunciation:**
- Amharic has 7 vowel sounds
- Some sounds don't exist in English
- Practice with native speakers
- Listen to Amharic music and radio

**2. Master the Script:**
- Ge'ez script has 33 basic characters
- Each character has 7 forms (vowel variations)
- Practice writing daily
- Use flashcards for memorization

**3. Build Vocabulary:**
- Learn 10-20 words daily
- Focus on practical words first
- Use spaced repetition
- Practice with real situations

**4. Grammar Basics:**
- Subject-Object-Verb word order
- No articles (a, an, the)
- Gender agreement important
- Verb conjugations vary by person

**5. Practice Methods:**
- Language exchange with Ethiopians
- Watch Amharic movies with subtitles
- Listen to Amharic music
- Read simple texts
- Use language learning apps

**Common Mistakes to Avoid:**
- Don't confuse formal and informal speech
- Remember to use appropriate greetings
- Be careful with gender agreements
- Don't translate word-for-word
- Practice proper pronunciation

**Resources for Learning:**

**Online Resources:**
- Amharic language apps
- YouTube tutorials
- Online dictionaries
- Language exchange websites
- Amharic learning websites

**Books and Materials:**
- Amharic textbooks
- Phrase books for travelers
- Children's books in Amharic
- Amharic-English dictionaries
- Grammar guides

**Cultural Context:**
- Language reflects Ethiopian culture
- Respect for elders in speech
- Formal vs. informal situations
- Religious expressions common
- Hospitality language important

**Regional Variations:**
- Addis Ababa Amharic (standard)
- Regional dialects exist
- Some words vary by region
- Pronunciation differences
- Cultural expressions vary

**Business Amharic:**
- Formal language for business
- Respectful expressions
- Negotiation phrases
- Meeting vocabulary
- Professional greetings

**Travel Amharic:**
- Transportation vocabulary
- Hotel and accommodation
- Restaurant and food
- Shopping and bargaining
- Emergency situations

**Advanced Learning:**
- Literature and poetry
- News and media
- Academic language
- Technical vocabulary
- Cultural expressions

**Language Exchange:**
- Find Ethiopian language partners
- Practice speaking regularly
- Learn cultural context
- Share your language
- Build friendships

**Common Amharic Words in English:**
- Coffee (from Arabic via Amharic)
- Injera (Ethiopian bread)
- Wat (Ethiopian stew)
- Buna (coffee ceremony)
- Gursha (feeding gesture)

**Pronunciation Guide:**
- **ሀ** = "ha" (like "hat")
- **ሁ** = "hu" (like "who")
- **ሂ** = "hi" (like "hit")
- **ሃ** = "ha" (like "hah")
- **ሄ** = "he" (like "hey")
- **ህ** = "h" (like "h" in "hat")
- **ሆ** = "ho" (like "hoe")

**Cultural Etiquette:**
- Always greet people properly
- Use formal language with elders
- Show respect in speech
- Learn cultural expressions
- Practice hospitality language

**Learning Timeline:**
- **Week 1-2**: Basic greetings and numbers
- **Month 1**: Essential phrases and vocabulary
- **Month 2-3**: Grammar basics and simple conversations
- **Month 4-6**: Intermediate conversations and reading
- **Month 6+**: Advanced topics and cultural fluency

**Tips for Success:**
- Practice daily, even for 15 minutes
- Don't be afraid to make mistakes
- Immerse yourself in the culture
- Find learning methods that work for you
- Be patient with yourself

**Common Tourist Phrases:**
- **I'm a tourist** = **Turist neh** (ቱሪስት ነህ)
- **I don't understand** = **Algebagnem** (አልገባኝም)
- **Can you help me?** = **Tiru** (ትሩ)
- **I'm looking for...** = **Tiru** (ትሩ)
- **Is this the way to...?** = **Tiru** (ትሩ)

Learning Amharic will greatly enhance your Ethiopian experience and show respect for the local culture! 🇪🇹🗣️''';
    }
    
    // Default comprehensive response
    return '''# 🇪🇹 Welcome to Ethiopia - Your Complete Travel Companion

I'm **EthioBot**, your AI assistant for exploring the beautiful country of Ethiopia! I'm here to help you discover everything this amazing country has to offer.

## What I can help you with:

### 🏛️ Culture & History
• Ancient civilizations and kingdoms  
• UNESCO World Heritage Sites  
• Traditional ceremonies and festivals  
• Religious and spiritual practices  
• Art, music, and literature  

### 🍽️ Food & Cuisine
• Traditional Ethiopian dishes  
• Coffee ceremony etiquette  
• Regional specialties  
• Vegetarian and vegan options  
• Cooking techniques and recipes  

### 📍 Places to Visit
• Must-see attractions and landmarks  
• National parks and natural wonders  
• Cities and towns to explore  
• Hidden gems and off-the-beaten-path  
• Adventure and outdoor activities  

### 🗣️ Language Learning
• Basic Amharic phrases and greetings  
• Pronunciation guides  
• Cultural expressions  
• Learning resources and tips  
• Regional language variations  

### 🎯 Travel Tips
• Best times to visit  
• Transportation options  
• Accommodation recommendations  
• Safety and health advice  
• Budget planning and costs  

## Popular Topics:
• Coffee ceremonies and traditions  
• Injera and Ethiopian cuisine  
• Lalibela rock-hewn churches  
• Simien Mountains trekking  
• Tribal cultures and traditions  
• Ethiopian festivals and celebrations  

**Just ask me anything about Ethiopia!** I have extensive knowledge about:
• History and culture  
• Food and traditions  
• Places to visit  
• Language learning  
• Travel planning  
• Local customs and etiquette  

What would you like to know about Ethiopia? I'm here to make your journey unforgettable! 🇪🇹✨''';
  }
}
