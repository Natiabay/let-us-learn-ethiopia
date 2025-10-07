import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_assistive_app/features/language/models/lesson.dart';
import 'package:tourist_assistive_app/features/language/models/language_progress.dart';
import 'package:tourist_assistive_app/features/language/services/language_service.dart';

final languageServiceProvider = Provider<LanguageService>((ref) => LanguageService());

final languageLearningProvider = StateNotifierProvider<LanguageLearningNotifier, LanguageProgress>((ref) {
  final languageService = ref.watch(languageServiceProvider);
  return LanguageLearningNotifier(languageService);
});

final lessonsProvider = FutureProvider<List<Lesson>>((ref) async {
  final languageService = ref.watch(languageServiceProvider);
  return await languageService.getLessons();
});

final currentLessonProvider = StateProvider<Lesson?>((ref) => null);

class LanguageLearningNotifier extends StateNotifier<LanguageProgress> {
  final LanguageService _languageService;
  
  LanguageLearningNotifier(this._languageService) : super(
    const LanguageProgress(
      currentLevel: 1,
      totalXP: 0,
      currentXP: 0,
      targetXP: 100,
      streakDays: 0,
      completedLessons: [],
      lastStudyDate: null,
    ),
  ) {
    _loadProgress();
  }
  
  Future<void> _loadProgress() async {
    try {
      final progress = await _languageService.getUserProgress();
      state = progress;
    } catch (e) {
      // Keep default state if loading fails
    }
  }
  
  Future<void> completeLesson(String lessonId, int xpEarned) async {
    final updatedProgress = state.copyWith(
      totalXP: state.totalXP + xpEarned,
      currentXP: state.currentXP + xpEarned,
      completedLessons: [...state.completedLessons, lessonId],
      lastStudyDate: DateTime.now(),
    );
    
    // Check if level up
    if (updatedProgress.currentXP >= updatedProgress.targetXP) {
      final newLevel = updatedProgress.currentLevel + 1;
      final remainingXP = updatedProgress.currentXP - updatedProgress.targetXP;
      final newTargetXP = _calculateTargetXP(newLevel);
      
      state = updatedProgress.copyWith(
        currentLevel: newLevel,
        currentXP: remainingXP,
        targetXP: newTargetXP,
      );
    } else {
      state = updatedProgress;
    }
    
    // Update streak
    _updateStreak();
    
    // Save to backend
    await _languageService.updateUserProgress(state);
  }
  
  void _updateStreak() {
    final now = DateTime.now();
    final lastStudy = state.lastStudyDate;
    
    if (lastStudy == null) {
      state = state.copyWith(streakDays: 1);
    } else {
      final daysDifference = now.difference(lastStudy).inDays;
      
      if (daysDifference == 1) {
        // Consecutive day
        state = state.copyWith(streakDays: state.streakDays + 1);
      } else if (daysDifference > 1) {
        // Streak broken
        state = state.copyWith(streakDays: 1);
      }
      // Same day, keep streak as is
    }
  }
  
  int _calculateTargetXP(int level) {
    return 100 + (level - 1) * 50; // Increasing XP requirement
  }
  
  Future<void> resetProgress() async {
    state = const LanguageProgress(
      currentLevel: 1,
      totalXP: 0,
      currentXP: 0,
      targetXP: 100,
      streakDays: 0,
      completedLessons: [],
      lastStudyDate: null,
    );
    
    await _languageService.updateUserProgress(state);
  }
}




















