import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tourist_assistive_app/features/locations/data/ethiopian_locations.dart';

class LocationsColors {
  static const deepNavy = Color(0xFF0A1929);
  static const navyCard = Color(0xFF1A2F44);
  static const turquoise = Color(0xFF00D9B8);
  static const brightYellow = Color(0xFFFFD43B);
  static const brightBlue = Color(0xFF1CB0F6);
  static const brightGreen = Color(0xFF4CAF50);
  static const brightRed = Color(0xFFFF4B4B);
  static const pureWhite = Color(0xFFFFFFFF);
  static const lightGray = Color(0xFFE2E8F0);
  static const mediumGray = Color(0xFF94A3B8);
}

class ImaginativeTourScreen extends StatefulWidget {
  const ImaginativeTourScreen({super.key});

  @override
  State<ImaginativeTourScreen> createState() => _ImaginativeTourScreenState();
}

class _ImaginativeTourScreenState extends State<ImaginativeTourScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  int _currentLocationIndex = 0;
  bool _isPlaying = false;
  
  // Real Ethiopian historical site photos mapping
  final Map<String, String> _photoMapping = {
    'lalibela': 'assets/images/Lalibela.png',
    'axum': 'assets/images/Axum.png',
    'bale': 'assets/images/Bale.png',
    'jugol': 'assets/images/Jugol.png',
    'lake_tana': 'assets/images/lake tana.png',
    'fassil_gimb': 'assets/images/Fassil Gimb.png',
    'danakil': 'assets/images/Danakil.png',
    'debre_damo': 'assets/images/debre damo.png',
    'konso': 'assets/images/konso.png',
    'semen_mountain': 'assets/images/Semen mountain.jpg',
    'blue_nile': 'assets/images/blue nile.png',
    'national_museum': 'assets/images/National museium.jpg',
    'harar': 'Photos/Harer.jpg',
  };

  // Enhanced tour information for each location
  final Map<String, Map<String, dynamic>> _tourInformation = {
    'lalibela': {
      'title': 'Lalibela Rock-Hewn Churches',
      'description': 'Welcome to the "New Jerusalem" - 11 monolithic churches carved from solid rock in the 12th century. This UNESCO World Heritage site represents one of humanity\'s greatest architectural achievements.',
      'highlights': [
        '11 monolithic churches carved from living rock',
        'UNESCO World Heritage Site since 1978',
        'Active pilgrimage destination for Ethiopian Orthodox Christians',
        'Underground tunnel system connecting the churches',
        'Bete Giyorgis (Church of St. George) - the most famous cross-shaped church',
      ],
      'history': 'Built during the reign of King Lalibela (1181-1221), these churches were carved to create a "New Jerusalem" after Muslim conquests made pilgrimage to the Holy Land difficult.',
      'significance': 'Represents the pinnacle of Ethiopian Orthodox architecture and remains an active center of worship and pilgrimage.',
      'imaginativeTour': 'Close your eyes and imagine standing before these magnificent rock-hewn churches. Feel the cool air as you descend into the underground passages. Hear the echoes of ancient prayers. See the intricate carvings and feel the spiritual energy that has drawn pilgrims for over 800 years.',
    },
    'axum': {
      'title': 'Axum Obelisks & Ancient Kingdom',
      'description': 'Step into the ancient capital of the Axumite Kingdom, one of the most powerful states in the ancient world. Home to massive obelisks, royal tombs, and the legendary Ark of the Covenant.',
      'highlights': [
        'Ancient obelisks (stelae) up to 33 meters tall',
        'Royal tombs and underground chambers',
        'Church of St. Mary of Zion (Ark of the Covenant)',
        'Ancient inscriptions in Ge\'ez script',
        'Archaeological museum with royal artifacts',
      ],
      'history': 'Axum was the capital of the Axumite Kingdom (100-940 AD), a major trading empire that controlled trade routes between Africa, Arabia, and the Mediterranean.',
      'significance': 'Considered the birthplace of Ethiopian civilization and home to the Ark of the Covenant according to Ethiopian Orthodox tradition.',
      'imaginativeTour': 'Imagine walking through the ancient streets of Axum, where merchants once traded gold, ivory, and spices. Feel the weight of history as you stand before the towering obelisks. Sense the mystery surrounding the Ark of the Covenant, hidden in the Church of St. Mary of Zion.',
    },
    'danakil': {
      'title': 'Danakil Depression',
      'description': 'Experience one of the hottest places on Earth with active volcanoes, salt lakes, and otherworldly landscapes. This geological wonder offers some of the most extreme and beautiful scenery on the planet.',
      'highlights': [
        'Erta Ale - active volcano with lava lake',
        'Dallol - colorful hydrothermal fields',
        'Salt mining operations and camel caravans',
        'Extreme temperatures (up to 50°C)',
        'Unique geological formations',
      ],
      'history': 'Formed by the separation of the African and Arabian tectonic plates, creating one of the most geologically active regions on Earth.',
      'significance': 'One of the most extreme environments on Earth, offering unique geological and cultural experiences.',
      'imaginativeTour': 'Picture yourself in this alien landscape - feel the intense heat, see the bubbling lava lakes, and marvel at the colorful salt formations. Imagine the ancient salt caravans crossing this harsh terrain, carrying precious salt to distant markets.',
    },
    'bale': {
      'title': 'Bale Mountains National Park',
      'description': 'Discover a high-altitude wilderness area home to unique wildlife including the Ethiopian wolf, mountain nyala, and numerous endemic bird species. The park offers stunning landscapes and incredible biodiversity.',
      'highlights': [
        'Ethiopian wolf (world\'s rarest canid)',
        'Mountain nyala and other endemic mammals',
        'Over 300 bird species',
        'Sanetti Plateau - Africa\'s largest alpine habitat',
        'Harenna Forest - cloud forest ecosystem',
      ],
      'history': 'Established as a national park in 1970 to protect the unique high-altitude ecosystems and endemic wildlife.',
      'significance': 'Critical habitat for endangered species and one of Africa\'s most important biodiversity hotspots.',
      'imaginativeTour': 'Imagine hiking through the misty Harenna Forest, where ancient trees are draped in moss. Feel the crisp mountain air as you spot the rare Ethiopian wolf. Listen to the calls of endemic birds and feel the peace of this pristine wilderness.',
    },
    'jugol': {
      'title': 'Harar Jugol - Walled City',
      'description': 'Explore a fortified historic town with 82 mosques and 102 shrines, representing the fourth-holiest city in Islam. Known for its unique architecture, hyena feeding tradition, and vibrant markets.',
      'highlights': [
        '82 mosques and 102 shrines',
        'Traditional Harari houses with colorful facades',
        'Hyena feeding tradition',
        'Vibrant markets and traditional crafts',
        'UNESCO World Heritage Site',
      ],
      'history': 'Founded in the 7th century, Harar became a major center of Islamic learning and trade, serving as the capital of the Harari Kingdom.',
      'significance': 'One of the most important Islamic cities in Africa and a center of Islamic scholarship and culture.',
      'imaginativeTour': 'Picture yourself walking through the narrow alleys of Harar\'s walled city. Smell the spices in the vibrant markets, hear the call to prayer from the mosques, and witness the unique tradition of hyena feeding at night. Feel the rich Islamic heritage that has been preserved for over 1000 years.',
    },
    'lake_tana': {
      'title': 'Lake Tana & Monasteries',
      'description': 'Discover Ethiopia\'s largest lake and the source of the Blue Nile. Home to ancient island monasteries with priceless religious manuscripts and artifacts.',
      'highlights': [
        'Source of the Blue Nile',
        '37 islands with ancient monasteries',
        'Priceless religious manuscripts',
        'Traditional boat trips',
        'Blue Nile Falls (Tis Abay) nearby',
      ],
      'history': 'The lake has been a center of Ethiopian Orthodox Christianity for over 1000 years, with monasteries dating back to the 14th century.',
      'significance': 'Spiritual center of Ethiopian Orthodox Christianity and source of the Blue Nile, one of the world\'s great rivers.',
      'imaginativeTour': 'Imagine taking a traditional boat across the serene waters of Lake Tana. Feel the gentle breeze as you approach the ancient monasteries on their islands. Picture the monks preserving priceless manuscripts and feel the spiritual tranquility of this sacred place.',
    },
  };

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locations = EthiopianLocations.all;
    final currentLocation = locations[_currentLocationIndex];
    final tourInfo = _tourInformation[currentLocation.id] ?? {};

    return Scaffold(
      backgroundColor: LocationsColors.deepNavy,
      appBar: AppBar(
        backgroundColor: LocationsColors.navyCard,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Imaginative Tour of Ethiopia',
          style: TextStyle(
            color: LocationsColors.pureWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(_isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded),
            onPressed: _toggleTour,
          ),
        ],
      ),
      body: Column(
        children: [
          // Location Image
          Expanded(
            flex: 3,
            child: _buildLocationImage(currentLocation),
          ),
          // Tour Information
          Expanded(
            flex: 4,
            child: _buildTourInformation(currentLocation, tourInfo),
          ),
          // Navigation Controls
          _buildNavigationControls(locations.length),
        ],
      ),
    );
  }

  Widget _buildLocationImage(dynamic location) {
    final imagePath = _photoMapping[location.id] ?? 'assets/images/Logo.png';
    
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            LocationsColors.deepNavy,
            LocationsColors.navyCard,
          ],
        ),
      ),
      child: Stack(
        children: [
          // Main Image
          Image.asset(
            imagePath,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      _getCategoryColor(location.category),
                      _getCategoryColor(location.category).withValues(alpha: 0.6),
                    ],
                  ),
                ),
                child: Center(
                  child: Icon(
                    _getCategoryIcon(location.category),
                    color: LocationsColors.pureWhite,
                    size: 80,
                  ),
                ),
              );
            },
          ),
          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.7),
                ],
              ),
            ),
          ),
          // Location Info Overlay
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  location.name,
                  style: const TextStyle(
                    color: LocationsColors.pureWhite,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 1),
                        blurRadius: 3,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getCategoryColor(location.category),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    location.category,
                    style: const TextStyle(
                      color: LocationsColors.deepNavy,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Play/Pause Overlay
          if (_isPlaying)
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.play_arrow_rounded,
                  color: LocationsColors.turquoise,
                  size: 48,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTourInformation(dynamic location, Map<String, dynamic> tourInfo) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: LocationsColors.navyCard,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tour Description
            Text(
              tourInfo['description'] ?? location.description,
              style: const TextStyle(
                color: LocationsColors.pureWhite,
                fontSize: 16,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 20),
            
            // Imaginative Tour Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: LocationsColors.turquoise.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: LocationsColors.turquoise.withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.visibility_rounded,
                        color: LocationsColors.turquoise,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Imaginative Tour',
                        style: TextStyle(
                          color: LocationsColors.turquoise,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    tourInfo['imaginativeTour'] ?? 'Close your eyes and imagine the beauty and history of this incredible location...',
                    style: const TextStyle(
                      color: LocationsColors.lightGray,
                      fontSize: 14,
                      height: 1.5,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            // Key Highlights
            if (tourInfo['highlights'] != null) ...[
              const Text(
                'Key Highlights',
                style: TextStyle(
                  color: LocationsColors.pureWhite,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              ...(tourInfo['highlights'] as List<String>).map((highlight) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: LocationsColors.brightYellow,
                      size: 16,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        highlight,
                        style: const TextStyle(
                          color: LocationsColors.lightGray,
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
              const SizedBox(height: 20),
            ],
            
            // Historical Significance
            if (tourInfo['significance'] != null) ...[
              const Text(
                'Historical Significance',
                style: TextStyle(
                  color: LocationsColors.pureWhite,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                tourInfo['significance'],
                style: const TextStyle(
                  color: LocationsColors.lightGray,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationControls(int totalLocations) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: LocationsColors.deepNavy,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        children: [
          // Previous Button
          IconButton(
            onPressed: _currentLocationIndex > 0 ? _previousLocation : null,
            icon: const Icon(Icons.skip_previous_rounded),
            color: _currentLocationIndex > 0 
                ? LocationsColors.turquoise 
                : LocationsColors.mediumGray,
            style: IconButton.styleFrom(
              backgroundColor: _currentLocationIndex > 0 
                  ? LocationsColors.turquoise.withValues(alpha: 0.1)
                  : LocationsColors.mediumGray.withValues(alpha: 0.1),
              padding: const EdgeInsets.all(12),
            ),
          ),
          const SizedBox(width: 12),
          
          // Location Counter
          Expanded(
            child: Column(
              children: [
                Text(
                  '${_currentLocationIndex + 1} of $totalLocations',
                  style: const TextStyle(
                    color: LocationsColors.lightGray,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: (_currentLocationIndex + 1) / totalLocations,
                  backgroundColor: LocationsColors.mediumGray.withValues(alpha: 0.3),
                  valueColor: const AlwaysStoppedAnimation<Color>(LocationsColors.turquoise),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          
          // Next Button
          IconButton(
            onPressed: _currentLocationIndex < totalLocations - 1 ? _nextLocation : null,
            icon: const Icon(Icons.skip_next_rounded),
            color: _currentLocationIndex < totalLocations - 1 
                ? LocationsColors.turquoise 
                : LocationsColors.mediumGray,
            style: IconButton.styleFrom(
              backgroundColor: _currentLocationIndex < totalLocations - 1 
                  ? LocationsColors.turquoise.withValues(alpha: 0.1)
                  : LocationsColors.mediumGray.withValues(alpha: 0.1),
              padding: const EdgeInsets.all(12),
            ),
          ),
        ],
      ),
    );
  }

  void _toggleTour() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
    
    if (_isPlaying) {
      _animationController.repeat();
    } else {
      _animationController.stop();
    }
  }

  void _previousLocation() {
    if (_currentLocationIndex > 0) {
      setState(() {
        _currentLocationIndex--;
      });
    }
  }

  void _nextLocation() {
    final locations = EthiopianLocations.all;
    if (_currentLocationIndex < locations.length - 1) {
      setState(() {
        _currentLocationIndex++;
      });
    }
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'historical':
        return LocationsColors.brightYellow;
      case 'nature':
        return LocationsColors.brightGreen;
      case 'cultural':
        return LocationsColors.turquoise;
      case 'religious':
        return LocationsColors.brightBlue;
      case 'adventure':
        return LocationsColors.brightRed;
      default:
        return LocationsColors.turquoise;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'historical':
        return Icons.account_balance_rounded;
      case 'nature':
        return Icons.landscape_rounded;
      case 'cultural':
        return Icons.theater_comedy_rounded;
      case 'religious':
        return Icons.temple_buddhist_rounded;
      case 'adventure':
        return Icons.terrain_rounded;
      default:
        return Icons.place_rounded;
    }
  }
}
