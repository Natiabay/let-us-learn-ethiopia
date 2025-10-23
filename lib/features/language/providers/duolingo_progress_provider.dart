import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for Duolingo-style progress tracking
final duolingoProgressProvider = StateNotifierProvider<DuolingoProgressNotifier, DuolingoProgress>((ref) {
  return DuolingoProgressNotifier();
});

class DuolingoProgress {
  final int totalXP;
  final int currentXP;
  final int targetXP;
  final int streakDays;
  final bool isStreakActive;
  final int level;
  final int completedLessons;
  final int totalLessons;
  final DateTime? lastPracticeDate;
  final Map<String, int> categoryXP;

  DuolingoProgress({
    this.totalXP = 0,
    this.currentXP = 0,
    this.targetXP = 100,
    this.streakDays = 0,
    this.isStreakActive = false,
    this.level = 1,
    this.completedLessons = 0,
    this.totalLessons = 50,
    this.lastPracticeDate,
    this.categoryXP = const {},
  });

  double get progressPercentage => currentXP / targetXP;

  DuolingoProgress copyWith({
    int? totalXP,
    int? currentXP,
    int? targetXP,
    int? streakDays,
    bool? isStreakActive,
    int? level,
    int? completedLessons,
    int? totalLessons,
    DateTime? lastPracticeDate,
    Map<String, int>? categoryXP,
  }) {
    return DuolingoProgress(
      totalXP: totalXP ?? this.totalXP,
      currentXP: currentXP ?? this.currentXP,
      targetXP: targetXP ?? this.targetXP,
      streakDays: streakDays ?? this.streakDays,
      isStreakActive: isStreakActive ?? this.isStreakActive,
      level: level ?? this.level,
      completedLessons: completedLessons ?? this.completedLessons,
      totalLessons: totalLessons ?? this.totalLessons,
      lastPracticeDate: lastPracticeDate ?? this.lastPracticeDate,
      categoryXP: categoryXP ?? this.categoryXP,
    );
  }
}

class DuolingoProgressNotifier extends StateNotifier<DuolingoProgress> {
  DuolingoProgressNotifier() : super(DuolingoProgress()) {
    _initializeProgress();
  }

  void _initializeProgress() {
    // Initialize with default progress
    state = DuolingoProgress(
      totalXP: 0,
      currentXP: 0,
      targetXP: 100,
      streakDays: 0,
      isStreakActive: false,
      level: 1,
      completedLessons: 0,
      totalLessons: 50,
      categoryXP: {},
    );
  }

  void addXP(int xp, {String? category}) {
    final newTotalXP = state.totalXP + xp;
    final newCurrentXP = state.currentXP + xp;
    
    // Check if level up
    if (newCurrentXP >= state.targetXP) {
      final newLevel = state.level + 1;
      final remainingXP = newCurrentXP - state.targetXP;
      final newTargetXP = _calculateTargetXP(newLevel);
      
      state = state.copyWith(
        totalXP: newTotalXP,
        currentXP: remainingXP,
        targetXP: newTargetXP,
        level: newLevel,
        lastPracticeDate: DateTime.now(),
      );
    } else {
      state = state.copyWith(
        totalXP: newTotalXP,
        currentXP: newCurrentXP,
        lastPracticeDate: DateTime.now(),
      );
    }
    
    // Update category XP if provided
    if (category != null) {
      final categoryXP = Map<String, int>.from(state.categoryXP);
      categoryXP[category] = (categoryXP[category] ?? 0) + xp;
      state = state.copyWith(categoryXP: categoryXP);
    }
    
    _updateStreak();
  }

  void completeLesson() {
    state = state.copyWith(
      completedLessons: state.completedLessons + 1,
      lastPracticeDate: DateTime.now(),
    );
    _updateStreak();
  }

  void _updateStreak() {
    final now = DateTime.now();
    final lastPractice = state.lastPracticeDate;
    
    if (lastPractice == null) {
      state = state.copyWith(
        streakDays: 1,
        isStreakActive: true,
      );
      return;
    }
    
    final daysSinceLastPractice = now.difference(lastPractice).inDays;
    
    if (daysSinceLastPractice == 0) {
      // Same day, maintain streak
      state = state.copyWith(isStreakActive: true);
    } else if (daysSinceLastPractice == 1) {
      // Next day, increment streak
      state = state.copyWith(
        streakDays: state.streakDays + 1,
        isStreakActive: true,
      );
    } else {
      // Streak broken
      state = state.copyWith(
        streakDays: 0,
        isStreakActive: false,
      );
    }
  }

  int _calculateTargetXP(int level) {
    // Progressive XP requirements: 100, 150, 200, 250, etc.
    return 100 + (level - 1) * 50;
  }

  void resetProgress() {
    _initializeProgress();
  }

  void loadProgress(DuolingoProgress progress) {
    state = progress;
    _updateStreak();
  }
}




