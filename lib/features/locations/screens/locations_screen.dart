import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:tourist_assistive_app/features/locations/providers/locations_provider.dart';
import 'package:tourist_assistive_app/features/locations/models/location_model.dart';
import 'package:tourist_assistive_app/features/locations/screens/location_detail_screen.dart';

/// Professional Ethiopian Tour Guide - Map-Focused Locations Screen
/// Scrollable Image Gallery | Google Maps Integration | Real Historical Photos
/// Navy Blue Background (#0A1929) with Turquoise Accents (#00D9B8)
class LocationsScreen extends ConsumerStatefulWidget {
  const LocationsScreen({super.key});

  @override
  ConsumerState<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends ConsumerState<LocationsScreen> {
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

  String _selectedCategory = 'All';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  // Real historical site photos from Photos folder
  final List<Map<String, dynamic>> _historicalPhotos = [
    {
      'id': 'lalibela',
      'name': 'Lalibela Rock-Hewn Churches',
      'image': 'assets/images/Lalibela.png',
      'category': 'Historical',
      'description': 'UNESCO World Heritage site with 11 monolithic churches carved from rock',
      'location': 'Lalibela, Ethiopia',
      'rating': 4.9,
    },
    {
      'id': 'axum',
      'name': 'Axum Obelisks',
      'image': 'assets/images/Axum.png',
      'category': 'Historical',
      'description': 'Ancient capital of the Kingdom of Axum with towering obelisks',
      'location': 'Axum, Ethiopia',
      'rating': 4.7,
    },
    {
      'id': 'bale',
      'name': 'Bale Mountains National Park',
      'image': 'assets/images/Bale.png',
      'category': 'Natural',
      'description': 'Highland park with unique wildlife and stunning landscapes',
      'location': 'Bale, Ethiopia',
      'rating': 4.6,
    },
    {
      'id': 'jugol',
      'name': 'Harar Jugol',
      'image': 'assets/images/Jugol.png',
      'category': 'Cultural',
      'description': 'Walled city with 82 mosques and traditional houses',
      'location': 'Harar, Ethiopia',
      'rating': 4.8,
    },
    {
      'id': 'lake_tana',
      'name': 'Lake Tana',
      'image': 'assets/images/lake tana.png',
      'category': 'Natural',
      'description': 'Source of the Blue Nile with ancient monasteries',
      'location': 'Bahir Dar, Ethiopia',
      'rating': 4.5,
    },
    {
      'id': 'fassil_gimb',
      'name': 'Fasil Ghebbi',
      'image': 'assets/images/Fassil Gimb.png',
      'category': 'Historical',
      'description': 'Royal fortress complex of Gondar',
      'location': 'Gondar, Ethiopia',
      'rating': 4.4,
    },
    {
      'id': 'danakil',
      'name': 'Danakil Depression',
      'image': 'assets/images/Danakil.png',
      'category': 'Adventure',
      'description': 'One of the hottest places on Earth with active volcanoes',
      'location': 'Afar, Ethiopia',
      'rating': 4.7,
    },
    {
      'id': 'debre_damo',
      'name': 'Debre Damo Monastery',
      'image': 'assets/images/debre damo.png',
      'category': 'Religious',
      'description': 'Ancient monastery accessible only by rope',
      'location': 'Tigray, Ethiopia',
      'rating': 4.3,
    },
    {
      'id': 'konso',
      'name': 'Konso Cultural Landscape',
      'image': 'assets/images/konso.png',
      'category': 'Cultural',
      'description': 'Traditional agricultural landscape with terraced fields',
      'location': 'Konso, Ethiopia',
      'rating': 4.2,
    },
    {
      'id': 'semen_mountain',
      'name': 'Semen Mountains',
      'image': 'assets/images/Semen mountain.jpg',
      'category': 'Natural',
      'description': 'Dramatic mountain landscapes and wildlife',
      'location': 'Semen, Ethiopia',
      'rating': 4.8,
    },
    {
      'id': 'blue_nile',
      'name': 'Blue Nile Falls',
      'image': 'assets/images/blue nile.png',
      'category': 'Natural',
      'description': 'Spectacular waterfall known as Tis Abay',
      'location': 'Bahir Dar, Ethiopia',
      'rating': 4.6,
    },
    {
      'id': 'national_museum',
      'name': 'National Museum of Ethiopia',
      'image': 'assets/images/National museium.jpg',
      'category': 'Cultural',
      'description': 'Home to Lucy and other archaeological treasures',
      'location': 'Addis Ababa, Ethiopia',
      'rating': 4.5,
    },
  ];

  void _showLocationDetail(Map<String, dynamic> photo) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.95,
        decoration: const BoxDecoration(
          color: _navyBlue,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: LocationDetailScreen(locationId: photo['id']),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _navyBlue,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // Professional Header
            _buildHeader(),
            
            // Search and Filters
            _buildSearchAndFilters(),
            
            // Main Content - Full Screen Gallery (No Map)
            _buildScrollableGallery(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _navyCard,
        border: Border(
          bottom: BorderSide(color: _turquoise.withOpacity(0.3), width: 2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Compass Icon
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _turquoise,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: _turquoise.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.explore_rounded,
              color: _navyBlue,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          
          // Title and Description
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Explore Ethiopia',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: _textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Discover ${_historicalPhotos.length} Historic Sites & Natural Wonders',
                  style: TextStyle(
                    fontSize: 16,
                    color: _textSecondary,
                  ),
                ),
              ],
            ),
          ),
          
          // Stats Badges
          Row(
            children: [
              _buildStatBadge('9', 'UNESCO Sites', _turquoise),
              const SizedBox(width: 12),
              _buildStatBadge('15+', 'Natural Parks', _yellow),
              const SizedBox(width: 12),
              _buildStatBadge('20+', 'Historic Sites', _blue),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatBadge(String number, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: _navyCard,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            number,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: _textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Search Bar
          Container(
            decoration: BoxDecoration(
              color: _navyCard,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _turquoise.withOpacity(0.3)),
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              style: const TextStyle(color: _textPrimary),
              decoration: InputDecoration(
                hintText: 'Search historic sites, national parks...',
                hintStyle: TextStyle(color: _textTertiary),
                prefixIcon: Icon(Icons.search_rounded, color: _turquoise),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Category Filters - Professional Alignment
          Container(
            height: 50,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  'All', 'Historical', 'Natural', 'Religious', 'Cultural', 'Adventure'
                ].map((category) {
                  final isSelected = _selectedCategory == category;
                  Color categoryColor = _textTertiary;
                  if (category == 'Historical') categoryColor = _turquoise;
                  if (category == 'Natural') categoryColor = _yellow;
                  if (category == 'Religious') categoryColor = _blue;
                  if (category == 'Cultural') categoryColor = _red;
                  if (category == 'Adventure') categoryColor = const Color(0xFFFF6B35);
                  
                  return Container(
                    margin: const EdgeInsets.only(right: 12),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _selectedCategory = category;
                          });
                        },
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            color: isSelected ? categoryColor : _navyCard,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: isSelected ? categoryColor : _textTertiary.withOpacity(0.3),
                              width: 2,
                            ),
                            boxShadow: isSelected ? [
                              BoxShadow(
                                color: categoryColor.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ] : null,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (isSelected) ...[
                                Icon(
                                  Icons.check_circle_rounded,
                                  color: _navyBlue,
                                  size: 16,
                                ),
                                const SizedBox(width: 8),
                              ],
                              Text(
                                category,
                                style: TextStyle(
                                  color: isSelected ? _navyBlue : _textPrimary,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildScrollableGallery() {
    final filteredPhotos = _getFilteredPhotos();
    
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _navyCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _turquoise.withOpacity(0.3), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Professional Gallery Header
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _turquoise.withOpacity(0.2),
                  _blue.withOpacity(0.1),
                ],
              ),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _turquoise,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: _turquoise.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.photo_library_rounded,
                    color: _navyBlue,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Historical Sites Gallery',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: _textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Discover ${filteredPhotos.length} Ethiopian Heritage Sites',
                        style: TextStyle(
                          fontSize: 16,
                          color: _textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: _turquoise,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: _turquoise.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    '${filteredPhotos.length} Sites',
                    style: const TextStyle(
                      color: _navyBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Full-Screen Scrollable Gallery
          filteredPhotos.isEmpty
              ? Container(
                  height: 200,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: _navyBlue,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: _textTertiary.withOpacity(0.3)),
                          ),
                          child: Icon(Icons.search_off_rounded, color: _textTertiary, size: 64),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'No sites found',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: _textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try a different search or category',
                          style: TextStyle(
                            fontSize: 16,
                            color: _textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(20),
                  itemCount: filteredPhotos.length,
                  itemBuilder: (context, index) {
                    final photo = filteredPhotos[index];
                    return _buildGalleryItem(photo, index);
                  },
                ),
        ],
      ),
    );
  }

  Widget _buildGalleryItem(Map<String, dynamic> photo, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: _navyCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _turquoise.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showLocationDetail(photo),
          borderRadius: BorderRadius.circular(20),
          child: Row(
            children: [
              // Image Section
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(19),
                  bottomLeft: Radius.circular(19),
                ),
                child: Stack(
                  children: [
                    Image.asset(
                      photo['image'],
                      width: 150,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 150,
                          height: 200,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [_navyBlue, _navyCard],
                            ),
                          ),
                          child: const Center(
                            child: Icon(Icons.landscape_rounded, color: _textTertiary, size: 48),
                          ),
                        );
                      },
                    ),
                    
                    // Category Badge
                    Positioned(
                      top: 12,
                      right: 12,
                      child: _buildCategoryBadge(photo['category']),
                    ),
                    
                    // Rating Badge
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _yellow,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star_rounded, color: _navyBlue, size: 14),
                            const SizedBox(width: 4),
                            Text(
                              photo['rating'].toString(),
                              style: const TextStyle(
                                color: _navyBlue,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Content
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      photo['name'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _textPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      photo['description'],
                      style: const TextStyle(
                        fontSize: 14,
                        color: _textSecondary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.location_on_rounded, color: _blue, size: 16),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            photo['location'],
                            style: const TextStyle(
                              fontSize: 12,
                              color: _textSecondary,
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        category,
        style: const TextStyle(
          color: _navyBlue,
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredPhotos() {
    var filtered = _historicalPhotos;
    
    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((photo) {
        return photo['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
               photo['description'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
               photo['location'].toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }
    
    // Apply category filter
    if (_selectedCategory != 'All') {
      filtered = filtered.where((photo) => photo['category'] == _selectedCategory).toList();
    }
    
    return filtered;
  }
}