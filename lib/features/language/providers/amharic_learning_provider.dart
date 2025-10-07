import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_assistive_app/features/language/models/amharic_lesson_model.dart';

class AmharicLearningState {
  final List<AmharicLesson> lessons;
  final int currentStreak;
  final int totalXP;
  final int hearts;
  final bool isLoading;
  final String? error;
  final int currentLessonIndex;

  AmharicLearningState({
    required this.lessons,
    required this.currentStreak,
    required this.totalXP,
    required this.hearts,
    required this.isLoading,
    this.error,
    this.currentLessonIndex = 0,
  });

  AmharicLearningState copyWith({
    List<AmharicLesson>? lessons,
    int? currentStreak,
    int? totalXP,
    int? hearts,
    bool? isLoading,
    String? error,
    int? currentLessonIndex,
  }) {
    return AmharicLearningState(
      lessons: lessons ?? this.lessons,
      currentStreak: currentStreak ?? this.currentStreak,
      totalXP: totalXP ?? this.totalXP,
      hearts: hearts ?? this.hearts,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      currentLessonIndex: currentLessonIndex ?? this.currentLessonIndex,
    );
  }
}

class AmharicLearningNotifier extends StateNotifier<AmharicLearningState> {
  AmharicLearningNotifier() : super(AmharicLearningState(
    lessons: [],
    currentStreak: 0,
    totalXP: 0,
    hearts: 5,
    isLoading: true,
  )) {
    _loadLessons();
  }

  void _loadLessons() {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final lessons = AmharicLessonsData.getLessons();
      state = state.copyWith(
        lessons: lessons,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  void completeLesson(int lessonId, int correctAnswers, int totalQuestions) {
    final accuracy = correctAnswers / totalQuestions;
    final lessonIndex = state.lessons.indexWhere((lesson) => lesson.id == lessonId);
    
    if (lessonIndex == -1) return;
    
    final lesson = state.lessons[lessonIndex];
    final xpEarned = (accuracy * lesson.xpReward).round();
    
    // Update lesson completion
    final updatedLesson = lesson.copyWith(
      isCompleted: true,
      progress: 1.0,
    );
    
    final updatedLessons = List<AmharicLesson>.from(state.lessons);
    updatedLessons[lessonIndex] = updatedLesson;
    
    // Update state
    state = state.copyWith(
      lessons: updatedLessons,
      totalXP: state.totalXP + xpEarned,
      currentStreak: state.currentStreak + 1,
    );
    
    // Unlock next lesson if applicable
    _unlockNextLesson(lessonId);
  }

  void _unlockNextLesson(int completedLessonId) {
    final nextLessonIndex = state.lessons.indexWhere(
      (lesson) => lesson.id == completedLessonId + 1,
    );
    
    if (nextLessonIndex != -1 && !state.lessons[nextLessonIndex].isUnlocked) {
      final updatedLessons = List<AmharicLesson>.from(state.lessons);
      updatedLessons[nextLessonIndex] = updatedLessons[nextLessonIndex].copyWith(
        isUnlocked: true,
      );
      
      state = state.copyWith(lessons: updatedLessons);
    }
  }

  void loseHeart() {
    if (state.hearts > 0) {
      state = state.copyWith(hearts: state.hearts - 1);
    }
  }

  void restoreHearts() {
    state = state.copyWith(hearts: 5);
  }

  void resetStreak() {
    state = state.copyWith(currentStreak: 0);
  }

  AmharicLesson? getLessonById(int id) {
    try {
      return state.lessons.firstWhere((lesson) => lesson.id == id);
    } catch (e) {
      return null;
    }
  }

  List<AmharicLesson> getCompletedLessons() {
    return state.lessons.where((lesson) => lesson.isCompleted).toList();
  }

  List<AmharicLesson> getUnlockedLessons() {
    return state.lessons.where((lesson) => lesson.isUnlocked).toList();
  }

  double getOverallProgress() {
    if (state.lessons.isEmpty) return 0.0;
    
    final completedLessons = state.lessons.where((lesson) => lesson.isCompleted).length;
    return completedLessons / state.lessons.length;
  }

  int getTotalLessons() {
    return state.lessons.length;
  }

  int getCompletedLessonsCount() {
    return state.lessons.where((lesson) => lesson.isCompleted).length;
  }

  void refreshLessons() {
    _loadLessons();
  }
}

final amharicLearningProvider = StateNotifierProvider<AmharicLearningNotifier, AmharicLearningState>((ref) {
  return AmharicLearningNotifier();
});

// Convenience providers
final lessonsProvider = Provider<List<AmharicLesson>>((ref) {
  return ref.watch(amharicLearningProvider).lessons;
});

final currentStreakProvider = Provider<int>((ref) {
  return ref.watch(amharicLearningProvider).currentStreak;
});

final totalXPProvider = Provider<int>((ref) {
  return ref.watch(amharicLearningProvider).totalXP;
});

final heartsProvider = Provider<int>((ref) {
  return ref.watch(amharicLearningProvider).hearts;
});

final overallProgressProvider = Provider<double>((ref) {
  final notifier = ref.read(amharicLearningProvider.notifier);
  return notifier.getOverallProgress();
});

final completedLessonsCountProvider = Provider<int>((ref) {
  final notifier = ref.read(amharicLearningProvider.notifier);
  return notifier.getCompletedLessonsCount();
});

final totalLessonsProvider = Provider<int>((ref) {
  final notifier = ref.read(amharicLearningProvider.notifier);
  return notifier.getTotalLessons();
});
