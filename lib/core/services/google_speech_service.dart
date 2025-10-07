import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:tourist_assistive_app/core/config/environment_config.dart';
// import 'package:speech_to_text/speech_to_text.dart';  // Temporarily disabled

class GoogleSpeechService {
  static const String _baseUrl = 'https://speech.googleapis.com/v1/speech:recognize';
  
  // Get API key from environment config
  static String get _apiKey => EnvironmentConfig.getGoogleCloudKey();
  
  // Temporarily disabled speech_to_text functionality
  /*
  static final SpeechToText _speech = SpeechToText();
  
  static Future<bool> initialize() async {
    return await _speech.initialize();
  }
  
  static Future<void> startListening({
    required Function(String) onResult,
    required Function(String) onError,
    String locale = 'en-US',
  }) async {
    await _speech.listen(
      onResult: (result) => onResult(result.recognizedWords),
      localeId: locale,
      partialResults: true,
      onSoundLevelChange: (level) {},
    );
  }
  
  static Future<void> stopListening() async {
    await _speech.stop();
  }
  
  static bool get isListening => _speech.isListening;
  */
  
  /// Initialize the service
  static Future<bool> initialize() async {
    try {
      final apiKey = _apiKey;
      if (apiKey.isEmpty || apiKey.contains('dev-')) {
        debugPrint('🔄 Google Speech Service running in development mode');
        return false;
      }
      debugPrint('✅ Google Speech Service initialized with real API key');
      return true;
    } catch (e) {
      debugPrint('⚠️ Google Speech Service initialization failed: $e');
      return false;
    }
  }

  // Alternative implementation using Google Cloud Speech-to-Text API
  static Future<String> recognizeSpeechFromFile(String audioFilePath) async {
    try {
      final apiKey = _apiKey;
      if (apiKey.isEmpty || apiKey.contains('dev-')) {
        return 'Speech recognition not available in development mode';
      }
      
      final audioBytes = await File(audioFilePath).readAsBytes();
      final audioBase64 = base64Encode(audioBytes);
      
      final response = await http.post(
        Uri.parse('$_baseUrl?key=$apiKey'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'config': {
            'encoding': 'LINEAR16',
            'sampleRateHertz': 16000,
            'languageCode': 'en-US',
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
      
      return 'Recognition failed';
    } catch (e) {
      debugPrint('Speech recognition error: $e');
      return 'Error: $e';
    }
  }
  
  static Future<String> recognizeSpeechFromBytes(List<int> audioBytes) async {
    try {
      final apiKey = _apiKey;
      if (apiKey.isEmpty || apiKey.contains('dev-')) {
        return 'Speech recognition not available in development mode';
      }
      
      final audioBase64 = base64Encode(audioBytes);
      
      final response = await http.post(
        Uri.parse('$_baseUrl?key=$apiKey'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'config': {
            'encoding': 'LINEAR16',
            'sampleRateHertz': 16000,
            'languageCode': 'en-US',
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
      
      return 'Recognition failed';
    } catch (e) {
      debugPrint('Speech recognition error: $e');
      return 'Error: $e';
    }
  }
}