import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tourist_assistive_app/features/locations/providers/locations_provider.dart';
import 'package:tourist_assistive_app/features/locations/data/ethiopian_locations.dart';
import 'package:tourist_assistive_app/features/locations/screens/location_detail_screen.dart';
import 'package:tourist_assistive_app/features/locations/screens/tour_guides_screen.dart';

// Professional Color Palette with Better Contrast
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
  static const darkGray = Color(0xFF475569);
  
  // Enhanced contrast colors for better visibility
  static const highContrastWhite = Color(0xFFFFFFFF);
  static const highContrastBlack = Color(0xFF000000);
  static const cardBackground = Color(0xFF1E293B);
  static const accentBlue = Color(0xFF0EA5E9);
  static const accentGreen = Color(0xFF10B981);
  static const accentOrange = Color(0xFFF59E0B);
}

class LocationsScreen extends ConsumerStatefulWidget {
  const LocationsScreen({super.key});

  @override
  ConsumerState<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends ConsumerState<LocationsScreen>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  String _selectedView = 'grid'; // 'grid', 'list'
  late AnimationController _fabController;

  // Correct Ethiopian historical site photos mapping with proper names
  final Map<String, String> _photoMapping = {
    // Lalibela Rock-Hewn Churches
    'lalibela-churches': 'assets/images/Lalibela.png',
    'lalibela': 'assets/images/Lalibela.png',
    
    // Axum Obelisks
    'axum-obelisks': 'assets/images/Axum.png',
    'axum': 'assets/images/Axum.png',
    
    // Gondar Castles
    'gondar-castles': 'assets/images/Fassil Gimb.png',
    'fassil-ghebbi': 'assets/images/Fassil Gimb.png',
    
    // Simien Mountains
    'simien-mountains': 'assets/images/Semen mountain.jpg',
    'simien': 'assets/images/Semen mountain.jpg',
    
    // Danakil Depression
    'danakil-depression': 'assets/images/Danakil.png',
    'danakil': 'assets/images/Danakil.png',
    
    // Bale Mountains
    'bale-mountains': 'assets/images/Bale.png',
    'bale': 'assets/images/Bale.png',
    
    // Harar Jugol
    'harar-jugol': 'Photos/Harer.jpg',
    'harar': 'Photos/Harer.jpg',
    
    // Lake Tana
    'lake-tana': 'assets/images/lake tana.png',
    'lake_tana': 'assets/images/lake tana.png',
    
    // Blue Nile Falls
    'blue-nile-falls': 'assets/images/blue nile.png',
    'blue_nile': 'assets/images/blue nile.png',
    
    // Konso Cultural Landscape
    'konso-cultural': 'assets/images/konso.png',
    'konso': 'assets/images/konso.png',
    
    // Debre Damo
    'debre-damo': 'assets/images/debre damo.png',
    'debre_damo': 'assets/images/debre damo.png',
    
    // National Museum
    'national-museum': 'assets/images/National museium.jpg',
    'national_museum': 'assets/images/National museium.jpg',
    
    // Additional Ethiopian sites with proper fallbacks
    'tiya-archaeological': 'assets/images/Lalibela.png',
    'yeha-temple': 'assets/images/Axum.png',
    'abuna-yemata': 'assets/images/Lalibela.png',
    'bete-amanuel': 'assets/images/Lalibela.png',
    'omo-valley': 'assets/images/Bale.png',
    'awash-national-park': 'assets/images/Bale.png',
    'sof-omar-caves': 'assets/images/Danakil.png',
    'entoto-mountains': 'assets/images/Semen mountain.jpg',
    'adadi-mariam': 'assets/images/Lalibela.png',
  };

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _fabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locationsState = ref.watch(locationsProvider);
    final filteredLocations = locationsState.filteredLocations;

    return Scaffold(
      backgroundColor: LocationsColors.deepNavy,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: _buildHeader(),
            ),
            // Search and Filters
            SliverToBoxAdapter(
              child: _buildSearchAndFilters(),
            ),
            // View Toggle
            SliverToBoxAdapter(
              child: _buildViewToggle(),
            ),
            // Content
            _selectedView == 'list'
                ? _buildListView(filteredLocations)
                : _buildGridView(filteredLocations),
          ],
        ),
      ),
      floatingActionButton: _buildFloatingActions(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            LocationsColors.deepNavy,
            LocationsColors.navyCard,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: LocationsColors.turquoise.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.explore_rounded,
                  color: LocationsColors.turquoise,
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ethiopian Historical Sites',
                      style: TextStyle(
                        color: LocationsColors.pureWhite,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Welcome to Ethiopia 🇪🇹',
                      style: TextStyle(
                        color: LocationsColors.lightGray,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildStatsRow(),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.3, end: 0);
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        _buildStatBadge(
          icon: Icons.location_city_rounded,
          label: '9 UNESCO Sites',
          color: LocationsColors.turquoise,
        ),
        const SizedBox(width: 8),
        _buildStatBadge(
          icon: Icons.park_rounded,
          label: '15+ Parks',
          color: LocationsColors.brightGreen,
        ),
        const SizedBox(width: 8),
        _buildStatBadge(
          icon: Icons.temple_buddhist_rounded,
          label: '20+ Historic',
          color: LocationsColors.brightYellow,
        ),
      ],
    );
  }

  Widget _buildStatBadge({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        children: [
          // Search Bar
          Container(
            decoration: BoxDecoration(
              color: LocationsColors.navyCard,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: LocationsColors.pureWhite),
              decoration: const InputDecoration(
                hintText: 'Search Ethiopian historical sites...',
                hintStyle: TextStyle(color: LocationsColors.mediumGray),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: LocationsColors.turquoise,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
              ),
              onChanged: (value) {
                ref.read(locationsProvider.notifier).searchLocations(value);
                setState(() {});
              },
            ),
          ),
          const SizedBox(height: 12),
          // Category Filters
          _buildCategoryFilters(),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms, duration: 400.ms);
  }

  Widget _buildCategoryFilters() {
    final selectedCategory = ref.watch(locationsProvider).selectedCategory;
    final categories = EthiopianLocations.categories;

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == selectedCategory;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              selected: isSelected,
              label: Text(category),
              labelStyle: TextStyle(
                color: isSelected
                    ? LocationsColors.deepNavy
                    : LocationsColors.lightGray,
                fontWeight: FontWeight.w600,
              ),
              backgroundColor: LocationsColors.navyCard,
              selectedColor: _getCategoryColor(category),
              checkmarkColor: LocationsColors.deepNavy,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected
                      ? _getCategoryColor(category)
                      : LocationsColors.darkGray,
                ),
              ),
              onSelected: (selected) {
                ref.read(locationsProvider.notifier).filterByCategory(category);
              },
            ).animate(target: isSelected ? 1 : 0).scale(
                  begin: const Offset(1, 1),
                  end: const Offset(1.05, 1.05),
                ),
          );
        },
      ),
    );
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

  Widget _buildViewToggle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          Text(
            '${ref.watch(locationsProvider).filteredLocations.length} Ethiopian Sites',
            style: const TextStyle(
              color: LocationsColors.lightGray,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              color: LocationsColors.navyCard,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                _buildViewButton(Icons.grid_view_rounded, 'grid'),
                _buildViewButton(Icons.list_rounded, 'list'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewButton(IconData icon, String view) {
    final isSelected = _selectedView == view;
    return IconButton(
      icon: Icon(icon),
      color: isSelected ? LocationsColors.turquoise : LocationsColors.mediumGray,
      onPressed: () {
        setState(() {
          _selectedView = view;
        });
      },
    );
  }

  Widget _buildGridView(List<dynamic> locations) {
    if (locations.isEmpty) {
      return SliverToBoxAdapter(child: _buildEmptyState());
    }

    return SliverPadding(
      padding: const EdgeInsets.all(20),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final location = locations[index];
            return _buildLocationCard(location, index);
          },
          childCount: locations.length,
        ),
      ),
    );
  }

  Widget _buildListView(List<dynamic> locations) {
    if (locations.isEmpty) {
      return SliverToBoxAdapter(child: _buildEmptyState());
    }

    return SliverPadding(
      padding: const EdgeInsets.all(20),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final location = locations[index];
            return _buildLocationListTile(location, index);
          },
          childCount: locations.length,
        ),
      ),
    );
  }

  Widget _buildLocationCard(dynamic location, int index) {
    final imagePath = _photoMapping[location.id] ?? 'assets/images/Logo.png';
    
    return GestureDetector(
      onTap: () => _showFullScreenImage(context, location, imagePath),
      child: Container(
        decoration: BoxDecoration(
          color: LocationsColors.navyCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: LocationsColors.turquoise.withValues(alpha: 0.2),
          ),
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
            // Real Ethiopian Historical Site Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  child: Image.asset(
                    imagePath,
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 140,
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
                            size: 48,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Rating Badge
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: LocationsColors.brightYellow,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          location.rating.toString(),
                          style: const TextStyle(
                            color: LocationsColors.pureWhite,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Category Badge
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getCategoryColor(location.category),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      location.category,
                      style: const TextStyle(
                        color: LocationsColors.deepNavy,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location.name,
                    style: const TextStyle(
                      color: LocationsColors.pureWhite,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        color: LocationsColors.turquoise,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          _getLocationCity(location),
                          style: const TextStyle(
                            color: LocationsColors.mediumGray,
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ).animate().fadeIn(delay: (100 * index).ms).slideY(begin: 0.3, end: 0),
    );
  }

  Widget _buildLocationListTile(dynamic location, int index) {
    final imagePath = _photoMapping[location.id] ?? 'assets/images/Logo.png';
    
    return GestureDetector(
      onTap: () => _showFullScreenImage(context, location, imagePath),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: LocationsColors.navyCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: LocationsColors.turquoise.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          children: [
            // Real Ethiopian Historical Site Image
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(16),
              ),
              child: Image.asset(
                imagePath,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 100,
                    width: 100,
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
                    child: Icon(
                      _getCategoryIcon(location.category),
                      color: LocationsColors.pureWhite,
                      size: 40,
                    ),
                  );
                },
              ),
            ),
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      location.name,
                      style: const TextStyle(
                        color: LocationsColors.pureWhite,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      location.description,
                      style: const TextStyle(
                        color: LocationsColors.mediumGray,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getCategoryColor(location.category).withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            location.category,
                            style: TextStyle(
                              color: _getCategoryColor(location.category),
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.star_rounded,
                          color: LocationsColors.brightYellow,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          location.rating.toString(),
                          style: const TextStyle(
                            color: LocationsColors.pureWhite,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(12),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: LocationsColors.turquoise,
                size: 20,
              ),
            ),
          ],
        ),
      ).animate().fadeIn(delay: (50 * index).ms).slideX(begin: 0.3, end: 0),
    );
  }

  // Full-screen image viewer
  void _showFullScreenImage(BuildContext context, dynamic location, String imagePath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenImageViewer(
          location: location,
          imagePath: imagePath,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 80,
            color: LocationsColors.mediumGray.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          const Text(
            'No Ethiopian sites found',
            style: TextStyle(
              color: LocationsColors.lightGray,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Try adjusting your search or filters',
            style: TextStyle(
              color: LocationsColors.mediumGray,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActions() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TourGuidesScreen(),
              ),
            );
          },
          backgroundColor: LocationsColors.turquoise,
          icon: const Icon(Icons.tour_rounded),
          label: const Text(
            'Imaginative Tour',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ).animate().fadeIn(delay: 400.ms).scale(),
      ],
    );
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

  String _getLocationCity(dynamic location) {
    if (location.city != null && location.city.isNotEmpty) {
      return location.city;
    }
    if (location.address != null && location.address.isNotEmpty) {
      return location.address.split(',').first;
    }
    return 'Ethiopia';
  }
}

// Full-screen image viewer widget
class FullScreenImageViewer extends StatelessWidget {
  final dynamic location;
  final String imagePath;

  const FullScreenImageViewer({
    super.key,
    required this.location,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black.withValues(alpha: 0.5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          location.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline_rounded, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LocationDetailScreen(locationId: location.id),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: InteractiveViewer(
          minScale: 0.5,
          maxScale: 4.0,
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.image_not_supported_rounded,
                      color: Colors.white,
                      size: 80,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Image not available',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      location.name,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
