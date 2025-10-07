import 'package:tourist_assistive_app/features/locations/data/ethiopian_locations.dart';

/// Global tourist locations with emphasis on Ethiopian sites
/// This class provides comprehensive global tourist destinations
/// while prioritizing Ethiopian locations for the tourist assistive app
class GlobalLocations {
  static const List<GlobalLocation> _globalLocations = [
    // ETHIOPIAN LOCATIONS (Priority - Detailed)
    // Historical Sites
    GlobalLocation(
      id: 'lalibela',
      name: 'Lalibela Rock-Hewn Churches',
      description: 'UNESCO World Heritage site with 11 monolithic churches carved from rock',
      category: 'Historical',
      country: 'Ethiopia',
      region: 'Africa',
      city: 'Lalibela',
      latitude: 12.0311,
      longitude: 39.0474,
      rating: 4.9,
      imageUrl: 'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800',
      isFavorite: true,
      isEthiopian: true,
      priority: 1, // Highest priority
      tags: ['UNESCO', 'Religious', 'Ancient', 'Architecture'],
      openingHours: 'Daily 8:00 AM - 6:00 PM',
      entryFee: '50 USD',
      features: ['Guided Tours', 'Photography', 'Religious Ceremonies'],
    ),
    GlobalLocation(
      id: 'axum',
      name: 'Axum Obelisks',
      description: 'Ancient capital of the Kingdom of Axum with towering obelisks',
      category: 'Historical',
      country: 'Ethiopia',
      region: 'Africa',
      city: 'Axum',
      latitude: 14.1211,
      longitude: 38.7234,
      rating: 4.7,
      imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800',
      isFavorite: true,
      isEthiopian: true,
      priority: 1,
      tags: ['UNESCO', 'Ancient', 'Kingdom', 'Obelisks'],
      openingHours: 'Daily 8:00 AM - 5:00 PM',
      entryFee: '30 USD',
      features: ['Archaeological Site', 'Museum', 'Guided Tours'],
    ),
    GlobalLocation(
      id: 'gondar',
      name: 'Fasil Ghebbi - Gondar',
      description: 'Royal castle complex from the 17th century',
      category: 'Historical',
      country: 'Ethiopia',
      region: 'Africa',
      city: 'Gondar',
      latitude: 12.6075,
      longitude: 37.4661,
      rating: 4.6,
      imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800',
      isFavorite: true,
      isEthiopian: true,
      priority: 1,
      tags: ['UNESCO', 'Castle', 'Royal', 'Architecture'],
      openingHours: 'Daily 8:00 AM - 6:00 PM',
      entryFee: '25 USD',
      features: ['Castle Tours', 'Historical Museum', 'Photography'],
    ),
    GlobalLocation(
      id: 'harar',
      name: 'Harar Jugol - Historic Walled City',
      description: 'Ancient walled city with 82 mosques and unique architecture',
      category: 'Cultural',
      country: 'Ethiopia',
      region: 'Africa',
      city: 'Harar',
      latitude: 9.3122,
      longitude: 42.1258,
      rating: 4.5,
      imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800',
      isFavorite: true,
      isEthiopian: true,
      priority: 1,
      tags: ['UNESCO', 'Islamic', 'Walled City', 'Culture'],
      openingHours: 'Daily 6:00 AM - 10:00 PM',
      entryFee: '15 USD',
      features: ['City Walks', 'Cultural Tours', 'Night Life'],
    ),
    GlobalLocation(
      id: 'simien',
      name: 'Simien Mountains National Park',
      description: 'Dramatic mountain landscapes with unique wildlife including Gelada baboons',
      category: 'Nature',
      country: 'Ethiopia',
      region: 'Africa',
      city: 'Debark',
      latitude: 13.2500,
      longitude: 38.2500,
      rating: 4.8,
      imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800',
      isFavorite: true,
      isEthiopian: true,
      priority: 1,
      tags: ['UNESCO', 'Mountains', 'Wildlife', 'Hiking'],
      openingHours: 'Daily 6:00 AM - 6:00 PM',
      entryFee: '20 USD',
      features: ['Hiking', 'Wildlife Viewing', 'Camping', 'Photography'],
    ),
    GlobalLocation(
      id: 'danakil',
      name: 'Danakil Depression',
      description: 'One of the hottest places on Earth with active volcanoes and salt lakes',
      category: 'Adventure',
      country: 'Ethiopia',
      region: 'Africa',
      city: 'Afar Region',
      latitude: 14.2417,
      longitude: 40.2992,
      rating: 4.7,
      imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800',
      isFavorite: true,
      isEthiopian: true,
      priority: 1,
      tags: ['Extreme', 'Volcano', 'Salt Lake', 'Adventure'],
      openingHours: 'Guided Tours Only',
      entryFee: '200 USD',
      features: ['Volcano Tours', 'Salt Mining', 'Extreme Adventure'],
    ),
    GlobalLocation(
      id: 'lake_tana',
      name: 'Lake Tana and Blue Nile Falls',
      description: 'Source of the Blue Nile with ancient monasteries on islands',
      category: 'Nature',
      country: 'Ethiopia',
      region: 'Africa',
      city: 'Bahir Dar',
      latitude: 11.7500,
      longitude: 37.2500,
      rating: 4.6,
      imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800',
      isFavorite: true,
      isEthiopian: true,
      priority: 1,
      tags: ['Lake', 'Monasteries', 'Waterfalls', 'Nature'],
      openingHours: 'Daily 6:00 AM - 6:00 PM',
      entryFee: '30 USD',
      features: ['Boat Tours', 'Monastery Visits', 'Waterfall Viewing'],
    ),

    // AFRICAN LOCATIONS (High Priority)
    GlobalLocation(
      id: 'pyramids',
      name: 'Great Pyramids of Giza',
      description: 'Ancient Egyptian pyramids and the Great Sphinx',
      category: 'Historical',
      country: 'Egypt',
      region: 'Africa',
      city: 'Giza',
      latitude: 29.9792,
      longitude: 31.1342,
      rating: 4.8,
      imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800',
      isFavorite: false,
      isEthiopian: false,
      priority: 2,
      tags: ['UNESCO', 'Ancient', 'Pyramids', 'Egyptian'],
      openingHours: 'Daily 8:00 AM - 5:00 PM',
      entryFee: '20 USD',
      features: ['Pyramid Tours', 'Sphinx Viewing', 'Camel Rides'],
    ),
    GlobalLocation(
      id: 'victoria_falls',
      name: 'Victoria Falls',
      description: 'One of the world\'s largest waterfalls on the Zambezi River',
      category: 'Nature',
      country: 'Zambia/Zimbabwe',
      region: 'Africa',
      city: 'Livingstone/Victoria Falls',
      latitude: -17.9243,
      longitude: 25.8572,
      rating: 4.9,
      imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800',
      isFavorite: false,
      isEthiopian: false,
      priority: 2,
      tags: ['UNESCO', 'Waterfall', 'Nature', 'Adventure'],
      openingHours: 'Daily 6:00 AM - 6:00 PM',
      entryFee: '30 USD',
      features: ['Waterfall Viewing', 'Helicopter Tours', 'Bungee Jumping'],
    ),
    GlobalLocation(
      id: 'serengeti',
      name: 'Serengeti National Park',
      description: 'Famous for the Great Migration of wildebeest and zebras',
      category: 'Nature',
      country: 'Tanzania',
      region: 'Africa',
      city: 'Arusha',
      latitude: -2.3333,
      longitude: 34.8333,
      rating: 4.9,
      imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800',
      isFavorite: false,
      isEthiopian: false,
      priority: 2,
      tags: ['UNESCO', 'Wildlife', 'Safari', 'Migration'],
      openingHours: 'Daily 6:00 AM - 6:00 PM',
      entryFee: '60 USD',
      features: ['Safari Tours', 'Wildlife Photography', 'Hot Air Balloons'],
    ),

    // EUROPEAN LOCATIONS (Medium Priority)
    GlobalLocation(
      id: 'colosseum',
      name: 'Colosseum',
      description: 'Ancient Roman amphitheater and iconic symbol of Rome',
      category: 'Historical',
      country: 'Italy',
      region: 'Europe',
      city: 'Rome',
      latitude: 41.8902,
      longitude: 12.4922,
      rating: 4.7,
      imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800',
      isFavorite: false,
      isEthiopian: false,
      priority: 3,
      tags: ['UNESCO', 'Roman', 'Ancient', 'Architecture'],
      openingHours: 'Daily 8:30 AM - 7:15 PM',
      entryFee: '16 EUR',
      features: ['Arena Tours', 'Underground Tours', 'Night Tours'],
    ),
    GlobalLocation(
      id: 'eiffel_tower',
      name: 'Eiffel Tower',
      description: 'Iconic iron lattice tower and symbol of Paris',
      category: 'Cultural',
      country: 'France',
      region: 'Europe',
      city: 'Paris',
      latitude: 48.8584,
      longitude: 2.2945,
      rating: 4.6,
      imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800',
      isFavorite: false,
      isEthiopian: false,
      priority: 3,
      tags: ['Iconic', 'Architecture', 'Views', 'Romantic'],
      openingHours: 'Daily 9:30 AM - 11:45 PM',
      entryFee: '29 EUR',
      features: ['Elevator Rides', 'Restaurant', 'Night Views'],
    ),
    GlobalLocation(
      id: 'stonehenge',
      name: 'Stonehenge',
      description: 'Prehistoric stone circle and UNESCO World Heritage site',
      category: 'Historical',
      country: 'United Kingdom',
      region: 'Europe',
      city: 'Wiltshire',
      latitude: 51.1789,
      longitude: -1.8262,
      rating: 4.4,
      imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800',
      isFavorite: false,
      isEthiopian: false,
      priority: 3,
      tags: ['UNESCO', 'Prehistoric', 'Mystery', 'Ancient'],
      openingHours: 'Daily 9:30 AM - 5:00 PM',
      entryFee: '23 GBP',
      features: ['Stone Circle Tours', 'Museum', 'Sunrise Tours'],
    ),

    // ASIAN LOCATIONS (Medium Priority)
    GlobalLocation(
      id: 'taj_mahal',
      name: 'Taj Mahal',
      description: 'White marble mausoleum and symbol of eternal love',
      category: 'Historical',
      country: 'India',
      region: 'Asia',
      city: 'Agra',
      latitude: 27.1751,
      longitude: 78.0421,
      rating: 4.8,
      imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800',
      isFavorite: false,
      isEthiopian: false,
      priority: 3,
      tags: ['UNESCO', 'Mughal', 'Architecture', 'Love'],
      openingHours: 'Daily 6:00 AM - 6:30 PM',
      entryFee: '1100 INR',
      features: ['Sunrise Tours', 'Photography', 'Garden Walks'],
    ),
    GlobalLocation(
      id: 'great_wall',
      name: 'Great Wall of China',
      description: 'Ancient fortification stretching across northern China',
      category: 'Historical',
      country: 'China',
      region: 'Asia',
      city: 'Beijing',
      latitude: 40.4319,
      longitude: 116.5704,
      rating: 4.7,
      imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800',
      isFavorite: false,
      isEthiopian: false,
      priority: 3,
      tags: ['UNESCO', 'Ancient', 'Fortification', 'Hiking'],
      openingHours: 'Daily 8:00 AM - 5:00 PM',
      entryFee: '45 CNY',
      features: ['Hiking', 'Cable Car', 'Photography', 'History Tours'],
    ),
    GlobalLocation(
      id: 'angkor_wat',
      name: 'Angkor Wat',
      description: 'Largest religious monument in the world',
      category: 'Historical',
      country: 'Cambodia',
      region: 'Asia',
      city: 'Siem Reap',
      latitude: 13.4125,
      longitude: 103.8670,
      rating: 4.9,
      imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800',
      isFavorite: false,
      isEthiopian: false,
      priority: 3,
      tags: ['UNESCO', 'Temple', 'Khmer', 'Architecture'],
      openingHours: 'Daily 5:00 AM - 6:00 PM',
      entryFee: '37 USD',
      features: ['Temple Tours', 'Sunrise Tours', 'Photography'],
    ),

    // AMERICAS LOCATIONS (Lower Priority)
    GlobalLocation(
      id: 'machu_picchu',
      name: 'Machu Picchu',
      description: 'Ancient Inca citadel high in the Andes Mountains',
      category: 'Historical',
      country: 'Peru',
      region: 'Americas',
      city: 'Cusco',
      latitude: -13.1631,
      longitude: -72.5450,
      rating: 4.9,
      imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800',
      isFavorite: false,
      isEthiopian: false,
      priority: 4,
      tags: ['UNESCO', 'Inca', 'Mountains', 'Ancient'],
      openingHours: 'Daily 6:00 AM - 5:30 PM',
      entryFee: '152 PEN',
      features: ['Hiking', 'Guided Tours', 'Photography', 'Sunrise Tours'],
    ),
    GlobalLocation(
      id: 'grand_canyon',
      name: 'Grand Canyon',
      description: 'Massive canyon carved by the Colorado River',
      category: 'Nature',
      country: 'United States',
      region: 'Americas',
      city: 'Arizona',
      latitude: 36.1069,
      longitude: -112.1129,
      rating: 4.8,
      imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800',
      isFavorite: false,
      isEthiopian: false,
      priority: 4,
      tags: ['National Park', 'Canyon', 'Nature', 'Hiking'],
      openingHours: '24/7',
      entryFee: '35 USD',
      features: ['Hiking', 'Helicopter Tours', 'Rafting', 'Photography'],
    ),
    GlobalLocation(
      id: 'niagara_falls',
      name: 'Niagara Falls',
      description: 'Famous waterfalls on the border of USA and Canada',
      category: 'Nature',
      country: 'Canada/USA',
      region: 'Americas',
      city: 'Ontario/New York',
      latitude: 43.0962,
      longitude: -79.0377,
      rating: 4.5,
      imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800',
      isFavorite: false,
      isEthiopian: false,
      priority: 4,
      tags: ['Waterfall', 'Border', 'Nature', 'Tourism'],
      openingHours: 'Daily 8:00 AM - 10:00 PM',
      entryFee: '25 CAD',
      features: ['Boat Tours', 'Observation Decks', 'Photography'],
    ),
  ];

  /// Get all global locations
  static List<GlobalLocation> get all => _globalLocations;

  /// Get Ethiopian locations only (highest priority)
  static List<GlobalLocation> get ethiopianLocations =>
      _globalLocations.where((loc) => loc.isEthiopian).toList();

  /// Get locations by region
  static List<GlobalLocation> getByRegion(String region) =>
      _globalLocations.where((loc) => loc.region == region).toList();

  /// Get locations by country
  static List<GlobalLocation> getByCountry(String country) =>
      _globalLocations.where((loc) => loc.country == country).toList();

  /// Get locations by priority (1 = highest, 4 = lowest)
  static List<GlobalLocation> getByPriority(int priority) =>
      _globalLocations.where((loc) => loc.priority == priority).toList();

  /// Get locations by category
  static List<GlobalLocation> getByCategory(String category) =>
      _globalLocations.where((loc) => loc.category == category).toList();

  /// Get top-rated locations (4.5+ stars)
  static List<GlobalLocation> get topRated =>
      _globalLocations.where((loc) => loc.rating >= 4.5).toList();

  /// Get favorite locations
  static List<GlobalLocation> get favorites =>
      _globalLocations.where((loc) => loc.isFavorite).toList();

  /// Search locations by name or description
  static List<GlobalLocation> search(String query) {
    if (query.isEmpty) return _globalLocations;
    
    final lowercaseQuery = query.toLowerCase();
    return _globalLocations.where((loc) =>
        loc.name.toLowerCase().contains(lowercaseQuery) ||
        loc.description.toLowerCase().contains(lowercaseQuery) ||
        loc.city.toLowerCase().contains(lowercaseQuery) ||
        loc.country.toLowerCase().contains(lowercaseQuery) ||
        loc.tags.any((tag) => tag.toLowerCase().contains(lowercaseQuery))
    ).toList();
  }
}

/// Global location model with comprehensive tourist information
class GlobalLocation {
  final String id;
  final String name;
  final String description;
  final String category;
  final String country;
  final String region;
  final String city;
  final double latitude;
  final double longitude;
  final double rating;
  final String imageUrl;
  final bool isFavorite;
  final bool isEthiopian;
  final int priority; // 1 = highest (Ethiopian), 4 = lowest
  final List<String> tags;
  final String openingHours;
  final String entryFee;
  final List<String> features;

  const GlobalLocation({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.country,
    required this.region,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.rating,
    required this.imageUrl,
    required this.isFavorite,
    required this.isEthiopian,
    required this.priority,
    required this.tags,
    required this.openingHours,
    required this.entryFee,
    required this.features,
  });
}




























