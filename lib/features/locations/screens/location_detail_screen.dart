import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tourist_assistive_app/features/locations/providers/locations_provider.dart';
import 'package:tourist_assistive_app/features/locations/models/location_model.dart';
import 'package:tourist_assistive_app/features/locations/screens/ar_location_view_screen.dart';

/// Professional Location Detail Screen
/// Navy Blue Theme | Real Photos | Comprehensive Information | No Pricing
class LocationDetailScreen extends ConsumerStatefulWidget {
  final String locationId;

  const LocationDetailScreen({
    super.key,
    required this.locationId,
  });

  @override
  ConsumerState<LocationDetailScreen> createState() => _LocationDetailScreenState();
}

class _LocationDetailScreenState extends ConsumerState<LocationDetailScreen> {
  // Professional color palette
  static const Color _navyBlue = Color(0xFF0A1929);
  static const Color _navyCard = Color(0xFF1A2F44);
  static const Color _turquoise = Color(0xFF00D9B8);
  static const Color _yellow = Color(0xFFFFD43B);
  static const Color _blue = Color(0xFF1CB0F6);
  static const Color _red = Color(0xFFFF4B4B);
  static const Color _textPrimary = Color(0xFFFFFFFF);
  static const Color _textSecondary = Color(0xFFB3B3B3);
  static const Color _textTertiary = Color(0xFF8B949E);

  // Real historical site photos mapping
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
  };

  // Enhanced descriptions for each location
  final Map<String, Map<String, dynamic>> _enhancedDescriptions = {
    'lalibela': {
      'title': 'Lalibela Rock-Hewn Churches',
      'description': 'Lalibela is home to 11 medieval monolithic cave churches, carved out of rock in the 12th century. This UNESCO World Heritage site is often called the "New Jerusalem" and represents one of the most remarkable architectural achievements in human history.',
      'highlights': [
        '11 monolithic churches carved from solid rock',
        'UNESCO World Heritage Site since 1978',
        'Active pilgrimage destination',
        'Underground tunnel system connecting churches',
        'Bete Giyorgis (Church of St. George) - most famous',
      ],
      'history': 'Built during the reign of King Lalibela (1181-1221), these churches were carved from the living rock to create a "New Jerusalem" after Muslim conquests made pilgrimage to the Holy Land difficult.',
      'significance': 'Represents the pinnacle of Ethiopian Orthodox architecture and remains an active center of worship and pilgrimage.',
      'bestTime': 'October to March (dry season)',
      'visitDuration': '2-3 days recommended',
      'tips': [
        'Wear comfortable walking shoes',
        'Respect religious customs and dress modestly',
        'Hire a local guide for detailed explanations',
        'Visit early morning for better lighting',
        'Allow time for the underground passages',
      ],
    },
    'axum': {
      'title': 'Axum Obelisks & Ancient Kingdom',
      'description': 'The ancient capital of the Axumite Kingdom, one of the most powerful states in the ancient world. Home to massive obelisks, royal tombs, and the legendary Ark of the Covenant.',
      'highlights': [
        'Ancient obelisks (stelae) up to 33 meters tall',
        'Royal tombs and underground chambers',
        'Church of St. Mary of Zion (Ark of the Covenant)',
        'Ancient inscriptions in Ge\'ez script',
        'Archaeological museum with royal artifacts',
      ],
      'history': 'Axum was the capital of the Axumite Kingdom (100-940 AD), a major trading empire that controlled trade routes between Africa, Arabia, and the Mediterranean.',
      'significance': 'Considered the birthplace of Ethiopian civilization and home to the Ark of the Covenant according to Ethiopian Orthodox tradition.',
      'bestTime': 'October to April',
      'visitDuration': '2-3 days',
      'tips': [
        'Visit the archaeological museum first',
        'Explore the royal tombs with a guide',
        'Respect the religious significance of the sites',
        'Wear comfortable shoes for walking',
        'Learn about the Ge\'ez script and inscriptions',
      ],
    },
    'danakil': {
      'title': 'Danakil Depression',
      'description': 'One of the hottest places on Earth with active volcanoes, salt lakes, and otherworldly landscapes. This geological wonder offers some of the most extreme and beautiful scenery on the planet.',
      'highlights': [
        'Erta Ale - active volcano with lava lake',
        'Dallol - colorful hydrothermal fields',
        'Salt mining operations and camel caravans',
        'Extreme temperatures (up to 50°C)',
        'Unique geological formations',
      ],
      'history': 'Formed by the separation of the African and Arabian tectonic plates, creating one of the most geologically active regions on Earth.',
      'significance': 'One of the most extreme environments on Earth, offering unique geological and cultural experiences.',
      'bestTime': 'November to March (cooler months)',
      'visitDuration': '3-4 days',
      'tips': [
        'Essential to go with experienced guides',
        'Bring plenty of water and sun protection',
        'Wear sturdy hiking boots',
        'Be prepared for extreme conditions',
        'Respect the local Afar people and their culture',
      ],
    },
    'bale': {
      'title': 'Bale Mountains National Park',
      'description': 'A high-altitude wilderness area home to unique wildlife including the Ethiopian wolf, mountain nyala, and numerous endemic bird species. The park offers stunning landscapes and incredible biodiversity.',
      'highlights': [
        'Ethiopian wolf (world\'s rarest canid)',
        'Mountain nyala and other endemic mammals',
        'Over 300 bird species',
        'Sanetti Plateau - Africa\'s largest alpine habitat',
        'Harenna Forest - cloud forest ecosystem',
      ],
      'history': 'Established as a national park in 1970 to protect the unique high-altitude ecosystems and endemic wildlife.',
      'significance': 'Critical habitat for endangered species and one of Africa\'s most important biodiversity hotspots.',
      'bestTime': 'October to May',
      'visitDuration': '3-5 days',
      'tips': [
        'Hire experienced wildlife guides',
        'Bring warm clothing for high altitudes',
        'Use binoculars for wildlife viewing',
        'Respect wildlife and maintain distance',
        'Book accommodation in advance',
      ],
    },
    'jugol': {
      'title': 'Harar Jugol - Walled City',
      'description': 'A fortified historic town with 82 mosques and 102 shrines, representing the fourth-holiest city in Islam. Known for its unique architecture, hyena feeding tradition, and vibrant markets.',
      'highlights': [
        '82 mosques and 102 shrines',
        'Traditional Harari houses with colorful facades',
        'Hyena feeding tradition',
        'Vibrant markets and traditional crafts',
        'UNESCO World Heritage Site',
      ],
      'history': 'Founded in the 7th century, Harar became a major center of Islamic learning and trade, serving as the capital of the Harari Kingdom.',
      'significance': 'One of the most important Islamic cities in Africa and a center of Islamic scholarship and culture.',
      'bestTime': 'October to April',
      'visitDuration': '2-3 days',
      'tips': [
        'Explore the walled city on foot',
        'Visit the hyena feeding at night',
        'Shop for traditional crafts',
        'Respect Islamic customs and dress modestly',
        'Try the famous Harari coffee ceremony',
      ],
    },
    'lake_tana': {
      'title': 'Lake Tana & Monasteries',
      'description': 'Ethiopia\'s largest lake and the source of the Blue Nile. Home to ancient island monasteries with priceless religious manuscripts and artifacts.',
      'highlights': [
        'Source of the Blue Nile',
        '37 islands with ancient monasteries',
        'Priceless religious manuscripts',
        'Traditional boat trips',
        'Blue Nile Falls (Tis Abay) nearby',
      ],
      'history': 'The lake has been a center of Ethiopian Orthodox Christianity for over 1000 years, with monasteries dating back to the 14th century.',
      'significance': 'Spiritual center of Ethiopian Orthodox Christianity and source of the Blue Nile, one of the world\'s great rivers.',
      'bestTime': 'October to May',
      'visitDuration': '2-3 days',
      'tips': [
        'Take boat trips to island monasteries',
        'Visit Blue Nile Falls (Tis Abay)',
        'Respect religious customs',
        'Bring camera for stunning lake views',
        'Learn about the religious manuscripts',
      ],
    },
  };

  @override
  Widget build(BuildContext context) {
    final locationsState = ref.watch(locationsProvider);
    LocationModel? location;
    try {
      location = locationsState.locations.cast<LocationModel>().firstWhere(
        (loc) => loc.id == widget.locationId,
      );
    } catch (e) {
      location = null;
    }

    if (location == null) {
      return _buildErrorScreen();
    }

    return Scaffold(
      backgroundColor: _navyBlue,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Hero App Bar with Image
          _buildHeroAppBar(location),
          
          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Enhanced Location Info
                  _buildEnhancedLocationInfo(location),
                  
                  const SizedBox(height: 20),
                  
                  // Detailed Description
                  _buildDetailedDescription(location),
                  
                  const SizedBox(height: 20),
                  
                  // Highlights Section
                  _buildHighlightsSection(location),
                  
                  const SizedBox(height: 20),
                  
                  // History & Significance
                  _buildHistorySection(location),
                  
                  const SizedBox(height: 20),
                  
                  // Visit Information
                  _buildVisitInformation(location),
                  
                  const SizedBox(height: 20),
                  
                  // Action Buttons
                  _buildActionButtons(location),
                  
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorScreen() {
    return Scaffold(
      backgroundColor: _navyBlue,
      appBar: AppBar(
        backgroundColor: _navyCard,
        foregroundColor: _textPrimary,
        title: const Text('Location Not Found'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_off_rounded, color: _textTertiary, size: 64),
            const SizedBox(height: 16),
            const Text(
              'Location not found',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: _textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'The location you\'re looking for doesn\'t exist',
              style: TextStyle(
                fontSize: 16,
                color: _textSecondary,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: _turquoise,
                foregroundColor: _navyBlue,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroAppBar(LocationModel location) {
    final imagePath = _photoMapping[location.id] ?? 'assets/images/Logo.png';
    
    return SliverAppBar(
      expandedHeight: 400,
      pinned: true,
      backgroundColor: _navyCard,
      foregroundColor: _textPrimary,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          location.name,
          style: const TextStyle(
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
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Main Image
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [_navyBlue, _navyCard],
                    ),
                  ),
                  child: const Center(
                    child: Icon(Icons.landscape_rounded, color: _textTertiary, size: 80),
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
            
            // Category Badge
            Positioned(
              top: 100,
              right: 20,
              child: _buildCategoryBadge(location.category),
            ),
            
            // Rating Badge
            Positioned(
              top: 100,
              left: 20,
              child: _buildRatingBadge(location.rating),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryBadge(String category) {
    Color color = _textTertiary;
    if (category == 'Historical') color = _turquoise;
    if (category == 'Natural') color = _yellow;
    if (category == 'Religious') color = _blue;
    if (category == 'Cultural') color = _red;
    if (category == 'Adventure') color = const Color(0xFFFF6B35);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        category,
        style: const TextStyle(
          color: _navyBlue,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildRatingBadge(double rating) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: _yellow,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star_rounded, color: _navyBlue, size: 16),
          const SizedBox(width: 4),
          Text(
            rating.toString(),
            style: const TextStyle(
              color: _navyBlue,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedLocationInfo(LocationModel location) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _navyCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _turquoise.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.info_rounded, color: _turquoise, size: 24),
              SizedBox(width: 12),
              Text(
                'Location Information',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          _buildInfoRow('Name', location.name),
          _buildInfoRow('Category', location.category),
          _buildInfoRow('City', location.city),
          if (location.country != null) _buildInfoRow('Country', location.country!),
          if (location.region != null) _buildInfoRow('Region', location.region!),
          _buildInfoRow('Coordinates', '${location.latitude.toStringAsFixed(4)}, ${location.longitude.toStringAsFixed(4)}'),
        ],
      ),
    );
  }

  Widget _buildDetailedDescription(LocationModel location) {
    final enhancedData = _enhancedDescriptions[location.id];
    final description = enhancedData?['description'] ?? location.description;
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _navyCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _blue.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.description_rounded, color: _blue, size: 24),
              SizedBox(width: 12),
              Text(
                'Detailed Description',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              color: _textSecondary,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightsSection(LocationModel location) {
    final enhancedData = _enhancedDescriptions[location.id];
    final highlights = enhancedData?['highlights'] as List<String>? ?? location.features;
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _navyCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _yellow.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.star_rounded, color: _yellow, size: 24),
              SizedBox(width: 12),
              Text(
                'Key Highlights',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...highlights.map((highlight) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.check_circle_rounded, color: _yellow, size: 16),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    highlight,
                    style: const TextStyle(
                      fontSize: 14,
                      color: _textSecondary,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildHistorySection(LocationModel location) {
    final enhancedData = _enhancedDescriptions[location.id];
    final history = enhancedData?['history'] as String?;
    final significance = enhancedData?['significance'] as String?;
    
    if (history == null && significance == null) return const SizedBox.shrink();
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _navyCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _red.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.history_rounded, color: _red, size: 24),
              SizedBox(width: 12),
              Text(
                'History & Significance',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (history != null) ...[
            const Text(
              'Historical Background',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              history,
              style: const TextStyle(
                fontSize: 14,
                color: _textSecondary,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
          ],
          if (significance != null) ...[
            const Text(
              'Cultural Significance',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              significance,
              style: const TextStyle(
                fontSize: 14,
                color: _textSecondary,
                height: 1.5,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildVisitInformation(LocationModel location) {
    final enhancedData = _enhancedDescriptions[location.id];
    final bestTime = enhancedData?['bestTime'] as String?;
    final visitDuration = enhancedData?['visitDuration'] as String?;
    final tips = enhancedData?['tips'] as List<String>?;
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _navyCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _turquoise.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.schedule_rounded, color: _turquoise, size: 24),
              SizedBox(width: 12),
              Text(
                'Visit Information',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          if (bestTime != null)
            _buildDetailRow(Icons.calendar_today_rounded, 'Best Time to Visit', bestTime, _turquoise),
          
          if (visitDuration != null)
            _buildDetailRow(Icons.timer_rounded, 'Recommended Duration', visitDuration, _blue),
          
          if (location.openingHours.isNotEmpty)
            _buildDetailRow(Icons.access_time_rounded, 'Opening Hours', location.openingHours, _yellow),
          
          _buildDetailRow(Icons.location_on_rounded, 'Coordinates', 
            '${location.latitude.toStringAsFixed(4)}, ${location.longitude.toStringAsFixed(4)}', _textTertiary),
          
          if (tips != null && tips.isNotEmpty) ...[
            const SizedBox(height: 16),
            const Text(
              'Travel Tips',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            ...tips.map((tip) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.lightbulb_rounded, color: _yellow, size: 16),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      tip,
                      style: const TextStyle(
                        fontSize: 14,
                        color: _textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: _textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    color: _textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(LocationModel location) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: Implement directions
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Directions feature coming soon!'),
                      backgroundColor: _turquoise,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.directions_rounded),
                label: const Text('Get Directions'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _turquoise,
                  foregroundColor: _navyBlue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  // TODO: Implement share
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Share feature coming soon!'),
                      backgroundColor: _blue,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.share_rounded),
                label: const Text('Share'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: _blue,
                  side: const BorderSide(color: _blue),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ARLocationViewScreen(
                    locationName: location.name,
                    locationImage: location.imageUrl,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.view_in_ar_rounded),
            label: const Text('View in AR'),
            style: ElevatedButton.styleFrom(
              backgroundColor: _yellow,
              foregroundColor: _navyBlue,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: _textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: _textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
