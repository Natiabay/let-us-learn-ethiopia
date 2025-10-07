/// Amharic Lessons - Complete Collection
/// All 12 parts with 10,000+ lines of professional Duolingo-style lessons

import 'package:tourist_assistive_app/features/language/models/amharic_lesson_models.dart';
import 'package:tourist_assistive_app/features/language/data/amharic_lessons_part1_greetings.dart';
import 'package:tourist_assistive_app/features/language/data/amharic_lessons_part2_numbers.dart';
import 'package:tourist_assistive_app/features/language/data/amharic_lessons_part3_food.dart';
import 'package:tourist_assistive_app/features/language/data/amharic_lessons_part4_family.dart';
import 'package:tourist_assistive_app/features/language/data/amharic_lessons_part5_directions.dart';
import 'package:tourist_assistive_app/features/language/data/amharic_lessons_part6_time.dart';
import 'package:tourist_assistive_app/features/language/data/amharic_lessons_part7_colors.dart';
import 'package:tourist_assistive_app/features/language/data/amharic_lessons_part8_transportation.dart';
import 'package:tourist_assistive_app/features/language/data/amharic_lessons_part9_accommodation.dart';
import 'package:tourist_assistive_app/features/language/data/amharic_lessons_part10_emergency.dart';
import 'package:tourist_assistive_app/features/language/data/amharic_lessons_part11_shopping.dart';
import 'package:tourist_assistive_app/features/language/data/amharic_lessons_part12_weather.dart';

/// Complete Amharic Lessons Database
/// 12 Parts, 60 Lessons, 600+ Exercises, 10,000+ Lines
class AmharicLessonsAll {
  
  /// Get all lessons from all parts
  static List<AmharicLesson> getAllLessons() {
    return [
      ...AmharicGreetingsLessons.lessons,       // Part 1: 5 lessons
      ...AmharicNumbersLessons.lessons,         // Part 2: 5 lessons
      ...AmharicFoodLessons.lessons,            // Part 3: 5 lessons
      ...AmharicFamilyLessons.lessons,          // Part 4: 5 lessons
      ...AmharicDirectionsLessons.lessons,      // Part 5: 5 lessons
      ...AmharicTimeLessons.lessons,            // Part 6: 5 lessons
      ...AmharicColorsLessons.lessons,          // Part 7: 5 lessons
      ...AmharicTransportationLessons.lessons,  // Part 8: 5 lessons
      ...AmharicAccommodationLessons.lessons,   // Part 9: 5 lessons
      ...AmharicEmergencyLessons.lessons,       // Part 10: 5 lessons
      ...AmharicShoppingLessons.lessons,        // Part 11: 5 lessons
      ...AmharicWeatherLessons.lessons,         // Part 12: 5 lessons
    ];
  }
  
  /// Get lessons by category
  static List<AmharicLesson> getLessonsByCategory(LessonCategory category) {
    return getAllLessons().where((lesson) => lesson.category == category).toList();
  }
  
  /// Get lessons by difficulty
  static List<AmharicLesson> getLessonsByDifficulty(DifficultyLevel difficulty) {
    return getAllLessons().where((lesson) => lesson.difficulty == difficulty).toList();
  }
  
  /// Get lesson by ID
  static AmharicLesson? getLessonById(String id) {
    try {
      return getAllLessons().firstWhere((lesson) => lesson.id == id);
    } catch (e) {
      return null;
    }
  }
  
  /// Get next lesson
  static AmharicLesson? getNextLesson(String currentLessonId) {
    final allLessons = getAllLessons();
    final currentIndex = allLessons.indexWhere((lesson) => lesson.id == currentLessonId);
    
    if (currentIndex == -1 || currentIndex >= allLessons.length - 1) {
      return null;
    }
    
    return allLessons[currentIndex + 1];
  }
  
  /// Get total statistics
  static Map<String, int> getStatistics() {
    final allLessons = getAllLessons();
    int totalExercises = 0;
    int totalXP = 0;
    
    for (final lesson in allLessons) {
      totalExercises += lesson.exercises.length;
      totalXP += lesson.totalXP;
    }
    
    return {
      'totalParts': 12,
      'totalLessons': allLessons.length,
      'totalExercises': totalExercises,
      'totalXP': totalXP,
      'categories': LessonCategory.values.length,
      'difficultyLevels': DifficultyLevel.values.length,
    };
  }
}






















