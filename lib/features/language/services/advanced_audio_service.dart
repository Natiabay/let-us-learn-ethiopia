import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final advancedAudioServiceProvider = Provider<AdvancedAudioService>((ref) {
  return AdvancedAudioService();
});

class AdvancedAudioService {
  final FlutterTts _flutterTts = FlutterTts();
  final AudioPlayer _audioPlayer = AudioPlayer();
  
  bool _isInitialized = false;
  Map<String, String> _cachedAudioFiles = {};

  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // Configure TTS for Amharic
      await _flutterTts.setLanguage('am-ET'); // Amharic (Ethiopia)
      await _flutterTts.setSpeechRate(0.5);
      await _flutterTts.setVolume(1.0);
      await _flutterTts.setPitch(1.0);
      
      // Set up TTS callbacks
      _flutterTts.setStartHandler(() {
        debugPrint('TTS Started');
      });
      
      _flutterTts.setCompletionHandler(() {
        debugPrint('TTS Completed');
      });
      
      _flutterTts.setErrorHandler((msg) {
        debugPrint('TTS Error: $msg');
      });

      _isInitialized = true;
    } catch (e) {
      debugPrint('Audio service initialization error: $e');
    }
  }

  Future<void> speakAmharic(String text) async {
    await initialize();
    try {
      await _flutterTts.setLanguage('am-ET');
      await _flutterTts.speak(text);
    } catch (e) {
      debugPrint('Amharic TTS error: $e');
    }
  }

  Future<void> speakEnglish(String text) async {
    await initialize();
    try {
      await _flutterTts.setLanguage('en-US');
      await _flutterTts.speak(text);
    } catch (e) {
      debugPrint('English TTS error: $e');
    }
  }

  Future<void> speakWithLanguage(String text, String languageCode) async {
    await initialize();
    try {
      await _flutterTts.setLanguage(languageCode);
      await _flutterTts.speak(text);
    } catch (e) {
      debugPrint('TTS error for $languageCode: $e');
    }
  }

  Future<void> playAudioFile(String audioUrl) async {
    try {
      if (audioUrl.startsWith('http')) {
        await _audioPlayer.play(UrlSource(audioUrl));
      } else {
        await _audioPlayer.play(AssetSource(audioUrl));
      }
    } catch (e) {
      debugPrint('Audio playback error: $e');
    }
  }

  Future<void> playCachedAudio(String text, String language) async {
    try {
      final cacheKey = '${language}_$text';
      
      if (_cachedAudioFiles.containsKey(cacheKey)) {
        final filePath = _cachedAudioFiles[cacheKey]!;
        await _audioPlayer.play(DeviceFileSource(filePath));
      } else {
        // Generate and cache audio file
        final audioFile = await _generateAndCacheAudio(text, language);
        if (audioFile != null) {
          _cachedAudioFiles[cacheKey] = audioFile;
          await _audioPlayer.play(DeviceFileSource(audioFile));
        } else {
          // Fallback to TTS
          await speakWithLanguage(text, language);
        }
      }
    } catch (e) {
      debugPrint('Cached audio playback error: $e');
      // Fallback to TTS
      await speakWithLanguage(text, language);
    }
  }

  Future<String?> _generateAndCacheAudio(String text, String language) async {
    if (kIsWeb) {
      // On web, we can't save files to local storage
      debugPrint('Audio caching not supported on web platform');
      return null;
    }
    
    try {
      final directory = await getApplicationDocumentsDirectory();
      // Note: File operations are not available on web platform
      final fileName = '${language}_${text.hashCode}.wav';
      
      // For now, we'll use TTS to generate audio
      // In a real implementation, you might use Google Cloud Text-to-Speech API
      await _flutterTts.setLanguage(language);
      await _flutterTts.speak(text);
      
      return fileName; // Return just the filename for web compatibility
    } catch (e) {
      debugPrint('Audio generation error: $e');
      return null;
    }
  }

  Future<void> downloadAndCacheAudio(String audioUrl, String fileName) async {
    if (kIsWeb) {
      // On web, we can't save files to local storage
      debugPrint('Audio download and caching not supported on web platform');
      return;
    }
    
    try {
      final directory = await getApplicationDocumentsDirectory();
      // Note: File operations are not available on web platform
      debugPrint('Audio download and caching not supported on web platform');
    } catch (e) {
      debugPrint('Audio download error: $e');
    }
  }

  Future<List<String>> getAvailableLanguages() async {
    await initialize();
    try {
      final languages = await _flutterTts.getLanguages;
      return languages.cast<String>();
    } catch (e) {
      debugPrint('Get languages error: $e');
      return ['en-US', 'am-ET']; // Default fallback
    }
  }

  Future<List<String>> getAvailableVoices() async {
    await initialize();
    try {
      final voices = await _flutterTts.getVoices;
      return voices.map((voice) => voice['name'] as String).toList();
    } catch (e) {
      debugPrint('Get voices error: $e');
      return [];
    }
  }

  Future<void> setVoice(String voiceName) async {
    await initialize();
    try {
      await _flutterTts.setVoice({'name': voiceName, 'locale': 'am-ET'});
    } catch (e) {
      debugPrint('Set voice error: $e');
    }
  }

  Future<void> setSpeechRate(double rate) async {
    await initialize();
    try {
      await _flutterTts.setSpeechRate(rate);
    } catch (e) {
      debugPrint('Set speech rate error: $e');
    }
  }

  Future<void> setVolume(double volume) async {
    await initialize();
    try {
      await _flutterTts.setVolume(volume);
    } catch (e) {
      debugPrint('Set volume error: $e');
    }
  }

  Future<void> setPitch(double pitch) async {
    await initialize();
    try {
      await _flutterTts.setPitch(pitch);
    } catch (e) {
      debugPrint('Set pitch error: $e');
    }
  }

  Future<void> stop() async {
    try {
      await _flutterTts.stop();
      await _audioPlayer.stop();
    } catch (e) {
      debugPrint('Stop audio error: $e');
    }
  }

  Future<void> pause() async {
    try {
      await _audioPlayer.pause();
    } catch (e) {
      debugPrint('Pause audio error: $e');
    }
  }

  Future<void> resume() async {
    try {
      await _audioPlayer.resume();
    } catch (e) {
      debugPrint('Resume audio error: $e');
    }
  }

  Future<Duration?> getDuration() async {
    try {
      return await _audioPlayer.getDuration();
    } catch (e) {
      debugPrint('Get duration error: $e');
      return null;
    }
  }

  Future<Duration?> getCurrentPosition() async {
    try {
      return await _audioPlayer.getCurrentPosition();
    } catch (e) {
      debugPrint('Get current position error: $e');
      return null;
    }
  }

  Stream<Duration> get onPositionChanged => _audioPlayer.onPositionChanged;
  Stream<Duration> get onDurationChanged => _audioPlayer.onDurationChanged;
  Stream<PlayerState> get onPlayerStateChanged => _audioPlayer.onPlayerStateChanged;

  void dispose() {
    _flutterTts.stop();
    _audioPlayer.dispose();
  }
}

