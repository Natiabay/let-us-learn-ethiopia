/// Amharic Lesson Models - Duolingo Style
/// Professional lesson structure for comprehensive Amharic learning

enum LessonType {
  tapWhatYouHear,
  completeTheSentence,
  completeTheChat,
  matchPairs,
  translateSentence,
  fillInTheBlank,
  speakThisPhrase,
  listenAndRepeat,
  multipleChoice,
  conversation,
}

enum DifficultyLevel {
  beginner,
  elementary,
  intermediate,
  advanced,
  expert,
}

enum LessonCategory {
  greetings,
  numbers,
  food,
  family,
  directions,
  time,
  colors,
  transportation,
  accommodation,
  emergency,
  shopping,
  weather,
  culture,
  grammar,
}

/// Main Lesson Model
class AmharicLesson {
  final String id;
  final String title;
  final String description;
  final LessonCategory category;
  final DifficultyLevel difficulty;
  final int order;
  final List<LessonExercise> exercises;
  final int totalXP;
  final bool isLocked;
  final String? prerequisiteId;
  
  const AmharicLesson({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.difficulty,
    required this.order,
    required this.exercises,
    this.totalXP = 10,
    this.isLocked = false,
    this.prerequisiteId,
  });
}

/// Exercise Model
class LessonExercise {
  final String id;
  final LessonType type;
  final String question;
  final String? audioUrl;
  final String? imageUrl;
  final List<String> options;
  final String correctAnswer;
  final String? explanation;
  final String? amharicScript;
  final String? pronunciation;
  final List<String>? wordBank;
  final ConversationData? conversation;
  
  const LessonExercise({
    required this.id,
    required this.type,
    required this.question,
    this.audioUrl,
    this.imageUrl,
    required this.options,
    required this.correctAnswer,
    this.explanation,
    this.amharicScript,
    this.pronunciation,
    this.wordBank,
    this.conversation,
  });
}

/// Conversation Data for Chat Exercises
class ConversationData {
  final String character1;
  final String character1Avatar;
  final String character2;
  final String character2Avatar;
  final List<ConversationMessage> messages;
  
  const ConversationData({
    required this.character1,
    required this.character1Avatar,
    required this.character2,
    required this.character2Avatar,
    required this.messages,
  });
}

class ConversationMessage {
  final String speaker;
  final String text;
  final String? amharic;
  final bool isUserResponse;
  
  const ConversationMessage({
    required this.speaker,
    required this.text,
    this.amharic,
    this.isUserResponse = false,
  });
}

/// Lesson Progress Model
class LessonProgress {
  final String lessonId;
  final int completedExercises;
  final int totalExercises;
  final int xpEarned;
  final int hearts;
  final int maxHearts;
  final bool isCompleted;
  final DateTime? completedAt;
  
  const LessonProgress({
    required this.lessonId,
    required this.completedExercises,
    required this.totalExercises,
    this.xpEarned = 0,
    this.hearts = 3,
    this.maxHearts = 3,
    this.isCompleted = false,
    this.completedAt,
  });
  
  double get progressPercentage => 
      totalExercises > 0 ? (completedExercises / totalExercises) * 100 : 0;
  
  LessonProgress copyWith({
    int? completedExercises,
    int? xpEarned,
    int? hearts,
    bool? isCompleted,
    DateTime? completedAt,
  }) {
    return LessonProgress(
      lessonId: lessonId,
      completedExercises: completedExercises ?? this.completedExercises,
      totalExercises: totalExercises,
      xpEarned: xpEarned ?? this.xpEarned,
      hearts: hearts ?? this.hearts,
      maxHearts: maxHearts,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}

/// User Amharic Stats
class AmharicLearningStats {
  final int totalXP;
  final int currentStreak;
  final int longestStreak;
  final int lessonsCompleted;
  final int totalLessons;
  final Map<LessonCategory, int> categoryProgress;
  final DateTime? lastPracticeDate;
  
  const AmharicLearningStats({
    this.totalXP = 0,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.lessonsCompleted = 0,
    this.totalLessons = 0,
    this.categoryProgress = const {},
    this.lastPracticeDate,
  });
}























