import 'package:flutter/material.dart';
import 'package:tourist_assistive_app/features/language/data/amharic_vocabulary_database.dart';
import 'package:tourist_assistive_app/features/language/data/massive_tourist_lessons.dart';

class AmharicLesson {
  final int id;
  final String title;
  final String description;
  final String category;
  final String difficulty;
  final int estimatedTime; // in minutes
  final int xpReward;
  final List<AmharicWord> words;
  final bool isUnlocked;
  final bool isCompleted;
  final double progress; // 0.0 to 1.0
  final String icon;

  AmharicLesson({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.difficulty,
    required this.estimatedTime,
    required this.xpReward,
    required this.words,
    required this.isUnlocked,
    required this.isCompleted,
    this.progress = 0.0,
    required this.icon,
  });

  List<AmharicQuestion> generateQuestions() {
    List<AmharicQuestion> questions = [];
    
    // Generate different types of questions based on words
    for (int i = 0; i < words.length; i++) {
      final word = words[i];
      
      // Add translation question
      questions.add(AmharicQuestion(
        id: '${id}_translate_$i',
        type: 'translate',
        instruction: 'Translate this sentence',
        amharicText: word.amharic,
        correctAnswer: word.english,
        options: _generateTranslationOptions(word),
        imageOptions: [],
      ));
      
      // Add select image question if word has image
      if (word.imageUrl != null || word.icon != null) {
        questions.add(AmharicQuestion(
          id: '${id}_image_$i',
          type: 'select_image',
          instruction: 'Select the correct image',
          amharicText: word.amharic,
          correctAnswer: word.english,
          options: [],
          imageOptions: _generateImageOptions(word),
        ));
      }
      
      // Add listen question
      questions.add(AmharicQuestion(
        id: '${id}_listen_$i',
        type: 'listen',
        instruction: 'What did you hear?',
        amharicText: word.amharic,
        correctAnswer: word.english,
        options: _generateListenOptions(word),
        imageOptions: [],
      ));
    }
    
    // Shuffle questions for variety
    questions.shuffle();
    return questions.take(10).toList(); // Limit to 10 questions per lesson
  }

  List<String> _generateTranslationOptions(AmharicWord word) {
    List<String> options = [word.english];
    
    // Add similar words from the same category
    final similarWords = words
        .where((w) => w.category == word.category && w.id != word.id)
        .take(3)
        .map((w) => w.english)
        .toList();
    
    options.addAll(similarWords);
    
    // Add some common wrong answers
    final wrongAnswers = [
      'Hello', 'Goodbye', 'Thank you', 'Please', 'Sorry',
      'Yes', 'No', 'Water', 'Food', 'House', 'Car', 'Book'
    ];
    
    while (options.length < 4) {
      final wrongAnswer = wrongAnswers[DateTime.now().millisecondsSinceEpoch % wrongAnswers.length];
      if (!options.contains(wrongAnswer)) {
        options.add(wrongAnswer);
      }
    }
    
    options.shuffle();
    return options;
  }

  List<ImageOption> _generateImageOptions(AmharicWord word) {
    List<ImageOption> options = [
      ImageOption(
        english: word.english,
        icon: word.icon ?? Icons.help_outline,
        imageUrl: word.imageUrl,
      ),
    ];
    
    // Add similar words from the same category
    final similarWords = words
        .where((w) => w.category == word.category && w.id != word.id)
        .take(3)
        .map((w) => ImageOption(
          english: w.english,
          icon: w.icon ?? Icons.help_outline,
          imageUrl: w.imageUrl,
        ))
        .toList();
    
    options.addAll(similarWords);
    
    // Add some common wrong answers with icons
    final wrongOptions = [
      ImageOption(english: 'Hello', icon: Icons.waving_hand, imageUrl: null),
      ImageOption(english: 'Water', icon: Icons.water_drop, imageUrl: null),
      ImageOption(english: 'Food', icon: Icons.restaurant, imageUrl: null),
      ImageOption(english: 'House', icon: Icons.home, imageUrl: null),
      ImageOption(english: 'Car', icon: Icons.directions_car, imageUrl: null),
      ImageOption(english: 'Book', icon: Icons.book, imageUrl: null),
    ];
    
    while (options.length < 4) {
      final wrongOption = wrongOptions[DateTime.now().millisecondsSinceEpoch % wrongOptions.length];
      if (!options.any((opt) => opt.english == wrongOption.english)) {
        options.add(wrongOption);
      }
    }
    
    options.shuffle();
    return options;
  }

  List<String> _generateListenOptions(AmharicWord word) {
    List<String> options = [word.english];
    
    // Add similar words from the same category
    final similarWords = words
        .where((w) => w.category == word.category && w.id != word.id)
        .take(3)
        .map((w) => w.english)
        .toList();
    
    options.addAll(similarWords);
    
    // Add some common wrong answers
    final wrongAnswers = [
      'Hello', 'Goodbye', 'Thank you', 'Please', 'Sorry',
      'Yes', 'No', 'Water', 'Food', 'House', 'Car', 'Book'
    ];
    
    while (options.length < 4) {
      final wrongAnswer = wrongAnswers[DateTime.now().millisecondsSinceEpoch % wrongAnswers.length];
      if (!options.contains(wrongAnswer)) {
        options.add(wrongAnswer);
      }
    }
    
    options.shuffle();
    return options;
  }

  AmharicLesson copyWith({
    int? id,
    String? title,
    String? description,
    String? category,
    String? difficulty,
    int? estimatedTime,
    int? xpReward,
    List<AmharicWord>? words,
    bool? isUnlocked,
    bool? isCompleted,
    double? progress,
    String? icon,
  }) {
    return AmharicLesson(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      difficulty: difficulty ?? this.difficulty,
      estimatedTime: estimatedTime ?? this.estimatedTime,
      xpReward: xpReward ?? this.xpReward,
      words: words ?? this.words,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      isCompleted: isCompleted ?? this.isCompleted,
      progress: progress ?? this.progress,
      icon: icon ?? this.icon,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'difficulty': difficulty,
      'estimatedTime': estimatedTime,
      'xpReward': xpReward,
      'words': words.map((word) => word.toJson()).toList(),
      'isUnlocked': isUnlocked,
      'isCompleted': isCompleted,
      'progress': progress,
      'icon': icon,
    };
  }

  factory AmharicLesson.fromJson(Map<String, dynamic> json) {
    return AmharicLesson(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      difficulty: json['difficulty'],
      estimatedTime: json['estimatedTime'],
      xpReward: json['xpReward'],
      words: (json['words'] as List)
          .map((wordJson) => AmharicWord.fromJson(wordJson))
          .toList(),
      isUnlocked: json['isUnlocked'],
      isCompleted: json['isCompleted'],
      progress: json['progress']?.toDouble() ?? 0.0,
      icon: json['icon'],
    );
  }
}

class AmharicWord {
  final int id;
  final String amharic;
  final String english;
  final String pronunciation;
  final String? audioUrl;
  final String? imageUrl;
  final String category;
  final List<String> examples;
  final String? partOfSpeech;
  final int difficulty; // 1-5 scale
  final bool isLearned;
  final int correctAnswers;
  final int totalAttempts;
  final IconData? icon;

  AmharicWord({
    required this.id,
    required this.amharic,
    required this.english,
    required this.pronunciation,
    this.audioUrl,
    this.imageUrl,
    required this.category,
    this.examples = const [],
    this.partOfSpeech,
    this.difficulty = 1,
    this.isLearned = false,
    this.correctAnswers = 0,
    this.totalAttempts = 0,
    this.icon,
  });

  double get accuracy {
    if (totalAttempts == 0) return 0.0;
    return correctAnswers / totalAttempts;
  }

  AmharicWord copyWith({
    int? id,
    String? amharic,
    String? english,
    String? pronunciation,
    String? audioUrl,
    String? imageUrl,
    String? category,
    List<String>? examples,
    String? partOfSpeech,
    int? difficulty,
    bool? isLearned,
    int? correctAnswers,
    int? totalAttempts,
    IconData? icon,
  }) {
    return AmharicWord(
      id: id ?? this.id,
      amharic: amharic ?? this.amharic,
      english: english ?? this.english,
      pronunciation: pronunciation ?? this.pronunciation,
      audioUrl: audioUrl ?? this.audioUrl,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      examples: examples ?? this.examples,
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
      difficulty: difficulty ?? this.difficulty,
      isLearned: isLearned ?? this.isLearned,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      totalAttempts: totalAttempts ?? this.totalAttempts,
      icon: icon ?? this.icon,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amharic': amharic,
      'english': english,
      'pronunciation': pronunciation,
      'audioUrl': audioUrl,
      'imageUrl': imageUrl,
      'category': category,
      'examples': examples,
      'partOfSpeech': partOfSpeech,
      'difficulty': difficulty,
      'isLearned': isLearned,
      'correctAnswers': correctAnswers,
      'totalAttempts': totalAttempts,
      'icon': icon?.codePoint,
    };
  }

  factory AmharicWord.fromJson(Map<String, dynamic> json) {
    return AmharicWord(
      id: json['id'],
      amharic: json['amharic'],
      english: json['english'],
      pronunciation: json['pronunciation'],
      audioUrl: json['audioUrl'],
      imageUrl: json['imageUrl'],
      category: json['category'],
      examples: List<String>.from(json['examples'] ?? []),
      partOfSpeech: json['partOfSpeech'],
      difficulty: json['difficulty'] ?? 1,
      isLearned: json['isLearned'] ?? false,
      correctAnswers: json['correctAnswers'] ?? 0,
      totalAttempts: json['totalAttempts'] ?? 0,
      icon: json['icon'] != null ? IconData(json['icon'], fontFamily: 'MaterialIcons') : null,
    );
  }
}

class AmharicQuestion {
  final String id;
  final String type; // 'translate', 'select_image', 'select_word', 'listen'
  final String instruction;
  final String amharicText;
  final String correctAnswer;
  final List<String> options;
  final List<ImageOption> imageOptions;

  AmharicQuestion({
    required this.id,
    required this.type,
    required this.instruction,
    required this.amharicText,
    required this.correctAnswer,
    required this.options,
    required this.imageOptions,
  });
}

class ImageOption {
  final String english;
  final IconData icon;
  final String? imageUrl;

  ImageOption({
    required this.english,
    required this.icon,
    this.imageUrl,
  });
}

// Massive comprehensive Amharic lessons for tourists - Just like Duolingo!
class AmharicLessonsData {
  static List<AmharicLesson> getLessons() {
    // Use the massive tourist lessons instead of the basic ones
    return MassiveTouristLessons.getMassiveLessons();
  }

  // Keep the old method for backward compatibility
  static List<AmharicLesson> getBasicLessons() {
    final allWords = AmharicVocabularyDatabase.getAllWords();
    
    return [
      // Basics Lesson
      AmharicLesson(
        id: 1,
        title: 'Basics',
        description: 'Learn essential Amharic words and phrases',
        category: 'Basics',
        difficulty: 'Beginner',
        estimatedTime: 5,
        xpReward: 20,
        icon: '📚',
        isUnlocked: true,
        isCompleted: false,
        words: allWords.where((word) => word.category == 'Greetings' || word.category == 'Basics').take(10).toList(),
      ),

      // Family Lesson
      AmharicLesson(
        id: 2,
        title: 'Family',
        description: 'Learn family members in Amharic',
        category: 'Family',
        difficulty: 'Beginner',
        estimatedTime: 7,
        xpReward: 25,
        icon: '👨‍👩‍👧‍👦',
        isUnlocked: true,
        isCompleted: false,
        words: allWords.where((word) => word.category == 'Family').toList(),
      ),

      // Food Lesson
      AmharicLesson(
        id: 3,
        title: 'Food',
        description: 'Learn about Ethiopian food and drinks',
        category: 'Food',
        difficulty: 'Beginner',
        estimatedTime: 8,
        xpReward: 30,
        icon: '🍽️',
        isUnlocked: true,
        isCompleted: false,
        words: allWords.where((word) => word.category == 'Food').toList(),
      ),

      // Numbers Lesson
      AmharicLesson(
        id: 4,
        title: 'Numbers',
        description: 'Learn numbers 1-10 in Amharic',
        category: 'Numbers',
        difficulty: 'Beginner',
        estimatedTime: 6,
        xpReward: 25,
        icon: '🔢',
        isUnlocked: true,
        isCompleted: false,
        words: allWords.where((word) => word.category == 'Numbers').toList(),
      ),

      // Travel Lesson
      AmharicLesson(
        id: 5,
        title: 'Travel',
        description: 'Essential phrases for travelers',
        category: 'Travel',
        difficulty: 'Intermediate',
        estimatedTime: 10,
        xpReward: 35,
        icon: '✈️',
        isUnlocked: false,
        isCompleted: false,
        words: allWords.where((word) => word.category == 'Travel').toList(),
      ),

      // Colors Lesson
      AmharicLesson(
        id: 6,
        title: 'Colors',
        description: 'Learn colors in Amharic',
        category: 'Colors',
        difficulty: 'Beginner',
        estimatedTime: 5,
        xpReward: 20,
        icon: '🎨',
        isUnlocked: true,
        isCompleted: false,
        words: allWords.where((word) => word.category == 'Colors').toList(),
      ),

      // Animals Lesson
      AmharicLesson(
        id: 7,
        title: 'Animals',
        description: 'Learn animal names in Amharic',
        category: 'Animals',
        difficulty: 'Beginner',
        estimatedTime: 6,
        xpReward: 25,
        icon: '🐾',
        isUnlocked: true,
        isCompleted: false,
        words: allWords.where((word) => word.category == 'Animals').toList(),
      ),

      // Body Parts Lesson
      AmharicLesson(
        id: 8,
        title: 'Body Parts',
        description: 'Learn body parts in Amharic',
        category: 'Body',
        difficulty: 'Beginner',
        estimatedTime: 6,
        xpReward: 25,
        icon: '👤',
        isUnlocked: true,
        isCompleted: false,
        words: allWords.where((word) => word.category == 'Body').toList(),
      ),

      // Time Lesson
      AmharicLesson(
        id: 9,
        title: 'Time',
        description: 'Learn time-related words in Amharic',
        category: 'Time',
        difficulty: 'Intermediate',
        estimatedTime: 8,
        xpReward: 30,
        icon: '⏰',
        isUnlocked: false,
        isCompleted: false,
        words: allWords.where((word) => word.category == 'Time').toList(),
      ),

      // Weather Lesson
      AmharicLesson(
        id: 10,
        title: 'Weather',
        description: 'Learn weather words in Amharic',
        category: 'Weather',
        difficulty: 'Intermediate',
        estimatedTime: 7,
        xpReward: 25,
        icon: '🌤️',
        isUnlocked: false,
        isCompleted: false,
        words: allWords.where((word) => word.category == 'Weather').toList(),
      ),

      // Shopping Lesson
      AmharicLesson(
        id: 11,
        title: 'Shopping',
        description: 'Learn shopping phrases in Amharic',
        category: 'Shopping',
        difficulty: 'Intermediate',
        estimatedTime: 10,
        xpReward: 35,
        icon: '🛒',
        isUnlocked: false,
        isCompleted: false,
        words: allWords.where((word) => word.category == 'Shopping').toList(),
      ),

      // Emergency Lesson
      AmharicLesson(
        id: 12,
        title: 'Emergency',
        description: 'Essential emergency phrases',
        category: 'Emergency',
        difficulty: 'Advanced',
        estimatedTime: 8,
        xpReward: 40,
        icon: '🚨',
        isUnlocked: false,
        isCompleted: false,
        words: allWords.where((word) => word.category == 'Emergency').toList(),
      ),

      // Emotions Lesson
      AmharicLesson(
        id: 13,
        title: 'Emotions',
        description: 'Learn emotion words in Amharic',
        category: 'Emotions',
        difficulty: 'Intermediate',
        estimatedTime: 7,
        xpReward: 25,
        icon: '😊',
        isUnlocked: false,
        isCompleted: false,
        words: allWords.where((word) => word.category == 'Emotions').toList(),
      ),

      // Actions Lesson
      AmharicLesson(
        id: 14,
        title: 'Actions',
        description: 'Learn action verbs in Amharic',
        category: 'Actions',
        difficulty: 'Intermediate',
        estimatedTime: 8,
        xpReward: 30,
        icon: '🏃',
        isUnlocked: false,
        isCompleted: false,
        words: allWords.where((word) => word.category == 'Actions').toList(),
      ),
    ];
  }
}
