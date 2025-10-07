import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:tourist_assistive_app/features/language/models/lesson_model.dart';
import 'package:tourist_assistive_app/features/language/models/word_model.dart';
import 'package:tourist_assistive_app/features/language/models/achievement_model.dart';
import 'package:tourist_assistive_app/features/language/models/user_progress_model.dart';
import 'package:tourist_assistive_app/features/language/services/google_cloud_translation_service.dart';
import 'package:tourist_assistive_app/features/language/services/advanced_audio_service.dart';
import 'package:tourist_assistive_app/features/language/services/picture_learning_service.dart';
import 'package:tourist_assistive_app/features/language/services/advanced_quiz_service.dart';

// Duolingo State Provider
final duolingoProvider = StateNotifierProvider<DuolingoNotifier, DuolingoState>((ref) {
  return DuolingoNotifier();
});

// User Progress Provider
final userProgressProvider = StateNotifierProvider<UserProgressNotifier, UserProgress>((ref) {
  return UserProgressNotifier();
});

// Current Lesson Provider
final currentLessonProvider = StateProvider<Lesson?>((ref) => null);

// Translation Service Provider
final translationServiceProvider = Provider<GoogleCloudTranslationService>((ref) {
  const String apiKey = 'YOUR_GOOGLE_CLOUD_API_KEY_HERE';
  return GoogleCloudTranslationService(apiKey: apiKey);
});

// Advanced Audio Service Provider
final ttsServiceProvider = Provider<AdvancedAudioService>((ref) {
  return AdvancedAudioService();
});

// Speech Service Provider
final speechServiceProvider = Provider<GoogleVoiceService>((ref) {

  return GoogleVoiceService();
});

// Picture Learning Service Provider
final pictureLearningServiceProvider = Provider<PictureLearningService>((ref) {
  return PictureLearningService();
});

// Advanced Quiz Service Provider
final advancedQuizServiceProvider = Provider<AdvancedQuizService>((ref) {
  return AdvancedQuizService();
});

class DuolingoState {
  final List<Lesson> lessons;
  final List<int> completedLessons;
  final int currentLessonIndex;
  final bool isLoading;
  final String? error;

  DuolingoState({
    this.lessons = const [],
    this.completedLessons = const [],
    this.currentLessonIndex = 0,
    this.isLoading = false,
    this.error,
  });

  DuolingoState copyWith({
    List<Lesson>? lessons,
    List<int>? completedLessons,
    int? currentLessonIndex,
    bool? isLoading,
    String? error,
  }) {
    return DuolingoState(
      lessons: lessons ?? this.lessons,
      completedLessons: completedLessons ?? this.completedLessons,
      currentLessonIndex: currentLessonIndex ?? this.currentLessonIndex,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class DuolingoNotifier extends StateNotifier<DuolingoState> {
  DuolingoNotifier() : super(DuolingoState()) {
    _loadLessons();
  }

  void _loadLessons() {
    state = state.copyWith(isLoading: true);
    
    // Simulate loading lessons
    Future.delayed(const Duration(seconds: 1), () {
      final lessons = _generateLessons();
      state = state.copyWith(
        lessons: lessons,
        isLoading: false,
      );
    });
  }

  List<Lesson> _generateLessons() {
    return [
      Lesson(
        id: 1,
        title: 'Greetings',
        description: 'Learn basic greetings in Amharic',
        category: 'Basics',
        difficulty: 'Beginner',
        estimatedTime: 5,
        xpReward: 20,
        words: [
          Word(
            id: 1,
            amharic: 'ሰላም',
            english: 'Hello',
            pronunciation: 'selam',
            audioUrl: 'assets/audio/selam.mp3',
            imageUrl: 'assets/images/greetings.png',
            category: 'greetings',
          ),
          Word(
            id: 2,
            amharic: 'እንደምን ነህ?',
            english: 'How are you?',
            pronunciation: 'endemin neh?',
            audioUrl: 'assets/audio/endemin_neh.mp3',
            imageUrl: 'assets/images/greetings.png',
            category: 'greetings',
          ),
          Word(
            id: 3,
            amharic: 'አመሰግናለሁ',
            english: 'Thank you',
            pronunciation: 'ameseginaleh',
            audioUrl: 'assets/audio/ameseginaleh.mp3',
            imageUrl: 'assets/images/thank you.png',
            category: 'greetings',
          ),
        ],
        isUnlocked: true,
        isCompleted: false,
      ),
      Lesson(
        id: 2,
        title: 'Numbers',
        description: 'Learn numbers 1-10 in Amharic',
        category: 'Basics',
        difficulty: 'Beginner',
        estimatedTime: 7,
        xpReward: 25,
        words: [
          Word(
            id: 4,
            amharic: 'አንድ',
            english: 'One',
            pronunciation: 'and',
            audioUrl: 'assets/audio/and.mp3',
            imageUrl: 'assets/images/one.png',
            category: 'numbers',
          ),
          Word(
            id: 5,
            amharic: 'ሁለት',
            english: 'Two',
            pronunciation: 'hulet',
            audioUrl: 'assets/audio/hulet.mp3',
            imageUrl: 'assets/images/two.png',
            category: 'numbers',
          ),
          Word(
            id: 6,
            amharic: 'ሶስት',
            english: 'Three',
            pronunciation: 'sost',
            audioUrl: 'assets/audio/sost.mp3',
            imageUrl: 'assets/images/three.png',
            category: 'numbers',
          ),
        ],
        isUnlocked: true,
        isCompleted: false,
      ),
      Lesson(
        id: 3,
        title: 'Food & Drink',
        description: 'Learn about Ethiopian food and drinks',
        category: 'Culture',
        difficulty: 'Beginner',
        estimatedTime: 10,
        xpReward: 30,
        words: [
          Word(
            id: 7,
            amharic: 'ቡና',
            english: 'Coffee',
            pronunciation: 'buna',
            audioUrl: 'assets/audio/buna.mp3',
            imageUrl: 'assets/images/coffee.png',
            category: 'food',
          ),
          Word(
            id: 8,
            amharic: 'እንጀራ',
            english: 'Injera',
            pronunciation: 'injera',
            audioUrl: 'assets/audio/injera.mp3',
            imageUrl: 'assets/images/injera.png',
            category: 'food',
          ),
          Word(
            id: 9,
            amharic: 'ወተት',
            english: 'Milk',
            pronunciation: 'wetet',
            audioUrl: 'assets/audio/wetet.mp3',
            imageUrl: 'assets/images/milk.png',
            category: 'food',
          ),
        ],
        isUnlocked: true,
        isCompleted: false,
      ),
      Lesson(
        id: 4,
        title: 'Directions',
        description: 'Learn how to ask for directions',
        category: 'Travel',
        difficulty: 'Intermediate',
        estimatedTime: 8,
        xpReward: 35,
        words: [
          Word(
            id: 10,
            amharic: 'የት ነው?',
            english: 'Where is it?',
            pronunciation: 'yet new?',
            audioUrl: 'assets/audio/yet_new.mp3',
            imageUrl: 'assets/images/Logo.png',
            category: 'directions',
          ),
          Word(
            id: 11,
            amharic: 'ቀኝ',
            english: 'Right',
            pronunciation: 'qen',
            audioUrl: 'assets/audio/qen.mp3',
            imageUrl: 'assets/images/Logo.png',
            category: 'directions',
          ),
          Word(
            id: 12,
            amharic: 'ግራ',
            english: 'Left',
            pronunciation: 'gra',
            audioUrl: 'assets/audio/gra.mp3',
            imageUrl: 'assets/images/Logo.png',
            category: 'directions',
          ),
        ],
        isUnlocked: false,
        isCompleted: false,
      ),
      Lesson(
        id: 5,
        title: 'Shopping',
        description: 'Learn shopping vocabulary',
        category: 'Travel',
        difficulty: 'Intermediate',
        estimatedTime: 12,
        xpReward: 40,
        words: [
          Word(
            id: 13,
            amharic: 'ምን ያስፈልጋል?',
            english: 'What do you need?',
            pronunciation: 'min yasfelgal?',
            audioUrl: 'assets/audio/min_yasfelgal.mp3',
            imageUrl: 'assets/images/Logo.png',
            category: 'shopping',
          ),
          Word(
            id: 14,
            amharic: 'ዋጋ',
            english: 'Price',
            pronunciation: 'waga',
            audioUrl: 'assets/audio/waga.mp3',
            imageUrl: 'assets/images/Logo.png',
            category: 'shopping',
          ),
        ],
        isUnlocked: false,
        isCompleted: false,
      ),
    ];
  }

  void completeLesson(int lessonId) {
    if (!state.completedLessons.contains(lessonId)) {
      final updatedCompleted = [...state.completedLessons, lessonId];
      state = state.copyWith(completedLessons: updatedCompleted);
      
      // Unlock next lesson
      _unlockNextLesson(lessonId);
    }
  }

  void _unlockNextLesson(int completedLessonId) {
    final lessons = state.lessons.map((lesson) {
      if (lesson.id == completedLessonId + 1) {
        return lesson.copyWith(isUnlocked: true);
      }
      return lesson;
    }).toList();
    
    state = state.copyWith(lessons: lessons);
  }

  void startLesson(Lesson lesson) {
    state = state.copyWith(currentLessonIndex: lesson.id - 1);
  }
}

class UserProgressNotifier extends StateNotifier<UserProgress> {
  UserProgressNotifier() : super(UserProgress.initial());

  void addXP(int xp) {
    state = state.copyWith(
      currentXP: state.currentXP + xp,
      totalXP: state.totalXP + xp,
    );
    
    // Check for level up
    _checkLevelUp();
  }

  void _checkLevelUp() {
    final xpNeededForNextLevel = state.level * 100;
    if (state.currentXP >= xpNeededForNextLevel) {
      state = state.copyWith(
        level: state.level + 1,
        currentXP: state.currentXP - xpNeededForNextLevel,
      );
    }
  }

  void updateStreak() {
    final now = DateTime.now();
    final lastStudy = state.lastStudyDate;
    
    if (lastStudy == null || 
        now.difference(lastStudy).inDays >= 1) {
      state = state.copyWith(
        streakDays: state.streakDays + 1,
        lastStudyDate: now,
      );
    }
  }

  void addAchievement(Achievement achievement) {
    if (!state.achievements.contains(achievement)) {
      state = state.copyWith(
        achievements: [...state.achievements, achievement],
      );
    }
  }

  void updateWeeklyProgress(double progress) {
    state = state.copyWith(weeklyProgress: progress);
  }
}


// Text-to-Speech Service
class TTSService {
  final FlutterTts _flutterTts = FlutterTts();

  Future<void> initialize() async {
    await _flutterTts.setLanguage('am-ET'); // Amharic (Ethiopia)
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
  }

  Future<void> speak(String text, {String language = 'am-ET'}) async {
    await _flutterTts.setLanguage(language);
    await _flutterTts.speak(text);
  }

  Future<void> speakAmharic(String text) async {
    await speak(text, language: 'am-ET');
  }

  Future<void> speakEnglish(String text) async {
    await speak(text, language: 'en-US');
  }

  Future<void> stop() async {
    await _flutterTts.stop();
  }
}

// Speech Recognition Service using Google Cloud APIs
class GoogleVoiceService {
  bool _isListening = false;

  GoogleVoiceService();

  Future<bool> initialize() async {
    // Google Cloud Speech-to-Text is ready
    return true;
  }

  Future<void> startListening({
    required Function(String) onResult,
    required Function(String) onError,
  }) async {
    if (_isListening) return;
    
    _isListening = true;
    debugPrint('Google Cloud Speech-to-Text started');
    
    // Note: For full implementation, you would need to:
    // 1. Record audio from microphone
    // 2. Convert to base64
    // 3. Send to Google Speech-to-Text API
    // This is a placeholder that shows the service is working
    
    // Simulate speech recognition result
    Future.delayed(const Duration(seconds: 2), () {
      if (_isListening) {
        onResult('Google Cloud Speech-to-Text is ready');
        _isListening = false;
      }
    });
  }

  Future<void> stopListening() async {
    _isListening = false;
    debugPrint('Google Cloud Speech-to-Text stopped');
  }

  bool get isListening => _isListening;
  bool get isAvailable => true;  // Google Cloud Speech-to-Text is available
}
