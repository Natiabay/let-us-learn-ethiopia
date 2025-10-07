import 'package:tourist_assistive_app/features/chatbot/models/chat_message.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';

class ChatbotService {
  // User context tracking
  LatLng? _userLocation;
  String? _userCity;
  List<String> _userInterests = [];
  List<String> _visitedLocations = [];
  DateTime? _lastInteraction;
  String? _currentActivity;
  
  // Enhanced Ethiopian tourism knowledge base with location data
  static final Map<String, dynamic> _knowledgeBase = {
    'greetings': {
      'keywords': ['hello', 'hi', 'good morning', 'good afternoon', 'greetings', 'selam'],
      'responses': [
        '''# 🇪🇹 Welcome to ETHIO-TOUR!

**ሰላም!** I'm your personal Ethiopian travel assistant, here to help you discover the incredible beauty and rich culture of Ethiopia.

## 🎯 How I Can Help You:

• **🗺️ Travel Planning** - Find the best places to visit
• **🍽️ Local Cuisine** - Discover authentic Ethiopian food
• **🏛️ Cultural Sites** - Explore historical landmarks
• **🚗 Transportation** - Get around efficiently
• **💬 Language Learning** - Learn basic Amharic phrases
• **🌤️ Weather & Climate** - Plan for the perfect trip

## 🚀 Quick Start:
Ask me anything about Ethiopia - from the rock churches of Lalibela to the coffee ceremonies in Addis Ababa!

*What would you like to explore first?*''',
        '''# 🇪🇹 ETHIO-TOUR Assistant

**Hello!** I'm here to be your comprehensive guide to Ethiopia. Whether you're planning your first visit or looking to discover hidden gems, I've got you covered.

## 📋 Popular Topics:
• **🏛️ UNESCO World Heritage Sites**
• **🍽️ Traditional Ethiopian Cuisine** 
• **🏔️ Natural Wonders & Wildlife**
• **🎭 Cultural Experiences**
• **🚗 Transportation & Logistics**

*What interests you most about Ethiopia?*''',
        '''# 🇪🇹 Ready for Adventure!

**Good day!** Welcome to your Ethiopian journey. I'm excited to help you explore this amazing country.

## 🌟 Top Experiences:
• **Lalibela** - Ancient rock-hewn churches
• **Simien Mountains** - Breathtaking landscapes
• **Danakil Depression** - Unique geological wonders
• **Harar** - Historic walled city
• **Addis Ababa** - Vibrant capital city

*Where would you like to start your Ethiopian adventure?*''',
      ],
    },
    'weather': {
      'keywords': ['weather', 'temperature', 'climate', 'rain', 'dry', 'hot', 'cold'],
      'responses': [
        '''# 🌤️ Ethiopia Weather Guide

Ethiopia's climate is incredibly diverse due to its varied topography!

## 🌡️ Temperature Ranges:
• **Addis Ababa** - 15-25°C year-round (mild & pleasant)
• **Highland Areas** - Cooler, often 10-20°C
• **Danakil Depression** - Can reach 50°C+ (hottest place on Earth!)
• **Lowland Areas** - Generally warmer, 25-35°C

## 📅 Best Travel Seasons:
• **🌞 Dry Season** - October to May (Recommended)
• **🌧️ Rainy Season** - June to September (Still beautiful, but wetter)

## 🎯 Regional Highlights:
• **🏔️ Simien Mountains** - Cool mountain climate
• **🏜️ Danakil** - Extreme heat, visit in cooler months
• **🏛️ Lalibela** - Pleasant year-round
• **🌊 Lake Tana** - Moderate temperatures

*Would you like specific weather information for a particular region or time of year?*''',
      ],
    },
    'food': {
      'keywords': ['food', 'eat', 'restaurant', 'injera', 'doro wat', 'coffee', 'cuisine', 'spicy'],
      'responses': [
        '''# 🍽️ Ethiopian Cuisine Guide

Ethiopian food is a true culinary adventure! 🇪🇹

## 🥘 Must-Try Dishes:
• **🍗 Doro Wat** - Spicy chicken stew (national dish)
• **🥖 Injera** - Sourdough flatbread (staple food)
• **🥩 Tibs** - Grilled meat with spices
• **🌶️ Kitfo** - Minced raw beef (for the adventurous!)
• **🥬 Gomen** - Collard greens with spices

## ☕ Coffee Culture:
• **🇪🇹 Birthplace of Coffee** - Ethiopia is where coffee originated!
• **☕ Coffee Ceremony** - Traditional 3-hour ritual
• **🌱 Fresh Roasting** - Beans roasted right before brewing

## 🥗 Dietary Options:
• **🌱 Vegetarian** - Excellent fasting food (vegan dishes)
• **🥛 Dairy-Free** - Many traditional dishes are naturally dairy-free
• **🌶️ Spice Levels** - Can be adjusted to your preference

## 🍴 Dining Etiquette:
• **🤲 Eat with your hands** - Traditional way using injera
• **👥 Share plates** - Meals are communal experiences
• **💧 Wash hands** - Before and after eating

*What type of Ethiopian food interests you most?*''',
      ],
    },
    'transport': {
      'keywords': ['transport', 'bus', 'taxi', 'flight', 'travel', 'airport', 'getting around'],
      'responses': [
        '''# 🚗 Transportation in Ethiopia

Getting around Ethiopia is an adventure in itself! Here's your complete guide:

## 🚌 City Transport:
• **🚌 Blue Minibuses** - Main city transport (very affordable)
• **🚕 Taxis** - Available in major cities
• **📱 Ride-Sharing** - Apps available in Addis Ababa
• **🚶 Walking** - Great way to explore city centers

## 🚐 Long-Distance Travel:
• **🚌 Intercity Buses** - Connect major cities
• **✈️ Domestic Flights** - Fast option for long distances
• **🚗 Private Cars** - For flexibility and comfort

## 🏔️ Remote Areas:
• **🏔️ Simien Mountains** - Organized tours recommended
• **🏜️ Danakil Depression** - Guided expeditions only
• **🌋 Active Volcanoes** - Specialized tour operators

## ✈️ Airports:
• **🛫 Bole International** - Main international gateway (Addis Ababa)
• **🛫 Regional Airports** - Connect to major tourist destinations

## 💡 Pro Tips:
• **📅 Book ahead** - Especially for popular routes
• **💰 Budget-friendly** - Public transport is very affordable
• **⏰ Time flexibility** - Allow extra time for delays
• **🎒 Pack light** - Easier to move around

*What type of transportation are you planning to use?*''',
      ],
    },
    'attractions': {
      'keywords': ['visit', 'see', 'attraction', 'lalibela', 'axum', 'gondar', 'simien', 'danakil', 'harar', 'places'],
      'responses': [
        'Ethiopia\'s top attractions: 🏛️ Lalibela rock churches (UNESCO site), 🏰 Gondar castles, 🗿 Axum obelisks, 🏔️ Simien Mountains wildlife, 🌋 Danakil Depression (hottest place on Earth), 🕌 Harar\'s ancient walls. Which type interests you - historical, natural, or cultural?',
      ],
      'locations': {
        'lalibela': {
          'name': 'Lalibela Rock Churches',
          'coordinates': {'lat': 12.0317, 'lng': 39.0417},
          'description': '11 medieval rock-hewn churches, UNESCO World Heritage Site',
          'best_time': 'October to March',
          'entry_fee': 'Free (donations welcome)',
          'nearby_attractions': ['Bete Giyorgis', 'Bete Medhane Alem', 'Bete Maryam'],
        },
        'gondar': {
          'name': 'Gondar Castles',
          'coordinates': {'lat': 12.6075, 'lng': 37.4661},
          'description': 'Royal castles and palaces from the 17th century',
          'best_time': 'October to March',
          'entry_fee': '200 ETB',
          'nearby_attractions': ['Fasil Ghebbi', 'Debre Berhan Selassie Church'],
        },
        'axum': {
          'name': 'Axum Obelisks',
          'coordinates': {'lat': 14.1207, 'lng': 38.7268},
          'description': 'Ancient obelisks and archaeological sites',
          'best_time': 'October to March',
          'entry_fee': '150 ETB',
          'nearby_attractions': ['St. Mary of Zion Church', 'Queen of Sheba\'s Palace'],
        },
        'simien': {
          'name': 'Simien Mountains National Park',
          'coordinates': {'lat': 13.1833, 'lng': 38.0667},
          'description': 'UNESCO World Heritage Site with endemic wildlife',
          'best_time': 'October to March',
          'entry_fee': '90 ETB per day',
          'nearby_attractions': ['Ras Dashen Peak', 'Gelada Baboons', 'Ethiopian Wolf'],
        },
        'danakil': {
          'name': 'Danakil Depression',
          'coordinates': {'lat': 14.2417, 'lng': 40.3000},
          'description': 'Hottest place on Earth with otherworldly landscapes',
          'best_time': 'November to March',
          'entry_fee': 'Organized tours required',
          'nearby_attractions': ['Erta Ale Volcano', 'Dallol Sulfur Springs', 'Salt Lakes'],
        },
        'harar': {
          'name': 'Harar Jugol',
          'coordinates': {'lat': 9.3167, 'lng': 42.1167},
          'description': 'Ancient walled city with 82 mosques',
          'best_time': 'October to March',
          'entry_fee': 'Free',
          'nearby_attractions': ['Hyena Feeding', 'Harar Museum', 'Arthur Rimbaud House'],
        },
      },
    },
    'culture': {
      'keywords': ['culture', 'tradition', 'customs', 'etiquette', 'religion', 'orthodox', 'muslim'],
      'responses': [
        'Ethiopian culture is diverse! 🎭 Major groups: Orthodox Christianity (45%), Islam (35%), traditional beliefs. Greet elders with both hands. Remove shoes entering homes/churches. Coffee ceremonies show hospitality. Learn basic Amharic phrases - locals appreciate it! Tipping 10-15% is customary. Any specific cultural questions?',
      ],
    },
    'money': {
      'keywords': ['money', 'currency', 'birr', 'exchange', 'atm', 'credit card', 'payment'],
      'responses': [
        'Currency: Ethiopian Birr (ETB). 💰 Exchange at banks or authorized dealers. ATMs available in major cities but carry cash for rural areas. Credit cards accepted in upscale hotels/restaurants. US Dollars widely accepted. Current rate: ~1 USD = 55 ETB (fluctuates). Need money exchange locations?',
      ],
    },
    'safety': {
      'keywords': ['safe', 'security', 'dangerous', 'crime', 'police', 'emergency'],
      'responses': [
        'Ethiopia is generally safe for tourists! 🛡️ Common sense applies: don\'t flash valuables, stay in groups at night, use reputable tour operators for remote areas. Emergency numbers: Police 991, Fire 939, Medical 907. Tourist police available in major sites. Avoid border regions. Need specific area safety info?',
      ],
    },
    'language': {
      'keywords': ['language', 'amharic', 'english', 'speak', 'translate', 'learn'],
      'responses': [
        'Languages: Amharic (official), English (widely spoken in cities), 80+ local languages! 📚 Learn basic Amharic: ሰላም (selam) = hello, አመሰግናለሁ (ameseginaleh) = thank you. Use our app\'s translation feature! In tourist areas, English is common. Rural areas may need local guides.',
      ],
    },
    'accommodation': {
      'keywords': ['hotel', 'accommodation', 'stay', 'lodge', 'guesthouse', 'camping'],
      'responses': [
        'Accommodation options: International hotels in Addis Ababa, local guesthouses for authentic experience, camping in national parks, mountain lodges in Simien Mountains. Book ahead for peak season (Dec-Jan, Jul-Aug). Budget: 10-30 USD, Mid-range: 30-80 USD, Luxury: 80+ USD. Need recommendations?',
      ],
    },
    'health': {
      'keywords': ['health', 'vaccination', 'medicine', 'hospital', 'doctor', 'sick', 'altitude'],
      'responses': [
        'Health tips: 💉 Yellow fever vaccination required if coming from infected areas. Malaria risk in lowlands - bring prophylaxis. Altitude sickness possible in highlands. Drink bottled water. Good hospitals in Addis Ababa. Travel insurance recommended. Pack basic meds. Need specific health advice for your activities?',
      ],
    },
    'time': {
      'keywords': ['time', 'timezone', 'clock', 'calendar', 'hours'],
      'responses': [
        'Time in Ethiopia: ⏰ Ethiopian time counts from sunrise (6 AM = 12 o\'clock Ethiopian time). Ethiopian calendar has 13 months! We\'re 7-8 years behind Gregorian calendar. Timezone: EAT (UTC+3). Most tourist services use international time, but clarify with locals!',
      ],
    },
    'festivals': {
      'keywords': ['festival', 'celebration', 'timkat', 'meskel', 'genna', 'holiday'],
      'responses': [
        'Ethiopian festivals: 🎉 Timkat (Epiphany, Jan 19) - colorful Orthodox celebration, 🌼 Meskel (Finding of True Cross, Sep 27), 🎄 Genna (Christmas, Jan 7), 🌙 Irreecha (Oromo thanksgiving, Oct). Join local celebrations for authentic cultural experience! Each region has unique festivals too.',
      ],
    },
    'emergency': {
      'keywords': ['emergency', 'help', 'police', 'ambulance', 'fire', 'urgent'],
      'responses': [
        '🚨 EMERGENCY NUMBERS:\n• Police: 991\n• Medical: 907\n• Fire: 939\n• Tourist Police: Ask hotel for number\n\nFor immediate help:\n• Go to nearest hotel lobby\n• Contact your embassy\n• Tourist areas have English speakers\n• Show this message to locals if needed',
      ],
    },
  };

  // Advanced responses for specific queries
  static const Map<String, String> _specificQueries = {
    'how much does it cost to visit lalibela': 'Lalibela visit costs: Entry is FREE (donations welcome). Guide: \$10-20/day. Accommodation: \$15-150/night. Flight from Addis: \$200-300. Total budget: \$50-200/day depending on comfort level.',
    'best time to visit ethiopia': 'Best time: October-March (dry season). December-January is peak (book early). Avoid June-September (rainy season) except for Danakil (accessible only then). April-May is shoulder season with good weather and fewer crowds.',
    'how to get to simien mountains': 'To Simien Mountains: Fly to Gondar (1hr from Addis), then 2-3hr drive to Debark (park HQ). From there, arrange guides and trek. Multi-day treks require camping/lodge bookings. Best months: October-March.',
    'is ethiopia safe for solo female travelers': 'Ethiopia is generally safe for solo female travelers with precautions: Stay in groups when possible, dress modestly (covering shoulders/knees), avoid walking alone at night, use reputable tour companies, and trust your instincts.',
    'what vaccinations do i need for ethiopia': 'Required: Yellow fever (if from infected areas). Recommended: Hepatitis A/B, Typhoid, Meningitis, Polio booster. Malaria prophylaxis for lowland areas. Consult travel clinic 4-6 weeks before travel.',
  };

  List<ChatMessage> _chatHistory = [];

  Future<ChatMessage> sendMessage(String userMessage) async {
    // Add user message to history
    final userMsg = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: userMessage,
      isUser: true,
      timestamp: DateTime.now(),
    );
    _chatHistory.add(userMsg);

    // Simulate processing time
    await Future.delayed(const Duration(milliseconds: 800));

    // Generate response
    final response = _generateResponse(userMessage.toLowerCase());
    
    final botMsg = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: response,
      isUser: false,
      timestamp: DateTime.now(),
    );
    _chatHistory.add(botMsg);

    return botMsg;
  }

  String _generateResponse(String userMessage) {
    // Check for specific queries first
    for (final query in _specificQueries.keys) {
      if (userMessage.contains(query.toLowerCase())) {
        return _specificQueries[query]!;
      }
    }

    // Check knowledge base
    for (final category in _knowledgeBase.keys) {
      final categoryData = _knowledgeBase[category] as Map<String, dynamic>;
      final keywords = categoryData['keywords'] as List<String>;
      
      for (final keyword in keywords) {
        if (userMessage.contains(keyword.toLowerCase())) {
          final responses = categoryData['responses'] as List<String>;
          return responses[DateTime.now().millisecond % responses.length];
        }
      }
    }

    // Fallback responses
    final fallbackResponses = [
      'That\'s an interesting question about Ethiopia! While I may not have specific information about that, I can help you with attractions, food, culture, transportation, safety, and more. What specific aspect of Ethiopian travel interests you?',
      'I\'d love to help you with that! I\'m specialized in Ethiopian tourism. Try asking about popular destinations like Lalibela, Simien Mountains, or Danakil Depression. You can also ask about food, culture, or practical travel tips!',
      'Let me help you explore Ethiopia! I have information about historical sites, natural wonders, cultural experiences, food, transportation, and safety. What would you like to know more about?',
      'Great question! While I focus on Ethiopian tourism, I can help with destinations, local customs, food recommendations, transportation options, and travel tips. What specific area would you like to explore?',
    ];

    return fallbackResponses[DateTime.now().millisecond % fallbackResponses.length];
  }

  List<ChatMessage> getChatHistory() => _chatHistory;

  void clearChat() {
    _chatHistory.clear();
  }

  // Get suggested questions for users
  List<String> getSuggestedQuestions() {
    return [
      'What are the top attractions in Ethiopia?',
      'What should I eat in Ethiopia?',
      'How do I get around Ethiopia?',
      'Is Ethiopia safe for tourists?',
      'What\'s the best time to visit?',
      'Tell me about Ethiopian culture',
      'How much does travel cost?',
      'What languages are spoken?',
      'Where should I stay?',
      'What festivals can I experience?',
    ];
  }

  // Get quick emergency info
  Map<String, String> getEmergencyInfo() {
    return {
      'Police': '991',
      'Medical Emergency': '907',
      'Fire Department': '939',
      'Tourist Police': 'Contact hotel',
      'US Embassy': '+251-11-130-6000',
      'UK Embassy': '+251-11-617-0100',
    };
  }

  // Get essential phrases
  List<Map<String, String>> getEssentialPhrases() {
    return [
      {'english': 'Hello', 'amharic': 'ሰላም (selam)'},
      {'english': 'Thank you', 'amharic': 'አመሰግናለሁ (ameseginaleh)'},
      {'english': 'How much?', 'amharic': 'ስንት ነው? (sent new?)'},
      {'english': 'Where is...?', 'amharic': 'የት ነው...? (yet new...?)'},
      {'english': 'Help', 'amharic': 'ረዳት (redat)'},
      {'english': 'Water', 'amharic': 'ውሃ (wuha)'},
      {'english': 'Food', 'amharic': 'ምግብ (megeb)'},
      {'english': 'Hotel', 'amharic': 'ሆቴል (hotel)'},
    ];
  }

  // Context-aware responses based on user location or interests
  String getContextualRecommendation(String userLocation, List<String> interests) {
    final recommendations = <String>[];

    if (userLocation.toLowerCase().contains('addis')) {
      recommendations.add('🏛️ Visit the National Museum to see Lucy\'s fossil');
      recommendations.add('🛍️ Explore Merkato, Africa\'s largest market');
      recommendations.add('☕ Experience traditional coffee ceremony');
    }

    if (interests.contains('history')) {
      recommendations.add('🏛️ Lalibela rock churches are unmissable');
      recommendations.add('🏰 Gondar\'s royal castles showcase imperial history');
      recommendations.add('🗿 Axum obelisks reveal ancient civilization');
    }

    if (interests.contains('nature')) {
      recommendations.add('🏔️ Trek Simien Mountains for endemic wildlife');
      recommendations.add('🌋 Danakil Depression offers otherworldly landscapes');
      recommendations.add('💧 Blue Nile Falls create spectacular views');
    }

    if (recommendations.isEmpty) {
      return 'Tell me more about your interests and location so I can give personalized recommendations!';
    }

    return 'Based on your interests, here are my recommendations:\n\n${recommendations.join('\n')}';
  }

  // Enhanced location-aware methods
  Future<void> updateUserLocation(LatLng coordinates) async {
    _userLocation = coordinates;
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        coordinates.latitude,
        coordinates.longitude,
      );
      if (placemarks.isNotEmpty) {
        _userCity = placemarks.first.locality ?? placemarks.first.administrativeArea;
      }
    } catch (e) {
      print('Error getting location name: $e');
    }
  }

  Future<ChatMessage> sendMessageWithContext(String userMessage) async {
    // Add user message to history
    final userMsg = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: userMessage,
      isUser: true,
      timestamp: DateTime.now(),
    );
    _chatHistory.add(userMsg);

    // Simulate processing time
    await Future.delayed(const Duration(milliseconds: 800));

    // Generate context-aware response
    final response = _generateContextualResponse(userMessage.toLowerCase());
    
    final botMsg = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: response,
      isUser: false,
      timestamp: DateTime.now(),
    );
    _chatHistory.add(botMsg);

    _lastInteraction = DateTime.now();
    return botMsg;
  }

  String _generateContextualResponse(String userMessage) {
    // Check for location-specific queries
    if (userMessage.contains('near me') || userMessage.contains('around here')) {
      return _getNearbyAttractions();
    }

    if (userMessage.contains('distance') || userMessage.contains('how far')) {
      return _getDistanceToAttractions(userMessage);
    }

    if (userMessage.contains('weather') && _userCity != null) {
      return _getLocalWeatherInfo();
    }

    if (userMessage.contains('restaurant') || userMessage.contains('food')) {
      return _getLocalFoodRecommendations();
    }

    // Check for specific attraction queries
    for (final attraction in _knowledgeBase['attractions']['locations'].keys) {
      if (userMessage.contains(attraction)) {
        return _getDetailedAttractionInfo(attraction);
      }
    }

    // Fall back to regular response generation
    return _generateResponse(userMessage);
  }

  String _getNearbyAttractions() {
    if (_userLocation == null) {
      return 'I\'d love to help you find nearby attractions! Please enable location services so I can give you personalized recommendations.';
    }

    final nearbyAttractions = <Map<String, dynamic>>[];
    final attractions = _knowledgeBase['attractions']['locations'] as Map<String, dynamic>;

    for (final attraction in attractions.values) {
      final coords = attraction['coordinates'] as Map<String, double>;
      final distance = _calculateDistance(
        _userLocation!.latitude,
        _userLocation!.longitude,
        coords['lat']!,
        coords['lng']!,
      );

      if (distance < 500) { // Within 500km
        nearbyAttractions.add({
          'name': attraction['name'],
          'distance': distance,
          'description': attraction['description'],
        });
      }
    }

    if (nearbyAttractions.isEmpty) {
      return 'I don\'t see any major attractions within 500km of your current location. Would you like me to suggest some popular destinations in Ethiopia?';
    }

    // Sort by distance
    nearbyAttractions.sort((a, b) => (a['distance'] as double).compareTo(b['distance'] as double));

    String response = 'Here are the attractions near you:\n\n';
    for (int i = 0; i < nearbyAttractions.length && i < 3; i++) {
      final attraction = nearbyAttractions[i];
      final distance = (attraction['distance'] as double).round();
      response += '📍 ${attraction['name']} - ${distance}km away\n';
      response += '${attraction['description']}\n\n';
    }

    return response;
  }

  String _getDistanceToAttractions(String userMessage) {
    if (_userLocation == null) {
      return 'I need your location to calculate distances. Please enable location services.';
    }

    final attractions = _knowledgeBase['attractions']['locations'] as Map<String, dynamic>;
    String response = 'Here are the distances to major attractions:\n\n';

    for (final attraction in attractions.values) {
      final coords = attraction['coordinates'] as Map<String, double>;
      final distance = _calculateDistance(
        _userLocation!.latitude,
        _userLocation!.longitude,
        coords['lat']!,
        coords['lng']!,
      );

      response += '📍 ${attraction['name']}: ${distance.round()}km\n';
    }

    return response;
  }

  String _getLocalWeatherInfo() {
    if (_userCity == null) {
      return 'I can provide weather information for your area. Please enable location services for accurate local weather.';
    }

    return 'Weather in $_userCity: Ethiopia has diverse climates! In most areas, it\'s typically 15-25°C year-round. The dry season (October-May) is best for travel. Highland areas are cooler, while lowlands can be much warmer. Would you like specific weather info for any attractions you\'re planning to visit?';
  }

  String _getLocalFoodRecommendations() {
    if (_userCity == null) {
      return 'Ethiopian cuisine is amazing! 🇪🇹 Try our national dish Doro Wat (spicy chicken stew) with Injera (sourdough flatbread). Coffee ceremonies are special cultural experiences - Ethiopia is coffee\'s birthplace! Vegetarian? Try fasting food (vegan dishes).';
    }

    return 'Food recommendations for $_userCity: Ethiopian cuisine is amazing! 🇪🇹 Try our national dish Doro Wat (spicy chicken stew) with Injera (sourdough flatbread). Coffee ceremonies are special cultural experiences - Ethiopia is coffee\'s birthplace! Vegetarian? Try fasting food (vegan dishes). Ask locals for the best traditional restaurants in your area!';
  }

  String _getDetailedAttractionInfo(String attractionName) {
    final attractions = _knowledgeBase['attractions']['locations'] as Map<String, dynamic>;
    final attraction = attractions[attractionName];

    if (attraction == null) {
      return 'I don\'t have detailed information about that attraction. Could you try asking about Lalibela, Gondar, Axum, Simien Mountains, Danakil Depression, or Harar?';
    }

    String response = '📍 ${attraction['name']}\n\n';
    response += '${attraction['description']}\n\n';
    response += '🕒 Best time to visit: ${attraction['best_time']}\n';
    response += '💰 Entry fee: ${attraction['entry_fee']}\n\n';
    
    if (attraction['nearby_attractions'] != null) {
      response += '🏛️ Nearby attractions:\n';
      for (final nearby in attraction['nearby_attractions']) {
        response += '• $nearby\n';
      }
    }

    if (_userLocation != null) {
      final coords = attraction['coordinates'] as Map<String, double>;
      final distance = _calculateDistance(
        _userLocation!.latitude,
        _userLocation!.longitude,
        coords['lat']!,
        coords['lng']!,
      );
      response += '\n📏 Distance from you: ${distance.round()}km';
    }

    return response;
  }

  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371; // Earth's radius in kilometers
    
    final double dLat = _degreesToRadians(lat2 - lat1);
    final double dLon = _degreesToRadians(lon2 - lon1);
    
    final double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(lat1)) * cos(_degreesToRadians(lat2)) *
        sin(dLon / 2) * sin(dLon / 2);
    
    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    
    return earthRadius * c;
  }

  double _degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }

  // Update user interests and preferences
  void updateUserInterests(List<String> interests) {
    _userInterests = interests;
  }

  void addVisitedLocation(String location) {
    if (!_visitedLocations.contains(location)) {
      _visitedLocations.add(location);
    }
  }

  void setCurrentActivity(String activity) {
    _currentActivity = activity;
  }

  // Get personalized recommendations based on user context
  String getPersonalizedRecommendations() {
    if (_userInterests.isEmpty && _visitedLocations.isEmpty) {
      return 'Tell me about your interests and I\'ll give you personalized recommendations! Do you prefer history, nature, culture, or adventure?';
    }

    String response = 'Based on your interests, here are my recommendations:\n\n';

    if (_userInterests.contains('history')) {
      response += '🏛️ Historical sites: Lalibela rock churches, Gondar castles, Axum obelisks\n';
    }

    if (_userInterests.contains('nature')) {
      response += '🏔️ Natural wonders: Simien Mountains, Danakil Depression, Blue Nile Falls\n';
    }

    if (_userInterests.contains('culture')) {
      response += '🎭 Cultural experiences: Harar old town, coffee ceremonies, traditional music\n';
    }

    if (_userInterests.contains('adventure')) {
      response += '🌋 Adventure activities: Danakil trekking, Simien hiking, volcano tours\n';
    }

    if (_visitedLocations.isNotEmpty) {
      response += '\n📍 You\'ve visited: ${_visitedLocations.join(', ')}\n';
      response += 'Consider exploring nearby attractions or trying something different!';
    }

    return response;
  }
}










