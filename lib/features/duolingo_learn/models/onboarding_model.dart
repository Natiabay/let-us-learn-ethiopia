/// Onboarding Data Model - Stores user preferences collected during onboarding
class OnboardingData {
  final String nativeLanguage;
  final String nativeLanguageCode;
  final String proficiencyLevel;
  final List<String> learningGoals;
  final bool showTransliteration;
  final bool enableSubtitles;
  final int dailyGoalXP;
  final bool notificationsEnabled;
  final String preferredVoice; // male/female
  final bool isComplete;

  const OnboardingData({
    this.nativeLanguage = 'English',
    this.nativeLanguageCode = 'en-US',
    this.proficiencyLevel = 'beginner',
    this.learningGoals = const [],
    this.showTransliteration = true,
    this.enableSubtitles = true,
    this.dailyGoalXP = 20,
    this.notificationsEnabled = true,
    this.preferredVoice = 'female',
    this.isComplete = false,
  });

  /// Copy with method
  OnboardingData copyWith({
    String? nativeLanguage,
    String? nativeLanguageCode,
    String? proficiencyLevel,
    List<String>? learningGoals,
    bool? showTransliteration,
    bool? enableSubtitles,
    int? dailyGoalXP,
    bool? notificationsEnabled,
    String? preferredVoice,
    bool? isComplete,
  }) {
    return OnboardingData(
      nativeLanguage: nativeLanguage ?? this.nativeLanguage,
      nativeLanguageCode: nativeLanguageCode ?? this.nativeLanguageCode,
      proficiencyLevel: proficiencyLevel ?? this.proficiencyLevel,
      learningGoals: learningGoals ?? this.learningGoals,
      showTransliteration: showTransliteration ?? this.showTransliteration,
      enableSubtitles: enableSubtitles ?? this.enableSubtitles,
      dailyGoalXP: dailyGoalXP ?? this.dailyGoalXP,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      preferredVoice: preferredVoice ?? this.preferredVoice,
      isComplete: isComplete ?? this.isComplete,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'nativeLanguage': nativeLanguage,
      'nativeLanguageCode': nativeLanguageCode,
      'proficiencyLevel': proficiencyLevel,
      'learningGoals': learningGoals,
      'showTransliteration': showTransliteration,
      'enableSubtitles': enableSubtitles,
      'dailyGoalXP': dailyGoalXP,
      'notificationsEnabled': notificationsEnabled,
      'preferredVoice': preferredVoice,
      'isComplete': isComplete,
    };
  }

  /// Create from JSON
  factory OnboardingData.fromJson(Map<String, dynamic> json) {
    return OnboardingData(
      nativeLanguage: json['nativeLanguage'] as String? ?? 'English',
      nativeLanguageCode: json['nativeLanguageCode'] as String? ?? 'en-US',
      proficiencyLevel: json['proficiencyLevel'] as String? ?? 'beginner',
      learningGoals: (json['learningGoals'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      showTransliteration: json['showTransliteration'] as bool? ?? true,
      enableSubtitles: json['enableSubtitles'] as bool? ?? true,
      dailyGoalXP: json['dailyGoalXP'] as int? ?? 20,
      notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
      preferredVoice: json['preferredVoice'] as String? ?? 'female',
      isComplete: json['isComplete'] as bool? ?? false,
    );
  }
}

/// Supported Native Languages for Onboarding
class SupportedLanguage {
  final String name;
  final String code;
  final String flag;

  const SupportedLanguage({
    required this.name,
    required this.code,
    required this.flag,
  });

  /// List of supported languages
  static const List<SupportedLanguage> all = [
    SupportedLanguage(name: 'English (US)', code: 'en-US', flag: '🇺🇸'),
    SupportedLanguage(name: 'English (UK)', code: 'en-GB', flag: '🇬🇧'),
    SupportedLanguage(name: 'Spanish', code: 'es-ES', flag: '🇪🇸'),
    SupportedLanguage(name: 'French', code: 'fr-FR', flag: '🇫🇷'),
    SupportedLanguage(name: 'German', code: 'de-DE', flag: '🇩🇪'),
    SupportedLanguage(name: 'Chinese', code: 'zh-CN', flag: '🇨🇳'),
    SupportedLanguage(name: 'Arabic', code: 'ar-SA', flag: '🇸🇦'),
    SupportedLanguage(name: 'Portuguese', code: 'pt-BR', flag: '🇧🇷'),
    SupportedLanguage(name: 'Italian', code: 'it-IT', flag: '🇮🇹'),
    SupportedLanguage(name: 'Japanese', code: 'ja-JP', flag: '🇯🇵'),
    SupportedLanguage(name: 'Russian', code: 'ru-RU', flag: '🇷🇺'),
  ];
}

/// Learning Goals
class LearningGoal {
  final String id;
  final String name;
  final String icon;
  final String description;

  const LearningGoal({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
  });

  /// Predefined learning goals
  static const List<LearningGoal> all = [
    LearningGoal(
      id: 'tourism',
      name: 'Tourism & Travel',
      icon: '✈️',
      description: 'Learn phrases for traveling in Ethiopia',
    ),
    LearningGoal(
      id: 'business',
      name: 'Business',
      icon: '💼',
      description: 'Professional communication in Amharic',
    ),
    LearningGoal(
      id: 'culture',
      name: 'Culture & History',
      icon: '🏛️',
      description: 'Understand Ethiopian culture and traditions',
    ),
    LearningGoal(
      id: 'conversation',
      name: 'Daily Conversation',
      icon: '💬',
      description: 'Everyday communication skills',
    ),
    LearningGoal(
      id: 'family',
      name: 'Family & Friends',
      icon: '👨‍👩‍👧‍👦',
      description: 'Connect with Ethiopian friends and family',
    ),
    LearningGoal(
      id: 'general',
      name: 'General Learning',
      icon: '📚',
      description: 'Learn for personal enrichment',
    ),
  ];
}

/// Proficiency Levels
class ProficiencyLevel {
  final String id;
  final String name;
  final String description;

  const ProficiencyLevel({
    required this.id,
    required this.name,
    required this.description,
  });

  /// Predefined proficiency levels
  static const List<ProficiencyLevel> all = [
    ProficiencyLevel(
      id: 'beginner',
      name: 'Beginner',
      description: 'I\'m new to Amharic',
    ),
    ProficiencyLevel(
      id: 'intermediate',
      name: 'Intermediate',
      description: 'I know some Amharic',
    ),
    ProficiencyLevel(
      id: 'advanced',
      name: 'Advanced',
      description: 'I can hold conversations in Amharic',
    ),
  ];
}

