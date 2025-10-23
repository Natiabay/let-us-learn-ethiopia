import 'package:flutter/material.dart';

enum LanguageLevel {
  beginner,
  elementary,
  intermediate,
  advanced,
}

enum ExerciseType {
  selectImage,
  translate,
  listen,
  speak,
  fillBlank,
  multipleChoice,
  matching,
  matchPairs,
  pronunciation,
  readAndRespond,
  completeSentence,
  tapWhatYouHear,
  completeChat,
}

class LanguageOption {
  final String name;
  final String nativeName;
  final String flag;
  final Color color;
  final String description;
  final bool isAvailable;
  final String languageCode;

  LanguageOption({
    required this.name,
    required this.nativeName,
    required this.flag,
    required this.color,
    required this.description,
    required this.isAvailable,
    required this.languageCode,
  });
}

class Lesson {
  final String id;
  final String title;
  final String description;
  final LanguageLevel level;
  final String languageCode;
  final int estimatedMinutes;
  final int xpReward;
  final List<Exercise> exercises;
  final List<String> vocabulary;
  final String category;
  final bool isUnlocked;
  final bool isCompleted;
  final double progress;
  final int? estimatedTime; // For Duolingo-style lessons

  Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.level,
    required this.languageCode,
    required this.estimatedMinutes,
    required this.xpReward,
    required this.exercises,
    required this.vocabulary,
    required this.category,
    this.isUnlocked = true,
    this.isCompleted = false,
    this.progress = 0.0,
    this.estimatedTime,
  });
}

class Exercise {
  final String id;
  final ExerciseType type;
  final String instruction;
  final String amharicText;
  final String translation;
  final String? audioUrl;
  final String? imageUrl;
  final List<ExerciseOption> options;
  final String? correctAnswer;
  final String? explanation;
  final int timeLimit; // in seconds
  final int xpReward;
  final String? content; // For Duolingo-style exercises
  final String? question; // For question-based exercises

  Exercise({
    required this.id,
    required this.type,
    required this.instruction,
    required this.amharicText,
    required this.translation,
    this.audioUrl,
    this.imageUrl,
    required this.options,
    this.correctAnswer,
    this.explanation,
    this.timeLimit = 30,
    this.xpReward = 10,
    this.content,
    this.question,
  });
}

class ExerciseOption {
  final String text;
  final String? imageUrl;
  final bool isCorrect;
  final String? audioUrl;

  ExerciseOption({
    required this.text,
    this.imageUrl,
    required this.isCorrect,
    this.audioUrl,
  });
}

class LanguageLevelData {
  final LanguageLevel level;
  final String title;
  final String description;
  final int totalMinutes;
  final int totalLessons;
  final int totalXP;
  final Color color;
  final String icon;

  LanguageLevelData({
    required this.level,
    required this.title,
    required this.description,
    required this.totalMinutes,
    required this.totalLessons,
    required this.totalXP,
    required this.color,
    required this.icon,
  });
}

class VocabularyWord {
  final String amharic;
  final String english;
  final String? pronunciation;
  final String? audioUrl;
  final String? imageUrl;
  final String category;
  final List<String> examples;
  final String? notes;

  VocabularyWord({
    required this.amharic,
    required this.english,
    this.pronunciation,
    this.audioUrl,
    this.imageUrl,
    required this.category,
    required this.examples,
    this.notes,
  });
}

// Comprehensive lesson data for all languages
class ComprehensiveLessonData {
  static List<LanguageOption> getAvailableLanguages() {
    return [
      LanguageOption(
        name: 'English',
        nativeName: 'English',
        flag: '🇺🇸',
        color: const Color(0xFF1CB0F6),
        description: 'Learn Amharic from English',
        isAvailable: true,
        languageCode: 'en',
      ),
      LanguageOption(
        name: 'Mandarin',
        nativeName: '中文',
        flag: '🇨🇳',
        color: const Color(0xFFCE82FF),
        description: 'Learn Amharic from Mandarin Chinese',
        isAvailable: true,
        languageCode: 'zh',
      ),
      LanguageOption(
        name: 'French',
        nativeName: 'Français',
        flag: '🇫🇷',
        color: const Color(0xFF1CB0F6),
        description: 'Learn Amharic from French',
        isAvailable: true,
        languageCode: 'fr',
      ),
      LanguageOption(
        name: 'German',
        nativeName: 'Deutsch',
        flag: '🇩🇪',
        color: const Color(0xFFCE82FF),
        description: 'Learn Amharic from German',
        isAvailable: true,
        languageCode: 'de',
      ),
      LanguageOption(
        name: 'Spanish',
        nativeName: 'Español',
        flag: '🇪🇸',
        color: const Color(0xFF1CB0F6),
        description: 'Learn Amharic from Spanish',
        isAvailable: true,
        languageCode: 'es',
      ),
      LanguageOption(
        name: 'Arabic',
        nativeName: 'العربية',
        flag: '🇸🇦',
        color: const Color(0xFFCE82FF),
        description: 'Learn Amharic from Arabic',
        isAvailable: true,
        languageCode: 'ar',
      ),
      LanguageOption(
        name: 'Portuguese',
        nativeName: 'Português',
        flag: '🇵🇹',
        color: const Color(0xFF1CB0F6),
        description: 'Learn Amharic from Portuguese',
        isAvailable: true,
        languageCode: 'pt',
      ),
      LanguageOption(
        name: 'Russian',
        nativeName: 'Русский',
        flag: '🇷🇺',
        color: const Color(0xFFCE82FF),
        description: 'Learn Amharic from Russian',
        isAvailable: true,
        languageCode: 'ru',
      ),
      LanguageOption(
        name: 'Japanese',
        nativeName: '日本語',
        flag: '🇯🇵',
        color: const Color(0xFF1CB0F6),
        description: 'Learn Amharic from Japanese',
        isAvailable: true,
        languageCode: 'ja',
      ),
    ];
  }

  static List<LanguageLevelData> getLevelData() {
    return [
      LanguageLevelData(
        level: LanguageLevel.beginner,
        title: 'Beginner',
        description: 'Start your Amharic journey with basic words and phrases',
        totalMinutes: 150,
        totalLessons: 25,
        totalXP: 2500,
        color: const Color(0xFF00D9B8),
        icon: '🌱',
      ),
      LanguageLevelData(
        level: LanguageLevel.intermediate,
        title: 'Intermediate',
        description: 'Build confidence with conversations and grammar',
        totalMinutes: 150,
        totalLessons: 20,
        totalXP: 3000,
        color: const Color(0xFF1CB0F6),
        icon: '🌿',
      ),
      LanguageLevelData(
        level: LanguageLevel.advanced,
        title: 'Advanced',
        description: 'Master complex conversations and cultural nuances',
        totalMinutes: 100,
        totalLessons: 15,
        totalXP: 2000,
        color: const Color(0xFFCE82FF),
        icon: '🌳',
      ),
    ];
  }

  // Generate comprehensive lessons for each language and level
  static List<Lesson> generateLessonsForLanguage(String languageCode, LanguageLevel level) {
    final lessons = <Lesson>[];
    
    switch (level) {
      case LanguageLevel.beginner:
        lessons.addAll(_generateBeginnerLessons(languageCode));
        break;
      case LanguageLevel.elementary:
        lessons.addAll(_generateBeginnerLessons(languageCode)); // Use beginner lessons for elementary
        break;
      case LanguageLevel.intermediate:
        lessons.addAll(_generateIntermediateLessons(languageCode));
        break;
      case LanguageLevel.advanced:
        lessons.addAll(_generateAdvancedLessons(languageCode));
        break;
    }
    
    return lessons;
  }

  static List<Lesson> _generateBeginnerLessons(String languageCode) {
    return [
      // Lesson 1: Greetings
      Lesson(
        id: '${languageCode}_beginner_1',
        title: _getLocalizedTitle('Greetings', languageCode),
        description: _getLocalizedDescription('Learn basic greetings in Amharic', languageCode),
        level: LanguageLevel.beginner,
        languageCode: languageCode,
        estimatedMinutes: 6,
        xpReward: 100,
        category: 'Basics',
        exercises: _generateGreetingExercises(languageCode),
        vocabulary: ['ሰላም', 'እንዴት ናችሁ', 'እንደምን አለ', 'ታዲያስ', 'እንደምን አለች'],
      ),
      
      // Lesson 2: Numbers 1-10
      Lesson(
        id: '${languageCode}_beginner_2',
        title: _getLocalizedTitle('Numbers 1-10', languageCode),
        description: _getLocalizedDescription('Learn to count from 1 to 10', languageCode),
        level: LanguageLevel.beginner,
        languageCode: languageCode,
        estimatedMinutes: 6,
        xpReward: 100,
        category: 'Numbers',
        exercises: _generateNumberExercises(languageCode),
        vocabulary: ['አንድ', 'ሁለት', 'ሶስት', 'አራት', 'አምስት', 'ስድስት', 'ሰባት', 'ስምንት', 'ዘጠኝ', 'አስር'],
      ),
      
      // Lesson 3: Family
      Lesson(
        id: '${languageCode}_beginner_3',
        title: _getLocalizedTitle('Family', languageCode),
        description: _getLocalizedDescription('Learn family member names', languageCode),
        level: LanguageLevel.beginner,
        languageCode: languageCode,
        estimatedMinutes: 6,
        xpReward: 100,
        category: 'Family',
        exercises: _generateFamilyExercises(languageCode),
        vocabulary: ['አባት', 'እናት', 'ወንድም', 'እህት', 'ልጅ', 'ወላጅ'],
      ),
      
      // Lesson 4: Colors
      Lesson(
        id: '${languageCode}_beginner_4',
        title: _getLocalizedTitle('Colors', languageCode),
        description: _getLocalizedDescription('Learn basic colors in Amharic', languageCode),
        level: LanguageLevel.beginner,
        languageCode: languageCode,
        estimatedMinutes: 6,
        xpReward: 100,
        category: 'Colors',
        exercises: _generateColorExercises(languageCode),
        vocabulary: ['ቀይ', 'ሰማያዊ', 'አረንጓዴ', 'ቢጫ', 'ጥቁር', 'ነጭ'],
      ),
      
      // Lesson 5: Food
      Lesson(
        id: '${languageCode}_beginner_5',
        title: _getLocalizedTitle('Food', languageCode),
        description: _getLocalizedDescription('Learn food vocabulary', languageCode),
        level: LanguageLevel.beginner,
        languageCode: languageCode,
        estimatedMinutes: 6,
        xpReward: 100,
        category: 'Food',
        exercises: _generateFoodExercises(languageCode),
        vocabulary: ['ምግብ', 'ባይ', 'ዳቦ', 'ስጋ', 'ሩዝ', 'ቡና'],
      ),
      
      // Continue with more lessons to reach 25 total for beginner level
      // I'll add more lessons to reach the 150 minutes target
    ];
  }

  static List<Lesson> _generateIntermediateLessons(String languageCode) {
    return [
      // Intermediate lessons will be added here
    ];
  }

  static List<Lesson> _generateAdvancedLessons(String languageCode) {
    return [
      // Advanced lessons will be added here
    ];
  }

  // Helper methods for localized content
  static String _getLocalizedTitle(String englishTitle, String languageCode) {
    // This would contain translations for each language
    // For now, returning English titles
    return englishTitle;
  }

  static String _getLocalizedDescription(String englishDescription, String languageCode) {
    // This would contain translations for each language
    // For now, returning English descriptions
    return englishDescription;
  }

  // Exercise generators
  static List<Exercise> _generateGreetingExercises(String languageCode) {
    return [
      Exercise(
        id: 'greeting_1',
        type: ExerciseType.selectImage,
        instruction: _getLocalizedInstruction('Select the correct image for "Hello"', languageCode),
        amharicText: 'ሰላም',
        translation: 'Hello',
        imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&h=300&fit=crop',
        options: [
          ExerciseOption(
            text: 'Hello',
            imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&h=300&fit=crop',
            isCorrect: true,
          ),
          ExerciseOption(
            text: 'Goodbye',
            imageUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=300&h=300&fit=crop',
            isCorrect: false,
          ),
          ExerciseOption(
            text: 'Thank you',
            imageUrl: 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=300&h=300&fit=crop',
            isCorrect: false,
          ),
          ExerciseOption(
            text: 'Please',
            imageUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=300&h=300&fit=crop',
            isCorrect: false,
          ),
        ],
      ),
    ];
  }

  static List<Exercise> _generateNumberExercises(String languageCode) {
    return [
      Exercise(
        id: 'number_1',
        type: ExerciseType.translate,
        instruction: _getLocalizedInstruction('Translate "One" to Amharic', languageCode),
        amharicText: 'አንድ',
        translation: 'One',
        options: [
          ExerciseOption(text: 'አንድ', isCorrect: true),
          ExerciseOption(text: 'ሁለት', isCorrect: false),
          ExerciseOption(text: 'ሶስት', isCorrect: false),
          ExerciseOption(text: 'አራት', isCorrect: false),
        ],
      ),
    ];
  }

  static List<Exercise> _generateFamilyExercises(String languageCode) {
    return [
      Exercise(
        id: 'family_1',
        type: ExerciseType.selectImage,
        instruction: _getLocalizedInstruction('Select the image for "Father"', languageCode),
        amharicText: 'አባት',
        translation: 'Father',
        imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&h=300&fit=crop',
        options: [
          ExerciseOption(
            text: 'Father',
            imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&h=300&fit=crop',
            isCorrect: true,
          ),
          ExerciseOption(
            text: 'Mother',
            imageUrl: 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=300&h=300&fit=crop',
            isCorrect: false,
          ),
          ExerciseOption(
            text: 'Brother',
            imageUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=300&h=300&fit=crop',
            isCorrect: false,
          ),
          ExerciseOption(
            text: 'Sister',
            imageUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=300&h=300&fit=crop',
            isCorrect: false,
          ),
        ],
      ),
    ];
  }

  static String _getLocalizedInstruction(String englishInstruction, String languageCode) {
    // This would contain translations for each language
    // For now, returning English instructions
    return englishInstruction;
  }

  static List<Exercise> _generateColorExercises(String languageCode) {
    return [
      Exercise(
        id: 'color_1',
        type: ExerciseType.selectImage,
        instruction: _getLocalizedInstruction('Select the image for "Red"', languageCode),
        amharicText: 'ቀይ',
        translation: 'Red',
        imageUrl: 'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?w=300&h=300&fit=crop',
        options: [
          ExerciseOption(
            text: 'Red',
            imageUrl: 'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?w=300&h=300&fit=crop',
            isCorrect: true,
          ),
          ExerciseOption(
            text: 'Blue',
            imageUrl: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=300&h=300&fit=crop',
            isCorrect: false,
          ),
          ExerciseOption(
            text: 'Green',
            imageUrl: 'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=300&h=300&fit=crop',
            isCorrect: false,
          ),
          ExerciseOption(
            text: 'Yellow',
            imageUrl: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=300&h=300&fit=crop',
            isCorrect: false,
          ),
        ],
      ),
    ];
  }

  static List<Exercise> _generateFoodExercises(String languageCode) {
    return [
      Exercise(
        id: 'food_1',
        type: ExerciseType.selectImage,
        instruction: _getLocalizedInstruction('Select the image for "Water"', languageCode),
        amharicText: 'ባይ',
        translation: 'Water',
        imageUrl: 'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=300&h=300&fit=crop',
        options: [
          ExerciseOption(
            text: 'Water',
            imageUrl: 'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=300&h=300&fit=crop',
            isCorrect: true,
          ),
          ExerciseOption(
            text: 'Food',
            imageUrl: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=300&h=300&fit=crop',
            isCorrect: false,
          ),
          ExerciseOption(
            text: 'Bread',
            imageUrl: 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=300&h=300&fit=crop',
            isCorrect: false,
          ),
          ExerciseOption(
            text: 'Coffee',
            imageUrl: 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=300&h=300&fit=crop',
            isCorrect: false,
          ),
        ],
      ),
    ];
  }
}
