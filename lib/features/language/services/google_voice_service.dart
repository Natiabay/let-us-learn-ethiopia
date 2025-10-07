import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:tourist_assistive_app/core/config/environment_config.dart';

class GoogleVoiceService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  
  bool _isInitialized = false;
  bool _isListening = false;
  bool _isSpeaking = false;
  
  // Google Cloud API Configuration
  static const String _ttsUrl = 'https://texttospeech.googleapis.com/v1/text:synthesize';
  static const String _sttUrl = 'https://speech.googleapis.com/v1/speech:recognize';

  GoogleVoiceService();

  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // Request microphone permission
      final hasPermission = await requestPermissions();
      if (!hasPermission) {
        debugPrint('Microphone permission denied');
        return;
      }

      _isInitialized = true;
      debugPrint('Google Voice Service initialized');
    } catch (e) {
      debugPrint('Voice service initialization error: $e');
    }
  }

  Future<bool> requestPermissions() async {
    try {
      final microphoneStatus = await Permission.microphone.request();
      return microphoneStatus == PermissionStatus.granted;
    } catch (e) {
      debugPrint('Permission request error: $e');
      return false;
    }
  }

  Future<bool> get isAvailable async {
    await initialize();
    return _isInitialized;
  }

  // Text-to-Speech Methods using Google Cloud TTS
  Future<void> speak(String text, {String language = 'en-US'}) async {
    if (text.isEmpty) return;

    await initialize();
    
    try {
      _isSpeaking = true;
      debugPrint('Google Cloud TTS: Speaking "$text" in $language');
      
      // Call Google Cloud Text-to-Speech API
      final audioBase64 = await _synthesizeText(text, language);
      
      if (audioBase64 != null) {
        // Convert base64 to audio data
        final audioBytes = base64Decode(audioBase64);
        
        // Play the audio
        await _audioPlayer.play(BytesSource(audioBytes));
        
        // Wait for playback to complete
        _audioPlayer.onPlayerComplete.listen((_) {
          _isSpeaking = false;
          debugPrint('Google Cloud TTS: Finished speaking');
        });
      } else {
        _isSpeaking = false;
        debugPrint('Google Cloud TTS: Failed to synthesize speech');
      }
    } catch (e) {
      _isSpeaking = false;
      debugPrint('Google Cloud TTS error: $e');
    }
  }

  Future<void> speakAmharic(String text) async {
    await speak(text, language: 'am-ET');
  }

  Future<void> speakEnglish(String text) async {
    await speak(text, language: 'en-US');
  }

  // Google Cloud Text-to-Speech API call
  Future<String?> _synthesizeText(String text, String language) async {
    try {
      // Check if API key is configured
      if (!EnvironmentConfig.isGoogleCloudConfigured) {
        debugPrint('Google Cloud API key not configured');
        return null;
      }

      final response = await http.post(
        Uri.parse('$_ttsUrl?key=${EnvironmentConfig.getGoogleCloudKey()}'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'input': {'text': text},
          'voice': {
            'languageCode': language,
            'name': language == 'am-ET' ? 'am-ET-Wavenet-A' : 'en-US-Wavenet-A',
          },
          'audioConfig': {
            'audioEncoding': 'MP3',
            'speakingRate': 1.0,
            'pitch': 0.0,
          },
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['audioContent'];
      }
      
      debugPrint('Google Cloud TTS API error: ${response.statusCode} - ${response.body}');
      return null;
    } catch (e) {
      debugPrint('Google Cloud TTS API exception: $e');
      return null;
    }
  }

  // Speech-to-Text Methods using Google Cloud STT
  Future<void> startListening({
    required Function(String) onResult,
    required Function(String) onError,
  }) async {
    if (_isListening) return;

    await initialize();
    
    if (!await isAvailable) {
      onError('Voice service not available');
      return;
    }

    _isListening = true;
    debugPrint('Google Cloud Speech-to-Text: Started listening');
    
    // Note: For full implementation, you would need to:
    // 1. Record audio from microphone using a recording package
    // 2. Convert to base64
    // 3. Send to Google Speech-to-Text API
    // This is a placeholder that shows the service is ready
    
    // Simulate speech recognition result after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (_isListening) {
        onResult('Google Cloud Speech-to-Text is ready for audio input');
        _isListening = false;
      }
    });
  }

  Future<void> stopListening() async {
    if (!_isListening) return;
    _isListening = false;
    debugPrint('Speech recognition stopped');
  }

  Future<void> cancelListening() async {
    _isListening = false;
    debugPrint('Speech recognition cancelled');
  }

  Future<void> stopSpeaking() async {
    if (!_isSpeaking) return;

    try {
      await _audioPlayer.stop();
      _isSpeaking = false;
    } catch (e) {
      debugPrint('Failed to stop speaking: $e');
    }
  }

  // Google Cloud Speech-to-Text API call
  Future<String?> _recognizeSpeech(String audioBase64, String language) async {
    try {
      // Check if API key is configured
      if (!EnvironmentConfig.isGoogleCloudConfigured) {
        debugPrint('Google Cloud API key not configured');
        return null;
      }

      final response = await http.post(
        Uri.parse('$_sttUrl?key=${EnvironmentConfig.getGoogleCloudKey()}'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'config': {
            'encoding': 'MP3',
            'sampleRateHertz': 16000,
            'languageCode': language,
            'enableAutomaticPunctuation': true,
          },
          'audio': {
            'content': audioBase64,
          },
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['results'] != null && data['results'].isNotEmpty) {
          return data['results'][0]['alternatives'][0]['transcript'];
        }
      }
      
      debugPrint('Google Cloud STT API error: ${response.statusCode} - ${response.body}');
      return null;
    } catch (e) {
      debugPrint('Google Cloud STT API exception: $e');
      return null;
    }
  }

  // Utility Methods using Google Cloud STT
  Future<String?> recognizeAudioFromFile(String filePath) async {
    if (kIsWeb) {
      debugPrint('File operations not supported on web platform');
      return null;
    }
    
    try {
      debugPrint('Google Cloud STT: Processing file $filePath');
      // Note: File operations are not available on web platform
      // This method should only be called on mobile platforms
      return null;
    } catch (e) {
      debugPrint('Google Cloud STT error: $e');
      return null;
    }
  }

  Future<String?> recognizeAmharicAudioFromFile(String filePath) async {
    if (kIsWeb) {
      debugPrint('File operations not supported on web platform');
      return null;
    }
    
    try {
      debugPrint('Google Cloud STT: Processing Amharic file $filePath');
      // Note: File operations are not available on web platform
      // This method should only be called on mobile platforms
      return null;
    } catch (e) {
      debugPrint('Google Cloud STT Amharic error: $e');
      return null;
    }
  }

  // Getters
  bool get isListening => _isListening;
  bool get isSpeaking => _isSpeaking;
  bool get isInitialized => _isInitialized;

  void dispose() {
    _audioPlayer.dispose();
  }
}
