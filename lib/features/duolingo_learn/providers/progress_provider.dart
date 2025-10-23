import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/models/user_progress_model.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/models/exercise_model.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/services/progress_service.dart';

/// Progress Provider - Manages user progress state
final progressProvider = StateNotifierProvider<ProgressNotifier, UserProgress?>((ref) {
  return ProgressNotifier();
});

class ProgressNotifier extends StateNotifier<UserProgress?> {
  ProgressNotifier() : super(null) {
    _initialize();
  }

  final _progressService = ProgressService();

  /// Initialize and load saved progress
  Future<void> _initialize() async {
    await _progressService.initialize();
    await loadProgress('default_user'); // TODO: Use actual user ID from auth
  }

  /// Load progress from storage
  Future<void> loadProgress(String userId) async {
    final progress = await _progressService.loadProgress(userId);
    
    if (progress != null) {
      state = progress;
    } else {
      // Create new progress for new user
      state = UserProgress.initial(userId);
      await _saveProgress();
    }
  }

  /// Save progress to storage
  Future<void> _saveProgress() async {
    if (state != null) {
      await _progressService.saveProgress(state!);
    }
  }

  /// Add XP to user progress
  Future<void> addXP(int points) async {
    if (state == null) return;
    
    final oldLevel = state!.level;
    state = state!.addXP(points);
    
    // Check if leveled up
    if (state!.level > oldLevel) {
      // TODO: Show level up animation/celebration
      print('🎉 Level Up! Now at level ${state!.level}');
    }
    
    await _saveProgress();
  }

  /// Lose a heart (make a mistake)
  Future<void> loseHeart() async {
    if (state == null) return;
    
    state = state!.loseHeart();
    await _saveProgress();
    
    if (state!.hearts == 0) {
      // TODO: Show "out of hearts" screen
      print('💔 Out of hearts!');
    }
  }

  /// Regenerate a heart
  Future<void> regenerateHeart() async {
    if (state == null || state!.hearts >= state!.maxHearts) return;
    
    state = state!.regenerateHeart();
    await _saveProgress();
  }

  /// Check and regenerate hearts based on time
  Future<void> checkHeartRegeneration() async {
    if (state == null || state!.hearts >= state!.maxHearts) return;
    if (state!.lastHeartRegenTime == null) return;

    final now = DateTime.now();
    final hoursSinceRegen = now.difference(state!.lastHeartRegenTime!).inHours;
    
    // Regenerate 1 heart every 5 hours
    final heartsToRegen = hoursSinceRegen ~/ 5;
    
    if (heartsToRegen > 0) {
      for (var i = 0; i < heartsToRegen; i++) {
        if (state!.hearts < state!.maxHearts) {
          await regenerateHeart();
        }
      }
    }
  }

  /// Complete a lesson
  Future<void> completeLesson({
    required String lessonId,
    required LessonResult result,
  }) async {
    if (state == null) return;

    state = state!.completeLesson(
      lessonId: lessonId,
      xpEarned: result.xpEarned,
      isPerfect: result.isPerfect,
    );

    // Update daily goal
    state = state!.updateDailyGoal(result.xpEarned);

    // Check for achievements
    await _checkAchievements();

    await _saveProgress();

    print('✅ Lesson completed! XP earned: ${result.xpEarned}');
    if (result.isPerfect) {
      print('⭐ Perfect! No mistakes!');
    }
  }

  /// Unlock a category
  Future<void> unlockCategory(String categoryId) async {
    if (state == null) return;
    
    state = state!.unlockCategory(categoryId);
    await _saveProgress();
    print('🔓 Category unlocked: $categoryId');
  }

  /// Check and award achievements
  Future<void> _checkAchievements() async {
    if (state == null) return;

    final achievements = <Achievement>[];

    // First Step - Complete first lesson
    if (state!.totalLessonsCompleted == 1) {
      achievements.add(Achievement(
        id: 'first_step',
        name: 'First Step',
        description: 'Complete your first lesson',
        icon: '🎯',
        xpReward: 10,
        earnedAt: DateTime.now(),
      ));
    }

    // Scholar - 10 lessons
    if (state!.totalLessonsCompleted == 10) {
      achievements.add(Achievement(
        id: 'scholar',
        name: 'Scholar',
        description: 'Complete 10 lessons',
        icon: '📚',
        xpReward: 50,
        earnedAt: DateTime.now(),
      ));
    }

    // Streak Master - 7 day streak
    if (state!.currentStreak == 7) {
      achievements.add(Achievement(
        id: 'streak_master_7',
        name: 'Week Warrior',
        description: '7 day streak',
        icon: '🔥',
        xpReward: 100,
        earnedAt: DateTime.now(),
      ));
    }

    // Perfect - First perfect lesson
    if (state!.perfectLessons == 1) {
      achievements.add(Achievement(
        id: 'perfectionist',
        name: 'Perfectionist',
        description: 'Complete a lesson with no mistakes',
        icon: '⭐',
        xpReward: 25,
        earnedAt: DateTime.now(),
      ));
    }

    // Award achievements
    for (final achievement in achievements) {
      state = state!.addAchievement(achievement);
      state = state!.addXP(achievement.xpReward);
      print('🏆 Achievement unlocked: ${achievement.name}');
    }

    if (achievements.isNotEmpty) {
      await _saveProgress();
    }
  }

  /// Update daily goal
  Future<void> setDailyGoal(int targetXP) async {
    if (state == null) return;

    state = state!.copyWith(
      dailyGoal: DailyGoal(
        targetXP: targetXP,
        currentXP: state!.dailyGoal.currentXP,
        date: DateTime.now(),
      ),
    );

    await _saveProgress();
  }

  /// Reset daily goal (called at start of new day)
  Future<void> resetDailyGoal() async {
    if (state == null) return;

    final now = DateTime.now();
    final goalDate = state!.dailyGoal.date;
    
    // Check if it's a new day
    if (now.day != goalDate.day ||
        now.month != goalDate.month ||
        now.year != goalDate.year) {
      state = state!.copyWith(
        dailyGoal: state!.dailyGoal.reset(),
      );
      await _saveProgress();
      print('🌅 Daily goal reset for new day');
    }
  }

  /// Get progress statistics
  Map<String, dynamic> getStatistics() {
    if (state == null) return {};

    return {
      'level': state!.level,
      'xp': state!.xp,
      'xpForNextLevel': state!.xpForNextLevel,
      'levelProgress': state!.levelProgress,
      'currentStreak': state!.currentStreak,
      'longestStreak': state!.longestStreak,
      'totalLessons': state!.totalLessonsCompleted,
      'perfectLessons': state!.perfectLessons,
      'achievements': state!.achievements.length,
      'dailyGoalProgress': state!.dailyGoal.progress,
      'isDailyGoalMet': state!.isDailyGoalMet,
    };
  }

  /// Reset progress (for testing)
  Future<void> resetProgress(String userId) async {
    state = UserProgress.initial(userId);
    await _saveProgress();
    print('🔄 Progress reset');
  }
}

/// Helper provider to check if hearts are available
final hasHeartsProvider = Provider<bool>((ref) {
  final progress = ref.watch(progressProvider);
  return progress?.canTakeLesson ?? false;
});

/// Helper provider to check if daily goal is met
final isDailyGoalMetProvider = Provider<bool>((ref) {
  final progress = ref.watch(progressProvider);
  return progress?.isDailyGoalMet ?? false;
});

/// Helper provider for current level
final currentLevelProvider = Provider<int>((ref) {
  final progress = ref.watch(progressProvider);
  return progress?.level ?? 1;
});

/// Helper provider for current XP
final currentXPProvider = Provider<int>((ref) {
  final progress = ref.watch(progressProvider);
  return progress?.xp ?? 0;
});

/// Helper provider for current streak
final currentStreakProvider = Provider<int>((ref) {
  final progress = ref.watch(progressProvider);
  return progress?.currentStreak ?? 0;
});

/// Helper provider for hearts count
final heartsProvider = Provider<int>((ref) {
  final progress = ref.watch(progressProvider);
  return progress?.hearts ?? 5;
});

