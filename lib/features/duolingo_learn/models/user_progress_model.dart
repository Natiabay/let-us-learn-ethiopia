import 'package:flutter/foundation.dart';

/// User Progress Model - Tracks all gamification elements
/// XP, Level, Streak, Hearts, Achievements, Daily Goals
class UserProgress {
  final String userId;
  final int xp;
  final int level;
  final int currentStreak;
  final int longestStreak;
  final int hearts;
  final int maxHearts;
  final DateTime? lastHeartRegenTime;
  final DateTime? lastLessonDate;
  final List<String> completedLessons;
  final List<String> unlockedCategories;
  final List<Achievement> achievements;
  final int totalLessonsCompleted;
  final int perfectLessons;
  final DailyGoal dailyGoal;
  final Map<String, int> categoryProgress; // categoryId -> completed lessons count
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserProgress({
    required this.userId,
    this.xp = 0,
    this.level = 1,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.hearts = 5,
    this.maxHearts = 5,
    this.lastHeartRegenTime,
    this.lastLessonDate,
    this.completedLessons = const [],
    this.unlockedCategories = const ['basics'], // Start with basics unlocked
    this.achievements = const [],
    this.totalLessonsCompleted = 0,
    this.perfectLessons = 0,
    required this.dailyGoal,
    this.categoryProgress = const {},
    required this.createdAt,
    required this.updatedAt,
  });

  /// Calculate XP needed for next level
  int get xpForNextLevel => level * 100;

  /// Calculate progress to next level (0.0 to 1.0)
  double get levelProgress {
    final xpInCurrentLevel = xp - ((level - 1) * 100);
    return (xpInCurrentLevel / xpForNextLevel).clamp(0.0, 1.0);
  }

  /// Check if user can take a lesson (has hearts)
  bool get canTakeLesson => hearts > 0;

  /// Check if streak is active (completed lesson today)
  bool get isStreakActive {
    if (lastLessonDate == null) return false;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final lastLesson = DateTime(
      lastLessonDate!.year,
      lastLessonDate!.month,
      lastLessonDate!.day,
    );
    return today.difference(lastLesson).inDays == 0;
  }

  /// Check if daily goal is met
  bool get isDailyGoalMet => dailyGoal.currentXP >= dailyGoal.targetXP;

  /// Copy with method for immutability
  UserProgress copyWith({
    String? userId,
    int? xp,
    int? level,
    int? currentStreak,
    int? longestStreak,
    int? hearts,
    int? maxHearts,
    DateTime? lastHeartRegenTime,
    DateTime? lastLessonDate,
    List<String>? completedLessons,
    List<String>? unlockedCategories,
    List<Achievement>? achievements,
    int? totalLessonsCompleted,
    int? perfectLessons,
    DailyGoal? dailyGoal,
    Map<String, int>? categoryProgress,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserProgress(
      userId: userId ?? this.userId,
      xp: xp ?? this.xp,
      level: level ?? this.level,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      hearts: hearts ?? this.hearts,
      maxHearts: maxHearts ?? this.maxHearts,
      lastHeartRegenTime: lastHeartRegenTime ?? this.lastHeartRegenTime,
      lastLessonDate: lastLessonDate ?? this.lastLessonDate,
      completedLessons: completedLessons ?? this.completedLessons,
      unlockedCategories: unlockedCategories ?? this.unlockedCategories,
      achievements: achievements ?? this.achievements,
      totalLessonsCompleted: totalLessonsCompleted ?? this.totalLessonsCompleted,
      perfectLessons: perfectLessons ?? this.perfectLessons,
      dailyGoal: dailyGoal ?? this.dailyGoal,
      categoryProgress: categoryProgress ?? this.categoryProgress,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Add XP and handle level up
  UserProgress addXP(int points) {
    final newXP = xp + points;
    final newLevel = (newXP ~/ 100) + 1;
    final leveledUp = newLevel > level;

    return copyWith(
      xp: newXP,
      level: newLevel,
      updatedAt: DateTime.now(),
    );
  }

  /// Lose a heart (make a mistake)
  UserProgress loseHeart() {
    if (hearts <= 0) return this;
    return copyWith(
      hearts: hearts - 1,
      lastHeartRegenTime: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  /// Regenerate a heart (every 5 hours)
  UserProgress regenerateHeart() {
    if (hearts >= maxHearts) return this;
    return copyWith(
      hearts: hearts + 1,
      lastHeartRegenTime: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  /// Complete a lesson
  UserProgress completeLesson({
    required String lessonId,
    required int xpEarned,
    required bool isPerfect,
  }) {
    final now = DateTime.now();
    final newCompletedLessons = [...completedLessons, lessonId];
    
    // Update streak
    int newStreak = currentStreak;
    if (lastLessonDate != null) {
      final lastDay = DateTime(
        lastLessonDate!.year,
        lastLessonDate!.month,
        lastLessonDate!.day,
      );
      final today = DateTime(now.year, now.month, now.day);
      final daysDiff = today.difference(lastDay).inDays;
      
      if (daysDiff == 0) {
        // Same day, streak continues
        newStreak = currentStreak;
      } else if (daysDiff == 1) {
        // Next day, increment streak
        newStreak = currentStreak + 1;
      } else {
        // Streak broken
        newStreak = 1;
      }
    } else {
      // First lesson
      newStreak = 1;
    }

    final newLongestStreak = newStreak > longestStreak ? newStreak : longestStreak;

    return copyWith(
      completedLessons: newCompletedLessons,
      totalLessonsCompleted: totalLessonsCompleted + 1,
      perfectLessons: isPerfect ? perfectLessons + 1 : perfectLessons,
      currentStreak: newStreak,
      longestStreak: newLongestStreak,
      lastLessonDate: now,
      updatedAt: now,
    ).addXP(xpEarned);
  }

  /// Unlock a category
  UserProgress unlockCategory(String categoryId) {
    if (unlockedCategories.contains(categoryId)) return this;
    return copyWith(
      unlockedCategories: [...unlockedCategories, categoryId],
      updatedAt: DateTime.now(),
    );
  }

  /// Add an achievement
  UserProgress addAchievement(Achievement achievement) {
    if (achievements.any((a) => a.id == achievement.id)) return this;
    return copyWith(
      achievements: [...achievements, achievement],
      updatedAt: DateTime.now(),
    );
  }

  /// Update daily goal progress
  UserProgress updateDailyGoal(int xpEarned) {
    return copyWith(
      dailyGoal: dailyGoal.addXP(xpEarned),
      updatedAt: DateTime.now(),
    );
  }

  /// Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'xp': xp,
      'level': level,
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'hearts': hearts,
      'maxHearts': maxHearts,
      'lastHeartRegenTime': lastHeartRegenTime?.toIso8601String(),
      'lastLessonDate': lastLessonDate?.toIso8601String(),
      'completedLessons': completedLessons,
      'unlockedCategories': unlockedCategories,
      'achievements': achievements.map((a) => a.toJson()).toList(),
      'totalLessonsCompleted': totalLessonsCompleted,
      'perfectLessons': perfectLessons,
      'dailyGoal': dailyGoal.toJson(),
      'categoryProgress': categoryProgress,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  /// Create from JSON
  factory UserProgress.fromJson(Map<String, dynamic> json) {
    return UserProgress(
      userId: json['userId'] as String,
      xp: json['xp'] as int? ?? 0,
      level: json['level'] as int? ?? 1,
      currentStreak: json['currentStreak'] as int? ?? 0,
      longestStreak: json['longestStreak'] as int? ?? 0,
      hearts: json['hearts'] as int? ?? 5,
      maxHearts: json['maxHearts'] as int? ?? 5,
      lastHeartRegenTime: json['lastHeartRegenTime'] != null
          ? DateTime.parse(json['lastHeartRegenTime'] as String)
          : null,
      lastLessonDate: json['lastLessonDate'] != null
          ? DateTime.parse(json['lastLessonDate'] as String)
          : null,
      completedLessons: (json['completedLessons'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      unlockedCategories: (json['unlockedCategories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          ['basics'],
      achievements: (json['achievements'] as List<dynamic>?)
              ?.map((e) => Achievement.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      totalLessonsCompleted: json['totalLessonsCompleted'] as int? ?? 0,
      perfectLessons: json['perfectLessons'] as int? ?? 0,
      dailyGoal: json['dailyGoal'] != null
          ? DailyGoal.fromJson(json['dailyGoal'] as Map<String, dynamic>)
          : DailyGoal.basic(),
      categoryProgress: (json['categoryProgress'] as Map<String, dynamic>?)
              ?.map((k, v) => MapEntry(k, v as int)) ??
          {},
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : DateTime.now(),
    );
  }

  /// Create initial progress for new user
  factory UserProgress.initial(String userId) {
    final now = DateTime.now();
    return UserProgress(
      userId: userId,
      dailyGoal: DailyGoal.basic(),
      createdAt: now,
      updatedAt: now,
    );
  }
}

/// Achievement Model
class Achievement {
  final String id;
  final String name;
  final String description;
  final String icon;
  final int xpReward;
  final DateTime earnedAt;

  const Achievement({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    this.xpReward = 0,
    required this.earnedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'icon': icon,
      'xpReward': xpReward,
      'earnedAt': earnedAt.toIso8601String(),
    };
  }

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
      xpReward: json['xpReward'] as int? ?? 0,
      earnedAt: DateTime.parse(json['earnedAt'] as String),
    );
  }
}

/// Daily Goal Model
class DailyGoal {
  final int targetXP;
  final int currentXP;
  final DateTime date;

  const DailyGoal({
    required this.targetXP,
    this.currentXP = 0,
    required this.date,
  });

  /// Progress percentage (0.0 to 1.0)
  double get progress => (currentXP / targetXP).clamp(0.0, 1.0);

  /// Is goal completed?
  bool get isCompleted => currentXP >= targetXP;

  /// Add XP to daily goal
  DailyGoal addXP(int points) {
    return DailyGoal(
      targetXP: targetXP,
      currentXP: currentXP + points,
      date: date,
    );
  }

  /// Reset daily goal for new day
  DailyGoal reset() {
    return DailyGoal(
      targetXP: targetXP,
      currentXP: 0,
      date: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'targetXP': targetXP,
      'currentXP': currentXP,
      'date': date.toIso8601String(),
    };
  }

  factory DailyGoal.fromJson(Map<String, dynamic> json) {
    return DailyGoal(
      targetXP: json['targetXP'] as int,
      currentXP: json['currentXP'] as int? ?? 0,
      date: DateTime.parse(json['date'] as String),
    );
  }

  /// Basic daily goal (20 XP - about 1-2 lessons)
  factory DailyGoal.basic() {
    return DailyGoal(
      targetXP: 20,
      date: DateTime.now(),
    );
  }

  /// Regular daily goal (50 XP - about 3-4 lessons)
  factory DailyGoal.regular() {
    return DailyGoal(
      targetXP: 50,
      date: DateTime.now(),
    );
  }

  /// Serious daily goal (100 XP - about 6-7 lessons)
  factory DailyGoal.serious() {
    return DailyGoal(
      targetXP: 100,
      date: DateTime.now(),
    );
  }

  /// Intense daily goal (200 XP - about 13-14 lessons)
  factory DailyGoal.intense() {
    return DailyGoal(
      targetXP: 200,
      date: DateTime.now(),
    );
  }
}

