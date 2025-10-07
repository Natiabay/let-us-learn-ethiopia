import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:tourist_assistive_app/core/config/environment_config.dart';

/// Google Maps Service for cross-platform map functionality
class GoogleMapsService {
  static const String _ethiopiaCenterLat = '9.1450';
  static const String _ethiopiaCenterLng = '40.4897';
  
  /// Initialize Google Maps for the current platform
  static Future<void> initialize() async {
    try {
      if (kIsWeb) {
        // Web initialization
        await _initializeWebMaps();
      } else {
        // Mobile initialization
        await _initializeMobileMaps();
      }
    } catch (e) {
      debugPrint('Google Maps initialization error: $e');
    }
  }
  
  /// Initialize Google Maps for Web
  static Future<void> _initializeWebMaps() async {
    try {
      final apiKey = EnvironmentConfig.getGoogleMapsKey();
      if (apiKey.isNotEmpty && !apiKey.contains('dev-')) {
        // Real API key configured
        debugPrint('✅ Google Maps Web initialized with real API key');
      } else {
        // Development mode - use a placeholder or disable maps
        debugPrint('🔄 Google Maps Web running in development mode (no API key)');
        debugPrint('⚠️  To enable Google Maps, configure GOOGLE_MAPS_API_KEY environment variable');
      }
    } catch (e) {
      debugPrint('Google Maps Web initialization error: $e');
      debugPrint('🔄 Continuing in development mode without Google Maps');
    }
  }
  
  /// Initialize Google Maps for Mobile
  static Future<void> _initializeMobileMaps() async {
    try {
      final apiKey = EnvironmentConfig.getGoogleMapsKey();
      if (apiKey.isNotEmpty && !apiKey.contains('dev-')) {
        // Real API key configured
        debugPrint('✅ Google Maps Mobile initialized with real API key');
      } else {
        // Development mode
        debugPrint('🔄 Google Maps Mobile running in development mode');
      }
    } catch (e) {
      debugPrint('Google Maps Mobile initialization error: $e');
    }
  }
  
  /// Get current user location
  static Future<LatLng?> getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        debugPrint('Location services are disabled');
        return null;
      }
      
      // Check location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          debugPrint('Location permissions are denied');
          return null;
        }
      }
      
      if (permission == LocationPermission.deniedForever) {
        debugPrint('Location permissions are permanently denied');
        return null;
      }
      
      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      
      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      debugPrint('Error getting current location: $e');
      return null;
    }
  }
  
  /// Get address from coordinates
  static Future<String?> getAddressFromCoordinates(LatLng coordinates) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        coordinates.latitude,
        coordinates.longitude,
      );
      
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        return '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}';
      }
      return null;
    } catch (e) {
      debugPrint('Error getting address: $e');
      return null;
    }
  }
  
  /// Get coordinates from address
  static Future<LatLng?> getCoordinatesFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        Location location = locations[0];
        return LatLng(location.latitude, location.longitude);
      }
      return null;
    } catch (e) {
      debugPrint('Error getting coordinates: $e');
      return null;
    }
  }
  
  /// Get Ethiopia's major tourist destinations
  static List<Map<String, dynamic>> getEthiopiaTouristDestinations() {
    return [
      {
        'name': 'Lalibela Rock-Hewn Churches',
        'coordinates': LatLng(12.0317, 39.0417),
        'description': '11 monolithic churches carved from solid rock',
        'type': 'UNESCO World Heritage Site',
      },
      {
        'name': 'Simien Mountains National Park',
        'coordinates': LatLng(13.2500, 38.2500),
        'description': 'Dramatic mountain landscapes and wildlife',
        'type': 'National Park',
      },
      {
        'name': 'Aksum (Axum)',
        'coordinates': LatLng(14.1211, 38.7234),
        'description': 'Ancient capital with obelisks and archaeological sites',
        'type': 'Historical Site',
      },
      {
        'name': 'Gondar Castles',
        'coordinates': LatLng(12.6000, 37.4667),
        'description': '17th century castles and royal enclosure',
        'type': 'Historical Site',
      },
      {
        'name': 'Harar Jugol',
        'coordinates': LatLng(9.3167, 42.1167),
        'description': 'Walled city with 82 mosques',
        'type': 'Cultural Site',
      },
      {
        'name': 'Bahir Dar',
        'coordinates': LatLng(11.6000, 37.3833),
        'description': 'Lake Tana and Blue Nile Falls',
        'type': 'Natural Wonder',
      },
      {
        'name': 'Addis Ababa',
        'coordinates': LatLng(9.0192, 38.7525),
        'description': 'Capital city with museums and cultural sites',
        'type': 'Capital City',
      },
      {
        'name': 'Danakil Depression',
        'coordinates': LatLng(14.2417, 40.3000),
        'description': 'Hottest place on Earth with active volcanoes',
        'type': 'Natural Wonder',
      },
    ];
  }
  
  /// Get default camera position for Ethiopia
  static CameraPosition getEthiopiaCameraPosition() {
    return const CameraPosition(
      target: LatLng(9.1450, 40.4897), // Center of Ethiopia
      zoom: 6.0,
    );
  }
  
  /// Check if Google Maps is properly configured
  static bool get isConfigured {
    try {
      final apiKey = EnvironmentConfig.getGoogleMapsKey();
      return apiKey.isNotEmpty && !apiKey.contains('dev-');
    } catch (e) {
      return false;
    }
  }
  
  /// Get configuration status message
  static String get configurationStatus {
    if (isConfigured) {
      return '✅ Google Maps configured with real API key';
    } else {
      return '🔄 Google Maps running in development mode';
    }
  }
}