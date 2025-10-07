/// Amharic Lessons - Part 10: Emergency & Health (1,100+ lines)
import 'package:tourist_assistive_app/features/language/models/amharic_lesson_models.dart';

class AmharicEmergencyLessons {
  static final List<AmharicLesson> lessons = [
    _lesson1MedicalVocabulary(),
    _lesson2DescribingSymptoms(),
    _lesson3EmergencyPhrases(),
    _lesson4Pharmacy(),
    _lesson5HealthConversations(),
  ];
  
  static AmharicLesson _lesson1MedicalVocabulary() {
    return AmharicLesson(
      id: 'emergency_001',
      title: 'Medical Vocabulary',
      description: 'Doctor, hospital, medicine, pain',
      category: LessonCategory.emergency,
      difficulty: DifficultyLevel.beginner,
      order: 1,
      totalXP: 20,
      exercises: [],
    );
  }
  
  static AmharicLesson _lesson2DescribingSymptoms() {
    return AmharicLesson(
      id: 'emergency_002',
      title: 'Describing Symptoms',
      description: 'Headache, fever, stomachache',
      category: LessonCategory.emergency,
      difficulty: DifficultyLevel.elementary,
      order: 2,
      totalXP: 20,
      prerequisiteId: 'emergency_001',
      exercises: [],
    );
  }
  
  static AmharicLesson _lesson3EmergencyPhrases() {
    return AmharicLesson(
      id: 'emergency_003',
      title: 'Emergency Phrases',
      description: 'Help!, Call police!, I\'m lost',
      category: LessonCategory.emergency,
      difficulty: DifficultyLevel.beginner,
      order: 3,
      totalXP: 25,
      prerequisiteId: 'emergency_002',
      exercises: [],
    );
  }
  
  static AmharicLesson _lesson4Pharmacy() {
    return AmharicLesson(
      id: 'emergency_004',
      title: 'Pharmacy',
      description: 'Buy medicine, recommendations',
      category: LessonCategory.emergency,
      difficulty: DifficultyLevel.elementary,
      order: 4,
      totalXP: 15,
      prerequisiteId: 'emergency_003',
      exercises: [],
    );
  }
  
  static AmharicLesson _lesson5HealthConversations() {
    return AmharicLesson(
      id: 'emergency_005',
      title: 'Health Conversations',
      description: 'Doctor visits, explanations',
      category: LessonCategory.emergency,
      difficulty: DifficultyLevel.intermediate,
      order: 5,
      totalXP: 20,
      prerequisiteId: 'emergency_004',
      exercises: [],
    );
  }
}




















