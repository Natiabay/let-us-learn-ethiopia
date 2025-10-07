class Achievement {
  final String id;
  final String title;
  final String description;
  final String iconName;
  final int xpReward;
  final AchievementType type;
  final bool isUnlocked;
  final DateTime? unlockedDate;
  final Map<String, dynamic> requirements;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.iconName,
    required this.xpReward,
    required this.type,
    required this.isUnlocked,
    this.unlockedDate,
    required this.requirements,
  });

  Achievement copyWith({
    String? id,
    String? title,
    String? description,
    String? iconName,
    int? xpReward,
    AchievementType? type,
    bool? isUnlocked,
    DateTime? unlockedDate,
    Map<String, dynamic>? requirements,
  }) {
    return Achievement(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      iconName: iconName ?? this.iconName,
      xpReward: xpReward ?? this.xpReward,
      type: type ?? this.type,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockedDate: unlockedDate ?? this.unlockedDate,
      requirements: requirements ?? this.requirements,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'iconName': iconName,
      'xpReward': xpReward,
      'type': type.toString(),
      'isUnlocked': isUnlocked,
      'unlockedDate': unlockedDate?.toIso8601String(),
      'requirements': requirements,
    };
  }

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      iconName: json['iconName'],
      xpReward: json['xpReward'],
      type: AchievementType.values.firstWhere(
        (e) => e.toString() == json['type'],
        orElse: () => AchievementType.streak,
      ),
      isUnlocked: json['isUnlocked'] ?? false,
      unlockedDate: json['unlockedDate'] != null 
          ? DateTime.parse(json['unlockedDate']) 
          : null,
      requirements: Map<String, dynamic>.from(json['requirements'] ?? {}),
    );
  }
}

enum AchievementType {
  streak,
  lessons,
  words,
  xp,
  perfect,
  speed,
  category,
  special,
}

// Predefined achievements
class Achievements {
  static final List<Achievement> all = [
    Achievement(
      id: 'first_lesson',
      title: 'First Steps',
      description: 'Complete your first lesson',
      iconName: 'first_lesson',
      xpReward: 10,
      type: AchievementType.lessons,
      isUnlocked: false,
      requirements: {'lessons_completed': 1},
    ),
    Achievement(
      id: 'streak_7',
      title: 'Week Warrior',
      description: 'Study for 7 days in a row',
      iconName: 'streak_7',
      xpReward: 50,
      type: AchievementType.streak,
      isUnlocked: false,
      requirements: {'streak_days': 7},
    ),
    Achievement(
      id: 'streak_30',
      title: 'Month Master',
      description: 'Study for 30 days in a row',
      iconName: 'streak_30',
      xpReward: 200,
      type: AchievementType.streak,
      isUnlocked: false,
      requirements: {'streak_days': 30},
    ),
    Achievement(
      id: 'words_100',
      title: 'Word Collector',
      description: 'Learn 100 words',
      iconName: 'words_100',
      xpReward: 100,
      type: AchievementType.words,
      isUnlocked: false,
      requirements: {'words_learned': 100},
    ),
    Achievement(
      id: 'perfect_lesson',
      title: 'Perfectionist',
      description: 'Complete a lesson with 100% accuracy',
      iconName: 'perfect_lesson',
      xpReward: 25,
      type: AchievementType.perfect,
      isUnlocked: false,
      requirements: {'perfect_lessons': 1},
    ),
    Achievement(
      id: 'speed_demon',
      title: 'Speed Demon',
      description: 'Complete a lesson in under 2 minutes',
      iconName: 'speed_demon',
      xpReward: 30,
      type: AchievementType.speed,
      isUnlocked: false,
      requirements: {'fast_lesson_time': 120}, // 2 minutes in seconds
    ),
    Achievement(
      id: 'category_master',
      title: 'Category Master',
      description: 'Complete all lessons in a category',
      iconName: 'category_master',
      xpReward: 75,
      type: AchievementType.category,
      isUnlocked: false,
      requirements: {'category_completed': 'basics'},
    ),
    Achievement(
      id: 'early_bird',
      title: 'Early Bird',
      description: 'Study before 8 AM',
      iconName: 'early_bird',
      xpReward: 15,
      type: AchievementType.special,
      isUnlocked: false,
      requirements: {'study_before_hour': 8},
    ),
  ];
}

