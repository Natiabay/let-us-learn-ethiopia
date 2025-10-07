import 'package:tourist_assistive_app/features/language/models/achievement_model.dart';

class UserProgress {
  final int level;
  final int currentXP;
  final int totalXP;
  final int streakDays;
  final DateTime? lastStudyDate;
  final int dailyGoal;
  final double weeklyProgress;
  final List<Achievement> achievements;
  final Map<String, int> categoryProgress;
  final int totalLessonsCompleted;
  final int totalWordsLearned;

  UserProgress({
    required this.level,
    required this.currentXP,
    required this.totalXP,
    required this.streakDays,
    this.lastStudyDate,
    required this.dailyGoal,
    required this.weeklyProgress,
    required this.achievements,
    required this.categoryProgress,
    required this.totalLessonsCompleted,
    required this.totalWordsLearned,
  });

  factory UserProgress.initial() {
    return UserProgress(
      level: 1,
      currentXP: 0,
      totalXP: 0,
      streakDays: 0,
      lastStudyDate: null,
      dailyGoal: 50,
      weeklyProgress: 0.0,
      achievements: [],
      categoryProgress: {},
      totalLessonsCompleted: 0,
      totalWordsLearned: 0,
    );
  }

  UserProgress copyWith({
    int? level,
    int? currentXP,
    int? totalXP,
    int? streakDays,
    DateTime? lastStudyDate,
    int? dailyGoal,
    double? weeklyProgress,
    List<Achievement>? achievements,
    Map<String, int>? categoryProgress,
    int? totalLessonsCompleted,
    int? totalWordsLearned,
  }) {
    return UserProgress(
      level: level ?? this.level,
      currentXP: currentXP ?? this.currentXP,
      totalXP: totalXP ?? this.totalXP,
      streakDays: streakDays ?? this.streakDays,
      lastStudyDate: lastStudyDate ?? this.lastStudyDate,
      dailyGoal: dailyGoal ?? this.dailyGoal,
      weeklyProgress: weeklyProgress ?? this.weeklyProgress,
      achievements: achievements ?? this.achievements,
      categoryProgress: categoryProgress ?? this.categoryProgress,
      totalLessonsCompleted: totalLessonsCompleted ?? this.totalLessonsCompleted,
      totalWordsLearned: totalWordsLearned ?? this.totalWordsLearned,
    );
  }

  int get xpNeededForNextLevel {
    return level * 100 - currentXP;
  }

  double get levelProgress {
    final currentLevelXP = (level - 1) * 100;
    final nextLevelXP = level * 100;
    final progressXP = currentXP - currentLevelXP;
    return progressXP / (nextLevelXP - currentLevelXP);
  }

  bool get isDailyGoalReached {
    return currentXP >= dailyGoal;
  }

  Map<String, dynamic> toJson() {
    return {
      'level': level,
      'currentXP': currentXP,
      'totalXP': totalXP,
      'streakDays': streakDays,
      'lastStudyDate': lastStudyDate?.toIso8601String(),
      'dailyGoal': dailyGoal,
      'weeklyProgress': weeklyProgress,
      'achievements': achievements.map((a) => a.toJson()).toList(),
      'categoryProgress': categoryProgress,
      'totalLessonsCompleted': totalLessonsCompleted,
      'totalWordsLearned': totalWordsLearned,
    };
  }

  factory UserProgress.fromJson(Map<String, dynamic> json) {
    return UserProgress(
      level: json['level'] ?? 1,
      currentXP: json['currentXP'] ?? 0,
      totalXP: json['totalXP'] ?? 0,
      streakDays: json['streakDays'] ?? 0,
      lastStudyDate: json['lastStudyDate'] != null 
          ? DateTime.parse(json['lastStudyDate']) 
          : null,
      dailyGoal: json['dailyGoal'] ?? 50,
      weeklyProgress: (json['weeklyProgress'] ?? 0.0).toDouble(),
      achievements: (json['achievements'] as List?)
          ?.map((a) => Achievement.fromJson(a))
          .toList() ?? [],
      categoryProgress: Map<String, int>.from(json['categoryProgress'] ?? {}),
      totalLessonsCompleted: json['totalLessonsCompleted'] ?? 0,
      totalWordsLearned: json['totalWordsLearned'] ?? 0,
    );
  }
}

