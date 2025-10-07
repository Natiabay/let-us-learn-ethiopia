import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class GoogleCloudTranslationService {
  static const String _baseUrl = 'https://translation.googleapis.com/language/translate/v2';
  static const String _ttsUrl = 'https://texttospeech.googleapis.com/v1/text:synthesize';
  static const String _sttUrl = 'https://speech.googleapis.com/v1/speech:recognize';
  
  final String _apiKey;
  
  GoogleCloudTranslationService({required String apiKey}) : _apiKey = apiKey;
  
  // Translation Methods
  Future<String> translateText({
    required String text,
    required String fromLanguage,
    required String toLanguage,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl?key=$_apiKey'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'q': text,
          'source': fromLanguage,
          'target': toLanguage,
          'format': 'text',
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['data'] != null && data['data']['translations'] != null) {
          return data['data']['translations'][0]['translatedText'];
        }
      }
      
      debugPrint('Translation error: ${response.statusCode} - ${response.body}');
      return text; // Return original text if translation fails
    } catch (e) {
      debugPrint('Translation exception: $e');
      return text;
    }
  }

  Future<String> translateToAmharic(String englishText) async {
    return await translateText(
      text: englishText,
      fromLanguage: 'en',
      toLanguage: 'am',
    );
  }

  Future<String> translateToEnglish(String amharicText) async {
    return await translateText(
      text: amharicText,
      fromLanguage: 'am',
      toLanguage: 'en',
    );
  }

  // Text-to-Speech Methods
  Future<String?> synthesizeText({
    required String text,
    required String language,
    String voiceName = 'am-ET-Wavenet-A', // Amharic voice
    double speakingRate = 1.0,
    double pitch = 0.0,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_ttsUrl?key=$_apiKey'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'input': {'text': text},
          'voice': {
            'languageCode': language,
            'name': voiceName,
          },
          'audioConfig': {
            'audioEncoding': 'MP3',
            'speakingRate': speakingRate,
            'pitch': pitch,
          },
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['audioContent'];
      }
      
      debugPrint('TTS error: ${response.statusCode} - ${response.body}');
      return null;
    } catch (e) {
      debugPrint('TTS exception: $e');
      return null;
    }
  }

  Future<String?> synthesizeAmharic(String text) async {
    return await synthesizeText(
      text: text,
      language: 'am-ET',
      voiceName: 'am-ET-Wavenet-A',
    );
  }

  Future<String?> synthesizeEnglish(String text) async {
    return await synthesizeText(
      text: text,
      language: 'en-US',
      voiceName: 'en-US-Wavenet-A',
    );
  }

  // Speech-to-Text Methods
  Future<String?> recognizeSpeech({
    required String audioBase64,
    required String language,
    String encoding = 'MP3',
    int sampleRateHertz = 16000,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_sttUrl?key=$_apiKey'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'config': {
            'encoding': encoding,
            'sampleRateHertz': sampleRateHertz,
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
      
      debugPrint('STT error: ${response.statusCode} - ${response.body}');
      return null;
    } catch (e) {
      debugPrint('STT exception: $e');
      return null;
    }
  }

  Future<String?> recognizeAmharicSpeech(String audioBase64) async {
    return await recognizeSpeech(
      audioBase64: audioBase64,
      language: 'am-ET',
    );
  }

  Future<String?> recognizeEnglishSpeech(String audioBase64) async {
    return await recognizeSpeech(
      audioBase64: audioBase64,
      language: 'en-US',
    );
  }

  // Utility Methods
  Future<List<String>> getSupportedLanguages() async {
    try {
      final response = await http.get(
        Uri.parse('https://translation.googleapis.com/language/translate/v2/languages?key=$_apiKey'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['data'] != null && data['data']['languages'] != null) {
          return data['data']['languages']
              .map<String>((lang) => lang['language'])
              .toList();
        }
      }
      
      return ['en', 'am']; // Default fallback
    } catch (e) {
      debugPrint('Get languages exception: $e');
      return ['en', 'am'];
    }
  }

  Future<String> detectLanguage(String text) async {
    try {
      final response = await http.post(
        Uri.parse('https://translation.googleapis.com/language/translate/v2/detect?key=$_apiKey'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'q': text,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['data'] != null && data['data']['detections'] != null) {
          return data['data']['detections'][0][0]['language'];
        }
      }
      
      return 'en'; // Default fallback
    } catch (e) {
      debugPrint('Language detection exception: $e');
      return 'en';
    }
  }
}
