enum QuestionType {
  multipleChoice,
  trueFalse,
  fillInBlank,
  fillInTheBlank,
  audioRecognition,
  imageRecognition,
  translation,
  reverseTranslation,
  pronunciation,
  listening,
  speaking,
  writing,
  sentenceCompletion,
  pictureAssociation,
}

class QuizQuestion {
  final String id;
  final QuestionType type;
  final String question;
  final String correctAnswer;
  final List<String> options;
  final String? explanation;
  final String? audioUrl;
  final String? imageUrl;
  final int timeLimit; // in seconds
  final int points;
  final Map<String, dynamic>? metadata;

  QuizQuestion({
    required this.id,
    required this.type,
    required this.question,
    required this.correctAnswer,
    required this.options,
    this.explanation,
    this.audioUrl,
    this.imageUrl,
    this.timeLimit = 30,
    this.points = 10,
    this.metadata,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'question': question,
      'correctAnswer': correctAnswer,
      'options': options,
      'explanation': explanation,
      'audioUrl': audioUrl,
      'imageUrl': imageUrl,
      'timeLimit': timeLimit,
      'points': points,
      'metadata': metadata,
    };
  }

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      id: json['id'],
      type: QuestionType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => QuestionType.multipleChoice,
      ),
      question: json['question'],
      correctAnswer: json['correctAnswer'],
      options: List<String>.from(json['options']),
      explanation: json['explanation'],
      audioUrl: json['audioUrl'],
      imageUrl: json['imageUrl'],
      timeLimit: json['timeLimit'] ?? 30,
      points: json['points'] ?? 10,
      metadata: json['metadata'],
    );
  }
}

class QuizAnswer {
  final String questionId;
  final String answer;
  final bool isCorrect;
  final int timeSpent; // in seconds
  final DateTime timestamp;

  QuizAnswer({
    required this.questionId,
    required this.answer,
    required this.isCorrect,
    required this.timeSpent,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'answer': answer,
      'isCorrect': isCorrect,
      'timeSpent': timeSpent,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory QuizAnswer.fromJson(Map<String, dynamic> json) {
    return QuizAnswer(
      questionId: json['questionId'],
      answer: json['answer'],
      isCorrect: json['isCorrect'],
      timeSpent: json['timeSpent'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}

class QuizResult {
  final int totalQuestions;
  final int correctAnswers;
  final double accuracy;
  final int totalTime; // in seconds
  final double averageTime; // in seconds per question
  final Map<QuestionType, int> typeStats;
  final DateTime timestamp;

  QuizResult({
    required this.totalQuestions,
    required this.correctAnswers,
    required this.accuracy,
    required this.totalTime,
    required this.averageTime,
    required this.typeStats,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'totalQuestions': totalQuestions,
      'correctAnswers': correctAnswers,
      'accuracy': accuracy,
      'totalTime': totalTime,
      'averageTime': averageTime,
      'typeStats': typeStats.map((key, value) => MapEntry(key.name, value)),
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory QuizResult.fromJson(Map<String, dynamic> json) {
    return QuizResult(
      totalQuestions: json['totalQuestions'],
      correctAnswers: json['correctAnswers'],
      accuracy: json['accuracy'].toDouble(),
      totalTime: json['totalTime'],
      averageTime: json['averageTime'].toDouble(),
      typeStats: (json['typeStats'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(
          QuestionType.values.firstWhere((e) => e.name == key),
          value,
        ),
      ),
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
