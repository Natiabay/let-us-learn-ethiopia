/// 🌟 COMPREHENSIVE LESSONS LOADER
/// Loads ALL expanded lessons (200+ lessons when complete) across all categories
/// Distribution: 60% Beginner, 30% Intermediate, 10% Advanced
/// 
/// 📚 CURRENT STATUS:
/// ✅ Greetings: 15 lessons (COMPLETED)
/// ✅ Numbers: 15 lessons (COMPLETED - structure ready)
/// ⏳ Food: 15 lessons (TO BE EXPANDED)
/// ⏳ Family: 15 lessons (TO BE EXPANDED)
/// ⏳ Directions: 15 lessons (TO BE EXPANDED)
/// ⏳ Time: 15 lessons (TO BE EXPANDED)
/// ⏳ Colors: 15 lessons (TO BE EXPANDED)
/// ⏳ Transportation: 15 lessons (TO BE EXPANDED)
/// ⏳ Accommodation: 15 lessons (TO BE EXPANDED)
/// ⏳ Emergency: 15 lessons (TO BE EXPANDED)
/// ⏳ Shopping: 15 lessons (TO BE EXPANDED)
/// ⏳ Weather: 15 lessons (TO BE EXPANDED)
import 'package:tourist_assistive_app/features/language/models/amharic_lesson_models.dart';
import 'amharic_lessons_part1_greetings_expanded.dart';
import 'amharic_lessons_part2_numbers_expanded.dart';
// Import other expanded lessons (to be created)
// import 'amharic_lessons_part3_food_expanded.dart';
// import 'amharic_lessons_part4_family_expanded.dart';
// etc...

/// MASTER LESSON LOADER - Growing to 200+ Comprehensive Lessons
class ComprehensiveLessonsLoader {
  
  /// Get all expanded lessons from all categories
  /// Current: 30 lessons (2 categories complete)
  /// Target: 180+ lessons (12 categories × 15 lessons each)
  static List<AmharicLesson> getAllExpandedLessons() {
    return [
      // ✅ GREETINGS: 15 lessons (10 Beginner, 3 Intermediate, 2 Advanced)
      ...AmharicGreetingsLessonsExpanded.lessons,
      
      // ✅ NUMBERS: 15 lessons (10 Beginner, 3 Intermediate, 2 Advanced)
      ...AmharicNumbersLessonsExpanded.lessons,
      
      // 📝 TODO: Add remaining expanded categories (follow same pattern)
      // ...AmharicFoodLessonsExpanded.lessons,          // 15 lessons
      // ...AmharicFamilyLessonsExpanded.lessons,        // 15 lessons
      // ...AmharicDirectionsLessonsExpanded.lessons,    // 15 lessons
      // ...AmharicTimeLessonsExpanded.lessons,          // 15 lessons
      // ...AmharicColorsLessonsExpanded.lessons,        // 15 lessons
      // ...AmharicTransportationLessonsExpanded.lessons,// 15 lessons
      // ...AmharicAccommodationLessonsExpanded.lessons, // 15 lessons
      // ...AmharicEmergencyLessonsExpanded.lessons,     // 15 lessons
      // ...AmharicShoppingLessonsExpanded.lessons,      // 15 lessons
      // ...AmharicWeatherLessonsExpanded.lessons,       // 15 lessons
    ];
  }
  
  /// Get lesson statistics
  static Map<String, int> getLessonStatistics() {
    final allLessons = getAllExpandedLessons();
    
    final beginnerCount = allLessons.where((l) => l.difficulty == DifficultyLevel.beginner).length;
    final intermediateCount = allLessons.where((l) => l.difficulty == DifficultyLevel.intermediate).length;
    final advancedCount = allLessons.where((l) => l.difficulty == DifficultyLevel.advanced).length;
    
    // Count lessons by category
    final greetingsCount = allLessons.where((l) => l.category == LessonCategory.greetings).length;
    final numbersCount = allLessons.where((l) => l.category == LessonCategory.numbers).length;
    final foodCount = allLessons.where((l) => l.category == LessonCategory.food).length;
    final familyCount = allLessons.where((l) => l.category == LessonCategory.family).length;
    
    return {
      'total': allLessons.length,
      'beginner': beginnerCount,
      'intermediate': intermediateCount,
      'advanced': advancedCount,
      'greetings': greetingsCount,
      'numbers': numbersCount,
      'food': foodCount,
      'family': familyCount,
    };
  }
  
  /// Get lessons by category
  static List<AmharicLesson> getLessonsByCategory(LessonCategory category) {
    return getAllExpandedLessons().where((lesson) => lesson.category == category).toList();
  }
  
  /// Get lessons by difficulty
  static List<AmharicLesson> getLessonsByDifficulty(DifficultyLevel difficulty) {
    return getAllExpandedLessons().where((lesson) => lesson.difficulty == difficulty).toList();
  }
  
  /// Get lesson by ID
  static AmharicLesson? getLessonById(String id) {
    try {
      return getAllExpandedLessons().firstWhere((lesson) => lesson.id == id);
    } catch (e) {
      return null;
    }
  }
  
  /// Print lesson statistics (for debugging)
  static void printStatistics() {
    final stats = getLessonStatistics();
    print('');
    print('🌟 ========== COMPREHENSIVE LESSONS STATISTICS ==========');
    print('📚 TOTAL LESSONS: ${stats['total']}');
    print('');
    print('📊 BY DIFFICULTY:');
    print('   🟢 Beginner: ${stats['beginner']} lessons');
    print('   🟡 Intermediate: ${stats['intermediate']} lessons');
    print('   🔴 Advanced: ${stats['advanced']} lessons');
    print('');
    print('📂 BY CATEGORY:');
    print('   👋 Greetings: ${stats['greetings']} lessons');
    print('   🔢 Numbers: ${stats['numbers']} lessons');
    print('   🍽️  Food: ${stats['food']} lessons');
    print('   👨‍👩‍👧‍👦 Family: ${stats['family']} lessons');
    print('   (More categories to be added...)');
    print('========================================================');
    print('');
  }
}
