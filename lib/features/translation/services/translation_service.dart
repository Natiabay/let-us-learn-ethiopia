import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TranslationService {
  final FlutterTts _flutterTts = FlutterTts();
  
  // Google Cloud APIs configuration
  static const String _googleCloudApiKey = 'YOUR_GOOGLE_CLOUD_API_KEY'; // Replace with actual API key
  static const String _googleTranslateBaseUrl = 'https://translation.googleapis.com/language/translate/v2';
  static const String _googleSpeechToTextUrl = 'https://speech.googleapis.com/v1/speech:recognize';
  
  // Common Amharic-English translations
  static const Map<String, String> _amharicToEnglish = {
    'ሰላም': 'Hello/Peace',
    'እንደምን ነህ': 'How are you (male)',
    'እንደምን ነሽ': 'How are you (female)',
    'እንደምን ዋልክ': 'Good morning',
    'አመሰግናለሁ': 'Thank you',
    'ይቅርታ': 'Sorry/Excuse me',
    'አዎ': 'Yes',
    'አይ': 'No',
    'እሺ': 'OK/Alright',
    'በጣም': 'Very much',
    'እናት': 'Mother',
    'አባት': 'Father',
    'ወንድም': 'Brother',
    'እህት': 'Sister',
    'ልጅ': 'Child',
    'እንጀራ': 'Injera (Ethiopian bread)',
    'ዶሮ ወጥ': 'Chicken stew',
    'ቡና': 'Coffee',
    'ውሃ': 'Water',
    'የት ነው': 'Where is',
    'ስንት ነው': 'How much',
    'ስብሰባ': 'Meeting',
    'ሆቴል': 'Hotel',
    'ሰላማ ልእግዚኣብሔር': 'God bless you',
    'እግዚአብሔር ይመስገን': 'Thank God',
    'አንድ': 'One',
    'ሁለት': 'Two',
    'ሦስት': 'Three',
    'አራት': 'Four',
    'አምስት': 'Five',
    'ስድስት': 'Six',
    'ሰባት': 'Seven',
    'ስምንት': 'Eight',
    'ዘጠኝ': 'Nine',
    'አስር': 'Ten',
    'ሳንቲም': 'Cent',
    'ብር': 'Birr (Ethiopian currency)',
    'ሚጣድ': 'Spicy',
    'ጣፋጭ': 'Sweet/Delicious',
  };

  static const Map<String, String> _englishToAmharic = {
    'hello': 'ሰላም',
    'peace': 'ሰላም',
    'how are you': 'እንደምን ነህ/ነሽ',
    'good morning': 'እንደምን ዋልክ',
    'thank you': 'አመሰግናለሁ',
    'sorry': 'ይቅርታ',
    'excuse me': 'ይቅርታ',
    'yes': 'አዎ',
    'no': 'አይ',
    'ok': 'እሺ',
    'alright': 'እሺ',
    'very much': 'በጣም',
    'mother': 'እናት',
    'father': 'አባት',
    'brother': 'ወንድም',
    'sister': 'እህት',
    'child': 'ልጅ',
    'injera': 'እንጀራ',
    'bread': 'እንጀራ',
    'coffee': 'ቡና',
    'water': 'ውሃ',
    'where is': 'የት ነው',
    'how much': 'ስንት ነው',
    'meeting': 'ስብሰባ',
    'hotel': 'ሆቴል',
    'thank god': 'እግዚአብሔር ይመስገን',
    'one': 'አንድ',
    'two': 'ሁለት',
    'three': 'ሦስት',
    'four': 'አራት',
    'five': 'አምስት',
    'six': 'ስድስት',
    'seven': 'ሰባት',
    'eight': 'ስምንት',
    'nine': 'ዘጠኝ',
    'ten': 'አስር',
    'spicy': 'ሚጣድ',
    'sweet': 'ጣፋጭ',
    'delicious': 'ጣፋጭ',
  };

  // Emergency phrases
  static const Map<String, String> _emergencyPhrases = {
    'help': 'ረዳት - redat',
    'emergency': 'የአስቸኳይ ጊዜ - ye asechuki gize',
    'police': 'ፖሊስ - police',
    'hospital': 'ሆስፒታል - hospital',
    'doctor': 'ዶክተር - doctor',
    'fire': 'እሳት - esat',
    'ambulance': 'አምቡላንስ - ambulance',
    'pharmacy': 'ፋርማሲ - pharmacy',
    'toilet': 'ሽንት ቤት - shint bet',
    'water': 'ውሃ - wuha',
    'food': 'ምግብ - megeb',
    'money': 'ገንዘብ - genzeb',
    'phone': 'ስልክ - selk',
  };

  Future<void> initializeTts() async {
    await _flutterTts.setLanguage('en-US');
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
  }

  Future<void> initializeSpeechToText() async {
    // Google Cloud Speech-to-Text is always available
    // No initialization needed for Google Cloud APIs
  }

  // Translation methods
  String translateAmharicToEnglish(String amharicText) {
    // final lowercaseInput = amharicText.toLowerCase().trim();
    
    // Direct match
    if (_amharicToEnglish.containsKey(amharicText)) {
      return _amharicToEnglish[amharicText]!;
    }

    // Partial match
    for (final entry in _amharicToEnglish.entries) {
      if (amharicText.contains(entry.key)) {
        return entry.value;
      }
    }

    return 'Translation not found. Try a simpler phrase.';
  }

  String translateEnglishToAmharic(String englishText) {
    final lowercaseInput = englishText.toLowerCase().trim();
    
    // Direct match
    if (_englishToAmharic.containsKey(lowercaseInput)) {
      return _englishToAmharic[lowercaseInput]!;
    }

    // Partial match
    for (final entry in _englishToAmharic.entries) {
      if (lowercaseInput.contains(entry.key)) {
        return entry.value;
      }
    }

    return 'Translation not found. Try a simpler phrase.';
  }

  String getEmergencyPhrase(String englishPhrase) {
    final lowercaseInput = englishPhrase.toLowerCase().trim();
    return _emergencyPhrases[lowercaseInput] ?? 'Emergency phrase not found';
  }

  List<Map<String, String>> getAllEmergencyPhrases() {
    return _emergencyPhrases.entries
        .map((entry) => {'english': entry.key, 'amharic': entry.value})
        .toList();
  }

  List<Map<String, String>> getCommonPhrases() {
    return _englishToAmharic.entries
        .take(20) // Get first 20 common phrases
        .map((entry) => {'english': entry.key, 'amharic': entry.value})
        .toList();
  }

  // Text-to-Speech
  Future<void> speakEnglish(String text) async {
    await _flutterTts.setLanguage('en-US');
    await _flutterTts.speak(text);
  }

  Future<void> speakAmharic(String text) async {
    // Note: Amharic TTS might not be available on all devices
    // This would use English pronunciation of Amharic text
    await _flutterTts.setLanguage('en-US');
    await _flutterTts.speak(text);
  }

  Future<void> stopSpeaking() async {
    await _flutterTts.stop();
  }

  // Speech-to-Text using Google Cloud Speech-to-Text API
  Future<String?> startListening({String language = 'en-US'}) async {
    try {
      // Note: For full implementation, you would need to:
      // 1. Record audio from microphone using a recording package
      // 2. Convert to base64
      // 3. Send to Google Speech-to-Text API
      // This is a simplified implementation that shows the structure
      
      // Simulate audio recording (in real implementation, record actual audio)
      final audioBase64 = await _simulateAudioRecording();
      
      if (audioBase64 == null) {
        return null;
      }
      
      // Call Google Cloud Speech-to-Text API
      final recognizedText = await _recognizeSpeech(audioBase64, language);
      return recognizedText;
    } catch (e) {
      print('Speech recognition error: $e');
      return null;
    }
  }

  Future<void> stopListening() async {
    // In a real implementation, this would stop audio recording
    print('Stopped listening');
  }

  bool get isListening => false; // In real implementation, track recording state

  // Simulate audio recording (replace with actual recording implementation)
  Future<String?> _simulateAudioRecording() async {
    // This is a placeholder - in real implementation, you would:
    // 1. Use a recording package to capture audio from microphone
    // 2. Convert the audio to base64 format
    // 3. Return the base64 string
    
    // For now, return a dummy base64 string
    return 'dummy_audio_base64';
  }

  // Google Cloud Speech-to-Text API call
  Future<String?> _recognizeSpeech(String audioBase64, String language) async {
    try {
      final response = await http.post(
        Uri.parse('$_googleSpeechToTextUrl?key=$_googleCloudApiKey'),
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
      
      print('Speech recognition API error: ${response.statusCode} - ${response.body}');
      return null;
    } catch (e) {
      print('Speech recognition API exception: $e');
      return null;
    }
  }

  // Voice translation workflow
  Future<Map<String, String>> voiceTranslate({
    required String fromLanguage,
    required String toLanguage,
  }) async {
    try {
      // Start listening
      final recognizedText = await startListening(language: fromLanguage);
      
      if (recognizedText == null || recognizedText.isEmpty) {
        return {
          'error': 'No speech recognized. Please try again.',
          'original': '',
          'translation': '',
        };
      }

      // Translate
      String translation;
      if (fromLanguage.startsWith('en') && toLanguage.startsWith('am')) {
        translation = translateEnglishToAmharic(recognizedText);
      } else if (fromLanguage.startsWith('am') && toLanguage.startsWith('en')) {
        translation = translateAmharicToEnglish(recognizedText);
      } else {
        translation = 'Unsupported language pair';
      }

      // Speak translation
      if (toLanguage.startsWith('en')) {
        await speakEnglish(translation);
      } else {
        await speakAmharic(translation);
      }

      return {
        'original': recognizedText,
        'translation': translation,
        'error': '',
      };
    } catch (e) {
      return {
        'error': 'Translation failed: ${e.toString()}',
        'original': '',
        'translation': '',
      };
    }
  }

  // Cultural context for translations
  Map<String, String> getCulturalContext(String phrase) {
    final culturalNotes = {
      'ሰላም': 'Used as both hello and goodbye. Literally means "peace".',
      'እንደምን ነህ': 'Formal way to ask "how are you" to a male. Use "እንደምን ነሽ" for females.',
      'አመሰግናለሁ': 'Formal thank you. Can also use "አመሰግናለሁ" for informal situations.',
      'እንጀራ': 'Traditional Ethiopian sourdough flatbread, the staple food of Ethiopia.',
      'ቡና': 'Coffee originated in Ethiopia. Coffee ceremonies are important cultural events.',
      'እግዚአብሔር ይመስገን': 'Religious expression commonly used in daily conversation.',
    };

    return {
      'phrase': phrase,
      'context': culturalNotes[phrase] ?? 'No cultural context available for this phrase.',
    };
  }

  // Google Translate API Integration
  Future<Map<String, dynamic>> translateWithGoogle({
    required String text,
    required String fromLanguage,
    required String toLanguage,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(_googleTranslateBaseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'q': text,
          'source': fromLanguage,
          'target': toLanguage,
          'key': _googleCloudApiKey,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final translation = data['data']['translations'][0]['translatedText'];
        final detectedLanguage = data['data']['translations'][0]['detectedSourceLanguage'];
        
        return {
          'success': true,
          'translation': translation,
          'detectedLanguage': detectedLanguage,
          'originalText': text,
        };
      } else {
        return {
          'success': false,
          'error': 'Translation failed: ${response.statusCode}',
          'translation': '',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': 'Translation error: ${e.toString()}',
        'translation': '',
      };
    }
  }

  // Enhanced translation with fallback to local dictionary
  Future<String> translateText({
    required String text,
    required String fromLanguage,
    required String toLanguage,
    bool useGoogleTranslate = true,
  }) async {
    // First try Google Translate if enabled and API key is available
    if (useGoogleTranslate && _googleCloudApiKey != 'YOUR_GOOGLE_CLOUD_API_KEY') {
      final result = await translateWithGoogle(
        text: text,
        fromLanguage: fromLanguage,
        toLanguage: toLanguage,
      );
      
      if (result['success'] == true) {
        return result['translation'];
      }
    }
    
    // Fallback to local dictionary
    if (fromLanguage.startsWith('en') && toLanguage.startsWith('am')) {
      return translateEnglishToAmharic(text);
    } else if (fromLanguage.startsWith('am') && toLanguage.startsWith('en')) {
      return translateAmharicToEnglish(text);
    }
    
    return 'Translation not available';
  }

  // Real-time translation for tourist conversations
  Future<Map<String, String>> getTouristConversationTranslations() async {
    final commonTouristPhrases = [
      'Where is the bathroom?',
      'How much does this cost?',
      'Can you help me?',
      'I need a taxi',
      'Where is the hotel?',
      'I am lost',
      'Do you speak English?',
      'Thank you very much',
      'Excuse me',
      'I don\'t understand',
    ];

    final translations = <String, String>{};
    
    for (final phrase in commonTouristPhrases) {
      final translation = await translateText(
        text: phrase,
        fromLanguage: 'en',
        toLanguage: 'am',
        useGoogleTranslate: false, // Use local dictionary for reliability
      );
      translations[phrase] = translation;
    }
    
    return translations;
  }

  // Language detection
  Future<String> detectLanguage(String text) async {
    try {
      final response = await http.post(
        Uri.parse('https://translation.googleapis.com/language/translate/v2/detect'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'q': text,
          'key': _googleCloudApiKey,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data']['detections'][0][0]['language'];
      }
    } catch (e) {
      // Fallback: simple detection based on character sets
      if (RegExp(r'[\u1200-\u137F]').hasMatch(text)) {
        return 'am'; // Amharic
      } else if (RegExp(r'[a-zA-Z]').hasMatch(text)) {
        return 'en'; // English
      }
    }
    
    return 'unknown';
  }

  void dispose() {
    _flutterTts.stop();
  }
}














