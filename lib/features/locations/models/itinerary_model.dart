class ItineraryDay {
  final int day;
  final String title;
  final List<ItineraryActivity> activities;
  final String accommodation;
  final String meals;

  const ItineraryDay({
    required this.day,
    required this.title,
    required this.activities,
    required this.accommodation,
    required this.meals,
  });
}

class ItineraryActivity {
  final String time;
  final String title;
  final String description;
  final String locationId;

  const ItineraryActivity({
    required this.time,
    required this.title,
    required this.description,
    required this.locationId,
  });
}

class TourPackage {
  final String id;
  final String name;
  final String description;
  final int durationDays;
  final List<String> highlights;
  final List<String> includedLocations;
  final List<ItineraryDay> itinerary;
  final String difficulty;
  final List<String> included;
  final List<String> excluded;

  const TourPackage({
    required this.id,
    required this.name,
    required this.description,
    required this.durationDays,
    required this.highlights,
    required this.includedLocations,
    required this.itinerary,
    required this.difficulty,
    required this.included,
    required this.excluded,
  });
}

// Sample tour packages
class EthiopianTourPackages {
  static List<TourPackage> get all => [
    const TourPackage(
      id: 'historical-north',
      name: 'Historic North Circuit',
      description: 'Explore the ancient wonders of northern Ethiopia including Lalibela, Axum, and Gondar',
      durationDays: 7,
      highlights: [
        'Rock-hewn churches of Lalibela',
        'Ancient Axum obelisks',
        'Gondar castles and palaces',
        'Lake Tana monasteries',
      ],
      includedLocations: ['lalibela-churches', 'axum-obelisks', 'gondar-castles', 'lake-tana-monasteries'],
      itinerary: [],
      difficulty: 'Moderate',
      included: ['Accommodation', 'Meals', 'Transportation', 'Guide', 'Entry fees'],
      excluded: ['International flights', 'Personal expenses', 'Tips'],
    ),
    const TourPackage(
      id: 'nature-adventure',
      name: 'Nature & Wildlife Adventure',
      description: 'Experience Ethiopia\'s stunning natural beauty and unique wildlife',
      durationDays: 10,
      highlights: [
        'Simien Mountains trekking',
        'Bale Mountains wildlife',
        'Blue Nile Falls',
        'Endemic species viewing',
      ],
      includedLocations: ['simien-mountains', 'bale-mountains', 'blue-nile-falls'],
      itinerary: [],
      difficulty: 'Challenging',
      included: ['Camping equipment', 'Meals', 'Transportation', 'Guide', 'Park fees'],
      excluded: ['International flights', 'Personal gear', 'Tips'],
    ),
  ];
}


