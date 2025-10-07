import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tourist_assistive_app/core/services/automated_google_maps_service.dart';
import 'package:tourist_assistive_app/features/locations/data/global_locations.dart';

/// Enhanced Automated Map Widget with Global Locations and Ethiopian Emphasis
/// Shows worldwide tourist destinations with special focus on Ethiopian sites
class AutomatedMapWidget extends StatefulWidget {
  final List<LatLng>? customLocations;
  final LatLng? center;
  final double? zoom;
  final bool showUserLocation;
  final bool showEthiopianLocations;
  final bool showGlobalLocations;
  final String selectedRegion;
  final String selectedCountry;
  final String selectedCategory;

  const AutomatedMapWidget({
    super.key,
    this.customLocations,
    this.center,
    this.zoom,
    this.showUserLocation = true,
    this.showEthiopianLocations = true,
    this.showGlobalLocations = true,
    this.selectedRegion = 'All',
    this.selectedCountry = 'All',
    this.selectedCategory = 'All',
  });

  @override
  State<AutomatedMapWidget> createState() => _AutomatedMapWidgetState();
}

class _AutomatedMapWidgetState extends State<AutomatedMapWidget> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  LatLng? _currentLocation;
  bool _isLoading = true;
  List<GlobalLocation> _displayedLocations = [];

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  @override
  void didUpdateWidget(AutomatedMapWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedRegion != widget.selectedRegion ||
        oldWidget.selectedCountry != widget.selectedCountry ||
        oldWidget.selectedCategory != widget.selectedCategory) {
      _createMarkers();
    }
  }

  Future<void> _initializeMap() async {
    try {
      // Initialize automated Google Maps service
      await AutomatedGoogleMapsService.initialize();
      
      // Get current location if enabled
      if (widget.showUserLocation) {
        _currentLocation = await AutomatedGoogleMapsService.getCurrentLocation();
      }
      
      // Create markers
      await _createMarkers();
      
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('⚠️ Map initialization failed: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _createMarkers() async {
    final markers = <Marker>{};
    _displayedLocations.clear();
    
    // Get filtered locations based on selections
    List<GlobalLocation> locationsToShow = [];
    
    if (widget.showGlobalLocations) {
      locationsToShow = GlobalLocations.all;
      
      // Apply region filter
      if (widget.selectedRegion != 'All') {
        locationsToShow = locationsToShow.where((loc) => loc.region == widget.selectedRegion).toList();
      }
      
      // Apply country filter
      if (widget.selectedCountry != 'All') {
        locationsToShow = locationsToShow.where((loc) => loc.country == widget.selectedCountry).toList();
      }
      
      // Apply category filter
      if (widget.selectedCategory != 'All') {
        locationsToShow = locationsToShow.where((loc) => loc.category == widget.selectedCategory).toList();
      }
    } else if (widget.showEthiopianLocations) {
      // Show only Ethiopian locations
      locationsToShow = GlobalLocations.ethiopianLocations;
    }
    
    _displayedLocations = locationsToShow;
    
    // Create markers with different colors based on priority and type
    for (final location in locationsToShow) {
      final markerColor = _getMarkerColor(location);
      final markerIcon = _getMarkerIcon(location);
      
      markers.add(
        Marker(
          markerId: MarkerId(location.id),
          position: LatLng(location.latitude, location.longitude),
          infoWindow: InfoWindow(
            title: location.name,
            snippet: '${location.city}, ${location.country} • ⭐ ${location.rating}',
          ),
          icon: markerIcon,
          onTap: () => _onMarkerTapped(location),
        ),
      );
    }
    
    // Add custom locations if provided
    if (widget.customLocations != null) {
      for (int i = 0; i < widget.customLocations!.length; i++) {
        final location = widget.customLocations![i];
        markers.add(
          Marker(
            markerId: MarkerId('custom_$i'),
            position: location,
            infoWindow: InfoWindow(
              title: 'Custom Location ${i + 1}',
              snippet: 'User-defined location',
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          ),
        );
      }
    }
    
    // Add current location if available
    if (_currentLocation != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('current_location'),
          position: _currentLocation!,
          infoWindow: const InfoWindow(
            title: 'Your Location',
            snippet: 'Current position',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
    }
    
    setState(() {
      _markers = markers;
    });
  }

  BitmapDescriptor _getMarkerIcon(GlobalLocation location) {
    // Ethiopian locations get special treatment
    if (location.isEthiopian) {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
    }
    
    // High priority global locations
    if (location.priority <= 2) {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange);
    }
    
    // Other locations
    return BitmapDescriptor.defaultMarker;
  }

  Color _getMarkerColor(GlobalLocation location) {
    if (location.isEthiopian) {
      return Colors.red; // Ethiopian locations in red
    }
    
    switch (location.priority) {
      case 1:
        return Colors.red; // Ethiopian priority
      case 2:
        return Colors.orange; // African priority
      case 3:
        return Colors.blue; // European/Asian priority
      case 4:
        return Colors.green; // Americas priority
      default:
        return Colors.grey;
    }
  }

  void _onMarkerTapped(GlobalLocation location) {
    // Show detailed information about the location
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(location.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('📍 ${location.city}, ${location.country}'),
            const SizedBox(height: 8),
            Text('⭐ ${location.rating}/5.0'),
            const SizedBox(height: 8),
            Text(location.description),
            const SizedBox(height: 8),
            if (location.isEthiopian)
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.flag, color: Colors.red, size: 16),
                    SizedBox(width: 4),
                    Text('🇪🇹 Ethiopian Heritage Site', 
                         style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            const SizedBox(height: 8),
            Text('🕒 ${location.openingHours}'),
            Text('💰 ${location.entryFee}'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 4,
              children: location.tags.map((tag) => Chip(
                label: Text(tag),
                backgroundColor: Colors.blue.withOpacity(0.1),
                labelStyle: const TextStyle(fontSize: 12),
              )).toList(),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _navigateToLocation(location);
            },
            child: const Text('Get Directions'),
          ),
        ],
      ),
    );
  }

  void _navigateToLocation(GlobalLocation location) {
    if (_mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(location.latitude, location.longitude),
          15.0,
        ),
      );
    }
  }

  LatLng get _mapCenter {
    if (widget.center != null) return widget.center!;
    if (_currentLocation != null) return _currentLocation!;
    
    // If showing Ethiopian locations, center on Ethiopia
    if (widget.showEthiopianLocations && !widget.showGlobalLocations) {
      return AutomatedGoogleMapsService.getEthiopiaCenter();
    }
    
    // For global view, center on a balanced world view
    return const LatLng(20.0, 0.0); // Center of world map
  }

  double get _mapZoom {
    if (widget.zoom != null) return widget.zoom!;
    
    // Adjust zoom based on what's being shown
    if (widget.showEthiopianLocations && !widget.showGlobalLocations) {
      return 6.0; // Ethiopia-focused zoom
    }
    
    return 3.0; // World view zoom
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        height: 400,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Loading Global Map...'),
              SizedBox(height: 8),
              Text('Discovering worldwide destinations...', 
                   style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
      );
    }

    return Container(
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: _mapCenter,
                zoom: _mapZoom,
              ),
              markers: _markers,
              myLocationEnabled: widget.showUserLocation,
              myLocationButtonEnabled: widget.showUserLocation,
              zoomControlsEnabled: true,
              mapType: MapType.normal,
              onTap: (LatLng position) {
                debugPrint('Map tapped at: $position');
              },
            ),
            // Legend for marker colors
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.showEthiopianLocations) ...[
                      _buildLegendItem('🇪🇹 Ethiopian Sites', Colors.red),
                      const SizedBox(height: 4),
                    ],
                    if (widget.showGlobalLocations) ...[
                      _buildLegendItem('🌍 Global Sites', Colors.blue),
                      const SizedBox(height: 4),
                    ],
                    _buildLegendItem('📍 Your Location', Colors.blue),
                  ],
                ),
              ),
            ),
            // Location count display
            Positioned(
              bottom: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${_displayedLocations.length} locations',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}