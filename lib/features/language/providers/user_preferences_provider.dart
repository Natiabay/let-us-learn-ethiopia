import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// User preferences provider for managing app settings and onboarding state
final userPreferencesProvider = StateNotifierProvider<UserPreferencesNotifier, UserPreferences>((ref) {
  return UserPreferencesNotifier();
});

class UserPreferences {
  final bool hasCompletedOnboarding;
  final String selectedLanguage;
  final bool notificationsEnabled;
  final bool darkModeEnabled;
  final int dailyGoal;
  final List<String> favoriteCategories;
  final DateTime? lastActiveDate;

  const UserPreferences({
    this.hasCompletedOnboarding = false,
    this.selectedLanguage = 'en',
    this.notificationsEnabled = true,
    this.darkModeEnabled = true,
    this.dailyGoal = 20,
    this.favoriteCategories = const [],
    this.lastActiveDate,
  });

  UserPreferences copyWith({
    bool? hasCompletedOnboarding,
    String? selectedLanguage,
    bool? notificationsEnabled,
    bool? darkModeEnabled,
    int? dailyGoal,
    List<String>? favoriteCategories,
    DateTime? lastActiveDate,
  }) {
    return UserPreferences(
      hasCompletedOnboarding: hasCompletedOnboarding ?? this.hasCompletedOnboarding,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      darkModeEnabled: darkModeEnabled ?? this.darkModeEnabled,
      dailyGoal: dailyGoal ?? this.dailyGoal,
      favoriteCategories: favoriteCategories ?? this.favoriteCategories,
      lastActiveDate: lastActiveDate ?? this.lastActiveDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hasCompletedOnboarding': hasCompletedOnboarding,
      'selectedLanguage': selectedLanguage,
      'notificationsEnabled': notificationsEnabled,
      'darkModeEnabled': darkModeEnabled,
      'dailyGoal': dailyGoal,
      'favoriteCategories': favoriteCategories,
      'lastActiveDate': lastActiveDate?.toIso8601String(),
    };
  }

  factory UserPreferences.fromJson(Map<String, dynamic> json) {
    return UserPreferences(
      hasCompletedOnboarding: json['hasCompletedOnboarding'] ?? false,
      selectedLanguage: json['selectedLanguage'] ?? 'en',
      notificationsEnabled: json['notificationsEnabled'] ?? true,
      darkModeEnabled: json['darkModeEnabled'] ?? true,
      dailyGoal: json['dailyGoal'] ?? 20,
      favoriteCategories: List<String>.from(json['favoriteCategories'] ?? []),
      lastActiveDate: json['lastActiveDate'] != null 
          ? DateTime.parse(json['lastActiveDate']) 
          : null,
    );
  }
}

class UserPreferencesNotifier extends StateNotifier<UserPreferences> {
  UserPreferencesNotifier() : super(const UserPreferences()) {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final preferencesJson = prefs.getString('user_preferences');
      
      if (preferencesJson != null) {
        final preferences = UserPreferences.fromJson(
          Map<String, dynamic>.from(
            Uri.splitQueryString(preferencesJson)
          )
        );
        state = preferences;
      }
    } catch (e) {
      // Keep default state if loading fails
    }
  }

  Future<void> _savePreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final preferencesJson = state.toJson().entries
          .map((e) => '${e.key}=${e.value}')
          .join('&');
      await prefs.setString('user_preferences', preferencesJson);
    } catch (e) {
      // Handle error silently
    }
  }

  Future<void> completeOnboarding() async {
    state = state.copyWith(
      hasCompletedOnboarding: true,
      lastActiveDate: DateTime.now(),
    );
    await _savePreferences();
  }

  Future<void> setLanguage(String language) async {
    state = state.copyWith(selectedLanguage: language);
    await _savePreferences();
  }

  Future<void> setNotificationsEnabled(bool enabled) async {
    state = state.copyWith(notificationsEnabled: enabled);
    await _savePreferences();
  }

  Future<void> setDarkModeEnabled(bool enabled) async {
    state = state.copyWith(darkModeEnabled: enabled);
    await _savePreferences();
  }

  Future<void> setDailyGoal(int goal) async {
    state = state.copyWith(dailyGoal: goal);
    await _savePreferences();
  }

  Future<void> addFavoriteCategory(String category) async {
    final updatedCategories = List<String>.from(state.favoriteCategories);
    if (!updatedCategories.contains(category)) {
      updatedCategories.add(category);
      state = state.copyWith(favoriteCategories: updatedCategories);
      await _savePreferences();
    }
  }

  Future<void> removeFavoriteCategory(String category) async {
    final updatedCategories = List<String>.from(state.favoriteCategories);
    updatedCategories.remove(category);
    state = state.copyWith(favoriteCategories: updatedCategories);
    await _savePreferences();
  }

  Future<void> updateLastActiveDate() async {
    state = state.copyWith(lastActiveDate: DateTime.now());
    await _savePreferences();
  }

  Future<void> resetPreferences() async {
    state = const UserPreferences();
    await _savePreferences();
  }
}

