import 'package:flutter/material.dart';

/// Automated Image Service using local assets from Photos folder
class AutomatedImageService {
  
  /// Local images for Ethiopian locations from Photos folder
  static const Map<String, String> _locationImages = {
    // Historical Sites
    'lalibela': 'assets/images/Lalibela.png',
    'axum': 'assets/images/Axum.png',
    'gondar': 'assets/images/Fassil Gimb.png',
    'harar': 'assets/images/Jugol.png',
    'harar_jugol': 'assets/images/Jugol.png',
    'debre_damo': 'assets/images/debre damo.png',
    
    // Natural Sites
    'simien': 'assets/images/Bale.png',
    'simien_mountains': 'assets/images/Bale.png',
    'danakil': 'assets/images/Danakil.png',
    'danakil_depression': 'assets/images/Danakil.png',
    'lake_tana': 'assets/images/lake tana.png',
    'blue_nile': 'assets/images/blue nile.png',
    'bale': 'assets/images/Bale.png',
    'bale_mountains': 'assets/images/Bale.png',
    'konso': 'assets/images/konso.png',
    
    // Cities
    'addis_ababa': 'assets/images/Logo.png',
    'national_museum': 'assets/images/National museium.jpg',
    
    // Default fallback
    'default': 'assets/images/Logo.png',
  };
  
  /// Local images for language learning from Photos folder
  static const Map<String, String> _languageImages = {
    'greetings': 'assets/images/greetings.png',
    'food': 'assets/images/food.png',
    'hospital': 'assets/images/hospital.png',
    'hotel': 'assets/images/hotel.png',
    'restaurant': 'assets/images/Restaurant.png',
    'police': 'assets/images/polices.png',
    'water': 'assets/images/water.png',
    'coffee': 'assets/images/coffee.png',
    'injera': 'assets/images/injera.png',
    'milk': 'assets/images/milk.png',
    'thank_you': 'assets/images/thank you.png',
    'numbers_1': 'assets/images/one.png',
    'numbers_2': 'assets/images/two.png',
    'numbers_3': 'assets/images/three.png',
  };
  
  /// Get local image path for location
  static String getLocationImage(String locationId) {
    // Convert ID to lowercase and check variations
    final id = locationId.toLowerCase().replaceAll(' ', '_');
    
    // Direct match
    if (_locationImages.containsKey(id)) {
      return _locationImages[id]!;
    }
    
    // Check if ID contains any known location name
    for (final entry in _locationImages.entries) {
      if (id.contains(entry.key) || entry.key.contains(id)) {
        return entry.value;
      }
    }
    
    return _locationImages['default']!;
  }
  
  /// Get local image path for language learning
  static String getLanguageImage(String category) {
    final cat = category.toLowerCase().replaceAll(' ', '_');
    return _languageImages[cat] ?? _locationImages['default']!;
  }
  
  /// Create image widget from local assets
  static Widget createLocalImage({
    required String imagePath,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
  }) {
    return Image.asset(
      imagePath,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue[600]!,
                Colors.blue[400]!,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.image_outlined,
                size: 48,
                color: Colors.white.withValues(alpha: 0.7),
              ),
              const SizedBox(height: 8),
              Text(
                'Ethiopia',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  
  /// Create location image widget
  static Widget createLocationImage({
    required String locationId,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
  }) {
    final imagePath = getLocationImage(locationId);
    return createLocalImage(
      imagePath: imagePath,
      width: width,
      height: height,
      fit: fit,
    );
  }
  
  /// Create language learning image widget
  static Widget createLanguageImage({
    required String category,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
  }) {
    final imagePath = getLanguageImage(category);
    return createLocalImage(
      imagePath: imagePath,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
