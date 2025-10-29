import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:audioplayers/audioplayers.dart';

/// Audio Service for handling text-to-speech functionality
/// Uses flutter_tts for TTS and audioplayers for audio playback
class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal() {
    _initialize();
  }

  FlutterTts? _flutterTts;
  AudioPlayer? _audioPlayer;
  bool _isInitialized = false;
  bool _isPlaying = false;

  /// Initialize TTS and audio player
  Future<void> _initialize() async {
    if (_isInitialized) return;

    try {
      _flutterTts = FlutterTts();
      _audioPlayer = AudioPlayer();

      // Configure TTS
      await _flutterTts?.setVolume(1.0);
      await _flutterTts?.setSpeechRate(0.7); // Optimal for learning
      await _flutterTts?.setPitch(1.05); // Slightly higher for clarity

      // Set up handlers
      _flutterTts?.setStartHandler(() {
        _isPlaying = true;
        if (kDebugMode) {
          debugPrint('▶️ Audio started');
        }
      });

      _flutterTts?.setCompletionHandler(() {
        _isPlaying = false;
        if (kDebugMode) {
          debugPrint('✅ Audio completed');
        }
      });

      _flutterTts?.setErrorHandler((msg) {
        _isPlaying = false;
        if (kDebugMode) {
          debugPrint('❌ Audio error: $msg');
        }
      });

      _isInitialized = true;
      if (kDebugMode) {
        debugPrint('✅ AudioService initialized successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Failed to initialize AudioService: $e');
      }
      _isInitialized = false;
    }
  }

  /// Play Amharic text using TTS
  Future<void> playAmharicText(String text) async {
    if (!_isInitialized) {
      await _initialize();
    }

    try {
      if (_isPlaying) {
        await stop();
      }

      // Extract Amharic text from "transliteration/አማርኛ" format
      final amharicText = _extractAmharicText(text);

      if (kDebugMode) {
        debugPrint('🔊 Playing Amharic text: $amharicText');
      }

      // Try Amharic TTS with multiple fallbacks
      await _flutterTts?.setLanguage('am-ET');
      final result = await _flutterTts?.speak(amharicText);

      if (result == 0) {
        // Try alternative Amharic language codes
        await _flutterTts?.setLanguage('am');
        final result2 = await _flutterTts?.speak(amharicText);
        
        if (result2 == 0) {
          // Fallback to Google TTS if device doesn't support Amharic
          await _fallbackGoogleTTS(amharicText, 'am');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error playing Amharic text: $e');
      }
      // Try fallback methods
      try {
        await _fallbackGoogleTTS(_extractAmharicText(text), 'am');
      } catch (fallbackError) {
        if (kDebugMode) {
          debugPrint('❌ Fallback TTS also failed: $fallbackError');
        }
      }
    }
  }

  /// Play English text using TTS
  Future<void> playEnglishText(String text) async {
    if (!_isInitialized) {
      await _initialize();
    }

    try {
      if (_isPlaying) {
        await stop();
      }

      if (kDebugMode) {
        debugPrint('🔊 Playing English text: $text');
      }

      await _flutterTts?.setLanguage('en-US');
      await _flutterTts?.speak(text);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error playing English text: $e');
      }
      rethrow;
    }
  }

  /// Play text in specific language
  Future<void> playTextInLanguage(String text, String languageCode) async {
    if (!_isInitialized) {
      await _initialize();
    }

    try {
      if (_isPlaying) {
        await stop();
      }

      if (kDebugMode) {
        debugPrint('🔊 Playing text in $languageCode: $text');
      }

      await _flutterTts?.setLanguage(languageCode);
      final result = await _flutterTts?.speak(text);

      if (result == 0) {
        // Fallback to Google TTS
        await _fallbackGoogleTTS(text, languageCode.split('-').first);
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error playing text in $languageCode: $e');
      }
      rethrow;
    }
  }

  /// Fallback to Google Translate TTS
  Future<void> _fallbackGoogleTTS(String text, String lang) async {
    try {
      final url = 'https://translate.google.com/translate_tts?'
          'ie=UTF-8&tl=$lang&client=tw-ob&q=${Uri.encodeComponent(text)}';

      await _audioPlayer?.play(UrlSource(url));
      if (kDebugMode) {
        debugPrint('🔊 Using Google TTS fallback for: $text');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Fallback TTS failed: $e');
      }
    }
  }

  /// Extract Amharic text from "transliteration/አማርኛ" format
  String _extractAmharicText(String text) {
    if (text.contains('/')) {
      return text.split('/').last.trim();
    }
    return text;
  }

  /// Speak Amharic text
  Future<void> speakAmharic(String text) async {
    return playAmharicText(text);
  }

  /// Speak English text
  Future<void> speakEnglish(String text) async {
    return playEnglishText(text);
  }

  /// Stop any currently playing audio
  Future<void> stop() async {
    try {
      await _flutterTts?.stop();
      if (_audioPlayer != null) {
        try {
          await _audioPlayer!.stop();
        } catch (e) {
          // Ignore errors if player is already disposed
          if (kDebugMode) {
            debugPrint('⚠️ Audio player stop error (likely disposed): $e');
          }
        }
      }
      _isPlaying = false;
      if (kDebugMode) {
        debugPrint('⏹️ Audio stopped');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error stopping audio: $e');
      }
    }
  }

  /// Stop audio (alias for stop)
  Future<void> stopAudio() async {
    return stop();
  }

  /// Set speech rate (0.1 to 2.0)
  Future<void> setSpeechRate(double rate) async {
    try {
      await _flutterTts?.setSpeechRate(rate.clamp(0.1, 2.0));
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error setting speech rate: $e');
      }
    }
  }

  /// Set volume (0.0 to 1.0)
  Future<void> setVolume(double volume) async {
    try {
      await _flutterTts?.setVolume(volume.clamp(0.0, 1.0));
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error setting volume: $e');
      }
    }
  }

  /// Set pitch (0.5 to 2.0)
  Future<void> setPitch(double pitch) async {
    try {
      await _flutterTts?.setPitch(pitch.clamp(0.5, 2.0));
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error setting pitch: $e');
      }
    }
  }

  /// Check if currently playing
  bool get isPlaying => _isPlaying;

  /// Check if initialized
  bool get isInitialized => _isInitialized;

  /// Dispose of resources
  Future<void> dispose() async {
    try {
      await stop();
      if (_audioPlayer != null) {
        try {
          await _audioPlayer!.dispose();
        } catch (e) {
          // Ignore errors if player is already disposed
          if (kDebugMode) {
            debugPrint('⚠️ Audio player dispose error (likely already disposed): $e');
          }
        }
      }
      _audioPlayer = null;
      _isInitialized = false;
      if (kDebugMode) {
        debugPrint('🗑️ AudioService disposed');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error disposing AudioService: $e');
      }
    }
  }
}