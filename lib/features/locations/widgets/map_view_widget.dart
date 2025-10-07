import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tourist_assistive_app/core/theme/app_theme.dart';
import 'package:tourist_assistive_app/features/locations/models/location_model.dart';
import 'package:tourist_assistive_app/core/services/google_maps_service.dart';
import 'package:tourist_assistive_app/core/config/environment_config.dart';

class MapViewWidget extends StatefulWidget {
  final List<LocationModel> locations;
  final LatLng? userPosition;
  final ValueChanged<LocationModel> onLocationSelected;

  const MapViewWidget({
    super.key,
    required this.locations,
    this.userPosition,
    required this.onLocationSelected,
  });

  @override
  State<MapViewWidget> createState() => _MapViewWidgetState();
}

class _MapViewWidgetState extends State<MapViewWidget> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  CameraPosition _initialCameraPosition = GoogleMapsService.getEthiopiaCameraPosition();

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  void _initializeMap() {
    // Add markers for all locations
    _markers.clear();
    
    // Add user position marker if available
    if (widget.userPosition != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId('user_location'),
          position: widget.userPosition!,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: const InfoWindow(
            title: 'Your Location',
            snippet: 'Current position',
          ),
        ),
      );
    }

    // Add location markers
    for (int i = 0; i < widget.locations.length; i++) {
      final location = widget.locations[i];
      _markers.add(
        Marker(
          markerId: MarkerId('location_$i'),
          position: LatLng(location.latitude, location.longitude),
          icon: _getMarkerIcon(location.category),
          infoWindow: InfoWindow(
            title: location.name,
            snippet: location.description,
          ),
          onTap: () => widget.onLocationSelected(location),
        ),
      );
    }

    // Add Ethiopia tourist destinations
    final destinations = GoogleMapsService.getEthiopiaTouristDestinations();
    for (int i = 0; i < destinations.length; i++) {
      final destination = destinations[i];
      _markers.add(
        Marker(
          markerId: MarkerId('destination_$i'),
          position: destination['coordinates'] as LatLng,
          icon: _getDestinationMarkerIcon(destination['type'] as String),
          infoWindow: InfoWindow(
            title: destination['name'] as String,
            snippet: destination['description'] as String,
          ),
        ),
      );
    }

    setState(() {});
  }

  BitmapDescriptor _getMarkerIcon(String category) {
    switch (category.toLowerCase()) {
      case 'historical':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
      case 'natural':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
      case 'cultural':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange);
      case 'religious':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet);
      case 'adventure':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow);
      case 'food & drink':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan);
      case 'shopping':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta);
      default:
        return BitmapDescriptor.defaultMarker;
    }
  }

  BitmapDescriptor _getDestinationMarkerIcon(String type) {
    switch (type.toLowerCase()) {
      case 'unesco world heritage site':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
      case 'national park':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
      case 'historical site':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange);
      case 'cultural site':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet);
      case 'natural wonder':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan);
      case 'capital city':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
      default:
        return BitmapDescriptor.defaultMarker;
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: _buildMapContent(),
      ),
    );
  }

  Widget _buildMapContent() {
    // Check if we have a valid Google Maps API key
    try {
      final apiKey = EnvironmentConfig.getGoogleMapsKey();
      if (apiKey.isEmpty || apiKey.contains('dev-')) {
        return _buildMapPlaceholder();
      }
    } catch (e) {
      return _buildMapPlaceholder();
    }

    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: _initialCameraPosition,
      markers: _markers,
      mapType: MapType.normal,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      zoomControlsEnabled: true,
      mapToolbarEnabled: true,
      buildingsEnabled: true,
      trafficEnabled: false,
      onTap: (LatLng position) {
        // Handle map tap if needed
      },
    );
  }

  Widget _buildMapPlaceholder() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF58CC02).withValues(alpha: 0.1),
            const Color(0xFF1CB0F6).withValues(alpha: 0.1),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.map_outlined,
                  size: 48,
                  color: const Color(0xFF1CB0F6),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Map View',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B5E20),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Google Maps integration requires API key configuration',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF58CC02), Color(0xFF1CB0F6)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Development Mode',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}