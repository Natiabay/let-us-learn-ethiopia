import 'package:flutter/material.dart';
import 'package:tourist_assistive_app/core/constants/app_colors.dart';
import 'package:tourist_assistive_app/features/locations/models/location_model.dart';
import 'package:tourist_assistive_app/features/locations/screens/location_detail_screen_enhanced.dart';

/// Professional Locations Screen with Ethiopian Historical Sites
/// Features:
/// - Full-screen image viewing with InteractiveViewer
/// - Exact photo mapping for each Ethiopian location
/// - Google Maps integration in detail screen
/// - Professional UI/UX with smooth animations
/// - Search and filter functionality
/// - Interactive cards with ratings and distance
class LocationsScreen extends StatefulWidget {
  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> with SingleTickerProviderStateMixin {
  String _searchQuery = '';
  String _selectedCategory = 'All';
  bool _isGridView = true;
  late AnimationController _animationController;

  final List<String> _categories = [
    'All',
    'UNESCO Sites',
    'Historical',
    'Natural',
    'Religious',
    'Cultural',
  ];

  /// Ethiopian Historical Sites with Exact Photo Mapping
  final Map<String, String> _photoMapping = {
    'lalibela-churches': 'Photos/Lalibela.png',
    'simien-mountains': 'Photos/Semen mountain.jpg',
    'axum-obelisks': 'Photos/Axum.png',
    'fasil-ghebbi': 'Photos/Fassil Gimb.png',
    'lower-valley-omo': 'Photos/konso.png',
    'blue-nile-falls': 'Photos/blue nile.png',
    'lake-tana': 'Photos/lake tana.png',
    'bale-mountains': 'Photos/Bale.png',
    'danakil-depression': 'Photos/Danakil.png',
    'harar-jugol': 'Photos/Jugol.png',
    'national-museum': 'Photos/National museium.jpg',
    'addis-ababa': 'Photos/Addis Ababa.avif',
    'debre-damo': 'Photos/debre damo.png',
  };

  /// Complete List of Ethiopian Locations with All Required Fields
  final List<LocationModel> _allLocations = [
    // 1. Lalibela
    LocationModel(
      id: 'lalibela-churches',
      name: 'Rock-Hewn Churches of Lalibela',
      description: 'Eleven medieval monolithic churches carved from rock in the 12th century.',
      city: 'Lalibela',
      latitude: 12.0311,
      longitude: 39.0473,
      category: 'UNESCO Sites',
      rating: 4.9,
      imageUrl: 'Photos/Lalibela.png',
      isFavorite: false,
      openingHours: '6:00 AM - 6:00 PM daily',
      entryFee: '\$50 USD',
      features: ['Rock-hewn churches', 'Religious site', 'UNESCO Heritage'],
      nameAmharic: 'የላሊበላ ቤተ ክርስቲያናት',
      reviewCount: 15234,
      entrance: 50.0,
      visitDuration: '4-6 hours',
      isEthiopian: true,
      country: 'Ethiopia',
    ),

    // 2. Simien Mountains
    LocationModel(
      id: 'simien-mountains',
      name: 'Simien Mountains National Park',
      description: 'Africa\'s most spectacular mountain scenery with endemic wildlife.',
      city: 'Debark',
      latitude: 13.2167,
      longitude: 38.0500,
      category: 'UNESCO Sites',
      rating: 4.8,
      imageUrl: 'Photos/Semen mountain.jpg',
      isFavorite: false,
      openingHours: 'Open 24/7',
      entryFee: '\$90 USD',
      features: ['Mountain trekking', 'Wildlife viewing', 'UNESCO Heritage'],
      nameAmharic: 'የስሜን ተራሮች ብሔራዊ ፓርክ',
      reviewCount: 8956,
      entrance: 90.0,
      visitDuration: '3-7 days',
      isEthiopian: true,
      country: 'Ethiopia',
    ),

    // 3. Axum Obelisks
    LocationModel(
      id: 'axum-obelisks',
      name: 'Axum Obelisks',
      description: 'Ancient stelae marking royal tombs of the Aksumite Empire.',
      city: 'Axum',
      latitude: 14.1306,
      longitude: 38.7169,
      category: 'UNESCO Sites',
      rating: 4.7,
      imageUrl: 'Photos/Axum.png',
      isFavorite: false,
      openingHours: '8:00 AM - 5:00 PM',
      entryFee: '\$30 USD',
      features: ['Ancient obelisks', 'Historical site', 'UNESCO Heritage'],
      nameAmharic: 'የአክሱም ሐውልቶች',
      reviewCount: 6543,
      entrance: 30.0,
      visitDuration: '2-3 hours',
      isEthiopian: true,
      country: 'Ethiopia',
    ),

    // 4. Fasil Ghebbi
    LocationModel(
      id: 'fasil-ghebbi',
      name: 'Fasil Ghebbi (Royal Enclosure)',
      description: 'Fortress-city of Gondar with castles built by Ethiopian emperors.',
      city: 'Gondar',
      latitude: 12.6089,
      longitude: 37.4656,
      category: 'UNESCO Sites',
      rating: 4.6,
      imageUrl: 'Photos/Fassil Gimb.png',
      isFavorite: false,
      openingHours: '8:30 AM - 5:30 PM',
      entryFee: '\$20 USD',
      features: ['Medieval castles', 'Historical site', 'UNESCO Heritage'],
      nameAmharic: 'ፋሲል ግቢ',
      reviewCount: 5432,
      entrance: 20.0,
      visitDuration: '3-4 hours',
      isEthiopian: true,
      country: 'Ethiopia',
    ),

    // 5. Lower Valley of the Omo
    LocationModel(
      id: 'lower-valley-omo',
      name: 'Lower Valley of the Omo',
      description: 'Archaeological site with evidence of human evolution spanning 4 million years.',
      city: 'Jinka',
      latitude: 5.1167,
      longitude: 36.2500,
      category: 'UNESCO Sites',
      rating: 4.5,
      imageUrl: 'Photos/konso.png',
      isFavorite: false,
      openingHours: 'Open with guide',
      entryFee: '\$75 USD',
      features: ['Archaeological site', 'Tribal villages', 'UNESCO Heritage'],
      nameAmharic: 'የታችኛው የኦሞ ሸለቆ',
      reviewCount: 3210,
      entrance: 75.0,
      visitDuration: '3-7 days',
      isEthiopian: true,
      country: 'Ethiopia',
    ),

    // 6. Blue Nile Falls
    LocationModel(
      id: 'blue-nile-falls',
      name: 'Blue Nile Falls (Tis Issat)',
      description: 'Spectacular waterfall on the Blue Nile River, known as "Smoking Water".',
      city: 'Bahir Dar',
      latitude: 11.5152,
      longitude: 37.5860,
      category: 'Natural',
      rating: 4.4,
      imageUrl: 'Photos/blue nile.png',
      isFavorite: false,
      openingHours: 'Dawn to dusk',
      entryFee: '\$15 USD',
      features: ['Waterfall', 'Hiking trails', 'Natural wonder'],
      nameAmharic: 'ጥስ እሳት',
      reviewCount: 4567,
      entrance: 15.0,
      visitDuration: '2-3 hours',
      isEthiopian: true,
      country: 'Ethiopia',
    ),

    // 7. Lake Tana
    LocationModel(
      id: 'lake-tana',
      name: 'Lake Tana Monasteries',
      description: 'Ethiopia\'s largest lake with island monasteries dating back to 14th century.',
      city: 'Bahir Dar',
      latitude: 12.0000,
      longitude: 37.3167,
      category: 'Religious',
      rating: 4.5,
      imageUrl: 'Photos/lake tana.png',
      isFavorite: false,
      openingHours: '7:00 AM - 5:00 PM',
      entryFee: '\$25 USD',
      features: ['Island monasteries', 'Boat tours', 'Bird watching'],
      nameAmharic: 'የጣና ሀይቅ ገዳማት',
      reviewCount: 3890,
      entrance: 25.0,
      visitDuration: 'Full day',
      isEthiopian: true,
      country: 'Ethiopia',
    ),

    // 8. Bale Mountains
    LocationModel(
      id: 'bale-mountains',
      name: 'Bale Mountains National Park',
      description: 'Pristine afro-alpine habitat home to the endangered Ethiopian wolf.',
      city: 'Goba',
      latitude: 7.0667,
      longitude: 39.7833,
      category: 'Natural',
      rating: 4.7,
      imageUrl: 'Photos/Bale.png',
      isFavorite: false,
      openingHours: 'Open 24/7',
      entryFee: '\$90 USD',
      features: ['Wildlife viewing', 'Trekking', 'Ethiopian wolf habitat'],
      nameAmharic: 'የባሌ ተራሮች ብሔራዊ ፓርክ',
      reviewCount: 2345,
      entrance: 90.0,
      visitDuration: '2-5 days',
      isEthiopian: true,
      country: 'Ethiopia',
    ),

    // 9. Danakil Depression
    LocationModel(
      id: 'danakil-depression',
      name: 'Danakil Depression',
      description: 'One of Earth\'s hottest places with active volcano and colorful sulfur springs.',
      city: 'Mekele',
      latitude: 14.2417,
      longitude: 40.3000,
      category: 'Natural',
      rating: 4.9,
      imageUrl: 'Photos/Danakil.png',
      isFavorite: false,
      openingHours: 'Guided tours only',
      entryFee: '\$150 USD',
      features: ['Active volcano', 'Salt flats', 'Extreme environment'],
      nameAmharic: 'የዳናክል ቁልቁል',
      reviewCount: 1876,
      entrance: 150.0,
      visitDuration: '3-4 days',
      isEthiopian: true,
      country: 'Ethiopia',
    ),

    // 10. Harar Jugol
    LocationModel(
      id: 'harar-jugol',
      name: 'Harar Jugol (Fortified Historic Town)',
      description: 'Ancient walled city, fourth holiest city in Islam with unique architecture.',
      city: 'Harar',
      latitude: 9.3142,
      longitude: 42.1284,
      category: 'UNESCO Sites',
      rating: 4.6,
      imageUrl: 'Photos/Jugol.png',
      isFavorite: false,
      openingHours: 'Open access',
      entryFee: '\$20 USD',
      features: ['Walled city', 'Islamic heritage', 'Hyena feeding'],
      nameAmharic: 'ሐረር ጁጎል',
      reviewCount: 4123,
      entrance: 20.0,
      visitDuration: '2-3 days',
      isEthiopian: true,
      country: 'Ethiopia',
    ),

    // 11. National Museum
    LocationModel(
      id: 'national-museum',
      name: 'National Museum of Ethiopia',
      description: 'Home to "Lucy", the 3.2 million-year-old hominid fossil.',
      city: 'Addis Ababa',
      latitude: 9.0192,
      longitude: 38.7525,
      category: 'Cultural',
      rating: 4.5,
      imageUrl: 'Photos/National museium.jpg',
      isFavorite: false,
      openingHours: '8:30 AM - 5:00 PM (Closed Mondays)',
      entryFee: '\$10 USD',
      features: ['Lucy fossil', 'Ethiopian history', 'Archaeological exhibits'],
      nameAmharic: 'የኢትዮጵያ ብሔራዊ ሙዚየም',
      reviewCount: 5678,
      entrance: 10.0,
      visitDuration: '2-3 hours',
      isEthiopian: true,
      country: 'Ethiopia',
    ),

    // 12. Addis Ababa
    LocationModel(
      id: 'addis-ababa',
      name: 'Addis Ababa',
      description: 'Ethiopia\'s vibrant capital city, hub of African Union and rich coffee culture.',
      city: 'Addis Ababa',
      latitude: 9.0320,
      longitude: 38.7469,
      category: 'Cultural',
      rating: 4.3,
      imageUrl: 'Photos/Addis Ababa.avif',
      isFavorite: false,
      openingHours: 'Open 24/7',
      entryFee: 'Free',
      features: ['Capital city', 'African Union HQ', 'Coffee culture', 'Markets'],
      nameAmharic: 'አዲስ አበባ',
      reviewCount: 12345,
      entrance: 0.0,
      visitDuration: '2-4 days',
      isEthiopian: true,
      country: 'Ethiopia',
    ),

    // 13. Debre Damo
    LocationModel(
      id: 'debre-damo',
      name: 'Debre Damo Monastery',
      description: 'Ancient monastery atop a mountain, accessible only by rope (men only).',
      city: 'Adigrat',
      latitude: 14.3833,
      longitude: 39.2667,
      category: 'Religious',
      rating: 4.4,
      imageUrl: 'Photos/debre damo.png',
      isFavorite: false,
      openingHours: 'Dawn to dusk (Men only)',
      entryFee: '\$30 USD',
      features: ['Ancient monastery', 'Rope climb', 'Mountain views'],
      nameAmharic: 'ደብረ ዳሞ ገዳም',
      reviewCount: 876,
      entrance: 30.0,
      visitDuration: '3-4 hours',
      isEthiopian: true,
      country: 'Ethiopia',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<LocationModel> get _filteredLocations {
    return _allLocations.where((location) {
      final matchesSearch = location.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (location.nameAmharic?.contains(_searchQuery) ?? false) ||
          location.description.toLowerCase().contains(_searchQuery.toLowerCase());
      
      final matchesCategory = _selectedCategory == 'All' || location.category == _selectedCategory;
      
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with Search
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Explore Ethiopia',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 1),
                      blurRadius: 3.0,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'Photos/Addis Ababa.avif',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(color: Colors.grey[300]);
                    },
                  ),
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
                ],
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search Ethiopian destinations...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                  ),
                ),
              ),
            ),
          ),

          // Category Filter
          SliverToBoxAdapter(
            child: SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  final isSelected = category == _selectedCategory;
                  
                  return Padding(
                    padding: EdgeInsets.only(
                      left: index == 0 ? 16.0 : 8.0,
                      right: index == _categories.length - 1 ? 16.0 : 0,
                      top: 8.0,
                      bottom: 8.0,
                    ),
                    child: FilterChip(
                      label: Text(category),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                      backgroundColor: Colors.grey[200],
                      selectedColor: AppColors.primary,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // View Toggle and Count
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_filteredLocations.length} destinations found',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.grid_view,
                          color: _isGridView ? AppColors.primary : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isGridView = true;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.list,
                          color: !_isGridView ? AppColors.primary : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isGridView = false;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Locations Grid/List
          _isGridView ? _buildGridView() : _buildListView(),
        ],
      ),
    );
  }

  Widget _buildGridView() {
    return SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final location = _filteredLocations[index];
            return _buildLocationCard(location);
          },
          childCount: _filteredLocations.length,
        ),
      ),
    );
  }

  Widget _buildListView() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final location = _filteredLocations[index];
          return _buildLocationListItem(location);
        },
        childCount: _filteredLocations.length,
      ),
    );
  }

  Widget _buildLocationCard(LocationModel location) {
    final imagePath = _photoMapping[location.id] ?? 'Photos/New Logo.png';
    
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LocationDetailScreenEnhanced(
              locationId: location.id,
            ),
          ),
        );
      },
      onLongPress: () {
        _showFullScreenImage(context, location, imagePath);
      },
      child: Hero(
        tag: 'location_${location.id}',
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Icon(Icons.image_not_supported, size: 50),
                          );
                        },
                      ),
                      // Gradient Overlay
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 60,
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
                      ),
                      // Category Badge
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            location.category,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Details
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        location.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      // Amharic Name
                      if (location.nameAmharic != null)
                        Text(
                          location.nameAmharic!,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      const Spacer(),
                      // Rating
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            location.rating.toStringAsFixed(1),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 4),
                          if (location.reviewCount != null)
                            Text(
                              '(${location.reviewCount})',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[600],
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationListItem(LocationModel location) {
    final imagePath = _photoMapping[location.id] ?? 'Photos/New Logo.png';
    
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LocationDetailScreenEnhanced(
              locationId: location.id,
            ),
          ),
        );
      },
      onLongPress: () {
        _showFullScreenImage(context, location, imagePath);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          children: [
            // Image
            Hero(
              tag: 'location_${location.id}',
              child: ClipRRect(
                borderRadius: const BorderRadius.horizontal(left: Radius.circular(12.0)),
                child: Image.asset(
                  imagePath,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 120,
                      height: 120,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image_not_supported, size: 40),
                    );
                  },
                ),
              ),
            ),
            // Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      location.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    // Amharic Name
                    if (location.nameAmharic != null)
                      Text(
                        location.nameAmharic!,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const SizedBox(height: 8),
                    // Category
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        location.category,
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Rating and Reviews
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          location.rating.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (location.reviewCount != null)
                          Text(
                            '${location.reviewCount} reviews',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[600],
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Arrow Icon
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFullScreenImage(BuildContext context, LocationModel location, String imagePath) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FullScreenImageViewer(
          location: location,
          imagePath: imagePath,
        ),
      ),
    );
  }
}

/// Full Screen Image Viewer with InteractiveViewer for zoom/pan
class FullScreenImageViewer extends StatelessWidget {
  final LocationModel location;
  final String imagePath;

  const FullScreenImageViewer({
    super.key,
    required this.location,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Full Screen Image with Zoom/Pan
          InteractiveViewer(
            minScale: 0.5,
            maxScale: 4.0,
            child: Hero(
              tag: 'location_${location.id}',
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[900],
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported,
                        size: 100,
                        color: Colors.white54,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          // Bottom Details Overlay
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.9),
                  ],
                ),
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      location.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (location.nameAmharic != null)
                      Text(
                        location.nameAmharic!,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: 16,
                        ),
                      ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          location.rating.toStringAsFixed(1),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (location.reviewCount != null)
                          Text(
                            '(${location.reviewCount} reviews)',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.7),
                              fontSize: 14,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => LocationDetailScreenEnhanced(
                              locationId: location.id,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.info_outline),
                      label: const Text('View Full Details'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


