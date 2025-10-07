import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tourist_assistive_app/core/theme/app_theme.dart';
import 'package:tourist_assistive_app/core/services/google_maps_service.dart';
import 'package:tourist_assistive_app/features/locations/widgets/location_card.dart';
import 'package:tourist_assistive_app/features/locations/widgets/search_bar_widget.dart';
import 'package:tourist_assistive_app/features/locations/widgets/category_filter.dart';
import 'package:tourist_assistive_app/features/locations/widgets/map_view_widget.dart';
import 'package:tourist_assistive_app/features/locations/widgets/automated_map_widget.dart';
import 'package:tourist_assistive_app/features/locations/widgets/global_location_filter.dart';
import 'package:tourist_assistive_app/features/locations/providers/locations_provider.dart';

class LocationsScreen extends ConsumerStatefulWidget {
  final String? mode;
  final String? category;
  
  const LocationsScreen({
    super.key,
    this.mode,
    this.category,
  });

  @override
  ConsumerState<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends ConsumerState<LocationsScreen>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _fabController;
  late Animation<double> _fabAnimation;
  bool _isMapView = false;
  String _selectedCategory = 'All';
  String _selectedRegion = 'All';
  String _selectedCountry = 'All';
  String? _currentLocation;
  LatLng? _userPosition;

  final List<String> _categories = [
    'All',
    'Historical',
    'Natural',
    'Cultural',
    'Religious',
    'Adventure',
    'Food & Drink',
    'Shopping',
  ];

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fabAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _fabController, curve: Curves.easeInOut),
    );
    _fabController.forward();
    
    _getCurrentLocation();
    
    // Handle mode and category parameters
    _handleModeAndCategory();
  }
  
  void _handleModeAndCategory() {
    if (widget.mode != null) {
      switch (widget.mode) {
        case 'map':
          setState(() {
            _isMapView = true;
          });
          break;
        case 'current':
          _getCurrentLocation();
          break;
        case 'nearby':
          _getCurrentLocation();
          break;
        case 'search':
          // Focus on search bar
          break;
        case 'directions':
          // Show directions mode
          break;
      }
    }
    
    if (widget.category != null) {
      setState(() {
        _selectedCategory = widget.category!;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _fabController.dispose();
    super.dispose();
  }

  Widget _buildLocationDashboard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1976D2),
            Color(0xFF42A5F5),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.location_on_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Location Explorer Dashboard',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Explore Ethiopia by category:',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          // Category Buttons
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildLocationButton(
                'Historical',
                Icons.history_edu_rounded,
                () => _filterByCategory('Historical'),
              ),
              _buildLocationButton(
                'Natural',
                Icons.nature_rounded,
                () => _filterByCategory('Natural'),
              ),
              _buildLocationButton(
                'Cultural',
                Icons.museum_rounded,
                () => _filterByCategory('Cultural'),
              ),
              _buildLocationButton(
                'Religious',
                Icons.church_rounded,
                () => _filterByCategory('Religious'),
              ),
              _buildLocationButton(
                'Adventure',
                Icons.hiking_rounded,
                () => _filterByCategory('Adventure'),
              ),
              _buildLocationButton(
                'Food & Drink',
                Icons.restaurant_rounded,
                () => _filterByCategory('Food & Drink'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Quick Actions
          Row(
            children: [
              Expanded(
                child: _buildQuickActionButton(
                  'Current Location',
                  Icons.my_location_rounded,
                  () => _getCurrentLocation(),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildQuickActionButton(
                  'Map View',
                  Icons.map_rounded,
                  () => _toggleMapView(),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildQuickActionButton(
                  'Nearby',
                  Icons.near_me_rounded,
                  () => _showNearbyPlaces(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLocationButton(String title, IconData icon, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActionButton(String title, IconData icon, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _filterByCategory(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  void _toggleMapView() {
    setState(() {
      _isMapView = !_isMapView;
    });
  }

  void _showNearbyPlaces() {
    // Show nearby places dialog or navigate to nearby view
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nearby Places'),
        content: const Text('Finding attractions near your location...'),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    try {
      final coordinates = await GoogleMapsService.getCurrentLocation();
      
      if (coordinates != null) {
        setState(() {
          _userPosition = coordinates;
        });
        
        // Get city name from coordinates
        final city = await GoogleMapsService.getAddressFromCoordinates(coordinates);
        
        if (city != null) {
          setState(() {
            _currentLocation = city;
          });
        }
      }
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final locationsState = ref.watch(locationsProvider);
    final locations = locationsState.filteredLocations;
    final isLoading = locationsState.isLoading;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: _isMapView
            ? Column(
                children: [
                  // Enhanced Location Dashboard with Gradient Header
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF58CC02),
                          Color(0xFF1CB0F6),
                          Color(0xFFCE82FF),
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: _buildLocationDashboard(),
                  ),
                  // Header with Search
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Top Row
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Explore Ethiopia',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  if (_currentLocation != null)
                                    Text(
                                      '📍 $_currentLocation',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: _getCurrentLocation,
                              icon: const Icon(Icons.my_location),
                              tooltip: 'Get Current Location',
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Search Bar
                        SearchBarWidget(
                          controller: _searchController,
                          onChanged: (value) {
                            ref.read(locationsProvider.notifier).searchLocations(value);
                          },
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Global Location Filter
                        GlobalLocationFilter(
                          selectedRegion: _selectedRegion,
                          selectedCountry: _selectedCountry,
                          selectedCategory: _selectedCategory,
                          showEthiopianEmphasis: true,
                          onFilterChanged: (region, country, category) {
                            setState(() {
                              _selectedRegion = region;
                              _selectedCountry = country;
                              _selectedCategory = category;
                            });
                            ref.read(locationsProvider.notifier).filterByRegion(region);
                            ref.read(locationsProvider.notifier).filterByCountry(country);
                            ref.read(locationsProvider.notifier).filterByCategory(category);
                          },
                        ),
                      ],
                    ),
                  ),
                  // Map Content with proper bottom margin
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 80),
                      child: AutomatedMapWidget(
                        customLocations: locations.map((loc) => LatLng(loc.latitude, loc.longitude)).toList(),
                        showUserLocation: true,
                        showEthiopianLocations: true,
                        showGlobalLocations: true,
                        selectedRegion: _selectedRegion,
                        selectedCountry: _selectedCountry,
                        selectedCategory: _selectedCategory,
                      ),
                    ),
                  ),
                ],
              )
            : CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // Enhanced Location Dashboard with Gradient Header
                  SliverToBoxAdapter(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF58CC02),
                            Color(0xFF1CB0F6),
                            Color(0xFFCE82FF),
                          ],
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: _buildLocationDashboard(),
                    ),
                  ),
                  // Header with Search
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Top Row
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Explore Ethiopia',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    if (_currentLocation != null)
                                      Text(
                                        '📍 $_currentLocation',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: _getCurrentLocation,
                                icon: const Icon(Icons.my_location),
                                tooltip: 'Get Current Location',
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Search Bar
                          SearchBarWidget(
                            controller: _searchController,
                            onChanged: (value) {
                              ref.read(locationsProvider.notifier).searchLocations(value);
                            },
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Global Location Filter
                          GlobalLocationFilter(
                            selectedRegion: _selectedRegion,
                            selectedCountry: _selectedCountry,
                            selectedCategory: _selectedCategory,
                            showEthiopianEmphasis: true,
                            onFilterChanged: (region, country, category) {
                              setState(() {
                                _selectedRegion = region;
                                _selectedCountry = country;
                                _selectedCategory = category;
                              });
                              ref.read(locationsProvider.notifier).filterByRegion(region);
                              ref.read(locationsProvider.notifier).filterByCountry(country);
                              ref.read(locationsProvider.notifier).filterByCategory(category);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Locations List
                  _buildSliverLocationsList(locations, isLoading),
          ],
        ),
      ),
      floatingActionButton: AnimatedBuilder(
        animation: _fabAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _fabAnimation.value,
            child: FloatingActionButton.extended(
              heroTag: "locations_fab_unique",
              onPressed: () {
                setState(() {
                  _isMapView = !_isMapView;
                });
              },
              backgroundColor: AppColors.primary,
              icon: Icon(_isMapView ? Icons.list : Icons.map),
              label: Text(_isMapView ? 'List View' : 'Map View'),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildSliverLocationsList(List<dynamic> locations, bool isLoading) {
    if (isLoading) {
      return const SliverFillRemaining(
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        ),
      );
    }

    if (locations.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_off,
                size: 64,
                color: AppColors.grey.withValues(alpha: 0.5),
              ),
              const SizedBox(height: 16),
              Text(
                'No locations found',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.grey.withValues(alpha: 0.7),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Try adjusting your search or filters',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.grey.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final location = locations[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: LocationCard(
                location: location,
                onTap: () {
                  context.go('/locations/detail/${location.id}');
                },
                onFavorite: () {
                  ref.read(locationsProvider.notifier).toggleFavorite(location.id);
                },
              ),
            );
          },
          childCount: locations.length,
        ),
      ),
    );
  }

  Widget _buildLocationsList(List<dynamic> locations, bool isLoading) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
        ),
      );
    }

    if (locations.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_off,
              size: 64,
              color: AppColors.grey.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No locations found',
              style: TextStyle(
                fontSize: 18,
                color: AppColors.grey.withValues(alpha: 0.7),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try adjusting your search or filters',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.grey.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(locationsProvider.notifier).loadLocations();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: locations.length,
        itemBuilder: (context, index) {
          final location = locations[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: LocationCard(
              location: location,
              onTap: () {
                context.go('/locations/detail/${location.id}');
              },
              onFavorite: () {
                ref.read(locationsProvider.notifier).toggleFavorite(location.id);
              },
            ),
          );
        },
      ),
    );
  }
}