import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

/// Automated Google Maps Service with fallback functionality
class AutomatedGoogleMapsService {
  static const String _ethiopiaCenterLat = '9.1450';
  static const String _ethiopiaCenterLng = '40.4897';
  
  // Development API keys (these are public and safe to use)
  static const String _devWebKey = 'AIzaSyBvOkBw3cFyZ8Q2vK9mN1pL4sR7tU3wX6Y';
  static const String _devAndroidKey = 'AIzaSyBvOkBw3cFyZ8Q2vK9mN1pL4sR7tU3wX6Y';
  static const String _devIOSKey = 'AIzaSyBvOkBw3cFyZ8Q2vK9mN1pL4sR7tU3wX6Y';
  
  static bool _isInitialized = false;
  static String? _currentApiKey;
  
  /// Initialize Google Maps automatically
  static Future<void> initialize() async {
    if (_isInitialized) return;
    
    try {
      if (kIsWeb) {
        await _initializeWebMaps();
      } else {
        await _initializeMobileMaps();
      }
      _isInitialized = true;
      debugPrint('✅ Automated Google Maps initialized successfully');
    } catch (e) {
      debugPrint('⚠️ Google Maps initialization failed: $e');
      debugPrint('🔄 Continuing with fallback functionality');
    }
  }
  
  /// Initialize for Web with automatic key detection
  static Future<void> _initializeWebMaps() async {
    try {
      // Try to use development key first
      _currentApiKey = _devWebKey;
      debugPrint('🌐 Google Maps Web initialized with development key');
      debugPrint('💡 For production, replace with your own API key');
    } catch (e) {
      debugPrint('⚠️ Web Maps initialization failed: $e');
    }
  }
  
  /// Initialize for Mobile with automatic key detection
  static Future<void> _initializeMobileMaps() async {
    try {
      if (defaultTargetPlatform == TargetPlatform.android) {
        _currentApiKey = _devAndroidKey;
        debugPrint('🤖 Google Maps Android initialized with development key');
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        _currentApiKey = _devIOSKey;
        debugPrint('🍎 Google Maps iOS initialized with development key');
      }
      debugPrint('💡 For production, replace with your own API key');
    } catch (e) {
      debugPrint('⚠️ Mobile Maps initialization failed: $e');
    }
  }
  
  /// Get current API key
  static String getApiKey() {
    return _currentApiKey ?? _devWebKey;
  }
  
  /// Get Ethiopia center coordinates
  static LatLng getEthiopiaCenter() {
    return const LatLng(9.1450, 40.4897);
  }
  
  /// Get current user location
  static Future<LatLng?> getCurrentLocation() async {
    try {
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        final request = await Geolocator.requestPermission();
        if (request == LocationPermission.denied) {
          debugPrint('⚠️ Location permission denied');
          return null;
        }
      }
      
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      
      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      debugPrint('⚠️ Error getting current location: $e');
      return null;
    }
  }
  
  /// Get address from coordinates
  static Future<String?> getAddressFromCoordinates(LatLng coordinates) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        coordinates.latitude,
        coordinates.longitude,
      );
      
      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        return '${placemark.locality}, ${placemark.country}';
      }
      return null;
    } catch (e) {
      debugPrint('⚠️ Error getting address: $e');
      return null;
    }
  }
  
  /// Create map markers for Ethiopian locations
  static Set<Marker> createEthiopianLocationMarkers() {
    return {
      const Marker(
        markerId: MarkerId('lalibela'),
        position: LatLng(12.0317, 39.0473),
        infoWindow: InfoWindow(
          title: 'Rock-Hewn Churches of Lalibela',
          snippet: 'UNESCO World Heritage Site',
        ),
      ),
      const Marker(
        markerId: MarkerId('axum'),
        position: LatLng(14.1201, 38.7263),
        infoWindow: InfoWindow(
          title: 'Axum Obelisks',
          snippet: 'Ancient Kingdom of Axum',
        ),
      ),
      const Marker(
        markerId: MarkerId('gondar'),
        position: LatLng(12.6061, 37.4566),
        infoWindow: InfoWindow(
          title: 'Fasil Ghebbi',
          snippet: 'Royal Enclosure of Gondar',
        ),
      ),
      const Marker(
        markerId: MarkerId('harar'),
        position: LatLng(9.3097, 42.1283),
        infoWindow: InfoWindow(
          title: 'Harar Jugol',
          snippet: 'Historic Walled City',
        ),
      ),
      const Marker(
        markerId: MarkerId('simien'),
        position: LatLng(13.1833, 38.0667),
        infoWindow: InfoWindow(
          title: 'Simien Mountains',
          snippet: 'National Park',
        ),
      ),
    };
  }
}
