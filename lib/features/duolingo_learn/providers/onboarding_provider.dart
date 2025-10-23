import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/models/onboarding_model.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/services/progress_service.dart';

/// Onboarding Provider - Manages onboarding state
final onboardingProvider = StateNotifierProvider<OnboardingNotifier, OnboardingData>((ref) {
  return OnboardingNotifier();
});

class OnboardingNotifier extends StateNotifier<OnboardingData> {
  OnboardingNotifier() : super(const OnboardingData()) {
    _initialize();
  }

  final _progressService = ProgressService();

  /// Initialize and load saved onboarding data
  Future<void> _initialize() async {
    await _progressService.initialize();
    await loadOnboardingData();
  }

  /// Load onboarding data from storage
  Future<void> loadOnboardingData() async {
    final data = await _progressService.loadOnboardingData();
    if (data != null) {
      state = data;
    }
  }

  /// Save onboarding data
  Future<void> _save() async {
    await _progressService.saveOnboardingData(state);
  }

  /// Set native language
  Future<void> setNativeLanguage(String language, String languageCode) async {
    state = state.copyWith(
      nativeLanguage: language,
      nativeLanguageCode: languageCode,
    );
    await _save();
  }

  /// Set proficiency level
  Future<void> setProficiencyLevel(String level) async {
    state = state.copyWith(proficiencyLevel: level);
    await _save();
  }

  /// Add learning goal
  Future<void> addLearningGoal(String goalId) async {
    if (state.learningGoals.contains(goalId)) return;
    
    state = state.copyWith(
      learningGoals: [...state.learningGoals, goalId],
    );
    await _save();
  }

  /// Remove learning goal
  Future<void> removeLearningGoal(String goalId) async {
    state = state.copyWith(
      learningGoals: state.learningGoals.where((g) => g != goalId).toList(),
    );
    await _save();
  }

  /// Set learning goals (replace all)
  Future<void> setLearningGoals(List<String> goals) async {
    state = state.copyWith(learningGoals: goals);
    await _save();
  }

  /// Toggle transliteration
  Future<void> toggleTransliteration(bool enabled) async {
    state = state.copyWith(showTransliteration: enabled);
    await _save();
  }

  /// Toggle subtitles
  Future<void> toggleSubtitles(bool enabled) async {
    state = state.copyWith(enableSubtitles: enabled);
    await _save();
  }

  /// Set daily goal XP
  Future<void> setDailyGoalXP(int xp) async {
    state = state.copyWith(dailyGoalXP: xp);
    await _save();
  }

  /// Toggle notifications
  Future<void> toggleNotifications(bool enabled) async {
    state = state.copyWith(notificationsEnabled: enabled);
    await _save();
  }

  /// Set preferred voice
  Future<void> setPreferredVoice(String voice) async {
    state = state.copyWith(preferredVoice: voice);
    await _save();
  }

  /// Complete onboarding
  Future<void> completeOnboarding() async {
    state = state.copyWith(isComplete: true);
    await _save();
    print('✅ Onboarding completed');
  }

  /// Reset onboarding (for testing)
  Future<void> resetOnboarding() async {
    state = const OnboardingData();
    await _save();
    print('🔄 Onboarding reset');
  }

  /// Get recommended starting category based on proficiency
  String getRecommendedCategory() {
    switch (state.proficiencyLevel) {
      case 'beginner':
        return 'basics';
      case 'intermediate':
        return 'conversation';
      case 'advanced':
        return 'advanced_topics';
      default:
        return 'basics';
    }
  }

  /// Get recommended lessons based on learning goals
  List<String> getRecommendedLessons() {
    final lessons = <String>[];

    for (final goal in state.learningGoals) {
      switch (goal) {
        case 'tourism':
          lessons.addAll(['travel_basics', 'directions', 'hotel', 'restaurant']);
          break;
        case 'business':
          lessons.addAll(['business_greetings', 'numbers', 'time']);
          break;
        case 'culture':
          lessons.addAll(['culture_intro', 'traditions', 'history']);
          break;
        case 'conversation':
          lessons.addAll(['greetings', 'introductions', 'daily_phrases']);
          break;
        case 'family':
          lessons.addAll(['family_members', 'relationships', 'home']);
          break;
        default:
          lessons.add('basics');
      }
    }

    return lessons.toSet().toList(); // Remove duplicates
  }
}

/// Helper provider to check if onboarding is complete
final isOnboardingCompleteProvider = Provider<bool>((ref) {
  final onboarding = ref.watch(onboardingProvider);
  return onboarding.isComplete;
});

/// Helper provider for proficiency level
final proficiencyLevelProvider = Provider<String>((ref) {
  final onboarding = ref.watch(onboardingProvider);
  return onboarding.proficiencyLevel;
});

/// Helper provider for native language
final nativeLanguageProvider = Provider<String>((ref) {
  final onboarding = ref.watch(onboardingProvider);
  return onboarding.nativeLanguage;
});

/// Helper provider for daily goal XP
final dailyGoalXPProvider = Provider<int>((ref) {
  final onboarding = ref.watch(onboardingProvider);
  return onboarding.dailyGoalXP;
});

