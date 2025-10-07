import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  final AudioPlayer _audioPlayer = AudioPlayer();
  
  /// Play Amharic text using Google Translate TTS
  Future<void> playAmharicText(String text) async {
    try {
      if (kIsWeb) {
        // Use Web Speech API for web platform
        await _useWebSpeechAPI(text, 'am');
      } else {
        // Use Google Translate TTS URL for Amharic
        final ttsUrl = 'https://translate.google.com/translate_tts?ie=UTF-8&tl=am&client=tw-ob&q=${Uri.encodeComponent(text)}';
        
        // Play directly from URL
        await _audioPlayer.play(UrlSource(ttsUrl));
      }
    } catch (e) {
      print('Error playing Amharic audio: $e');
      // Fallback: try to play a local audio file if available
      await _playFallbackAudio(text);
    }
  }

  /// Play English text using Google Translate TTS
  Future<void> playEnglishText(String text) async {
    try {
      if (kIsWeb) {
        // Use Web Speech API for web platform
        await _useWebSpeechAPI(text, 'en');
      } else {
        final ttsUrl = 'https://translate.google.com/translate_tts?ie=UTF-8&tl=en&client=tw-ob&q=${Uri.encodeComponent(text)}';
        await _audioPlayer.play(UrlSource(ttsUrl));
      }
    } catch (e) {
      print('Error playing English audio: $e');
    }
  }

  /// Play audio from a specific language
  Future<void> playTextInLanguage(String text, String languageCode) async {
    try {
      if (kIsWeb) {
        // Use Web Speech API for web platform
        await _useWebSpeechAPI(text, languageCode);
      } else {
        final ttsUrl = 'https://translate.google.com/translate_tts?ie=UTF-8&tl=$languageCode&client=tw-ob&q=${Uri.encodeComponent(text)}';
        await _audioPlayer.play(UrlSource(ttsUrl));
      }
    } catch (e) {
      print('Error playing audio in $languageCode: $e');
    }
  }


  /// Use Web Speech API for TTS
  Future<void> _useWebSpeechAPI(String text, String languageCode) async {
    try {
      if (kIsWeb) {
        // Use JavaScript interop to call web TTS
        await _callWebTTS(text, languageCode);
      } else {
        print('🔊 Web TTS: Speaking $languageCode - $text');
        await Future.delayed(Duration(milliseconds: 500));
        print('✅ TTS completed for: $text');
      }
    } catch (e) {
      print('Web Speech API error: $e');
    }
  }

  /// Call JavaScript TTS function
  Future<void> _callWebTTS(String text, String languageCode) async {
    try {
      // This would use js interop in a real implementation
      // For now, we'll simulate the TTS
      print('🔊 Web TTS: Speaking $languageCode - $text');
      await Future.delayed(Duration(milliseconds: 1000));
      print('✅ TTS completed for: $text');
    } catch (e) {
      print('JavaScript TTS error: $e');
    }
  }

  /// Fallback method to play local audio files
  Future<void> _playFallbackAudio(String text) async {
    try {
      // Map common Amharic words to local audio files
      final audioMap = {
        'ሰላም': 'assets/audio/amharic/hello.mp3',
        'አመሰግናለሁ': 'assets/audio/amharic/thank_you.mp3',
        'ባይ': 'assets/audio/amharic/water.mp3',
        'ምግብ': 'assets/audio/amharic/food.mp3',
        'ቤት': 'assets/audio/amharic/house.mp3',
        'መኪና': 'assets/audio/amharic/car.mp3',
      };

      final audioPath = audioMap[text];
      if (audioPath != null) {
        await _audioPlayer.play(AssetSource(audioPath));
      }
    } catch (e) {
      print('Error playing fallback audio: $e');
    }
  }

  /// Stop current audio playback
  Future<void> stopAudio() async {
    await _audioPlayer.stop();
  }

  /// Play Amharic text (alias for playAmharicText)
  Future<void> speakAmharic(String text) async {
    await playAmharicText(text);
  }

  /// Play English text (alias for playEnglishText)
  Future<void> speakEnglish(String text) async {
    await playEnglishText(text);
  }

  /// Play tap sound effect
  Future<void> playTapSound() async {
    // Simple tone for tap feedback
    // TODO: Add actual sound effect asset
    print('🔊 Tap sound');
  }

  /// Play success sound effect
  Future<void> playSuccessSound() async {
    // Play a success chime
    // TODO: Add actual sound effect asset
    print('✅ Success sound');
  }

  /// Play error sound effect
  Future<void> playErrorSound() async {
    // Play an error buzz
    // TODO: Add actual sound effect asset
    print('❌ Error sound');
  }

  /// Dispose audio player
  void dispose() {
    _audioPlayer.dispose();
  }

  /// Get language code for different languages
  static String getLanguageCode(String languageName) {
    switch (languageName.toLowerCase()) {
      case 'english':
        return 'en';
      case 'mandarin':
      case 'chinese':
        return 'zh';
      case 'french':
        return 'fr';
      case 'german':
        return 'de';
      case 'spanish':
        return 'es';
      case 'arabic':
        return 'ar';
      case 'portuguese':
        return 'pt';
      case 'russian':
        return 'ru';
      case 'japanese':
        return 'ja';
      case 'amharic':
        return 'am';
      default:
        return 'en';
    }
  }
}

