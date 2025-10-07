import '../models/comprehensive_lesson_model.dart';
import 'complete_duolingo_curriculum.dart';
import 'expanded_lesson_categories.dart';
import 'english_amharic_lessons.dart';
import 'comprehensive_duolingo_lessons.dart';
import 'enhanced_duolingo_lessons.dart';

/// 🎓 COMPREHENSIVE LESSON MANAGER - FINAL
/// Master lesson manager that combines all lesson systems for a complete Duolingo-style experience
/// Total: 500+ lessons across all categories and difficulty levels
class ComprehensiveLessonManagerFinal {
  
  /// Get complete curriculum with 500+ lessons
  static List<Lesson> getCompleteCurriculum() {
    return [
      // CORE FOUNDATION (150 lessons)
      ...getCoreFoundationLessons(),
      
      // PRACTICAL SKILLS (150 lessons)
      ...getPracticalSkillsLessons(),
      
      // CONVERSATION MASTERY (100 lessons)
      ...getConversationMasteryLessons(),
      
      // PROFESSIONAL SKILLS (100 lessons)
      ...getProfessionalSkillsLessons(),
      
      // SPECIALIZED TOPICS (50 lessons)
      ...getSpecializedTopicsLessons(),
    ];
  }
  
  /// CORE FOUNDATION (150 lessons)
  static List<Lesson> getCoreFoundationLessons() {
    return [
      // Basic Duolingo-style lessons (60 lessons)
      ...CompleteDuolingoCurriculum.getFoundationSkills(),
      
      // Enhanced foundation lessons (60 lessons)
      ...EnhancedDuolingoLessons.getFoundationLessons(),
      
      // Comprehensive foundation lessons (30 lessons)
      ...ComprehensiveDuolingoLessons.getBeginnerLessons(),
    ];
  }
  
  /// PRACTICAL SKILLS (150 lessons)
  static List<Lesson> getPracticalSkillsLessons() {
    return [
      // Complete Duolingo curriculum (90 lessons)
      ...CompleteDuolingoCurriculum.getPracticalSkills(),
      
      // Enhanced practical lessons (30 lessons)
      ...EnhancedDuolingoLessons.getPracticalLessons(),
      
      // English-Amharic practical lessons (30 lessons)
      ...EnglishAmharicLessons.createFoodLessons(),
      ...EnglishAmharicLessons.createShoppingLessons(),
      ...EnglishAmharicLessons.createTransportationLessons(),
    ];
  }
  
  /// CONVERSATION MASTERY (100 lessons)
  static List<Lesson> getConversationMasteryLessons() {
    return [
      // Complete Duolingo curriculum (60 lessons)
      ...CompleteDuolingoCurriculum.getConversationSkills(),
      
      // Enhanced conversation lessons (20 lessons)
      ...EnhancedDuolingoLessons.getConversationLessons(),
      
      // Expanded conversation lessons (20 lessons)
      ...ExpandedLessonCategories.getConversationMasteryLessons(),
    ];
  }
  
  /// PROFESSIONAL SKILLS (100 lessons)
  static List<Lesson> getProfessionalSkillsLessons() {
    return [
      // Complete Duolingo curriculum (60 lessons)
      ...CompleteDuolingoCurriculum.getProfessionalSkills(),
      
      // Enhanced professional lessons (20 lessons)
      ...EnhancedDuolingoLessons.getProfessionalLessons(),
      
      // Expanded professional lessons (20 lessons)
      ...ExpandedLessonCategories.getProfessionalSkillsLessons(),
    ];
  }
  
  /// SPECIALIZED TOPICS (50 lessons)
  static List<Lesson> getSpecializedTopicsLessons() {
    return [
      // Expanded specialized lessons (30 lessons)
      ...ExpandedLessonCategories.getSpecializedTopicsLessons(),
      
      // Cultural immersion lessons (20 lessons)
      ...ExpandedLessonCategories.getCulturalImmersionLessons(),
    ];
  }
  
  /// Get lessons by difficulty level
  static List<Lesson> getLessonsByLevel(LanguageLevel level) {
    return getCompleteCurriculum()
        .where((lesson) => lesson.level == level)
        .toList();
  }
  
  /// Get lessons by category
  static List<Lesson> getLessonsByCategory(String category) {
    return getCompleteCurriculum()
        .where((lesson) => lesson.category.toLowerCase() == category.toLowerCase())
        .toList();
  }
  
  /// Get lesson statistics
  static Map<String, dynamic> getLessonStatistics() {
    final allLessons = getCompleteCurriculum();
    final beginnerLessons = allLessons.where((l) => l.level == LanguageLevel.beginner).length;
    final intermediateLessons = allLessons.where((l) => l.level == LanguageLevel.intermediate).length;
    final advancedLessons = allLessons.where((l) => l.level == LanguageLevel.advanced).length;
    
    int totalExercises = 0;
    int totalXP = 0;
    Set<String> categories = {};
    
    for (final lesson in allLessons) {
      totalExercises += lesson.exercises.length;
      totalXP += lesson.xpReward;
      categories.add(lesson.category);
    }
    
    return {
      'totalLessons': allLessons.length,
      'beginnerLessons': beginnerLessons,
      'intermediateLessons': intermediateLessons,
      'advancedLessons': advancedLessons,
      'totalExercises': totalExercises,
      'totalXP': totalXP,
      'categories': categories.length,
      'averageExercisesPerLesson': (totalExercises / allLessons.length).round(),
      'averageXPPerLesson': (totalXP / allLessons.length).round(),
    };
  }
  
  /// Get lesson by ID
  static Lesson? getLessonById(String id) {
    try {
      return getCompleteCurriculum().firstWhere((lesson) => lesson.id == id);
    } catch (e) {
      return null;
    }
  }
  
  /// Get next lesson in sequence
  static Lesson? getNextLesson(String currentLessonId) {
    final allLessons = getCompleteCurriculum();
    final currentIndex = allLessons.indexWhere((lesson) => lesson.id == currentLessonId);
    
    if (currentIndex == -1 || currentIndex >= allLessons.length - 1) {
      return null;
    }
    
    return allLessons[currentIndex + 1];
  }
  
  /// Get previous lesson in sequence
  static Lesson? getPreviousLesson(String currentLessonId) {
    final allLessons = getCompleteCurriculum();
    final currentIndex = allLessons.indexWhere((lesson) => lesson.id == currentLessonId);
    
    if (currentIndex <= 0) {
      return null;
    }
    
    return allLessons[currentIndex - 1];
  }
  
  /// Get lessons for a specific learning path
  static List<Lesson> getLearningPath(String pathName) {
    switch (pathName.toLowerCase()) {
      case 'tourist':
        return getTouristLearningPath();
      case 'business':
        return getBusinessLearningPath();
      case 'academic':
        return getAcademicLearningPath();
      case 'complete':
        return getCompleteCurriculum();
      default:
        return getCompleteCurriculum();
    }
  }
  
  /// Get tourist-focused learning path
  static List<Lesson> getTouristLearningPath() {
    return getCompleteCurriculum()
        .where((lesson) => 
          lesson.category.toLowerCase() == 'greetings' ||
          lesson.category.toLowerCase() == 'food' ||
          lesson.category.toLowerCase() == 'shopping' ||
          lesson.category.toLowerCase() == 'transportation' ||
          lesson.category.toLowerCase() == 'accommodation' ||
          lesson.category.toLowerCase() == 'emergency' ||
          lesson.category.toLowerCase() == 'travel'
        )
        .toList();
  }
  
  /// Get business-focused learning path
  static List<Lesson> getBusinessLearningPath() {
    return getCompleteCurriculum()
        .where((lesson) => 
          lesson.category.toLowerCase() == 'business' ||
          lesson.category.toLowerCase() == 'professional' ||
          lesson.category.toLowerCase() == 'legal' ||
          lesson.category.toLowerCase() == 'technology'
        )
        .toList();
  }
  
  /// Get academic-focused learning path
  static List<Lesson> getAcademicLearningPath() {
    return getCompleteCurriculum()
        .where((lesson) => 
          lesson.category.toLowerCase() == 'education' ||
          lesson.category.toLowerCase() == 'grammar' ||
          lesson.category.toLowerCase() == 'culture' ||
          lesson.category.toLowerCase() == 'conversation'
        )
        .toList();
  }
  
  /// Get lesson recommendations based on user progress
  static List<Lesson> getRecommendedLessons(List<String> completedLessonIds, String userLevel) {
    final allLessons = getCompleteCurriculum();
    final completedLessons = completedLessonIds.toSet();
    
    // Filter out completed lessons
    final availableLessons = allLessons
        .where((lesson) => !completedLessons.contains(lesson.id))
        .toList();
    
    // Filter by user level
    LanguageLevel targetLevel;
    switch (userLevel.toLowerCase()) {
      case 'beginner':
        targetLevel = LanguageLevel.beginner;
        break;
      case 'intermediate':
        targetLevel = LanguageLevel.intermediate;
        break;
      case 'advanced':
        targetLevel = LanguageLevel.advanced;
        break;
      default:
        targetLevel = LanguageLevel.beginner;
    }
    
    return availableLessons
        .where((lesson) => lesson.level == targetLevel)
        .take(10)
        .toList();
  }
  
  /// Get lesson difficulty progression
  static Map<String, List<Lesson>> getDifficultyProgression() {
    return {
      'beginner': getLessonsByLevel(LanguageLevel.beginner),
      'intermediate': getLessonsByLevel(LanguageLevel.intermediate),
      'advanced': getLessonsByLevel(LanguageLevel.advanced),
    };
  }
  
  /// Get category-based lesson organization
  static Map<String, List<Lesson>> getCategoryOrganization() {
    final allLessons = getCompleteCurriculum();
    final Map<String, List<Lesson>> categoryMap = {};
    
    for (final lesson in allLessons) {
      if (!categoryMap.containsKey(lesson.category)) {
        categoryMap[lesson.category] = [];
      }
      categoryMap[lesson.category]!.add(lesson);
    }
    
    return categoryMap;
  }
  
  /// Get lesson completion statistics
  static Map<String, dynamic> getCompletionStatistics(List<String> completedLessonIds) {
    final allLessons = getCompleteCurriculum();
    final completedLessons = completedLessonIds.length;
    final totalLessons = allLessons.length;
    final completionPercentage = (completedLessons / totalLessons * 100).round();
    
    // Calculate XP earned
    int totalXPEarned = 0;
    for (final lessonId in completedLessonIds) {
      final lesson = getLessonById(lessonId);
      if (lesson != null) {
        totalXPEarned += lesson.xpReward;
      }
    }
    
    // Calculate total XP available
    final totalXPAvailable = allLessons.fold(0, (sum, lesson) => sum + lesson.xpReward);
    
    return {
      'completedLessons': completedLessons,
      'totalLessons': totalLessons,
      'completionPercentage': completionPercentage,
      'xPEarned': totalXPEarned,
      'totalXPAvailable': totalXPAvailable,
      'xPPercentage': (totalXPEarned / totalXPAvailable * 100).round(),
    };
  }
}


