import 'package:flutter/foundation.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';

/// Speech-to-Text Service for voice recognition
/// Handles speech recognition with proper permissions
class SpeechService {
  static final SpeechService _instance = SpeechService._internal();
  factory SpeechService() => _instance;
  SpeechService._internal();

  stt.SpeechToText? _speech;
  bool _isInitialized = false;
  bool _isListening = false;
  String _recognizedText = '';

  /// Initialize speech recognition
  Future<bool> initialize() async {
    if (_isInitialized) return true;

    try {
      // Request microphone permission
      final permissionStatus = await Permission.microphone.request();
      if (!permissionStatus.isGranted) {
        if (kDebugMode) {
          debugPrint('❌ Microphone permission denied');
        }
        return false;
      }

      _speech = stt.SpeechToText();
      final available = await _speech!.initialize(
        onError: (error) {
          if (kDebugMode) {
            debugPrint('❌ Speech recognition error: ${error.errorMsg}');
          }
          _isListening = false;
        },
        onStatus: (status) {
          if (kDebugMode) {
            debugPrint('🎤 Speech recognition status: $status');
          }
          if (status == 'done' || status == 'notListening') {
            _isListening = false;
          }
        },
      );

      _isInitialized = available;
      if (kDebugMode) {
        if (available) {
          debugPrint('✅ Speech recognition initialized successfully');
        } else {
          debugPrint('❌ Speech recognition not available on this device');
        }
      }
      return available;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Failed to initialize speech recognition: $e');
      }
      _isInitialized = false;
      return false;
    }
  }

  /// Start listening for speech
  Future<bool> startListening({
    required Function(String) onResult,
    String? languageCode,
    bool partialResults = true,
  }) async {
    if (!_isInitialized) {
      final initialized = await initialize();
      if (!initialized) return false;
    }

    if (_isListening) {
      await stopListening();
    }

    try {
      _recognizedText = '';
      
      // Try multiple language codes for better compatibility
      final localeId = _getBestLocaleId(languageCode);
      
      await _speech!.listen(
        onResult: (result) {
          _recognizedText = result.recognizedWords;
          if (kDebugMode) {
            debugPrint('🎤 Recognized: $_recognizedText (${result.finalResult ? "final" : "partial"})');
          }
          onResult(_recognizedText);
        },
        localeId: localeId,
        partialResults: partialResults,
        listenMode: stt.ListenMode.confirmation,
        cancelOnError: false, // Don't cancel on error, try to continue
        listenFor: const Duration(seconds: 30),
        pauseFor: const Duration(seconds: 3),
      );

      _isListening = true;
      if (kDebugMode) {
        debugPrint('🎤 Started listening in locale: $localeId');
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error starting speech recognition: $e');
      }
      _isListening = false;
      return false;
    }
  }

  /// Get the best available locale ID for the given language code
  String _getBestLocaleId(String? languageCode) {
    if (languageCode == null) return 'en_US';
    
    // Try to find the best match from available locales
    switch (languageCode.toLowerCase()) {
      case 'am':
      case 'amharic':
        return 'am_ET';
      case 'en':
      case 'english':
        return 'en_US';
      case 'es':
      case 'spanish':
        return 'es_ES';
      case 'fr':
      case 'french':
        return 'fr_FR';
      case 'de':
      case 'german':
        return 'de_DE';
      default:
        return 'en_US';
    }
  }

  /// Stop listening
  Future<void> stopListening() async {
    try {
      await _speech?.stop();
      _isListening = false;
      if (kDebugMode) {
        debugPrint('⏹️ Stopped listening');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error stopping speech recognition: $e');
      }
    }
  }

  /// Cancel listening
  Future<void> cancelListening() async {
    try {
      await _speech?.cancel();
      _isListening = false;
      _recognizedText = '';
      if (kDebugMode) {
        debugPrint('❌ Cancelled listening');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error cancelling speech recognition: $e');
      }
    }
  }

  /// Get available locales
  Future<List<stt.LocaleName>> getAvailableLocales() async {
    if (!_isInitialized) {
      await initialize();
    }

    try {
      final locales = await _speech?.locales() ?? [];
      if (kDebugMode) {
        debugPrint('📝 Available locales: ${locales.length}');
      }
      return locales;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error getting locales: $e');
      }
      return [];
    }
  }

  /// Check if Amharic is supported
  Future<bool> isAmharicSupported() async {
    final locales = await getAvailableLocales();
    return locales.any((locale) => 
      locale.localeId.toLowerCase().contains('am') ||
      locale.name.toLowerCase().contains('amharic')
    );
  }

  /// Get last recognized text
  String get recognizedText => _recognizedText;

  /// Check if currently listening
  bool get isListening => _isListening;

  /// Check if initialized
  bool get isInitialized => _isInitialized;

  /// Check if speech recognition is available
  Future<bool> isAvailable() async {
    if (!_isInitialized) {
      return await initialize();
    }
    return _speech?.isAvailable ?? false;
  }

  /// Dispose resources
  Future<void> dispose() async {
    try {
      await stopListening();
      _isInitialized = false;
      _recognizedText = '';
      if (kDebugMode) {
        debugPrint('🗑️ Speech service disposed');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error disposing speech service: $e');
      }
    }
  }
}

/// Language locale codes for speech recognition
class SpeechLocales {
  static const String english = 'en_US';
  static const String amharic = 'am_ET';
  static const String spanish = 'es_ES';
  static const String french = 'fr_FR';
  static const String german = 'de_DE';
  static const String italian = 'it_IT';
  static const String portuguese = 'pt_PT';
  static const String russian = 'ru_RU';
  static const String japanese = 'ja_JP';
  static const String chinese = 'zh_CN';
  static const String arabic = 'ar_SA';

  static const Map<String, String> localeNames = {
    'en': 'en_US',
    'am': 'am_ET',
    'es': 'es_ES',
    'fr': 'fr_FR',
    'de': 'de_DE',
    'it': 'it_IT',
    'pt': 'pt_PT',
    'ru': 'ru_RU',
    'ja': 'ja_JP',
    'zh': 'zh_CN',
    'ar': 'ar_SA',
  };

  static String getLocaleId(String languageCode) {
    return localeNames[languageCode] ?? 'en_US';
  }
}




