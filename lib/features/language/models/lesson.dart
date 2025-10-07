class Lesson {
  final String id;
  final String title;
  final String description;
  final LessonType type;
  final int difficulty;
  final int xpReward;
  final String iconPath;
  final List<Exercise> exercises;
  final bool isCompleted;
  final bool isLocked;
  final List<String> prerequisites;

  const Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.difficulty,
    required this.xpReward,
    required this.iconPath,
    required this.exercises,
    this.isCompleted = false,
    this.isLocked = false,
    this.prerequisites = const [],
  });

  Lesson copyWith({
    String? id,
    String? title,
    String? description,
    LessonType? type,
    int? difficulty,
    int? xpReward,
    String? iconPath,
    List<Exercise>? exercises,
    bool? isCompleted,
    bool? isLocked,
    List<String>? prerequisites,
  }) {
    return Lesson(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      difficulty: difficulty ?? this.difficulty,
      xpReward: xpReward ?? this.xpReward,
      iconPath: iconPath ?? this.iconPath,
      exercises: exercises ?? this.exercises,
      isCompleted: isCompleted ?? this.isCompleted,
      isLocked: isLocked ?? this.isLocked,
      prerequisites: prerequisites ?? this.prerequisites,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type.name,
      'difficulty': difficulty,
      'xpReward': xpReward,
      'iconPath': iconPath,
      'exercises': exercises.map((x) => x.toMap()).toList(),
      'isCompleted': isCompleted,
      'isLocked': isLocked,
      'prerequisites': prerequisites,
    };
  }

  factory Lesson.fromMap(Map<String, dynamic> map) {
    return Lesson(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      type: LessonType.values.firstWhere(
        (e) => e.name == map['type'],
        orElse: () => LessonType.vocabulary,
      ),
      difficulty: map['difficulty']?.toInt() ?? 0,
      xpReward: map['xpReward']?.toInt() ?? 0,
      iconPath: map['iconPath'] ?? '',
      exercises: List<Exercise>.from(
        map['exercises']?.map((x) => Exercise.fromMap(x)) ?? [],
      ),
      isCompleted: map['isCompleted'] ?? false,
      isLocked: map['isLocked'] ?? false,
      prerequisites: List<String>.from(map['prerequisites'] ?? []),
    );
  }
}

enum LessonType {
  vocabulary,
  grammar,
  listening,
  speaking,
  reading,
  writing,
  culture,
}

class Exercise {
  final String id;
  final ExerciseType type;
  final String question;
  final String? audioUrl;
  final String? imageUrl;
  final List<String> options;
  final String correctAnswer;
  final String explanation;
  final Map<String, String> translations;

  const Exercise({
    required this.id,
    required this.type,
    required this.question,
    this.audioUrl,
    this.imageUrl,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
    this.translations = const {},
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type.name,
      'question': question,
      'audioUrl': audioUrl,
      'imageUrl': imageUrl,
      'options': options,
      'correctAnswer': correctAnswer,
      'explanation': explanation,
      'translations': translations,
    };
  }

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      id: map['id'] ?? '',
      type: ExerciseType.values.firstWhere(
        (e) => e.name == map['type'],
        orElse: () => ExerciseType.multipleChoice,
      ),
      question: map['question'] ?? '',
      audioUrl: map['audioUrl'],
      imageUrl: map['imageUrl'],
      options: List<String>.from(map['options'] ?? []),
      correctAnswer: map['correctAnswer'] ?? '',
      explanation: map['explanation'] ?? '',
      translations: Map<String, String>.from(map['translations'] ?? {}),
    );
  }
}

enum ExerciseType {
  multipleChoice,
  fillInTheBlank,
  matchPairs,
  listening,
  speaking,
  translation,
  ordering,
  imageSelection,
}




















