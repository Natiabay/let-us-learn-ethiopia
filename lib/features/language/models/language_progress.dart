class LanguageProgress {
  final int currentLevel;
  final int totalXP;
  final int currentXP;
  final int targetXP;
  final int streakDays;
  final List<String> completedLessons;
  final DateTime? lastStudyDate;
  final Map<String, int> skillLevels;
  final List<Achievement> achievements;

  const LanguageProgress({
    required this.currentLevel,
    required this.totalXP,
    required this.currentXP,
    required this.targetXP,
    required this.streakDays,
    required this.completedLessons,
    this.lastStudyDate,
    this.skillLevels = const {},
    this.achievements = const [],
  });

  LanguageProgress copyWith({
    int? currentLevel,
    int? totalXP,
    int? currentXP,
    int? targetXP,
    int? streakDays,
    List<String>? completedLessons,
    DateTime? lastStudyDate,
    Map<String, int>? skillLevels,
    List<Achievement>? achievements,
  }) {
    return LanguageProgress(
      currentLevel: currentLevel ?? this.currentLevel,
      totalXP: totalXP ?? this.totalXP,
      currentXP: currentXP ?? this.currentXP,
      targetXP: targetXP ?? this.targetXP,
      streakDays: streakDays ?? this.streakDays,
      completedLessons: completedLessons ?? this.completedLessons,
      lastStudyDate: lastStudyDate ?? this.lastStudyDate,
      skillLevels: skillLevels ?? this.skillLevels,
      achievements: achievements ?? this.achievements,
    );
  }

  double get progressPercentage {
    if (targetXP <= 0) return 0.0;
    return (currentXP / targetXP).clamp(0.0, 1.0);
  }

  Map<String, dynamic> toMap() {
    return {
      'currentLevel': currentLevel,
      'totalXP': totalXP,
      'currentXP': currentXP,
      'targetXP': targetXP,
      'streakDays': streakDays,
      'completedLessons': completedLessons,
      'lastStudyDate': lastStudyDate?.toIso8601String(),
      'skillLevels': skillLevels,
      'achievements': achievements.map((x) => x.toMap()).toList(),
    };
  }

  factory LanguageProgress.fromMap(Map<String, dynamic> map) {
    return LanguageProgress(
      currentLevel: map['currentLevel']?.toInt() ?? 1,
      totalXP: map['totalXP']?.toInt() ?? 0,
      currentXP: map['currentXP']?.toInt() ?? 0,
      targetXP: map['targetXP']?.toInt() ?? 100,
      streakDays: map['streakDays']?.toInt() ?? 0,
      completedLessons: List<String>.from(map['completedLessons'] ?? []),
      lastStudyDate: map['lastStudyDate'] != null 
          ? DateTime.parse(map['lastStudyDate']) 
          : null,
      skillLevels: Map<String, int>.from(map['skillLevels'] ?? {}),
      achievements: List<Achievement>.from(
        map['achievements']?.map((x) => Achievement.fromMap(x)) ?? [],
      ),
    );
  }
}

class Achievement {
  final String id;
  final String title;
  final String description;
  final String iconPath;
  final DateTime unlockedAt;
  final AchievementType type;
  final int xpReward;

  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.iconPath,
    required this.unlockedAt,
    required this.type,
    required this.xpReward,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'iconPath': iconPath,
      'unlockedAt': unlockedAt.toIso8601String(),
      'type': type.name,
      'xpReward': xpReward,
    };
  }

  factory Achievement.fromMap(Map<String, dynamic> map) {
    return Achievement(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      iconPath: map['iconPath'] ?? '',
      unlockedAt: DateTime.parse(map['unlockedAt']),
      type: AchievementType.values.firstWhere(
        (e) => e.name == map['type'],
        orElse: () => AchievementType.milestone,
      ),
      xpReward: map['xpReward']?.toInt() ?? 0,
    );
  }
}

enum AchievementType {
  milestone,
  streak,
  skill,
  speed,
  perfect,
  dedication,
}




















