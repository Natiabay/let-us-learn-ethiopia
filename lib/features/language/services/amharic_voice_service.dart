import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:audioplayers/audioplayers.dart';

/// Amharic Voice Service for Real Pronunciation
/// Integrates with TTS and audio services for authentic Amharic pronunciation
class AmharicVoiceService {
  static final AmharicVoiceService _instance = AmharicVoiceService._internal();
  factory AmharicVoiceService() => _instance;
  AmharicVoiceService._internal();

  FlutterTts? _flutterTts;
  AudioPlayer? _audioPlayer;
  bool _isInitialized = false;
  String? _lastSpokenText;

  /// Initialize the voice service
  Future<void> initialize() async {
    try {
      _flutterTts = FlutterTts();
      _audioPlayer = AudioPlayer();
      
      // Configure TTS for Amharic
      await _flutterTts?.setLanguage('am-ET'); // Amharic (Ethiopia)
      await _flutterTts?.setSpeechRate(0.5); // Slower for learning
      await _flutterTts?.setVolume(1.0);
      await _flutterTts?.setPitch(1.0);
      
      _isInitialized = true;
      debugPrint('✅ Amharic Voice Service initialized successfully');
    } catch (e) {
      debugPrint('❌ Failed to initialize Amharic Voice Service: $e');
      _isInitialized = false;
    }
  }

  /// Speak Amharic text with TTS
  Future<void> speakAmharic(String amharicText, {String? englishTranslation}) async {
    if (!_isInitialized || _flutterTts == null) {
      debugPrint('⚠️ Voice service not initialized');
      return;
    }

    try {
      _lastSpokenText = amharicText; // Store the last spoken text
      // Speak the Amharic text
      await _flutterTts!.speak(amharicText);
      
      // If English translation provided, speak it after a delay
      if (englishTranslation != null) {
        await Future.delayed(const Duration(seconds: 2));
        await _flutterTts!.setLanguage('en-US');
        await _flutterTts!.speak(englishTranslation);
        await _flutterTts!.setLanguage('am-ET'); // Reset to Amharic
      }
    } catch (e) {
      debugPrint('❌ Error speaking Amharic: $e');
    }
  }

  /// Play pre-recorded audio file
  Future<void> playAudioFile(String audioUrl) async {
    if (!_isInitialized || _audioPlayer == null) {
      debugPrint('⚠️ Audio player not initialized');
      return;
    }

    try {
      await _audioPlayer!.play(UrlSource(audioUrl));
    } catch (e) {
      debugPrint('❌ Error playing audio file: $e');
    }
  }

  /// Stop current speech/audio
  Future<void> stop() async {
    try {
      await _flutterTts?.stop();
      await _audioPlayer?.stop();
    } catch (e) {
      debugPrint('❌ Error stopping audio: $e');
    }
  }

  /// Pause current speech/audio
  Future<void> pause() async {
    try {
      await _flutterTts?.pause();
      await _audioPlayer?.pause();
    } catch (e) {
      debugPrint('❌ Error pausing audio: $e');
    }
  }

  /// Resume paused speech/audio
  Future<void> resume() async {
    try {
      // flutter_tts doesn't have resume method, so we restart the speech
      if (_lastSpokenText != null && _lastSpokenText!.isNotEmpty) {
        await _flutterTts?.speak(_lastSpokenText!);
      }
      await _audioPlayer?.resume();
    } catch (e) {
      debugPrint('❌ Error resuming audio: $e');
    }
  }

  /// Set speech rate for learning
  Future<void> setSpeechRate(double rate) async {
    if (_flutterTts != null) {
      await _flutterTts!.setSpeechRate(rate);
    }
  }

  /// Set volume level
  Future<void> setVolume(double volume) async {
    if (_flutterTts != null) {
      await _flutterTts!.setVolume(volume);
    }
  }

  /// Get available languages
  Future<List<String>> getAvailableLanguages() async {
    if (_flutterTts == null) return [];
    
    try {
      final languages = await _flutterTts!.getLanguages;
      return languages.cast<String>();
    } catch (e) {
      debugPrint('❌ Error getting languages: $e');
      return [];
    }
  }

  /// Check if Amharic is supported
  Future<bool> isAmharicSupported() async {
    final languages = await getAvailableLanguages();
    return languages.contains('am-ET') || languages.contains('am');
  }

  /// Get pronunciation guide for Amharic text
  String getPronunciationGuide(String amharicText) {
    // Basic pronunciation guide mapping
    final Map<String, String> pronunciationMap = {
      'ሰላም': 'seh-lam',
      'እንደምን ነህ': 'en-dem-en neh',
      'ደህና ነኝ': 'deh-na neny',
      'ቻው': 'chaw',
      'አመሰግናለሁ': 'ah-meh-seg-na-leh-hu',
      'እባክህ': 'eh-bak-ih',
      'ይቅርታ': 'yiq-er-ta',
      'አዎ': 'a-wo',
      'አይ': 'ay',
      'አንድ': 'and',
      'ሁለት': 'hu-let',
      'ሦስት': 'sost',
      'አራት': 'a-rat',
      'አምስት': 'a-mest',
    };

    return pronunciationMap[amharicText] ?? amharicText;
  }

  /// Speak with pronunciation guide
  Future<void> speakWithGuide(String amharicText, String pronunciation) async {
    if (!_isInitialized || _flutterTts == null) return;

    try {
      // First speak the Amharic text
      await _flutterTts!.speak(amharicText);
      
      // Wait a moment
      await Future.delayed(const Duration(seconds: 1));
      
      // Then speak the pronunciation guide
      await _flutterTts!.setLanguage('en-US');
      await _flutterTts!.speak('Pronounced: $pronunciation');
      await _flutterTts!.setLanguage('am-ET'); // Reset to Amharic
    } catch (e) {
      debugPrint('❌ Error speaking with guide: $e');
    }
  }

  /// Get voice service status
  bool get isInitialized => _isInitialized;

  /// Dispose resources
  Future<void> dispose() async {
    try {
      await _flutterTts?.stop();
      await _audioPlayer?.dispose();
      _flutterTts = null;
      _audioPlayer = null;
      _isInitialized = false;
    } catch (e) {
      debugPrint('❌ Error disposing voice service: $e');
    }
  }
}
