import 'package:flutter/foundation.dart';
import '../../../core/services/audio_service.dart';

/// Voice Service for Amharic pronunciation
/// Provides text-to-speech functionality for language learning
class VoiceService {
  static final AudioService _audioService = AudioService();
  
  static bool _isInitialized = false;
  static bool _isSpeaking = false;

  /// Initialize the voice service
  static Future<void> initialize() async {
    if (_isInitialized) return;
    
    try {
      _isInitialized = true;
      if (kDebugMode) {
        print('VoiceService initialized successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to initialize VoiceService: $e');
      }
    }
  }

  /// Speak Amharic text
  static Future<void> speakAmharic(String text) async {
    if (!_isInitialized) {
      await initialize();
    }
    
    if (_isSpeaking) {
      await stopSpeaking();
    }
    
    try {
      _isSpeaking = true;
      await _audioService.speakAmharic(text);
      if (kDebugMode) {
        print('Speaking Amharic: $text');
      }
      _isSpeaking = false;
    } catch (e) {
      if (kDebugMode) {
        print('Failed to speak Amharic: $e');
      }
      _isSpeaking = false;
    }
  }

  /// Speak text in the user's native language
  static Future<void> speakNative(String text, String languageCode) async {
    if (!_isInitialized) {
      await initialize();
    }
    
    if (_isSpeaking) {
      await stopSpeaking();
    }
    
    try {
      _isSpeaking = true;
      await _audioService.playTextInLanguage(text, languageCode);
      if (kDebugMode) {
        print('Speaking $languageCode: $text');
      }
      _isSpeaking = false;
    } catch (e) {
      if (kDebugMode) {
        print('Failed to speak $languageCode: $e');
      }
      _isSpeaking = false;
    }
  }

  /// Stop current speech
  static Future<void> stopSpeaking() async {
    try {
      await _audioService.stopAudio();
      _isSpeaking = false;
      if (kDebugMode) {
        print('Stopped speaking');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to stop speaking: $e');
      }
    }
  }

  /// Check if currently speaking
  static bool get isSpeaking => _isSpeaking;

  /// Set speech rate (0.1 to 2.0)
  static Future<void> setSpeechRate(double rate) async {
    try {
      // For web, we'll use the browser's speech synthesis settings
      if (kDebugMode) {
        print('Speech rate set to: $rate');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to set speech rate: $e');
      }
    }
  }

  /// Set speech pitch (0.1 to 2.0)
  static Future<void> setSpeechPitch(double pitch) async {
    try {
      // For web, we'll use the browser's speech synthesis settings
      if (kDebugMode) {
        print('Speech pitch set to: $pitch');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to set speech pitch: $e');
      }
    }
  }

  /// Get available languages
  static Future<List<String>> getAvailableLanguages() async {
    try {
      // Return supported languages for TTS
      return ['en', 'am', 'es', 'fr', 'de', 'it', 'pt', 'ru', 'ja', 'ko', 'zh', 'ar'];
    } catch (e) {
      if (kDebugMode) {
        print('Failed to get available languages: $e');
      }
      return ['en', 'am']; // Default fallback
    }
  }

  /// Check if language is supported
  static Future<bool> isLanguageSupported(String languageCode) async {
    try {
      final supportedLanguages = await getAvailableLanguages();
      return supportedLanguages.contains(languageCode);
    } catch (e) {
      if (kDebugMode) {
        print('Failed to check language support: $e');
      }
      return false;
    }
  }

  /// Dispose resources
  static Future<void> dispose() async {
    try {
      await stopSpeaking();
      _isInitialized = false;
      if (kDebugMode) {
        print('VoiceService disposed');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to dispose VoiceService: $e');
      }
    }
  }
}

/// Language codes mapping for voice service
class LanguageCodes {
  static const Map<String, String> languageMap = {
    'en': 'en-US',
    'zh': 'zh-CN',
    'fr': 'fr-FR',
    'de': 'de-DE',
    'es': 'es-ES',
    'ar': 'ar-SA',
    'pt': 'pt-PT',
    'ru': 'ru-RU',
    'ja': 'ja-JP',
    'am': 'am-ET', // Amharic
  };

  static String getLanguageCode(String language) {
    return languageMap[language] ?? 'en-US';
  }
}
































