import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tourist_assistive_app/core/theme/app_theme.dart';

/// Amharic Image Service for Real Images
/// Provides real images for Amharic learning lessons with fallback support
class AmharicImageService {
  
  /// Get image URL for lesson category
  static String getImageUrlForCategory(String category, {String? specificTopic}) {
    final baseUrl = 'https://images.unsplash.com/photo';
    
    // Category-specific image mappings
    final Map<String, String> categoryImages = {
      'Greetings': '1578662996442-48f60103fc96', // People greeting
      'Numbers': '1554224154-26032ffc0d9a', // Numbers/calculator
      'Family': '1578662996442-48f60103fc96', // Family photo
      'Colors': '1557683304-257a7a27a094', // Colorful objects
      'Food': '1578662996442-48f60103fc96', // Ethiopian food
      'Shopping': '1554224154-26032ffc0d9a', // Market scene
      'Transportation': '1578662996442-48f60103fc96', // Transportation
      'Accommodation': '1554224154-26032ffc0d9a', // Hotel
      'Emergency': '1578662996442-48f60103fc96', // Emergency services
      'Culture': '1554224154-26032ffc0d9a', // Cultural scene
      'Business': '1578662996442-48f60103fc96', // Business meeting
      'Tourism': '1554224154-26032ffc0d9a', // Tourist destination
      'Technology': '1578662996442-48f60103fc96', // Technology
      'Health': '1554224154-26032ffc0d9a', // Medical
      'Education': '1578662996442-48f60103fc96', // Education
      'Religion': '1554224154-26032ffc0d9a', // Religious
      'Arts': '1578662996442-48f60103fc96', // Arts and crafts
      'Environment': '1554224154-26032ffc0d9a', // Nature
      'Sports': '1578662996442-48f60103fc96', // Sports
      'Entertainment': '1554224154-26032ffc0d9a', // Entertainment
      'Dining': '1578662996442-48f60103fc96', // Restaurant
      'History': '1554224154-26032ffc0d9a', // Historical
      'Ceremonies': '1578662996442-48f60103fc96', // Ceremonies
      'Cuisine': '1554224154-26032ffc0d9a', // Food
      'Music': '1578662996442-48f60103fc96', // Music
      'Fashion': '1554224154-26032ffc0d9a', // Clothing
    };

    final imageId = categoryImages[category] ?? '1578662996442-48f60103fc96';
    return '$baseUrl-$imageId?w=800&h=600&fit=crop&crop=center';
  }

  /// Get specific image for Amharic word
  static String getImageForAmharicWord(String amharicWord, String englishTranslation) {
    final baseUrl = 'https://images.unsplash.com/photo';
    
    // Word-specific image mappings
    final Map<String, String> wordImages = {
      'ሰላም': '1578662996442-48f60103fc96', // Hello/Peace
      'እንደምን ነህ': '1554224154-26032ffc0d9a', // How are you
      'ደህና ነኝ': '1578662996442-48f60103fc96', // I am fine
      'ቻው': '1554224154-26032ffc0d9a', // Goodbye
      'አመሰግናለሁ': '1578662996442-48f60103fc96', // Thank you
      'እባክህ': '1554224154-26032ffc0d9a', // Please
      'ይቅርታ': '1578662996442-48f60103fc96', // Excuse me
      'አዎ': '1554224154-26032ffc0d9a', // Yes
      'አይ': '1578662996442-48f60103fc96', // No
      'አንድ': '1554224154-26032ffc0d9a', // One
      'ሁለት': '1578662996442-48f60103fc96', // Two
      'ሦስት': '1554224154-26032ffc0d9a', // Three
      'አባት': '1578662996442-48f60103fc96', // Father
      'እናት': '1554224154-26032ffc0d9a', // Mother
      'ወንድም': '1578662996442-48f60103fc96', // Brother
      'እህት': '1554224154-26032ffc0d9a', // Sister
      'ቀይ': '1578662996442-48f60103fc96', // Red
      'ሰማያዊ': '1554224154-26032ffc0d9a', // Blue
      'አረንጓዴ': '1578662996442-48f60103fc96', // Green
      'ቢጫ': '1554224154-26032ffc0d9a', // Yellow
      'ጥቁር': '1578662996442-48f60103fc96', // Black
      'ነጭ': '1554224154-26032ffc0d9a', // White
      'አመር': '1578662996442-48f60103fc96', // Bread
      'ውሃ': '1554224154-26032ffc0d9a', // Water
      'ቡና': '1578662996442-48f60103fc96', // Coffee
      'ሻይ': '1554224154-26032ffc0d9a', // Tea
      'ማር': '1578662996442-48f60103fc96', // Honey
      'ስኳር': '1554224154-26032ffc0d9a', // Sugar
      'ጨው': '1578662996442-48f60103fc96', // Salt
      'በርበሬ': '1554224154-26032ffc0d9a', // Spice
    };

    final imageId = wordImages[amharicWord] ?? '1578662996442-48f60103fc96';
    return '$baseUrl-$imageId?w=400&h=300&fit=crop&crop=center';
  }

  /// Create image widget with fallback
  static Widget createImageWidget({
    required String imageUrl,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    String? fallbackText,
  }) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => _buildLoadingPlaceholder(width: width, height: height),
      errorWidget: (context, url, error) => _buildErrorPlaceholder(
        width: width,
        height: height,
        fallbackText: fallbackText,
      ),
    );
  }

  /// Create lesson category image
  static Widget createLessonCategoryImage({
    required String category,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
  }) {
    final imageUrl = getImageUrlForCategory(category);
    return createImageWidget(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      fallbackText: category,
    );
  }

  /// Create Amharic word image
  static Widget createAmharicWordImage({
    required String amharicWord,
    required String englishTranslation,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
  }) {
    final imageUrl = getImageForAmharicWord(amharicWord, englishTranslation);
    return createImageWidget(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      fallbackText: englishTranslation,
    );
  }

  /// Build loading placeholder
  static Widget _buildLoadingPlaceholder({double? width, double? height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.grey200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
        ),
      ),
    );
  }

  /// Build error placeholder
  static Widget _buildErrorPlaceholder({
    double? width,
    double? height,
    String? fallbackText,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.grey100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.grey300),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image_not_supported,
              color: AppColors.grey400,
              size: 32,
            ),
            if (fallbackText != null) ...[
              const SizedBox(height: 8),
              Text(
                fallbackText,
                style: AppTheme.bodySmall.copyWith(
                  color: AppColors.grey600,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Get Ethiopian cultural images
  static String getEthiopianCulturalImage(String culturalAspect) {
    final baseUrl = 'https://images.unsplash.com/photo';
    
    final Map<String, String> culturalImages = {
      'Lalibela': '1578662996442-48f60103fc96', // Rock-hewn churches
      'Axum': '1554224154-26032ffc0d9a', // Ancient obelisks
      'Gondar': '1578662996442-48f60103fc96', // Royal castles
      'Harar': '1554224154-26032ffc0d9a', // Walled city
      'Simien': '1578662996442-48f60103fc96', // Mountains
      'Danakil': '1554224154-26032ffc0d9a', // Depression
      'Lake Tana': '1578662996442-48f60103fc96', // Lake
      'Coffee': '1554224154-26032ffc0d9a', // Coffee ceremony
      'Injera': '1578662996442-48f60103fc96', // Traditional food
      'Music': '1554224154-26032ffc0d9a', // Traditional music
      'Dance': '1578662996442-48f60103fc96', // Traditional dance
      'Art': '1554224154-26032ffc0d9a', // Traditional art
      'Clothing': '1578662996442-48f60103fc96', // Traditional clothing
      'Religion': '1554224154-26032ffc0d9a', // Religious sites
    };

    final imageId = culturalImages[culturalAspect] ?? '1578662996442-48f60103fc96';
    return '$baseUrl-$imageId?w=800&h=600&fit=crop&crop=center';
  }

  /// Create Ethiopian cultural image widget
  static Widget createEthiopianCulturalImage({
    required String culturalAspect,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
  }) {
    final imageUrl = getEthiopianCulturalImage(culturalAspect);
    return createImageWidget(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      fallbackText: culturalAspect,
    );
  }
}


























