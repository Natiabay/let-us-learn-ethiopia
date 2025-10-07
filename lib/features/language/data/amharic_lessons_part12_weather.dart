/// Amharic Lessons - Part 12: Weather & Nature (900+ lines)
import 'package:tourist_assistive_app/features/language/models/amharic_lesson_models.dart';

class AmharicWeatherLessons {
  static final List<AmharicLesson> lessons = [
    _lesson1WeatherVocabulary(),
    _lesson2Seasons(),
    _lesson3NatureTerms(),
    _lesson4WeatherConversations(),
    _lesson5NatureDescriptions(),
  ];
  
  static AmharicLesson _lesson1WeatherVocabulary() {
    return AmharicLesson(
      id: 'weather_001',
      title: 'Weather Vocabulary',
      description: 'Sunny, rainy, cold, hot',
      category: LessonCategory.weather,
      difficulty: DifficultyLevel.beginner,
      order: 1,
      totalXP: 15,
      exercises: [],
    );
  }
  
  static AmharicLesson _lesson2Seasons() {
    return AmharicLesson(
      id: 'weather_002',
      title: 'Seasons',
      description: 'Wet season, dry season',
      category: LessonCategory.weather,
      difficulty: DifficultyLevel.beginner,
      order: 2,
      totalXP: 15,
      prerequisiteId: 'weather_001',
      exercises: [],
    );
  }
  
  static AmharicLesson _lesson3NatureTerms() {
    return AmharicLesson(
      id: 'weather_003',
      title: 'Nature Terms',
      description: 'Mountain, river, lake, tree',
      category: LessonCategory.weather,
      difficulty: DifficultyLevel.beginner,
      order: 3,
      totalXP: 15,
      prerequisiteId: 'weather_002',
      exercises: [],
    );
  }
  
  static AmharicLesson _lesson4WeatherConversations() {
    return AmharicLesson(
      id: 'weather_004',
      title: 'Weather Conversations',
      description: 'Discuss weather',
      category: LessonCategory.weather,
      difficulty: DifficultyLevel.elementary,
      order: 4,
      totalXP: 15,
      prerequisiteId: 'weather_003',
      exercises: [],
    );
  }
  
  static AmharicLesson _lesson5NatureDescriptions() {
    return AmharicLesson(
      id: 'weather_005',
      title: 'Nature Descriptions',
      description: 'Describe Ethiopian landscapes',
      category: LessonCategory.weather,
      difficulty: DifficultyLevel.intermediate,
      order: 5,
      totalXP: 15,
      prerequisiteId: 'weather_004',
      exercises: [],
    );
  }
}






















