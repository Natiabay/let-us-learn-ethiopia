import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/// Service for translating text using Google Translate API
/// 
/// Supports 10 common languages with automatic translation
class GoogleTranslatorService {
  static const String _apiKey = 'YOUR_GOOGLE_TRANSLATE_API_KEY'; // Replace with your API key
  static const String _baseUrl = 'https://translation.googleapis.com/language/translate/v2';
  
  // 10 Common Languages
  static const Map<String, LanguageInfo> supportedLanguages = {
    'en': LanguageInfo(code: 'en', name: 'English', nativeName: 'English', flag: '🇺🇸'),
    'es': LanguageInfo(code: 'es', name: 'Spanish', nativeName: 'Español', flag: '🇪🇸'),
    'zh': LanguageInfo(code: 'zh', name: 'Chinese', nativeName: '中文', flag: '🇨🇳'),
    'ar': LanguageInfo(code: 'ar', name: 'Arabic', nativeName: 'العربية', flag: '🇸🇦'),
    'hi': LanguageInfo(code: 'hi', name: 'Hindi', nativeName: 'हिन्दी', flag: '🇮🇳'),
    'fr': LanguageInfo(code: 'fr', name: 'French', nativeName: 'Français', flag: '🇫🇷'),
    'pt': LanguageInfo(code: 'pt', name: 'Portuguese', nativeName: 'Português', flag: '🇧🇷'),
    'de': LanguageInfo(code: 'de', name: 'German', nativeName: 'Deutsch', flag: '🇩🇪'),
    'ja': LanguageInfo(code: 'ja', name: 'Japanese', nativeName: '日本語', flag: '🇯🇵'),
    'ru': LanguageInfo(code: 'ru', name: 'Russian', nativeName: 'Русский', flag: '🇷🇺'),
  };

  /// Translate text from English to target language
  static Future<String> translateText(String text, String targetLanguage) async {
    if (targetLanguage == 'en') return text; // No translation needed for English
    
    try {
      // For development/testing, use free translation service or mock
      if (_apiKey == 'YOUR_GOOGLE_TRANSLATE_API_KEY') {
        debugPrint('⚠️ Google Translate API key not configured. Using fallback translation.');
        return await _fallbackTranslation(text, targetLanguage);
      }

      final response = await http.post(
        Uri.parse('$_baseUrl?key=$_apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'q': text,
          'source': 'en',
          'target': targetLanguage,
          'format': 'text',
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data']['translations'][0]['translatedText'];
      } else {
        debugPrint('Translation API error: ${response.statusCode}');
        return await _fallbackTranslation(text, targetLanguage);
      }
    } catch (e) {
      debugPrint('Translation error: $e');
      return await _fallbackTranslation(text, targetLanguage);
    }
  }

  /// Translate multiple texts in batch
  static Future<List<String>> translateBatch(
    List<String> texts,
    String targetLanguage,
  ) async {
    if (targetLanguage == 'en') return texts;

    try {
      final translations = await Future.wait(
        texts.map((text) => translateText(text, targetLanguage)),
      );
      return translations;
    } catch (e) {
      debugPrint('Batch translation error: $e');
      return texts; // Return original texts on error
    }
  }

  /// Fallback translation using a free service or mock data
  static Future<String> _fallbackTranslation(String text, String targetLanguage) async {
    // Use a free translation service as fallback
    // Option 1: MyMemory Translation API (free, no API key required)
    try {
      final response = await http.get(
        Uri.parse(
          'https://api.mymemory.translated.net/get?q=${Uri.encodeComponent(text)}&langpair=en|$targetLanguage',
        ),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['responseData']['translatedText'];
      }
    } catch (e) {
      debugPrint('Fallback translation error: $e');
    }

    // Option 2: Return text with language indicator (as last resort)
    return '$text [${supportedLanguages[targetLanguage]?.nativeName ?? targetLanguage}]';
  }

  /// Translate a lesson object
  static Future<Map<String, dynamic>> translateLesson(
    Map<String, dynamic> lesson,
    String targetLanguage,
  ) async {
    if (targetLanguage == 'en') return lesson;

    final translatedLesson = Map<String, dynamic>.from(lesson);

    // Translate title
    if (lesson['title'] != null) {
      translatedLesson['title'] = await translateText(
        lesson['title'],
        targetLanguage,
      );
    }

    // Translate description
    if (lesson['description'] != null) {
      translatedLesson['description'] = await translateText(
        lesson['description'],
        targetLanguage,
      );
    }

    // Translate vocabulary
    if (lesson['vocabulary'] != null && lesson['vocabulary'] is List) {
      translatedLesson['vocabulary'] = await translateBatch(
        List<String>.from(lesson['vocabulary']),
        targetLanguage,
      );
    }

    // Translate exercises
    if (lesson['exercises'] != null && lesson['exercises'] is List) {
      translatedLesson['exercises'] = await Future.wait(
        (lesson['exercises'] as List).map((exercise) async {
          final translatedExercise = Map<String, dynamic>.from(exercise);
          
          if (exercise['instruction'] != null) {
            translatedExercise['instruction'] = await translateText(
              exercise['instruction'],
              targetLanguage,
            );
          }
          
          if (exercise['question'] != null) {
            translatedExercise['question'] = await translateText(
              exercise['question'],
              targetLanguage,
            );
          }

          if (exercise['translation'] != null) {
            translatedExercise['translation'] = await translateText(
              exercise['translation'],
              targetLanguage,
            );
          }

          // Translate options
          if (exercise['options'] != null && exercise['options'] is List) {
            translatedExercise['options'] = await Future.wait(
              (exercise['options'] as List).map((option) async {
                final translatedOption = Map<String, dynamic>.from(option);
                if (option['text'] != null) {
                  translatedOption['text'] = await translateText(
                    option['text'],
                    targetLanguage,
                  );
                }
                return translatedOption;
              }),
            );
          }

          return translatedExercise;
        }),
      );
    }

    return translatedLesson;
  }

  /// Get language info by code
  static LanguageInfo? getLanguageInfo(String code) {
    return supportedLanguages[code];
  }

  /// Get all supported language codes
  static List<String> getSupportedLanguageCodes() {
    return supportedLanguages.keys.toList();
  }

  /// Get all supported languages
  static List<LanguageInfo> getSupportedLanguages() {
    return supportedLanguages.values.toList();
  }
}

/// Language information model
class LanguageInfo {
  final String code;
  final String name;
  final String nativeName;
  final String flag;

  const LanguageInfo({
    required this.code,
    required this.name,
    required this.nativeName,
    required this.flag,
  });

  Map<String, dynamic> toJson() => {
    'code': code,
    'name': name,
    'nativeName': nativeName,
    'flag': flag,
  };

  factory LanguageInfo.fromJson(Map<String, dynamic> json) => LanguageInfo(
    code: json['code'],
    name: json['name'],
    nativeName: json['nativeName'],
    flag: json['flag'],
  );
}



