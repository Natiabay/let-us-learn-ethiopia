/// Exercise Model - Represents a single learning exercise
/// Supports multiple exercise types like Duolingo
class Exercise {
  final String id;
  final ExerciseType type;
  final String question;
  final String? questionAmharic;
  final String? audioUrl;
  final String? imageUrl; // From migrated photos
  final List<ExerciseOption> options;
  final String correctAnswer;
  final String? explanation;
  final int points;

  const Exercise({
    required this.id,
    required this.type,
    required this.question,
    this.questionAmharic,
    this.audioUrl,
    this.imageUrl,
    required this.options,
    required this.correctAnswer,
    this.explanation,
    this.points = 10,
  });

  /// Create exercise with string options (for backward compatibility)
  factory Exercise.withStringOptions({
    required String id,
    required ExerciseType type,
    required String question,
    String? questionAmharic,
    String? audioUrl,
    String? imageUrl,
    required List<String> stringOptions,
    required String correctAnswer,
    String? explanation,
    int points = 10,
  }) {
    return Exercise(
      id: id,
      type: type,
      question: question,
      questionAmharic: questionAmharic,
      audioUrl: audioUrl,
      imageUrl: imageUrl,
      options: stringOptions.map((option) => 
        ExerciseOption.fromString(option, isCorrect: option == correctAnswer)
      ).toList(),
      correctAnswer: correctAnswer,
      explanation: explanation,
      points: points,
    );
  }

  /// Check if answer is correct
  bool isCorrect(String answer) {
    return answer.trim().toLowerCase() == correctAnswer.trim().toLowerCase();
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'question': question,
      'questionAmharic': questionAmharic,
      'audioUrl': audioUrl,
      'imageUrl': imageUrl,
      'options': options.map((o) => o.toJson()).toList(),
      'correctAnswer': correctAnswer,
      'explanation': explanation,
      'points': points,
    };
  }

  /// Create from JSON
  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'] as String,
      type: ExerciseType.values.firstWhere(
        (t) => t.name == json['type'],
        orElse: () => ExerciseType.multipleChoice,
      ),
      question: json['question'] as String,
      questionAmharic: json['questionAmharic'] as String?,
      audioUrl: json['audioUrl'] as String?,
      imageUrl: json['imageUrl'] as String?,
      options: (json['options'] as List<dynamic>)
          .map((e) => e is String 
              ? ExerciseOption.fromString(e, isCorrect: e == json['correctAnswer'])
              : ExerciseOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      correctAnswer: json['correctAnswer'] as String,
      explanation: json['explanation'] as String?,
      points: json['points'] as int? ?? 10,
    );
  }
}

/// Exercise Types (Duolingo-style)
enum ExerciseType {
  /// Match image to word
  matchImage,
  
  /// Translate English to Amharic
  translateToAmharic,
  
  /// Translate Amharic to English
  translateToEnglish,
  
  /// Multiple choice question
  multipleChoice,
  
  /// Fill in the blank
  fillBlank,
  
  /// Listen and select correct answer
  listening,
  
  /// Speak and get recognized
  speaking,
  
  /// Match pairs (word to word)
  matchPairs,
  
  /// Select missing word in sentence
  selectWord,
  
  /// Type what you hear
  typeWhatYouHear,
}

/// Exercise Option Model
class ExerciseOption {
  final String id;
  final String text;
  final String? textAmharic;
  final String? imageUrl;
  final String? audioUrl;
  final bool isCorrect;

  const ExerciseOption({
    required this.id,
    required this.text,
    this.textAmharic,
    this.imageUrl,
    this.audioUrl,
    this.isCorrect = false,
  });

  /// Create from string (for backward compatibility)
  factory ExerciseOption.fromString(String text, {bool isCorrect = false}) {
    return ExerciseOption(
      id: text.hashCode.toString(),
      text: text,
      isCorrect: isCorrect,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'textAmharic': textAmharic,
      'imageUrl': imageUrl,
      'audioUrl': audioUrl,
      'isCorrect': isCorrect,
    };
  }

  /// Create from JSON
  factory ExerciseOption.fromJson(Map<String, dynamic> json) {
    return ExerciseOption(
      id: json['id'] as String,
      text: json['text'] as String,
      textAmharic: json['textAmharic'] as String?,
      imageUrl: json['imageUrl'] as String?,
      audioUrl: json['audioUrl'] as String?,
      isCorrect: json['isCorrect'] as bool? ?? false,
    );
  }
}

/// Lesson Result Model
class LessonResult {
  final String lessonId;
  final int totalExercises;
  final int correctAnswers;
  final int mistakes;
  final int xpEarned;
  final Duration timeSpent;
  final bool isPerfect;
  final DateTime completedAt;

  const LessonResult({
    required this.lessonId,
    required this.totalExercises,
    required this.correctAnswers,
    required this.mistakes,
    required this.xpEarned,
    required this.timeSpent,
    required this.isPerfect,
    required this.completedAt,
  });

  /// Accuracy percentage (0.0 to 1.0)
  double get accuracy {
    if (totalExercises == 0) return 0.0;
    return correctAnswers / totalExercises;
  }

  /// Star rating (1-3 stars)
  int get stars {
    if (isPerfect) return 3;
    if (accuracy >= 0.8) return 2;
    return 1;
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'lessonId': lessonId,
      'totalExercises': totalExercises,
      'correctAnswers': correctAnswers,
      'mistakes': mistakes,
      'xpEarned': xpEarned,
      'timeSpentSeconds': timeSpent.inSeconds,
      'isPerfect': isPerfect,
      'completedAt': completedAt.toIso8601String(),
    };
  }

  /// Create from JSON
  factory LessonResult.fromJson(Map<String, dynamic> json) {
    return LessonResult(
      lessonId: json['lessonId'] as String,
      totalExercises: json['totalExercises'] as int,
      correctAnswers: json['correctAnswers'] as int,
      mistakes: json['mistakes'] as int,
      xpEarned: json['xpEarned'] as int,
      timeSpent: Duration(seconds: json['timeSpentSeconds'] as int),
      isPerfect: json['isPerfect'] as bool,
      completedAt: DateTime.parse(json['completedAt'] as String),
    );
  }
}

/// Exercise Session - Tracks progress through a lesson
class ExerciseSession {
  final String lessonId;
  final List<Exercise> exercises;
  final int currentExerciseIndex;
  final List<ExerciseAttempt> attempts;
  final DateTime startTime;
  final int hearts;

  const ExerciseSession({
    required this.lessonId,
    required this.exercises,
    this.currentExerciseIndex = 0,
    this.attempts = const [],
    required this.startTime,
    this.hearts = 5,
  });

  /// Current exercise
  Exercise get currentExercise => exercises[currentExerciseIndex];

  /// Is session complete?
  bool get isComplete => currentExerciseIndex >= exercises.length;

  /// Has hearts remaining?
  bool get hasHearts => hearts > 0;

  /// Can continue (has hearts and not complete)?
  bool get canContinue => hasHearts && !isComplete;

  /// Calculate results
  LessonResult calculateResult(int xpReward, int perfectBonus) {
    final correctCount = attempts.where((a) => a.isCorrect).length;
    final mistakes = attempts.where((a) => !a.isCorrect).length;
    final isPerfect = mistakes == 0;
    final xpEarned = isPerfect ? xpReward + perfectBonus : xpReward;

    return LessonResult(
      lessonId: lessonId,
      totalExercises: exercises.length,
      correctAnswers: correctCount,
      mistakes: mistakes,
      xpEarned: xpEarned,
      timeSpent: DateTime.now().difference(startTime),
      isPerfect: isPerfect,
      completedAt: DateTime.now(),
    );
  }

  /// Move to next exercise
  ExerciseSession nextExercise() {
    return ExerciseSession(
      lessonId: lessonId,
      exercises: exercises,
      currentExerciseIndex: currentExerciseIndex + 1,
      attempts: attempts,
      startTime: startTime,
      hearts: hearts,
    );
  }

  /// Add attempt
  ExerciseSession addAttempt(ExerciseAttempt attempt) {
    return ExerciseSession(
      lessonId: lessonId,
      exercises: exercises,
      currentExerciseIndex: currentExerciseIndex,
      attempts: [...attempts, attempt],
      startTime: startTime,
      hearts: attempt.isCorrect ? hearts : hearts - 1,
    );
  }

  /// Copy with method
  ExerciseSession copyWith({
    String? lessonId,
    List<Exercise>? exercises,
    int? currentExerciseIndex,
    List<ExerciseAttempt>? attempts,
    DateTime? startTime,
    int? hearts,
  }) {
    return ExerciseSession(
      lessonId: lessonId ?? this.lessonId,
      exercises: exercises ?? this.exercises,
      currentExerciseIndex: currentExerciseIndex ?? this.currentExerciseIndex,
      attempts: attempts ?? this.attempts,
      startTime: startTime ?? this.startTime,
      hearts: hearts ?? this.hearts,
    );
  }
}

/// Exercise Attempt - Records a single attempt at an exercise
class ExerciseAttempt {
  final String exerciseId;
  final String userAnswer;
  final bool isCorrect;
  final DateTime attemptedAt;

  const ExerciseAttempt({
    required this.exerciseId,
    required this.userAnswer,
    required this.isCorrect,
    required this.attemptedAt,
  });

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'exerciseId': exerciseId,
      'userAnswer': userAnswer,
      'isCorrect': isCorrect,
      'attemptedAt': attemptedAt.toIso8601String(),
    };
  }

  /// Create from JSON
  factory ExerciseAttempt.fromJson(Map<String, dynamic> json) {
    return ExerciseAttempt(
      exerciseId: json['exerciseId'] as String,
      userAnswer: json['userAnswer'] as String,
      isCorrect: json['isCorrect'] as bool,
      attemptedAt: DateTime.parse(json['attemptedAt'] as String),
    );
  }
}

