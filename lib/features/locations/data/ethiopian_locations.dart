import 'package:tourist_assistive_app/features/locations/models/location.dart';

class EthiopianLocations {
  static List<Location> get all => [
    // Historical Sites
    const Location(
      id: 'lalibela-churches',
      name: 'Rock-Hewn Churches of Lalibela',
      description: 'Eleven monolithic rock-hewn churches carved directly into volcanic rock in the 12th century. A UNESCO World Heritage site and spiritual center for Ethiopian Orthodox Christians.',
      category: 'Historical',
      imageUrl: 'assets/images/Lalibela.png',
      latitude: 12.0317,
      longitude: 39.0473,
      rating: 4.9,
      reviewCount: 2150,
      price: 'Free (Donation welcome)',
      openingHours: '6:00 AM - 6:00 PM',
      isOpen: true,
      isFavorite: false,
      tags: ['UNESCO World Heritage', 'Religious', 'Architecture', 'Photography', 'Historical'],
      facilities: ['Local Guides', 'Parking', 'Souvenir Shop', 'Restaurant', 'Photography Permitted'],
      website: 'https://ethiopia.travel/destinations/lalibela/',
      phone: '+251-33-336-0001',
      address: 'Lalibela, Amhara Region, Ethiopia',
    ),

    const Location(
      id: 'axum-obelisks',
      name: 'Axum Obelisks & Ancient Kingdom',
      description: 'Ancient obelisks and ruins of the Kingdom of Axum, one of the great civilizations of the ancient world. Home to the legendary Queen of Sheba.',
      category: 'Historical',
      imageUrl: 'assets/images/Axum.png',
      latitude: 14.1210,
      longitude: 38.7167,
      rating: 4.7,
      reviewCount: 1230,
      price: '200 ETB',
      openingHours: '8:00 AM - 5:00 PM',
      isOpen: true,
      isFavorite: false,
      tags: ['UNESCO World Heritage', 'Ancient Kingdom', 'Queen of Sheba', 'Archaeology'],
      facilities: ['Museum', 'Guided Tours', 'Parking', 'Information Center'],
      website: 'https://ethiopia.travel/destinations/axum/',
      phone: '+251-34-775-2195',
      address: 'Axum, Tigray Region, Ethiopia',
    ),

    const Location(
      id: 'gondar-castles',
      name: 'Fasil Ghebbi (Gondar Castles)',
      description: 'Royal enclosure with six castles and several other buildings built by Emperor Fasilides and his successors in the 17th-18th centuries.',
      category: 'Historical',
      imageUrl: 'assets/images/Fassil Gimb.png',
      latitude: 12.6089,
      longitude: 37.4671,
      rating: 4.6,
      reviewCount: 980,
      price: '200 ETB',
      openingHours: '8:30 AM - 5:30 PM',
      isOpen: true,
      isFavorite: false,
      tags: ['UNESCO World Heritage', 'Royal Palace', 'Architecture', 'Castles'],
      facilities: ['Museum', 'Guided Tours', 'Cafe', 'Gift Shop', 'Parking'],
      website: 'https://ethiopia.travel/destinations/gondar/',
      phone: '+251-58-111-1960',
      address: 'Gondar, Amhara Region, Ethiopia',
    ),

    // Natural Wonders
    const Location(
      id: 'simien-mountains',
      name: 'Simien Mountains National Park',
      description: 'Dramatic landscape with jagged mountain peaks, deep valleys, and endemic wildlife including Gelada baboons, Ethiopian wolves, and Walia ibex.',
      category: 'Nature',
      imageUrl: 'assets/images/Bale.png',
      latitude: 13.2000,
      longitude: 38.0000,
      rating: 4.8,
      reviewCount: 1567,
      price: '90 ETB + Guide fees',
      openingHours: '6:00 AM - 6:00 PM',
      isOpen: true,
      isFavorite: false,
      tags: ['UNESCO World Heritage', 'Trekking', 'Wildlife', 'Endemic Species', 'Photography'],
      facilities: ['Camping', 'Guided Tours', 'Ranger Station', 'Mountain Lodges', 'Equipment Rental'],
      website: 'https://ethiopia.travel/destinations/simien-mountains/',
      phone: '+251-58-117-4208',
      address: 'Simien Mountains, Amhara Region, Ethiopia',
    ),

    const Location(
      id: 'danakil-depression',
      name: 'Danakil Depression (Afar Triangle)',
      description: 'One of the hottest and lowest places on Earth, featuring active volcanism, salt mining, colorful hydrothermal fields, and unique geological formations.',
      category: 'Adventure',
      imageUrl: 'assets/images/Danakil.png',
      latitude: 14.2417,
      longitude: 40.3000,
      rating: 4.5,
      reviewCount: 654,
      price: '2000-4000 ETB (Tour packages)',
      openingHours: 'Multi-day tours only',
      isOpen: true,
      isFavorite: false,
      tags: ['Unique Geology', 'Active Volcano', 'Salt Mining', 'Extreme Adventure', 'Erta Ale'],
      facilities: ['Tour Operators', 'Camping Equipment', 'Local Guides', 'Transportation'],
      website: 'https://ethiopia.travel/destinations/danakil-depression/',
      phone: '+251-34-520-0123',
      address: 'Afar Region, Ethiopia',
    ),

    const Location(
      id: 'blue-nile-falls',
      name: 'Blue Nile Falls (Tis Abay)',
      description: 'Spectacular 45-meter waterfall on the Blue Nile River, known locally as "Tis Abay" meaning "great smoke" due to the spray and mist.',
      category: 'Nature',
      imageUrl: 'assets/images/blue nile.png',
      latitude: 11.4967,
      longitude: 37.5664,
      rating: 4.4,
      reviewCount: 432,
      price: '50 ETB + Boat fee',
      openingHours: '8:00 AM - 5:00 PM',
      isOpen: true,
      isFavorite: false,
      tags: ['Waterfall', 'Blue Nile', 'Photography', 'Boat Ride', 'Nature Walk'],
      facilities: ['Boat Service', 'Walking Trails', 'Viewpoints', 'Local Guides', 'Parking'],
      website: 'https://ethiopia.travel/destinations/blue-nile-falls/',
      phone: '+251-58-220-0456',
      address: 'Near Bahir Dar, Amhara Region, Ethiopia',
    ),

    const Location(
      id: 'bale-mountains',
      name: 'Bale Mountains National Park',
      description: 'High-altitude plateau with diverse ecosystems, home to endemic species like Ethiopian wolves, mountain nyala, and over 280 bird species.',
      category: 'Nature',
      imageUrl: 'assets/images/Bale.png',
      latitude: 7.0667,
      longitude: 39.7500,
      rating: 4.7,
      reviewCount: 523,
      price: '90 ETB entrance',
      openingHours: '6:00 AM - 6:00 PM',
      isOpen: true,
      isFavorite: false,
      tags: ['Endemic Wildlife', 'Ethiopian Wolf', 'Mountain Nyala', 'Bird Watching', 'Hiking'],
      facilities: ['Visitor Center', 'Camping', 'Research Station', 'Guided Wildlife Tours'],
      website: 'https://ethiopia.travel/destinations/bale-mountains/',
      phone: '+251-22-331-0789',
      address: 'Bale Zone, Oromia Region, Ethiopia',
    ),

    // Cultural Sites
    const Location(
      id: 'harar-jugol',
      name: 'Harar Jugol (Fortified Historic Town)',
      description: 'Walled city with 99 mosques and 102 shrines, considered the fourth holy city of Islam. Famous for its unique architecture and hyena men.',
      category: 'Cultural',
      imageUrl: 'assets/images/Jugol.png',
      latitude: 9.3077,
      longitude: 42.1179,
      rating: 4.6,
      reviewCount: 876,
      price: '50 ETB + Guide fees',
      openingHours: '24/7 (Guided tours during day)',
      isOpen: true,
      isFavorite: false,
      tags: ['UNESCO World Heritage', 'Islamic Architecture', 'Hyena Feeding', 'Cultural Heritage'],
      facilities: ['Cultural Center', 'Traditional Markets', 'Mosques', 'Guided Tours'],
      website: 'https://ethiopia.travel/destinations/harar/',
      phone: '+251-25-666-0123',
      address: 'Harar, Harari Region, Ethiopia',
    ),

    const Location(
      id: 'konso-villages',
      name: 'Konso Cultural Villages',
      description: 'Traditional terraced villages showcasing remarkable landscape cultivation and unique cultural practices of the Konso people.',
      category: 'Cultural',
      imageUrl: 'assets/images/konso.png',
      latitude: 5.2500,
      longitude: 37.4800,
      rating: 4.3,
      reviewCount: 234,
      price: '100 ETB + Community fee',
      openingHours: '8:00 AM - 5:00 PM',
      isOpen: true,
      isFavorite: false,
      tags: ['UNESCO World Heritage', 'Cultural Landscape', 'Traditional Agriculture', 'Indigenous Culture'],
      facilities: ['Community Guides', 'Cultural Demonstrations', 'Homestays'],
      website: 'https://ethiopia.travel/destinations/konso/',
      phone: '+251-46-775-0234',
      address: 'Konso Zone, Southern Nations Region, Ethiopia',
    ),

    // Religious Sites
    const Location(
      id: 'debre-damo',
      name: 'Debre Damo Monastery',
      description: 'Ancient monastery accessible only by rope climbing, one of the most important monasteries of the Ethiopian Orthodox Church.',
      category: 'Religious',
      imageUrl: 'assets/images/debre damo.png',
      latitude: 14.3833,
      longitude: 39.1667,
      rating: 4.5,
      reviewCount: 198,
      price: 'Donation welcome',
      openingHours: '7:00 AM - 4:00 PM',
      isOpen: true,
      isFavorite: false,
      tags: ['Monastery', 'Rope Climbing', 'Orthodox Church', 'Ancient Manuscripts', 'Adventure'],
      facilities: ['Rope Access', 'Monks Guide', 'Ancient Library'],
      phone: '+251-34-445-0123',
      address: 'Tigray Region, Ethiopia',
    ),

    const Location(
      id: 'lake-tana-monasteries',
      name: 'Lake Tana Monasteries',
      description: 'Collection of 14th-17th century monasteries on islands in Ethiopia\'s largest lake, featuring ancient religious art and manuscripts.',
      category: 'Religious',
      imageUrl: 'assets/images/lake tana.png',
      latitude: 12.0000,
      longitude: 37.3167,
      rating: 4.4,
      reviewCount: 567,
      price: '150 ETB + Boat fee',
      openingHours: '8:00 AM - 5:00 PM',
      isOpen: true,
      isFavorite: false,
      tags: ['Island Monasteries', 'Boat Tour', 'Religious Art', 'Lake Cruise', 'Bird Watching'],
      facilities: ['Boat Tours', 'Monastery Visits', 'Bird Watching', 'Lake Cruises'],
      website: 'https://ethiopia.travel/destinations/bahir-dar/',
      phone: '+251-58-220-0123',
      address: 'Bahir Dar, Amhara Region, Ethiopia',
    ),

    // Modern Attractions
    const Location(
      id: 'addis-ababa-national-museum',
      name: 'National Museum of Ethiopia',
      description: 'Home to "Lucy," the 3.2 million-year-old hominid fossil, and extensive collections of Ethiopian art, artifacts, and cultural heritage.',
      category: 'Cultural',
      imageUrl: 'assets/images/Logo.png',
      latitude: 9.0348,
      longitude: 38.7617,
      rating: 4.2,
      reviewCount: 1245,
      price: '10 ETB (Local), 100 ETB (Foreign)',
      openingHours: '8:30 AM - 5:30 PM (Closed Mondays)',
      isOpen: true,
      isFavorite: false,
      tags: ['Lucy Fossil', 'Ethiopian History', 'Artifacts', 'Paleontology', 'Cultural Heritage'],
      facilities: ['Museum Shop', 'Guided Tours', 'Audio Guides', 'Parking', 'Cafe'],
      website: 'https://nationalmuseumethiopia.org/',
      phone: '+251-11-117-8360',
      address: 'King George VI Street, Addis Ababa, Ethiopia',
    ),

    const Location(
      id: 'merkato',
      name: 'Merkato Market',
      description: 'Africa\'s largest open-air market, offering everything from spices and coffee to traditional crafts and textiles in a vibrant atmosphere.',
      category: 'Cultural',
      imageUrl: 'assets/images/Logo.png',
      latitude: 9.0167,
      longitude: 38.7167,
      rating: 4.0,
      reviewCount: 892,
      price: 'Free (Bargaining expected)',
      openingHours: '6:00 AM - 7:00 PM (Closed Sundays)',
      isOpen: true,
      isFavorite: false,
      tags: ['Market', 'Shopping', 'Local Culture', 'Coffee', 'Spices', 'Handicrafts'],
      facilities: ['ATM', 'Food Stalls', 'Public Transport', 'Money Exchange'],
      phone: '+251-11-445-0123',
      address: 'Addis Ketema, Addis Ababa, Ethiopia',
    ),

    // Coffee Culture
    const Location(
      id: 'coffee-origin-kaffa',
      name: 'Kaffa Coffee Forests',
      description: 'Birthplace of coffee, featuring wild coffee forests where coffee was first discovered. Experience traditional coffee ceremonies and forest walks.',
      category: 'Cultural',
      imageUrl: 'assets/images/coffee.png',
      latitude: 7.2700,
      longitude: 36.2500,
      rating: 4.6,
      reviewCount: 234,
      price: '200 ETB + Guide fee',
      openingHours: '8:00 AM - 5:00 PM',
      isOpen: true,
      isFavorite: false,
      tags: ['Coffee Origin', 'Forest Walk', 'Coffee Ceremony', 'Wild Coffee', 'Cultural Experience'],
      facilities: ['Coffee Tours', 'Forest Guides', 'Coffee Tasting', 'Local Homestays'],
      website: 'https://ethiopia.travel/experiences/coffee/',
      phone: '+251-47-331-0456',
      address: 'Kaffa Zone, Southern Nations Region, Ethiopia',
    ),
  ];

  static List<Location> getByCategory(String category) {
    if (category.toLowerCase() == 'all') return all;
    return all.where((location) => 
      location.category.toLowerCase() == category.toLowerCase()
    ).toList();
  }

  static List<Location> getFeatured() {
    return [
      all.firstWhere((loc) => loc.id == 'lalibela-churches'),
      all.firstWhere((loc) => loc.id == 'simien-mountains'),
      all.firstWhere((loc) => loc.id == 'danakil-depression'),
    ];
  }

  static List<String> get categories => [
    'All',
    'Historical',
    'Nature',
    'Cultural',
    'Religious',
    'Adventure',
  ];
}




















