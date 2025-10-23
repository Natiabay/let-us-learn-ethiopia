import 'package:tourist_assistive_app/features/duolingo_learn/models/exercise_model.dart';

/// Lesson Model - Represents a single learning unit
class Lesson {
  final String id;
  final String categoryId;
  final String title;
  final String? titleAmharic;
  final String description;
  final int order; // Order within category
  final LessonDifficulty difficulty;
  final List<String> newWords; // Amharic words introduced
  final List<Exercise> exercises;
  final List<String> requiredLessons; // Prerequisites
  final int xpReward;
  final int perfectXPBonus;
  final String? imageUrl; // From migrated photos
  final String? culturalNote; // Historical/cultural context
  final bool isLocked;

  const Lesson({
    required this.id,
    required this.categoryId,
    required this.title,
    this.titleAmharic,
    required this.description,
    required this.order,
    this.difficulty = LessonDifficulty.beginner,
    this.newWords = const [],
    required this.exercises,
    this.requiredLessons = const [],
    this.xpReward = 15,
    this.perfectXPBonus = 10,
    this.imageUrl,
    this.culturalNote,
    this.isLocked = false,
  });

  /// Total exercises in lesson
  int get totalExercises => exercises.length;

  /// Estimated time to complete (minutes)
  int get estimatedMinutes {
    // Rough estimate: 30 seconds per exercise
    return (exercises.length * 0.5).ceil();
  }

  /// Copy with method
  Lesson copyWith({
    String? id,
    String? categoryId,
    String? title,
    String? titleAmharic,
    String? description,
    int? order,
    LessonDifficulty? difficulty,
    List<String>? newWords,
    List<Exercise>? exercises,
    List<String>? requiredLessons,
    int? xpReward,
    int? perfectXPBonus,
    String? imageUrl,
    String? culturalNote,
    bool? isLocked,
  }) {
    return Lesson(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      title: title ?? this.title,
      titleAmharic: titleAmharic ?? this.titleAmharic,
      description: description ?? this.description,
      order: order ?? this.order,
      difficulty: difficulty ?? this.difficulty,
      newWords: newWords ?? this.newWords,
      exercises: exercises ?? this.exercises,
      requiredLessons: requiredLessons ?? this.requiredLessons,
      xpReward: xpReward ?? this.xpReward,
      perfectXPBonus: perfectXPBonus ?? this.perfectXPBonus,
      imageUrl: imageUrl ?? this.imageUrl,
      culturalNote: culturalNote ?? this.culturalNote,
      isLocked: isLocked ?? this.isLocked,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryId': categoryId,
      'title': title,
      'titleAmharic': titleAmharic,
      'description': description,
      'order': order,
      'difficulty': difficulty.name,
      'newWords': newWords,
      'exercises': exercises.map((e) => e.toJson()).toList(),
      'requiredLessons': requiredLessons,
      'xpReward': xpReward,
      'perfectXPBonus': perfectXPBonus,
      'imageUrl': imageUrl,
      'culturalNote': culturalNote,
      'isLocked': isLocked,
    };
  }

  /// Create from JSON
  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'] as String,
      categoryId: json['categoryId'] as String,
      title: json['title'] as String,
      titleAmharic: json['titleAmharic'] as String?,
      description: json['description'] as String,
      order: json['order'] as int,
      difficulty: LessonDifficulty.values.firstWhere(
        (d) => d.name == json['difficulty'],
        orElse: () => LessonDifficulty.beginner,
      ),
      newWords: (json['newWords'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      exercises: (json['exercises'] as List<dynamic>)
          .map((e) => Exercise.fromJson(e as Map<String, dynamic>))
          .toList(),
      requiredLessons: (json['requiredLessons'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      xpReward: json['xpReward'] as int? ?? 15,
      perfectXPBonus: json['perfectXPBonus'] as int? ?? 10,
      imageUrl: json['imageUrl'] as String?,
      culturalNote: json['culturalNote'] as String?,
      isLocked: json['isLocked'] as bool? ?? false,
    );
  }
}

/// Lesson difficulty levels
enum LessonDifficulty {
  beginner,
  intermediate,
  advanced,
}

/// Category Model - Groups related lessons
class LessonCategory {
  final String id;
  final String name;
  final String nameAmharic;
  final String description;
  final String icon;
  final int order;
  final List<Lesson> lessons;
  final String? imageUrl;
  final bool isUnlocked;
  final List<String> requiredCategories; // Prerequisites

  const LessonCategory({
    required this.id,
    required this.name,
    required this.nameAmharic,
    required this.description,
    required this.icon,
    required this.order,
    this.lessons = const [],
    this.imageUrl,
    this.isUnlocked = false,
    this.requiredCategories = const [],
  });

  /// Total lessons in category
  int get totalLessons => lessons.length;

  /// Completed lessons count (would be calculated from user progress)
  int completedCount(List<String> completedLessonIds) {
    return lessons.where((l) => completedLessonIds.contains(l.id)).length;
  }

  /// Progress percentage (0.0 to 1.0)
  double progress(List<String> completedLessonIds) {
    if (totalLessons == 0) return 0.0;
    return completedCount(completedLessonIds) / totalLessons;
  }

  /// Is category completed?
  bool isCompleted(List<String> completedLessonIds) {
    return completedCount(completedLessonIds) == totalLessons;
  }

  /// Copy with method
  LessonCategory copyWith({
    String? id,
    String? name,
    String? nameAmharic,
    String? description,
    String? icon,
    int? order,
    List<Lesson>? lessons,
    String? imageUrl,
    bool? isUnlocked,
    List<String>? requiredCategories,
  }) {
    return LessonCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      nameAmharic: nameAmharic ?? this.nameAmharic,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      order: order ?? this.order,
      lessons: lessons ?? this.lessons,
      imageUrl: imageUrl ?? this.imageUrl,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      requiredCategories: requiredCategories ?? this.requiredCategories,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nameAmharic': nameAmharic,
      'description': description,
      'icon': icon,
      'order': order,
      'lessons': lessons.map((l) => l.toJson()).toList(),
      'imageUrl': imageUrl,
      'isUnlocked': isUnlocked,
      'requiredCategories': requiredCategories,
    };
  }

  /// Create from JSON
  factory LessonCategory.fromJson(Map<String, dynamic> json) {
    return LessonCategory(
      id: json['id'] as String,
      name: json['name'] as String,
      nameAmharic: json['nameAmharic'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
      order: json['order'] as int,
      lessons: (json['lessons'] as List<dynamic>?)
              ?.map((e) => Lesson.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      imageUrl: json['imageUrl'] as String?,
      isUnlocked: json['isUnlocked'] as bool? ?? false,
      requiredCategories: (json['requiredCategories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }
}

/// Vocabulary Word Model
class VocabularyWord {
  final String amharic; // ሰላም
  final String transliteration; // selam
  final String english; // hello
  final String? audioUrl; // TTS or recorded audio
  final String? imageUrl; // From migrated photos
  final String? example; // Example sentence
  final String? exampleTranslation;

  const VocabularyWord({
    required this.amharic,
    required this.transliteration,
    required this.english,
    this.audioUrl,
    this.imageUrl,
    this.example,
    this.exampleTranslation,
  });

  /// Display format: "selam/ሰላም"
  String get displayFormat => '$transliteration/$amharic';

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'amharic': amharic,
      'transliteration': transliteration,
      'english': english,
      'audioUrl': audioUrl,
      'imageUrl': imageUrl,
      'example': example,
      'exampleTranslation': exampleTranslation,
    };
  }

  /// Create from JSON
  factory VocabularyWord.fromJson(Map<String, dynamic> json) {
    return VocabularyWord(
      amharic: json['amharic'] as String,
      transliteration: json['transliteration'] as String,
      english: json['english'] as String,
      audioUrl: json['audioUrl'] as String?,
      imageUrl: json['imageUrl'] as String?,
      example: json['example'] as String?,
      exampleTranslation: json['exampleTranslation'] as String?,
    );
  }
}

