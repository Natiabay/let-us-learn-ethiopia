import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/models/lesson_model.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/data/complete_lessons_1_5.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/data/complete_lessons_6_10.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/data/complete_lessons_11_20.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/data/complete_lessons_21_30.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/data/complete_lessons_31_33.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/data/fidel_lessons.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/data/real_intermediate_lessons_1_5.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/data/real_intermediate_lessons_6_10.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/data/real_intermediate_lessons_11_15.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/data/real_intermediate_lessons_16_20.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/data/real_intermediate_lessons_21_25.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/data/real_intermediate_lessons_26_30.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/data/real_intermediate_lessons_31_33.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/data/advanced_lessons_1_10.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/data/advanced_lessons_11_20.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/data/advanced_lessons_21_33.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/data/comprehensive_lessons.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/data/complete_1500_lessons.dart';

/// COMPREHENSIVE LESSON PROVIDER
/// Loads ALL 1,500+ real Amharic lessons across 100 categories
/// Categories: 1 Fidel + 33 Beginner + 33 Intermediate + 33 Advanced

class LessonNotifier extends StateNotifier<Map<String, List<Lesson>>> {
  LessonNotifier() : super({}) {
    _loadAllLessons();
  }

  void _loadAllLessons() {
    final allLessons = <String, List<Lesson>>{};
    
    // Load Complete 1500 Lessons with all photos integrated
    allLessons['fidel_alphabet'] = Complete1500Lessons.getFidelAlphabetLessons();
    allLessons['basic_greetings'] = Complete1500Lessons.getBasicGreetingsLessons();
    allLessons['everyday_objects'] = Complete1500Lessons.getEverydayObjectsLessons();
    
    // Load additional categories from existing data
    allLessons['simple_introductions'] = CompleteLessons15.simpleIntroductions();
    allLessons['polite_expressions'] = CompleteLessons15.politeExpressions();
    allLessons['numbers_1_10'] = ComprehensiveLessons.getNumbers1To10Lessons();
    allLessons['numbers_11_100'] = CompleteLessons610.numbers11100();
    
    // Load Beginner Categories 6-10 (75 lessons)
    allLessons['colors'] = CompleteLessons610.colors();
    allLessons['family_members'] = ComprehensiveLessons.getFamilyMembersLessons();
    allLessons['basic_food'] = CompleteLessons610.basicFood();
    allLessons['drinks_beverages'] = CompleteLessons610.drinksAndBeverages();
    allLessons['restaurant_basics'] = CompleteLessons1120.restaurantBasics();
    
    // Load Beginner Categories 11-20 (150 lessons)
    allLessons['shopping_basics'] = CompleteLessons1120.shoppingBasics();
    allLessons['asking_directions'] = CompleteLessons1120.askingForDirections();
    allLessons['basic_transportation'] = CompleteLessons1120.basicTransportation();
    allLessons['hotel_check_in'] = CompleteLessons1120.hotelCheckIn();
    allLessons['telling_time'] = CompleteLessons1120.tellingTime();
    allLessons['days_of_week'] = CompleteLessons1120.daysOfTheWeek();
    allLessons['months_seasons'] = CompleteLessons1120.monthsAndSeasons();
    allLessons['weather_terms'] = CompleteLessons1120.weatherTerms();
    allLessons['body_parts'] = CompleteLessons1120.bodyParts();
    allLessons['basic_health'] = CompleteLessons2130.basicHealth();
    
    // Load Beginner Categories 21-30 (150 lessons)
    allLessons['emergency_phrases'] = CompleteLessons2130.emergencyPhrases();
    allLessons['personal_pronouns'] = CompleteLessons2130.personalPronouns();
    allLessons['to_be_have'] = CompleteLessons2130.toBeAndHave();
    allLessons['common_verbs_1'] = CompleteLessons2130.commonVerbs1();
    allLessons['simple_adjectives'] = CompleteLessons2130.simpleAdjectives();
    allLessons['asking_questions'] = CompleteLessons2130.askingQuestions();
    allLessons['negative_sentences'] = CompleteLessons2130.negativeSentences();
    allLessons['simple_sentences'] = CompleteLessons2130.simpleSentences();
    allLessons['animals'] = CompleteLessons2130.animals();
    allLessons['clothing'] = CompleteLessons3133.clothing();
    
    // Load Beginner Categories 31-33 (45 lessons)
    allLessons['home_furniture'] = CompleteLessons3133.homeAndFurniture();
    allLessons['cultural_facts_1'] = CompleteLessons3133.culturalFacts1();
    allLessons['tourist_essentials_1'] = CompleteLessons3133.touristEssentials1();
    
    // Load Intermediate Categories 1-10 (150 lessons) - REAL LESSONS
    allLessons['intermediate_advanced_greetings'] = intermediateCategory1.lessons;
    allLessons['intermediate_conversations_1'] = intermediateCategory2.lessons;
    allLessons['intermediate_social_expressions'] = intermediateCategory3.lessons;
    allLessons['intermediate_numbers_advanced'] = intermediateCategory4.lessons;
    allLessons['intermediate_money_currency'] = intermediateCategory5.lessons;
    allLessons['intermediate_descriptive_adjectives'] = intermediateCategory6.lessons;
    allLessons['intermediate_family_relationships'] = intermediateCategory7.lessons;
    allLessons['intermediate_food_cooking'] = intermediateCategory8.lessons;
    allLessons['intermediate_dining_out'] = intermediateCategory9.lessons;
    allLessons['intermediate_shopping_bargaining'] = intermediateCategory10.lessons;
    
    // Load Intermediate Categories 11-20 (150 lessons)
    allLessons['intermediate_directions_maps'] = intermediateCategory11.lessons;
    allLessons['intermediate_transportation_modes'] = intermediateCategory12.lessons;
    allLessons['intermediate_hotel_services'] = intermediateCategory13.lessons;
    allLessons['intermediate_time_expressions'] = intermediateCategory14.lessons;
    allLessons['intermediate_dates_appointments'] = intermediateCategory15.lessons;
    allLessons['intermediate_weather_conversations'] = intermediateCategory16.lessons;
    allLessons['intermediate_health_doctor'] = intermediateCategory17.lessons;
    allLessons['intermediate_emergency_situations'] = intermediateCategory18.lessons;
    allLessons['intermediate_possessive_pronouns'] = intermediateCategory19.lessons;
    allLessons['intermediate_verb_conjugations_1'] = intermediateCategory20.lessons;
    
    // Load Intermediate Categories 21-33 (195 lessons)
    allLessons['intermediate_adverbs'] = intermediateCategory21.lessons;
    allLessons['intermediate_prepositions'] = intermediateCategory22.lessons;
    allLessons['intermediate_compound_sentences'] = intermediateCategory23.lessons;
    allLessons['intermediate_questions_advanced'] = intermediateCategory24.lessons;
    allLessons['intermediate_negatives_commands'] = intermediateCategory25.lessons;
    allLessons['intermediate_past_tense_basics'] = intermediateCategory26.lessons;
    allLessons['intermediate_future_tense_basics'] = intermediateCategory27.lessons;
    allLessons['intermediate_animals_nature'] = intermediateCategory28.lessons;
    allLessons['intermediate_clothing_fashion'] = intermediateCategory29.lessons;
    allLessons['intermediate_home_life'] = intermediateCategory30.lessons;
    allLessons['intermediate_cultural_facts_2'] = intermediateCategory31.lessons;
    allLessons['intermediate_tourist_essentials_2'] = intermediateCategory32.lessons;
    allLessons['intermediate_daily_routines'] = intermediateCategory33.lessons;
    
    // Load Advanced Categories 1-10 (150 lessons)
    allLessons['advanced_complex_greetings'] = advancedCategory1.lessons;
    allLessons['advanced_professional_conversations'] = advancedCategory2.lessons;
    allLessons['advanced_formal_writing'] = advancedCategory3.lessons;
    allLessons['advanced_numbers'] = advancedCategory4.lessons;
    allLessons['advanced_financial_terms'] = advancedCategory5.lessons;
    allLessons['advanced_complex_adjectives'] = advancedCategory6.lessons;
    allLessons['advanced_extended_family_society'] = advancedCategory7.lessons;
    allLessons['advanced_culinary_arts'] = advancedCategory8.lessons;
    allLessons['advanced_fine_dining'] = advancedCategory9.lessons;
    allLessons['advanced_business_commerce'] = advancedCategory10.lessons;
    
    // Load Advanced Categories 11-20 (150 lessons)
    allLessons['advanced_navigation_geography'] = advancedCategory11.lessons;
    allLessons['advanced_public_transportation_systems'] = advancedCategory12.lessons;
    allLessons['advanced_hospitality_industry'] = advancedCategory13.lessons;
    allLessons['advanced_time_scheduling'] = advancedCategory14.lessons;
    allLessons['advanced_calendar_planning'] = advancedCategory15.lessons;
    allLessons['advanced_climate_environment'] = advancedCategory16.lessons;
    allLessons['advanced_medical_terminology'] = advancedCategory17.lessons;
    allLessons['advanced_crisis_management'] = advancedCategory18.lessons;
    allLessons['advanced_grammar'] = advancedCategory19.lessons;
    allLessons['advanced_verb_conjugations'] = advancedCategory20.lessons;
    
    // Load Advanced Categories 21-33 (195 lessons)
    allLessons['advanced_rhetoric_style'] = advancedCategory21.lessons;
    allLessons['advanced_idiomatic_expressions'] = advancedCategory22.lessons;
    allLessons['advanced_complex_discourse'] = advancedCategory23.lessons;
    allLessons['advanced_academic_language'] = advancedCategory24.lessons;
    allLessons['advanced_commands_requests'] = advancedCategory25.lessons;
    allLessons['advanced_historical_narratives'] = advancedCategory26.lessons;
    allLessons['advanced_future_predictions'] = advancedCategory27.lessons;
    allLessons['advanced_ecology_wildlife'] = advancedCategory28.lessons;
    allLessons['advanced_traditional_attire'] = advancedCategory29.lessons;
    allLessons['advanced_family_dynamics'] = advancedCategory30.lessons;
    allLessons['advanced_ethiopian_history'] = advancedCategory31.lessons;
    allLessons['advanced_tourism_industry'] = advancedCategory32.lessons;
    allLessons['advanced_cultural_integration'] = advancedCategory33.lessons;
    
    // ALL LESSONS LOADED: 1 Fidel + 33 Beginner + 33 Intermediate + 33 Advanced = 100 categories total
    
    state = allLessons;
  }

  /// Get lessons for a specific category
  List<Lesson> getLessonsForCategory(String categoryId) {
    return state[categoryId] ?? [];
  }

  /// Get all available categories
  List<String> getAllCategories() {
    return state.keys.toList();
  }

  /// Get total lesson count
  int getTotalLessonCount() {
    return state.values.fold(0, (sum, lessons) => sum + lessons.length);
  }

  /// Get lesson by ID
  Lesson? getLessonById(String lessonId) {
    for (final lessons in state.values) {
      for (final lesson in lessons) {
        if (lesson.id == lessonId) {
          return lesson;
        }
      }
    }
    return null;
  }

  /// Get next lesson in sequence
  Lesson? getNextLesson(String currentLessonId) {
    final currentLesson = getLessonById(currentLessonId);
    if (currentLesson == null) return null;

    final categoryLessons = getLessonsForCategory(currentLesson.categoryId);
    final currentIndex = categoryLessons.indexWhere((l) => l.id == currentLessonId);
    
    if (currentIndex >= 0 && currentIndex < categoryLessons.length - 1) {
      return categoryLessons[currentIndex + 1];
    }
    
    return null;
  }

  /// Get lessons by difficulty level
  List<Lesson> getLessonsByLevel(String level) {
    final allLessons = <Lesson>[];
    for (final lessons in state.values) {
      allLessons.addAll(lessons.where((lesson) => 
        lesson.categoryId.contains(level.toLowerCase())));
    }
    return allLessons;
  }

  /// Search lessons by keyword
  List<Lesson> searchLessons(String keyword) {
    final allLessons = <Lesson>[];
    for (final lessons in state.values) {
      allLessons.addAll(lessons.where((lesson) => 
        lesson.title.toLowerCase().contains(keyword.toLowerCase()) ||
        (lesson.titleAmharic?.contains(keyword) ?? false) ||
        lesson.description.toLowerCase().contains(keyword.toLowerCase())));
    }
    return allLessons;
  }
}

/// Provider for lesson state
final lessonProvider = StateNotifierProvider<LessonNotifier, Map<String, List<Lesson>>>((ref) {
  return LessonNotifier();
});

/// Provider for specific category lessons
final categoryLessonsProvider = Provider.family<List<Lesson>, String>((ref, categoryId) {
  final lessonState = ref.watch(lessonProvider);
  return lessonState[categoryId] ?? [];
});

/// Provider for total lesson count
final totalLessonCountProvider = Provider<int>((ref) {
  final lessonState = ref.watch(lessonProvider);
  return lessonState.values.fold(0, (sum, lessons) => sum + lessons.length);
});

/// Provider for available categories
final availableCategoriesProvider = Provider<List<String>>((ref) {
  final lessonState = ref.watch(lessonProvider);
  return lessonState.keys.toList();
});

/// Provider for beginner lessons
final beginnerLessonsProvider = Provider<List<Lesson>>((ref) {
  final lessonState = ref.watch(lessonProvider);
  final beginnerCategories = [
    'basic_greetings', 'simple_introductions', 'polite_expressions',
    'numbers_1_10', 'numbers_11_100', 'colors', 'family_members',
    'basic_food', 'drinks_beverages', 'restaurant_basics',
    'shopping_basics', 'asking_directions', 'basic_transportation',
    'hotel_check_in', 'telling_time', 'days_of_week', 'months_seasons',
    'weather_terms', 'body_parts', 'basic_health', 'emergency_phrases',
    'personal_pronouns', 'to_be_have', 'common_verbs_1', 'simple_adjectives',
    'asking_questions', 'negative_sentences', 'simple_sentences', 'animals',
    'clothing', 'home_furniture', 'cultural_facts_1', 'tourist_essentials_1'
  ];
  
  final allLessons = <Lesson>[];
  for (final category in beginnerCategories) {
    allLessons.addAll(lessonState[category] ?? []);
  }
  return allLessons;
});

/// Provider for Fidel lessons
final fidelLessonsProvider = Provider<List<Lesson>>((ref) {
  final lessonState = ref.watch(lessonProvider);
  return lessonState['fidel_alphabet'] ?? [];
});

/// Provider to get a specific lesson by ID
final lessonByIdProvider = Provider.family<Lesson?, String>((ref, lessonId) {
  final lessonState = ref.watch(lessonProvider);
  
  // Search through all categories to find the lesson
  for (final categoryLessons in lessonState.values) {
    for (final lesson in categoryLessons) {
      if (lesson.id == lessonId) {
        return lesson;
      }
    }
  }
  
  return null;
});
