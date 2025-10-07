/// Converter to transform new Duolingo lessons to existing format
import 'package:tourist_assistive_app/features/language/models/amharic_lesson_models.dart' as new_model;
import 'package:tourist_assistive_app/features/language/models/comprehensive_lesson_model.dart' as old_model;

class LessonConverter {
  /// Convert new AmharicLesson to old Lesson format
  static old_model.Lesson convertToOldFormat(new_model.AmharicLesson newLesson) {
    return old_model.Lesson(
      id: newLesson.id,
      title: newLesson.title,
      description: newLesson.description,
      level: _convertDifficultyToLevel(newLesson.difficulty),
      languageCode: 'en', // English to Amharic
      estimatedMinutes: _estimateMinutes(newLesson.exercises.length),
      xpReward: newLesson.totalXP,
      exercises: newLesson.exercises.map((e) => _convertExercise(e)).toList(),
      vocabulary: _extractVocabulary(newLesson.exercises),
      category: _convertCategory(newLesson.category),
      isUnlocked: !newLesson.isLocked,
      isCompleted: false,
      progress: 0.0,
    );
  }
  
  /// Convert difficulty level
  static old_model.LanguageLevel _convertDifficultyToLevel(new_model.DifficultyLevel difficulty) {
    switch (difficulty) {
      case new_model.DifficultyLevel.beginner:
      case new_model.DifficultyLevel.elementary:
        return old_model.LanguageLevel.beginner;
      case new_model.DifficultyLevel.intermediate:
        return old_model.LanguageLevel.intermediate;
      case new_model.DifficultyLevel.advanced:
      case new_model.DifficultyLevel.expert:
        return old_model.LanguageLevel.advanced;
    }
  }
  
  /// Convert exercise
  static old_model.Exercise _convertExercise(new_model.LessonExercise newEx) {
    return old_model.Exercise(
      id: newEx.id,
      type: _convertExerciseType(newEx.type),
      instruction: newEx.question,
      amharicText: newEx.amharicScript ?? '',
      translation: newEx.correctAnswer,
      audioUrl: newEx.audioUrl,
      imageUrl: newEx.imageUrl,
      options: newEx.options.map((o) => old_model.ExerciseOption(
        text: o,
        isCorrect: o == newEx.correctAnswer,
      )).toList(),
      correctAnswer: newEx.correctAnswer,
      explanation: newEx.explanation,
      timeLimit: 60,
      xpReward: 10,
    );
  }
  
  /// Convert exercise type
  static old_model.ExerciseType _convertExerciseType(new_model.LessonType type) {
    switch (type) {
      case new_model.LessonType.tapWhatYouHear:
      case new_model.LessonType.listenAndRepeat:
        return old_model.ExerciseType.listen;
      case new_model.LessonType.completeTheSentence:
      case new_model.LessonType.fillInTheBlank:
        return old_model.ExerciseType.fillBlank;
      case new_model.LessonType.completeTheChat:
      case new_model.LessonType.conversation:
        return old_model.ExerciseType.translate;
      case new_model.LessonType.matchPairs:
        return old_model.ExerciseType.matching;
      case new_model.LessonType.translateSentence:
        return old_model.ExerciseType.translate;
      case new_model.LessonType.multipleChoice:
        return old_model.ExerciseType.multipleChoice;
      case new_model.LessonType.speakThisPhrase:
        return old_model.ExerciseType.speak;
    }
  }
  
  /// Extract vocabulary from exercises
  static List<String> _extractVocabulary(List<new_model.LessonExercise> exercises) {
    final vocab = <String>{};
    for (final ex in exercises) {
      if (ex.amharicScript != null) vocab.add(ex.amharicScript!);
      if (ex.wordBank != null) vocab.addAll(ex.wordBank!);
    }
    return vocab.toList();
  }
  
  /// Convert category
  static String _convertCategory(new_model.LessonCategory category) {
    switch (category) {
      case new_model.LessonCategory.greetings:
        return 'Greetings';
      case new_model.LessonCategory.numbers:
        return 'Numbers';
      case new_model.LessonCategory.food:
        return 'Food';
      case new_model.LessonCategory.family:
        return 'Family';
      case new_model.LessonCategory.directions:
        return 'Directions';
      case new_model.LessonCategory.time:
        return 'Time';
      case new_model.LessonCategory.colors:
        return 'Colors';
      case new_model.LessonCategory.transportation:
        return 'Transportation';
      case new_model.LessonCategory.accommodation:
        return 'Accommodation';
      case new_model.LessonCategory.emergency:
        return 'Emergency';
      case new_model.LessonCategory.shopping:
        return 'Shopping';
      case new_model.LessonCategory.weather:
        return 'Weather';
      case new_model.LessonCategory.culture:
        return 'Culture';
      case new_model.LessonCategory.grammar:
        return 'Grammar';
    }
  }
  
  /// Estimate minutes based on exercises
  static int _estimateMinutes(int exerciseCount) {
    return (exerciseCount * 1.5).round(); // ~1.5 minutes per exercise
  }
}




















