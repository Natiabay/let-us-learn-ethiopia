class EthiopiaKnowledgeBase {
  // Comprehensive knowledge about Ethiopia for the AI chatbot
  
  Map<String, List<LocationInfo>> get locations => {
    'Addis Ababa': [
      LocationInfo(
        name: 'National Museum of Ethiopia',
        description: 'Home to Lucy, the famous 3.2 million-year-old hominid fossil',
        category: 'museum',
        tips: 'Visit early morning to avoid crowds. Guided tours available in English.',
      ),
      LocationInfo(
        name: 'Mercato',
        description: 'Africa\'s largest open-air market',
        category: 'shopping',
        tips: 'Bargain hard! Keep valuables secure. Best visited with a local guide.',
      ),
      LocationInfo(
        name: 'Entoto Mountain',
        description: 'Scenic viewpoint with panoramic city views',
        category: 'nature',
        tips: 'Best visited at sunrise or sunset. Bring warm clothes - it gets cold!',
      ),
    ],
    'Lalibela': [
      LocationInfo(
        name: 'Rock-Hewn Churches',
        description: '11 medieval monolithic churches carved from rock',
        category: 'religious',
        tips: 'Wear comfortable shoes. Photography requires permits. Respectful dress required.',
      ),
    ],
    'Gondar': [
      LocationInfo(
        name: 'Fasil Ghebbi',
        description: 'Royal Enclosure with 17th-century castles',
        category: 'historical',
        tips: 'Hire a guide for historical context. Best visited in morning light.',
      ),
    ],
    'Bahir Dar': [
      LocationInfo(
        name: 'Lake Tana',
        description: 'Source of the Blue Nile with ancient monasteries',
        category: 'nature',
        tips: 'Boat trips available. Visit monasteries on islands. Bring sun protection.',
      ),
    ],
  };

  Map<String, List<FoodInfo>> get foods => {
    'Traditional': [
      FoodInfo(
        name: 'Injera',
        description: 'Sourdough flatbread made from teff flour',
        ingredients: ['teff flour', 'water', 'salt'],
        whereToFind: 'Available everywhere - it\'s the staple food',
        tips: 'Eat with your hands! Use injera to scoop up stews.',
      ),
      FoodInfo(
        name: 'Doro Wat',
        description: 'Spicy chicken stew with berbere spice',
        ingredients: ['chicken', 'onions', 'berbere', 'garlic', 'ginger'],
        whereToFind: 'Best at traditional restaurants like Yod Abyssinia',
        tips: 'Very spicy! Ask for mild version if you can\'t handle heat.',
      ),
      FoodInfo(
        name: 'Kitfo',
        description: 'Minced raw beef with spices',
        ingredients: ['beef', 'mitmita', 'niter kibbeh', 'cottage cheese'],
        whereToFind: 'Traditional restaurants, especially in Addis Ababa',
        tips: 'Can be ordered cooked if you prefer. Very rich and flavorful.',
      ),
    ],
    'Beverages': [
      FoodInfo(
        name: 'Ethiopian Coffee',
        description: 'Traditional coffee ceremony with roasted beans',
        ingredients: ['coffee beans', 'water', 'sugar'],
        whereToFind: 'Coffee ceremonies in hotels, restaurants, and homes',
        tips: 'The ceremony is as important as the coffee itself. Take your time!',
      ),
      FoodInfo(
        name: 'Tej',
        description: 'Traditional honey wine',
        ingredients: ['honey', 'water', 'gesho leaves'],
        whereToFind: 'Traditional tej houses and some restaurants',
        tips: 'Sweet and potent! Drink slowly and enjoy the traditional atmosphere.',
      ),
    ],
  };

  Map<String, List<CulturalInfo>> get culture => {
    'Etiquette': [
      CulturalInfo(
        title: 'Greeting Customs',
        description: 'Ethiopians are very warm and welcoming',
        details: 'Shake hands, maintain eye contact, and ask about family. "Selam" (hello) is always appreciated.',
      ),
      CulturalInfo(
        title: 'Dining Etiquette',
        description: 'Eating is a communal and respectful experience',
        details: 'Wash hands before eating. Use right hand only. Don\'t point with fingers. Share from the same plate.',
      ),
      CulturalInfo(
        title: 'Religious Respect',
        description: 'Ethiopia is deeply religious',
        details: 'Remove shoes in churches. Dress modestly. Don\'t take photos during prayers. Respect fasting periods.',
      ),
    ],
    'Traditions': [
      CulturalInfo(
        title: 'Coffee Ceremony',
        description: 'Central to Ethiopian social life',
        details: 'Three rounds of coffee (abol, tona, baraka). Takes 1-2 hours. Shows hospitality and friendship.',
      ),
      CulturalInfo(
        title: 'Timkat Festival',
        description: 'Epiphany celebration in January',
        details: 'Colorful processions, music, and dancing. Best experienced in Gondar or Lalibela.',
      ),
    ],
  };

  Map<String, List<TransportInfo>> get transportation => {
    'Addis Ababa': [
      TransportInfo(
        type: 'Light Rail',
        description: 'Modern tram system connecting major areas',
        cost: '2-6 ETB',
        tips: 'Clean and efficient. Buy tickets at stations. Avoid rush hours.',
      ),
      TransportInfo(
        type: 'Blue and White Taxis',
        description: 'Shared minibus taxis',
        cost: '2-5 ETB',
        tips: 'Very cheap but crowded. Know your destination in Amharic.',
      ),
      TransportInfo(
        type: 'Ride Sharing',
        description: 'Ferry (local Uber) available',
        cost: '50-200 ETB',
        tips: 'More expensive but comfortable. English-speaking drivers available.',
      ),
    ],
  };

  Map<String, List<EmergencyInfo>> get emergency => {
    'Contacts': [
      EmergencyInfo(
        service: 'Police',
        number: '911',
        description: 'Emergency police services',
        tips: 'English may not be spoken. Have a local contact ready.',
      ),
      EmergencyInfo(
        service: 'Ambulance',
        number: '907',
        description: 'Medical emergency services',
        tips: 'Response time can be slow. Consider private hospitals for serious cases.',
      ),
      EmergencyInfo(
        service: 'Fire Department',
        number: '939',
        description: 'Fire and rescue services',
        tips: 'Limited equipment in some areas. Prevention is key.',
      ),
    ],
    'Hospitals': [
      EmergencyInfo(
        service: 'Black Lion Hospital',
        number: '+251-11-123-4567',
        description: 'Major public hospital in Addis Ababa',
        tips: 'Free but can be crowded. Private hospitals recommended for tourists.',
      ),
    ],
  };

  List<LocationSpecificResponse> getLocationSpecificResponses(String location) {
    final locationData = locations[location];
    if (locationData == null) return [];

    return locationData.map((info) => LocationSpecificResponse(
      location: location,
      category: info.category,
      response: 'In $location, you should definitely visit ${info.name}. ${info.description} ${info.tips}',
    )).toList();
  }

  List<LocationSuggestion> getLocationSuggestions(String location) {
    final locationData = locations[location];
    if (locationData == null) return [];

    return locationData.map((info) => LocationSuggestion(
      title: info.name,
      subtitle: info.description,
      action: 'Tell me more about ${info.name}',
      icon: _getCategoryIcon(info.category),
    )).toList();
  }

  List<InterestSuggestion> getInterestBasedSuggestions(String interest) {
    switch (interest.toLowerCase()) {
      case 'food':
        return foods['Traditional']!.map((food) => InterestSuggestion(
          title: food.name,
          subtitle: food.description,
          action: 'Where can I try ${food.name}?',
          icon: '🍽️',
        )).toList();
      case 'culture':
        return culture['Etiquette']!.map((cultural) => InterestSuggestion(
          title: cultural.title,
          subtitle: cultural.description,
          action: 'Tell me about ${cultural.title}',
          icon: '🎭',
        )).toList();
      case 'history':
        return [
          InterestSuggestion(
            title: 'Ancient History',
            subtitle: 'Learn about Ethiopia\'s rich past',
            action: 'Tell me about Ethiopian history',
            icon: '🏛️',
          ),
        ];
      default:
        return [];
    }
  }

  String _getCategoryIcon(String category) {
    switch (category) {
      case 'museum': return '🏛️';
      case 'shopping': return '🛍️';
      case 'nature': return '🌿';
      case 'religious': return '⛪';
      case 'historical': return '🏰';
      default: return '📍';
    }
  }

  // Get random fun facts about Ethiopia
  List<String> get funFacts => [
    'Ethiopia is the only African country that was never colonized!',
    'The Ethiopian calendar is 7-8 years behind the Gregorian calendar.',
    'Coffee was first discovered in Ethiopia in the 9th century.',
    'Ethiopia has 13 months in a year (12 months of 30 days + 1 month of 5-6 days).',
    'The Great Rift Valley runs through Ethiopia, making it a geological wonder.',
    'Ethiopia is home to over 80 different ethnic groups and languages.',
    'The traditional Ethiopian alphabet has 33 letters and is one of the oldest in the world.',
    'Ethiopia is the birthplace of humanity - Lucy was found here!',
    'The country has 9 UNESCO World Heritage Sites.',
    'Ethiopian time is different - they use a 12-hour clock starting at sunrise (6 AM).',
  ];

  // Get current events and festivals
  Map<String, String> get festivals => {
    'January': 'Timkat (Epiphany) - Colorful religious festival',
    'March': 'Adwa Victory Day - Commemorates victory over Italy',
    'April': 'Easter - Major religious celebration',
    'May': 'Labour Day - National holiday',
    'September': 'New Year - Ethiopian New Year celebrations',
    'November': 'Meskel - Finding of the True Cross',
    'December': 'Christmas - Major religious celebration',
  };
}

class LocationInfo {
  final String name;
  final String description;
  final String category;
  final String tips;

  LocationInfo({
    required this.name,
    required this.description,
    required this.category,
    required this.tips,
  });
}

class FoodInfo {
  final String name;
  final String description;
  final List<String> ingredients;
  final String whereToFind;
  final String tips;

  FoodInfo({
    required this.name,
    required this.description,
    required this.ingredients,
    required this.whereToFind,
    required this.tips,
  });
}

class CulturalInfo {
  final String title;
  final String description;
  final String details;

  CulturalInfo({
    required this.title,
    required this.description,
    required this.details,
  });
}

class TransportInfo {
  final String type;
  final String description;
  final String cost;
  final String tips;

  TransportInfo({
    required this.type,
    required this.description,
    required this.cost,
    required this.tips,
  });
}

class EmergencyInfo {
  final String service;
  final String number;
  final String description;
  final String tips;

  EmergencyInfo({
    required this.service,
    required this.number,
    required this.description,
    required this.tips,
  });
}

class LocationSpecificResponse {
  final String location;
  final String category;
  final String response;

  LocationSpecificResponse({
    required this.location,
    required this.category,
    required this.response,
  });
}

class LocationSuggestion {
  final String title;
  final String subtitle;
  final String action;
  final String icon;

  LocationSuggestion({
    required this.title,
    required this.subtitle,
    required this.action,
    required this.icon,
  });
}

class InterestSuggestion {
  final String title;
  final String subtitle;
  final String action;
  final String icon;

  InterestSuggestion({
    required this.title,
    required this.subtitle,
    required this.action,
    required this.icon,
  });
}

