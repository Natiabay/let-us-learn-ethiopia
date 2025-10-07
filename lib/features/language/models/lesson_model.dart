import 'word_model.dart';

class Lesson {
  final int id;
  final String title;
  final String description;
  final String category;
  final String difficulty;
  final int estimatedTime; // in minutes
  final int xpReward;
  final List<Word> words;
  final bool isUnlocked;
  final bool isCompleted;
  final double progress; // 0.0 to 1.0

  Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.difficulty,
    required this.estimatedTime,
    required this.xpReward,
    required this.words,
    required this.isUnlocked,
    required this.isCompleted,
    this.progress = 0.0,
  });

  Lesson copyWith({
    int? id,
    String? title,
    String? description,
    String? category,
    String? difficulty,
    int? estimatedTime,
    int? xpReward,
    List<Word>? words,
    bool? isUnlocked,
    bool? isCompleted,
    double? progress,
  }) {
    return Lesson(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      difficulty: difficulty ?? this.difficulty,
      estimatedTime: estimatedTime ?? this.estimatedTime,
      xpReward: xpReward ?? this.xpReward,
      words: words ?? this.words,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      isCompleted: isCompleted ?? this.isCompleted,
      progress: progress ?? this.progress,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'difficulty': difficulty,
      'estimatedTime': estimatedTime,
      'xpReward': xpReward,
      'words': words.map((word) => word.toJson()).toList(),
      'isUnlocked': isUnlocked,
      'isCompleted': isCompleted,
      'progress': progress,
    };
  }

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      difficulty: json['difficulty'],
      estimatedTime: json['estimatedTime'],
      xpReward: json['xpReward'],
      words: (json['words'] as List)
          .map((wordJson) => Word.fromJson(wordJson))
          .toList(),
      isUnlocked: json['isUnlocked'],
      isCompleted: json['isCompleted'],
      progress: json['progress']?.toDouble() ?? 0.0,
    );
  }
}
