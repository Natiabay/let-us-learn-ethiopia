import 'package:flutter/material.dart';

/// Automated Image Service using local assets from Photos folder
class AutomatedImageService {
  
  /// Local images for Ethiopian locations from Photos folder - EXACT file names
  static const Map<String, String> _locationImages = {
    // Historical Sites - using exact file names from Photos folder
    'lalibela': 'Photos/Lalibela.png',
    'lalibela-churches': 'Photos/Lalibela.png',
    'axum': 'Photos/Axum.png',
    'axum-obelisks': 'Photos/Axum.png',
    'gondar': 'Photos/Fassil Gimb.png',
    'gondar-castles': 'Photos/Fassil Gimb.png',
    'fassil-ghebbi': 'Photos/Fassil Gimb.png',
    'harar': 'Photos/Harer.jpg',
    'harar-jugol': 'Photos/Harer.jpg',
    'harar_jugol': 'Photos/Harer.jpg',
    'debre-damo': 'Photos/debre damo.png',
    'debre_damo': 'Photos/debre damo.png',
    
    // Natural Sites - using exact file names
    'simien': 'Photos/Semen mountain.jpg',
    'simien-mountains': 'Photos/Semen mountain.jpg',
    'simien_mountains': 'Photos/Semen mountain.jpg',
    'danakil': 'Photos/Danakil.png',
    'danakil-depression': 'Photos/Danakil.png',
    'danakil_depression': 'Photos/Danakil.png',
    'lake-tana': 'Photos/lake tana.png',
    'lake_tana': 'Photos/lake tana.png',
    'blue-nile': 'Photos/blue nile.png',
    'blue-nile-falls': 'Photos/blue nile.png',
    'blue_nile': 'Photos/blue nile.png',
    'bale': 'Photos/Bale.png',
    'bale-mountains': 'Photos/Bale.png',
    'bale_mountains': 'Photos/Bale.png',
    'konso': 'Photos/konso.png',
    'konso-cultural': 'Photos/konso.png',
    
    // Cities and Museums - using exact file names
    'addis-ababa': 'Photos/Addis Ababa.avif',
    'addis_ababa': 'Photos/Addis Ababa.avif',
    'national-museum': 'Photos/National museium.jpg',
    'national_museum': 'Photos/National museium.jpg',
    
    // Additional locations
    'coffee-ceremony': 'Photos/coffee.png',
    'coffee': 'Photos/coffee.png',
    'ethiopian-food': 'Photos/food.png',
    'food': 'Photos/food.png',
    'greetings': 'Photos/greetings.png',
    'thank-you': 'Photos/thank you.png',
    'thank_you': 'Photos/thank you.png',
    
    // Default fallback
    'default': 'Photos/New Logo.png',
  };
  
  /// Local images for language learning from Photos folder - EXACT file names
  static const Map<String, String> _languageImages = {
    'greetings': 'Photos/greetings.png',
    'food': 'Photos/food.png',
    'hospital': 'Photos/hospital.png',
    'hotel': 'Photos/hotel.png',
    'restaurant': 'Photos/Restaurant.png',
    'police': 'Photos/polices.png',
    'water': 'Photos/water.png',
    'coffee': 'Photos/coffee.png',
    'injera': 'Photos/injera.png',
    'milk': 'Photos/milk.png',
    'thank_you': 'Photos/thank you.png',
    'numbers_1': 'Photos/one.png',
    'numbers_2': 'Photos/two.png',
    'numbers_3': 'Photos/three.png',
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
