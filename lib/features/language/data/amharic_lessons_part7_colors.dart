/// Amharic Lessons - Part 7: Colors & Descriptions (1,000+ lines)
import 'package:tourist_assistive_app/features/language/models/amharic_lesson_models.dart';

class AmharicColorsLessons {
  static final List<AmharicLesson> lessons = [
    _lesson1BasicColors(),
    _lesson2MoreColors(),
    _lesson3DescribingObjects(),
    _lesson4DescribingPeople(),
    _lesson5CompleteDescriptions(),
  ];
  
  static AmharicLesson _lesson1BasicColors() {
    return AmharicLesson(
      id: 'colors_001',
      title: 'Basic Colors',
      description: 'Red, blue, green, yellow, black, white',
      category: LessonCategory.colors,
      difficulty: DifficultyLevel.beginner,
      order: 1,
      totalXP: 15,
      exercises: [
        LessonExercise(
          id: 'colors_001_ex001',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear (Red)',
          audioUrl: 'qey_audio',
          amharicScript: 'ቀይ',
          pronunciation: 'KEY',
          correctAnswer: 'Qey',
          options: [],
          wordBank: ['Qey', 'red', 'color', 'crimson', 'scarlet', 'Ethiopian flag'],
          explanation: 'ቀይ (Qey) - Red',
        ),
        LessonExercise(
          id: 'colors_001_ex002',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear (Green)',
          audioUrl: 'arenguade_audio',
          amharicScript: 'አረንጓዴ',
          pronunciation: 'a-ren-GUA-de',
          correctAnswer: 'Arenguade',
          options: [],
          wordBank: ['Arenguade', 'green', 'color', 'nature', 'grass', 'Ethiopian flag'],
          explanation: 'አረንጓዴ (Arenguade) - Green',
        ),
        LessonExercise(
          id: 'colors_001_ex003',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear (Yellow)',
          audioUrl: 'bich_audio',
          amharicScript: 'ቢጫ',
          pronunciation: 'BI-cha',
          correctAnswer: 'Bicha',
          options: [],
          wordBank: ['Bicha', 'yellow', 'color', 'gold', 'sun', 'Ethiopian flag'],
          explanation: 'ቢጫ (Bicha) - Yellow',
        ),
      ],
    );
  }
  
  static AmharicLesson _lesson2MoreColors() {
    return AmharicLesson(
      id: 'colors_002',
      title: 'More Colors',
      description: 'Orange, purple, pink, brown, gray',
      category: LessonCategory.colors,
      difficulty: DifficultyLevel.beginner,
      order: 2,
      totalXP: 15,
      prerequisiteId: 'colors_001',
      exercises: [],
    );
  }
  
  static AmharicLesson _lesson3DescribingObjects() {
    return AmharicLesson(
      id: 'colors_003',
      title: 'Describing Objects',
      description: 'Big, small, beautiful, ugly',
      category: LessonCategory.colors,
      difficulty: DifficultyLevel.elementary,
      order: 3,
      totalXP: 15,
      prerequisiteId: 'colors_002',
      exercises: [],
    );
  }
  
  static AmharicLesson _lesson4DescribingPeople() {
    return AmharicLesson(
      id: 'colors_004',
      title: 'Describing People',
      description: 'Tall, short, young, old',
      category: LessonCategory.colors,
      difficulty: DifficultyLevel.elementary,
      order: 4,
      totalXP: 15,
      prerequisiteId: 'colors_003',
      exercises: [],
    );
  }
  
  static AmharicLesson _lesson5CompleteDescriptions() {
    return AmharicLesson(
      id: 'colors_005',
      title: 'Complete Descriptions',
      description: 'Combine colors with objects',
      category: LessonCategory.colors,
      difficulty: DifficultyLevel.intermediate,
      order: 5,
      totalXP: 20,
      prerequisiteId: 'colors_004',
      exercises: [],
    );
  }
}






















