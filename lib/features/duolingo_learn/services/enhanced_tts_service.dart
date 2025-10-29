import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:audioplayers/audioplayers.dart';

/// Enhanced TTS Service for Amharic Learning
/// Provides high-quality text-to-speech with transliteration fallback
/// Optimized for learning with proper pronunciation guidance
class EnhancedTTSService {
  static final EnhancedTTSService _instance = EnhancedTTSService._internal();
  factory EnhancedTTSService() => _instance;
  EnhancedTTSService._internal();

  FlutterTts? _flutterTts;
  AudioPlayer? _audioPlayer;
  bool _isInitialized = false;
  bool _isPlaying = false;

  // TTS Configuration for Learning
  static const String _amharicLanguage = 'am-ET'; // Amharic (Ethiopia)
  static const String _englishLanguage = 'en-US'; // English (US)
  static const double _learningSpeed = 0.7; // Optimal for learning (more natural)
  static const double _normalSpeed = 1.0; // Normal speed
  static const double _emphasisSpeed = 0.5; // Very slow for emphasis
  static const double _volume = 1.0;
  static const double _pitch = 1.05; // Slightly higher for clarity

  String _preferredVoice = 'female'; // male/female
  double _currentSpeed = _learningSpeed;

  /// Initialize TTS service
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      _flutterTts = FlutterTts();
      _audioPlayer = AudioPlayer();

      // Configure for Amharic
      await _configureTTS();

      // Set up completion handler
      _flutterTts?.setCompletionHandler(() {
        _isPlaying = false;
        debugPrint('✅ TTS playback completed');
      });

      // Set up error handler
      _flutterTts?.setErrorHandler((msg) {
        debugPrint('❌ TTS Error: $msg');
        _isPlaying = false;
      });

      // Set up start handler
      _flutterTts?.setStartHandler(() {
        _isPlaying = true;
        debugPrint('▶️ TTS playback started');
      });

      _isInitialized = true;
      debugPrint('✅ Enhanced TTS Service initialized successfully');
    } catch (e) {
      debugPrint('❌ Failed to initialize Enhanced TTS Service: $e');
      _isInitialized = false;
    }
  }

  /// Configure TTS settings
  Future<void> _configureTTS() async {
    if (_flutterTts == null) return;

    try {
      // Set language
      await _flutterTts!.setLanguage(_amharicLanguage);
      
      // Set voice parameters
      await _flutterTts!.setSpeechRate(_currentSpeed);
      await _flutterTts!.setVolume(_volume);
      await _flutterTts!.setPitch(_pitch);

      // iOS specific settings for better quality
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        await _flutterTts!.setIosAudioCategory(
          IosTextToSpeechAudioCategory.playback,
          [
            IosTextToSpeechAudioCategoryOptions.allowBluetooth,
            IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
            IosTextToSpeechAudioCategoryOptions.mixWithOthers,
            IosTextToSpeechAudioCategoryOptions.defaultToSpeaker,
          ],
          IosTextToSpeechAudioMode.spokenAudio,
        );
      }

      // Check if Amharic is supported
      final languages = await _flutterTts!.getLanguages;
      final amharicSupported = languages?.toString().contains('am') ?? false;
      
      if (!amharicSupported) {
        debugPrint('⚠️ Amharic TTS not available on this device');
        debugPrint('💡 Will use fallback methods for pronunciation');
      }
    } catch (e) {
      debugPrint('❌ Error configuring TTS: $e');
    }
  }

  /// Speak Amharic text (primary method)
  /// Format: "selam/ሰላም" or just "ሰላም"
  Future<void> speakAmharic(
    String text, {
    double? speed,
    bool useTransliteration = false,
  }) async {
    if (!_isInitialized) {
      await initialize();
    }

    if (_isPlaying) {
      await stop();
    }

    try {
      // Extract Amharic script from format "transliteration/ሰላም"
      final amharicText = _extractAmharic(text);
      
      // Try to set Amharic language
      await _flutterTts?.setLanguage(_amharicLanguage);
      
      // Set speed
      if (speed != null) {
        await _flutterTts?.setSpeechRate(speed);
      } else {
        await _flutterTts?.setSpeechRate(_currentSpeed);
      }

      // Speak
      final result = await _flutterTts?.speak(amharicText);
      
      if (result == 0) {
        debugPrint('❌ TTS failed to speak: $amharicText');
        // Fallback to transliteration if available
        if (useTransliteration) {
          final transliteration = _extractTransliteration(text);
          await _speakTransliteration(transliteration);
        }
      } else {
        debugPrint('✅ Speaking Amharic: $amharicText');
      }
    } catch (e) {
      debugPrint('❌ Error speaking Amharic: $e');
      // Try fallback methods
      await _fallbackSpeak(text);
    }
  }

  /// Speak English text (for translations)
  Future<void> speakEnglish(String text, {double? speed}) async {
    if (!_isInitialized) {
      await initialize();
    }

    if (_isPlaying) {
      await stop();
    }

    try {
      await _flutterTts?.setLanguage(_englishLanguage);
      await _flutterTts?.setSpeechRate(speed ?? _normalSpeed);
      await _flutterTts?.speak(text);
      debugPrint('✅ Speaking English: $text');
    } catch (e) {
      debugPrint('❌ Error speaking English: $e');
    }
  }

  /// Speak transliteration (fallback method)
  Future<void> _speakTransliteration(String transliteration) async {
    try {
      // Use English TTS to pronounce transliteration
      await _flutterTts?.setLanguage(_englishLanguage);
      await _flutterTts?.setSpeechRate(_learningSpeed); // Slow for learning
      await _flutterTts?.speak(transliteration);
      debugPrint('✅ Speaking transliteration: $transliteration');
    } catch (e) {
      debugPrint('❌ Error speaking transliteration: $e');
    }
  }

  /// Fallback speak method using Google Translate TTS
  Future<void> _fallbackSpeak(String text) async {
    try {
      final amharicText = _extractAmharic(text);
      final url = 'https://translate.google.com/translate_tts?'
          'ie=UTF-8&tl=am&client=tw-ob&q=${Uri.encodeComponent(amharicText)}';
      
      await _audioPlayer?.play(UrlSource(url));
      debugPrint('✅ Using Google TTS fallback for: $amharicText');
    } catch (e) {
      debugPrint('❌ Fallback TTS failed: $e');
    }
  }

  /// Extract Amharic script from "transliteration/ሰላም" format
  String _extractAmharic(String text) {
    if (text.contains('/')) {
      return text.split('/').last.trim();
    }
    return text;
  }

  /// Extract transliteration from "transliteration/ሰላም" format
  String _extractTransliteration(String text) {
    if (text.contains('/')) {
      return text.split('/').first.trim();
    }
    return text;
  }

  /// Stop current speech
  Future<void> stop() async {
    try {
      await _flutterTts?.stop();
      await _audioPlayer?.stop();
      _isPlaying = false;
      debugPrint('⏹️ TTS stopped');
    } catch (e) {
      debugPrint('❌ Error stopping TTS: $e');
    }
  }

  /// Pause current speech
  Future<void> pause() async {
    try {
      await _flutterTts?.pause();
      await _audioPlayer?.pause();
      _isPlaying = false;
      debugPrint('⏸️ TTS paused');
    } catch (e) {
      debugPrint('❌ Error pausing TTS: $e');
    }
  }

  /// Set speech speed
  Future<void> setSpeed(double speed) async {
    _currentSpeed = speed.clamp(0.1, 2.0);
    await _flutterTts?.setSpeechRate(_currentSpeed);
    debugPrint('🎚️ TTS speed set to: $_currentSpeed');
  }

  /// Set learning mode (slower speech)
  Future<void> setLearningMode(bool enabled) async {
    _currentSpeed = enabled ? _learningSpeed : _normalSpeed;
    await _flutterTts?.setSpeechRate(_currentSpeed);
    debugPrint('📚 Learning mode: ${enabled ? "ON" : "OFF"}');
  }

  /// Set preferred voice (male/female)
  Future<void> setPreferredVoice(String voice) async {
    _preferredVoice = voice;
    // Note: Voice selection is platform-dependent and may not always be available
    debugPrint('🎤 Preferred voice set to: $voice');
  }

  /// Check if TTS is currently playing
  bool get isPlaying => _isPlaying;

  /// Check if TTS is initialized
  bool get isInitialized => _isInitialized;

  /// Get available languages
  Future<List<String>> getAvailableLanguages() async {
    try {
      final languages = await _flutterTts?.getLanguages;
      return List<String>.from(languages ?? []);
    } catch (e) {
      debugPrint('❌ Error getting languages: $e');
      return [];
    }
  }

  /// Check if Amharic is supported
  Future<bool> isAmharicSupported() async {
    final languages = await getAvailableLanguages();
    return languages.any((lang) => lang.toLowerCase().contains('am'));
  }

  /// Dispose resources
  Future<void> dispose() async {
    try {
      await stop();
      await _flutterTts?.stop();
      await _audioPlayer?.dispose();
      _isInitialized = false;
      debugPrint('🗑️ Enhanced TTS Service disposed');
    } catch (e) {
      debugPrint('❌ Error disposing TTS: $e');
    }
  }

  /// Speak word with emphasis (for vocabulary learning)
  Future<void> speakWordWithEmphasis(String word) async {
    // Speak slowly for learning, then at normal speed for practice
    await speakAmharic(word, speed: _emphasisSpeed); // Very slow - 0.5
    await Future.delayed(const Duration(milliseconds: 800));
    await speakAmharic(word, speed: _learningSpeed); // Learning speed - 0.7
    await Future.delayed(const Duration(milliseconds: 600));
    await speakAmharic(word, speed: _normalSpeed); // Normal speed - 1.0
  }

  /// Speak sentence word by word (for learning)
  Future<void> speakSentenceWordByWord(List<String> words) async {
    for (final word in words) {
      await speakAmharic(word, speed: 0.5);
      await Future.delayed(const Duration(milliseconds: 300));
    }
  }

  /// Test TTS with sample phrase
  Future<void> testTTS() async {
    debugPrint('🧪 Testing TTS...');
    await speakAmharic('selam/ሰላም'); // Hello
    await Future.delayed(const Duration(seconds: 2));
    await speakEnglish('Hello, welcome to Amharic learning!');
  }
}

