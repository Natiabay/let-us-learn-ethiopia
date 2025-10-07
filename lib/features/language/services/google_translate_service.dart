import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Google Translate API Service
final googleTranslateServiceProvider = Provider<GoogleTranslateService>((ref) {
  return GoogleTranslateService();
});

class GoogleTranslateService {
  // You'll need to get your own API key from Google Cloud Console
  // For now, using a demo key - replace with your actual key
  static const String _apiKey = 'YOUR_GOOGLE_TRANSLATE_API_KEY';
  static const String _baseUrl = 'https://translation.googleapis.com/language/translate/v2';

  Future<TranslationResult> translate({
    required String text,
    required String from,
    required String to,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl?key=$_apiKey'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'q': text,
          'source': from,
          'target': to,
          'format': 'text',
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final translation = data['data']['translations'][0];
        
        return TranslationResult(
          originalText: text,
          translatedText: translation['translatedText'],
          detectedLanguage: translation['detectedSourceLanguage'] ?? from,
          confidence: 1.0,
        );
      } else {
        throw Exception('Translation failed: ${response.statusCode}');
      }
    } catch (e) {
      // Fallback to offline translation for demo
      return _getOfflineTranslation(text, from, to);
    }
  }

  Future<List<Language>> getSupportedLanguages() async {
    try {
      final response = await http.get(
        Uri.parse('https://translation.googleapis.com/language/translate/v2/languages?key=$_apiKey'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final languages = data['data']['languages'] as List;
        
        return languages.map((lang) => Language(
          code: lang['language'],
          name: lang['name'],
        )).toList();
      } else {
        return _getOfflineLanguages();
      }
    } catch (e) {
      return _getOfflineLanguages();
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
        final detection = data['data']['detections'][0][0];
        return detection['language'];
      } else {
        return 'en'; // Default to English
      }
    } catch (e) {
      return 'en';
    }
  }

  // Offline fallback translations
  TranslationResult _getOfflineTranslation(String text, String from, String to) {
    final offlineTranslations = {
      'en': {
        'am': {
          'Hello': 'ሰላም',
          'Thank you': 'አመሰግናለሁ',
          'Coffee': 'ቡና',
          'One': 'አንድ',
          'Two': 'ሁለት',
          'Three': 'ሶስት',
          'Milk': 'ወተት',
          'Injera': 'እንጀራ',
          'Where is it?': 'የት ነው?',
          'Right': 'ቀኝ',
          'Left': 'ግራ',
          'How are you?': 'እንደምን ነህ?',
          'Goodbye': 'ደህና ሁን',
          'Please': 'እባክዎ',
          'Sorry': 'ይቅርታ',
          'Yes': 'አዎ',
          'No': 'አይ',
          'Water': 'ውሃ',
          'Food': 'ምግብ',
          'Hotel': 'ሆቴል',
          'Restaurant': 'ምግብ ቤት',
          'Market': 'ገበያ',
          'Hospital': 'ሆስፒታል',
          'Police': 'ፖሊስ',
          'Help': 'እርዳታ',
          'Emergency': 'አደጋ',
        }
      },
      'am': {
        'en': {
          'ሰላም': 'Hello',
          'አመሰግናለሁ': 'Thank you',
          'ቡና': 'Coffee',
          'አንድ': 'One',
          'ሁለት': 'Two',
          'ሶስት': 'Three',
          'ወተት': 'Milk',
          'እንጀራ': 'Injera',
          'የት ነው?': 'Where is it?',
          'ቀኝ': 'Right',
          'ግራ': 'Left',
          'እንደምን ነህ?': 'How are you?',
          'ደህና ሁን': 'Goodbye',
          'እባክዎ': 'Please',
          'ይቅርታ': 'Sorry',
          'አዎ': 'Yes',
          'አይ': 'No',
          'ውሃ': 'Water',
          'ምግብ': 'Food',
          'ሆቴል': 'Hotel',
          'ምግብ ቤት': 'Restaurant',
          'ገበያ': 'Market',
          'ሆስፒታል': 'Hospital',
          'ፖሊስ': 'Police',
          'እርዳታ': 'Help',
          'አደጋ': 'Emergency',
        }
      }
    };

    final translation = offlineTranslations[from]?[to]?[text] ?? text;
    
    return TranslationResult(
      originalText: text,
      translatedText: translation,
      detectedLanguage: from,
      confidence: 0.8,
    );
  }

  List<Language> _getOfflineLanguages() {
    return [
      Language(code: 'en', name: 'English'),
      Language(code: 'am', name: 'Amharic'),
      Language(code: 'fr', name: 'French'),
      Language(code: 'es', name: 'Spanish'),
      Language(code: 'de', name: 'German'),
      Language(code: 'it', name: 'Italian'),
      Language(code: 'pt', name: 'Portuguese'),
      Language(code: 'ru', name: 'Russian'),
      Language(code: 'ja', name: 'Japanese'),
      Language(code: 'ko', name: 'Korean'),
      Language(code: 'zh', name: 'Chinese'),
      Language(code: 'ar', name: 'Arabic'),
    ];
  }
}

class TranslationResult {
  final String originalText;
  final String translatedText;
  final String detectedLanguage;
  final double confidence;

  TranslationResult({
    required this.originalText,
    required this.translatedText,
    required this.detectedLanguage,
    required this.confidence,
  });
}

class Language {
  final String code;
  final String name;

  Language({
    required this.code,
    required this.name,
  });
}

