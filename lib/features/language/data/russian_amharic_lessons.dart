import 'package:tourist_assistive_app/features/language/models/comprehensive_lesson_model.dart';

class RussianAmharicLessons {
  static List<Lesson> getAllLessons() {
    return [
      ...getBeginnerLessons(),
      ...getIntermediateLessons(),
      ...getAdvancedLessons(),
    ];
  }
  
  static List<Lesson> getBeginnerLessons() {
    return [
      _createLesson(
        id: 'ru_beginner_1',
        title: 'Приветствие и прощание', // Greetings and farewells
        description: 'Изучите основные приветствия на амхарском языке',
        category: 'Приветствие',
        vocabulary: {
          'ሰላም': 'Привет/Мир',
          'ታዲያስ': 'До свидания (мужчине)',
          'እንዴት ናችሁ': 'Как дела? (множественное)',
          'አመሰግናለሁ': 'Спасибо',
          'እንኳን ደህና መጣህ': 'Добро пожаловать',
        },
        exercises: _generateGreetingExercises(),
        xpReward: 100,
        estimatedMinutes: 15,
      ),
    ];
  }
  
  static List<Lesson> getIntermediateLessons() {
    return []; // Temporarily simplified for app stability
  }
  
  static List<Lesson> getAdvancedLessons() {
    return []; // Temporarily simplified for app stability
  }

  static List<Lesson> getLessons() {
    return [
      ...getBeginnerLessons(),
      ...getIntermediateLessons(),
      ...getAdvancedLessons(),
    ];
  }

  static Lesson _createLesson({
    required String id,
    required String title,
    required String description,
    required String category,
    required Map<String, String> vocabulary,
    required List<Exercise> exercises,
    required int xpReward,
    required int estimatedMinutes,
  }) {
    return Lesson(
      id: id,
      title: title,
      description: description,
      category: category,
      level: LanguageLevel.beginner,
      languageCode: 'ru',
      vocabulary: vocabulary.keys.toList(),
      exercises: exercises,
      xpReward: xpReward,
      estimatedMinutes: estimatedMinutes,
    );
  }

  static List<Exercise> _generateGreetingExercises() {
    return [
      Exercise(
        id: 'ru_greeting_1',
        type: ExerciseType.translate,
        instruction: 'Переведите: Привет',
        amharicText: 'ሰላም',
        translation: 'Привет',
        options: [
          ExerciseOption(text: 'ሰላም', isCorrect: true),
          ExerciseOption(text: 'ታዲያስ', isCorrect: false),
          ExerciseOption(text: 'እንዴት ናችሁ', isCorrect: false),
          ExerciseOption(text: 'አመሰግናለሁ', isCorrect: false),
        ],
        explanation: 'ሰላም означает "привет" или "мир" на амхарском.',
      ),
    ];
  }

}