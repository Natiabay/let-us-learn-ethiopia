import 'package:flutter/material.dart';

/// Avatar Service for Lesson Characters
/// Provides culturally relevant Ethiopian character avatars matching Duolingo style
class LessonAvatarService {
  
  /// Character types with proper avatars
  static const Map<String, CharacterAvatar> characters = {
    'traveler_male': CharacterAvatar(
      name: 'Alex',
      icon: Icons.face,
      color: Color(0xFF4A90E2),
      description: 'Male tourist learning Amharic',
    ),
    'traveler_female': CharacterAvatar(
      name: 'Sara',
      icon: Icons.face_2,
      color: Color(0xFFE94B8E),
      description: 'Female tourist learning Amharic',
    ),
    'ethiopian_woman': CharacterAvatar(
      name: 'Tigist',
      icon: Icons.person,
      color: Color(0xFF6BCF7F),
      description: 'Ethiopian woman in traditional dress',
    ),
    'ethiopian_man': CharacterAvatar(
      name: 'Abebe',
      icon: Icons.person_4,
      color: Color(0xFF58CC02),
      description: 'Ethiopian man',
    ),
    'elder_male': CharacterAvatar(
      name: 'Ato Bekele',
      icon: Icons.elderly,
      color: Color(0xFF8B7355),
      description: 'Respected Ethiopian elder',
    ),
    'elder_female': CharacterAvatar(
      name: 'Etege Almaz',
      icon: Icons.elderly_woman,
      color: Color(0xFFB5668B),
      description: 'Respected Ethiopian elder woman',
    ),
    'waiter': CharacterAvatar(
      name: 'Dawit',
      icon: Icons.restaurant,
      color: Color(0xFFFF6B6B),
      description: 'Restaurant waiter',
    ),
    'shopkeeper': CharacterAvatar(
      name: 'Hanna',
      icon: Icons.store,
      color: Color(0xFFFFD93D),
      description: 'Market shopkeeper',
    ),
    'taxi_driver': CharacterAvatar(
      name: 'Tadesse',
      icon: Icons.local_taxi,
      color: Color(0xFF1CB0F6),
      description: 'Taxi driver',
    ),
    'hotel_staff': CharacterAvatar(
      name: 'Selam',
      icon: Icons.hotel,
      color: Color(0xFFB4A7D6),
      description: 'Hotel receptionist',
    ),
    'friend': CharacterAvatar(
      name: 'Mulu',
      icon: Icons.person_outline,
      color: Color(0xFF88D8C0),
      description: 'Ethiopian friend',
    ),
    'teacher': CharacterAvatar(
      name: 'Tsegaye',
      icon: Icons.school,
      color: Color(0xFFF7DC6F),
      description: 'Amharic teacher',
    ),
    'guide': CharacterAvatar(
      name: 'Yohannes',
      icon: Icons.tour,
      color: Color(0xFFBB8FCE),
      description: 'Tourist guide',
    ),
  };
  
  /// Get character avatar by type
  static CharacterAvatar getCharacter(String type) {
    return characters[type] ?? characters['ethiopian_woman']!;
  }
  
  /// Create avatar widget
  static Widget createAvatarWidget(
    String characterType, {
    double size = 60,
    bool showBorder = true,
  }) {
    final character = getCharacter(characterType);
    
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: character.color,
        shape: BoxShape.circle,
        border: showBorder
            ? Border.all(
                color: Colors.white,
                width: 3,
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: character.color.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(
        character.icon,
        color: Colors.white,
        size: size * 0.5,
      ),
    );
  }
  
  /// Create avatar with name label
  static Widget createAvatarWithName(
    String characterType, {
    double size = 60,
    bool showName = true,
  }) {
    final character = getCharacter(characterType);
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        createAvatarWidget(characterType, size: size),
        if (showName) ...[
          const SizedBox(height: 8),
          Text(
            character.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ],
    );
  }
  
  /// Get appropriate character for lesson context
  static String getCharacterForContext(String context) {
    final contextMap = {
      'greeting': 'friend',
      'formal': 'elder_male',
      'restaurant': 'waiter',
      'shopping': 'shopkeeper',
      'travel': 'traveler_female',
      'hotel': 'hotel_staff',
      'transportation': 'taxi_driver',
      'learning': 'teacher',
      'tour': 'guide',
    };
    
    return contextMap[context.toLowerCase()] ?? 'ethiopian_woman';
  }
}

/// Character Avatar Model
class CharacterAvatar {
  final String name;
  final IconData icon;
  final Color color;
  final String description;
  
  const CharacterAvatar({
    required this.name,
    required this.icon,
    required this.color,
    required this.description,
  });
}
