import 'package:tourist_assistive_app/features/language/services/professional_audio_service.dart';

class EnhancedAudioPictureService {
  static final EnhancedAudioPictureService _instance = EnhancedAudioPictureService._internal();
  factory EnhancedAudioPictureService() => _instance;
  EnhancedAudioPictureService._internal();

  final ProfessionalAudioService _audioService = ProfessionalAudioService();

  // Enhanced Amharic word data with audio and picture information
  static const Map<String, Map<String, dynamic>> _enhancedWords = {
    // Greetings
    'ሰላም': {
      'english': 'Hello/Peace',
      'pronunciation': 'seh-lam',
      'audioFile': 'audio/amharic/selam.mp3',
      'pictureFile': 'images/amharic/greetings/hello.jpg',
      'category': 'Greetings',
      'difficulty': 1,
      'culturalContext': 'Used for both hello and goodbye in Ethiopian culture',
    },
    'እንደምን ነህ': {
      'english': 'How are you (male)',
      'pronunciation': 'en-dem-en neh',
      'audioFile': 'audio/amharic/endemen_neh.mp3',
      'pictureFile': 'images/amharic/greetings/how_are_you_male.jpg',
      'category': 'Greetings',
      'difficulty': 2,
      'culturalContext': 'Formal greeting for males',
    },
    'እንደምን ነሽ': {
      'english': 'How are you (female)',
      'pronunciation': 'en-dem-en nesh',
      'audioFile': 'audio/amharic/endemen_nesh.mp3',
      'pictureFile': 'images/amharic/greetings/how_are_you_female.jpg',
      'category': 'Greetings',
      'difficulty': 2,
      'culturalContext': 'Formal greeting for females',
    },
    'አመሰግናለሁ': {
      'english': 'Thank you',
      'pronunciation': 'ah-meh-seh-gah-nah-leh-hu',
      'audioFile': 'audio/amharic/ameseginalehu.mp3',
      'pictureFile': 'images/amharic/greetings/thank_you.jpg',
      'category': 'Greetings',
      'difficulty': 3,
      'culturalContext': 'Very polite way to say thank you',
    },
    
    // Family
    'እናት': {
      'english': 'Mother',
      'pronunciation': 'eh-nat',
      'audioFile': 'audio/amharic/enat.mp3',
      'pictureFile': 'images/amharic/family/mother.jpg',
      'category': 'Family',
      'difficulty': 1,
      'culturalContext': 'Mother is highly respected in Ethiopian culture',
    },
    'አባት': {
      'english': 'Father',
      'pronunciation': 'ah-bat',
      'audioFile': 'audio/amharic/abat.mp3',
      'pictureFile': 'images/amharic/family/father.jpg',
      'category': 'Family',
      'difficulty': 1,
      'culturalContext': 'Father is the head of the household',
    },
    'ወንድም': {
      'english': 'Brother',
      'pronunciation': 'wen-dim',
      'audioFile': 'audio/amharic/wendim.mp3',
      'pictureFile': 'images/amharic/family/brother.jpg',
      'category': 'Family',
      'difficulty': 1,
      'culturalContext': 'Brothers have strong bonds in Ethiopian families',
    },
    'እህት': {
      'english': 'Sister',
      'pronunciation': 'eh-het',
      'audioFile': 'audio/amharic/ehet.mp3',
      'pictureFile': 'images/amharic/family/sister.jpg',
      'category': 'Family',
      'difficulty': 1,
      'culturalContext': 'Sisters are very close in Ethiopian families',
    },
    
    // Food
    'እንጀራ': {
      'english': 'Injera (Ethiopian bread)',
      'pronunciation': 'in-jeh-rah',
      'audioFile': 'audio/amharic/injera.mp3',
      'pictureFile': 'images/amharic/food/injera.jpg',
      'category': 'Food',
      'difficulty': 2,
      'culturalContext': 'Traditional Ethiopian flatbread made from teff',
    },
    'ዶሮ ወጥ': {
      'english': 'Chicken stew',
      'pronunciation': 'do-ro wet',
      'audioFile': 'audio/amharic/doro_wet.mp3',
      'pictureFile': 'images/amharic/food/doro_wet.jpg',
      'category': 'Food',
      'difficulty': 3,
      'culturalContext': 'Popular Ethiopian dish served with injera',
    },
    'ቡና': {
      'english': 'Coffee',
      'pronunciation': 'boo-nah',
      'audioFile': 'audio/amharic/buna.mp3',
      'pictureFile': 'images/amharic/food/coffee.jpg',
      'category': 'Food',
      'difficulty': 1,
      'culturalContext': 'Ethiopia is the birthplace of coffee',
    },
    
    // Numbers
    'አንድ': {
      'english': 'One',
      'pronunciation': 'and',
      'audioFile': 'audio/amharic/and.mp3',
      'pictureFile': 'images/amharic/numbers/one.jpg',
      'category': 'Numbers',
      'difficulty': 1,
      'culturalContext': 'Basic counting number',
    },
    'ሁለት': {
      'english': 'Two',
      'pronunciation': 'hu-let',
      'audioFile': 'audio/amharic/hulet.mp3',
      'pictureFile': 'images/amharic/numbers/two.jpg',
      'category': 'Numbers',
      'difficulty': 1,
      'culturalContext': 'Basic counting number',
    },
    'ሦስት': {
      'english': 'Three',
      'pronunciation': 'sost',
      'audioFile': 'audio/amharic/sost.mp3',
      'pictureFile': 'images/amharic/numbers/three.jpg',
      'category': 'Numbers',
      'difficulty': 1,
      'culturalContext': 'Basic counting number',
    },
    
    // Colors
    'ቀይ': {
      'english': 'Red',
      'pronunciation': 'qey',
      'audioFile': 'audio/amharic/qey.mp3',
      'pictureFile': 'images/amharic/colors/red.jpg',
      'category': 'Colors',
      'difficulty': 1,
      'culturalContext': 'Red is a significant color in Ethiopian flag',
    },
    'ነጭ': {
      'english': 'White',
      'pronunciation': 'nech',
      'audioFile': 'audio/amharic/nech.mp3',
      'pictureFile': 'images/amharic/colors/white.jpg',
      'category': 'Colors',
      'difficulty': 1,
      'culturalContext': 'White represents peace in Ethiopian culture',
    },
    'ጥቁር': {
      'english': 'Black',
      'pronunciation': 'te-qur',
      'audioFile': 'audio/amharic/tequr.mp3',
      'pictureFile': 'images/amharic/colors/black.jpg',
      'category': 'Colors',
      'difficulty': 1,
      'culturalContext': 'Black represents the people of Ethiopia',
    },
    
    // Directions
    'ቀኝ': {
      'english': 'Right',
      'pronunciation': 'qen',
      'audioFile': 'audio/amharic/qen.mp3',
      'pictureFile': 'images/amharic/directions/right.jpg',
      'category': 'Directions',
      'difficulty': 2,
      'culturalContext': 'Important for navigation in Ethiopia',
    },
    'ግራ': {
      'english': 'Left',
      'pronunciation': 'gra',
      'audioFile': 'audio/amharic/gra.mp3',
      'pictureFile': 'images/amharic/directions/left.jpg',
      'category': 'Directions',
      'difficulty': 2,
      'culturalContext': 'Important for navigation in Ethiopia',
    },
  };

  // Get enhanced word data
  static Map<String, dynamic>? getWordData(String amharicWord) {
    return _enhancedWords[amharicWord];
  }

  // Get all words with enhanced data
  static List<String> getAllEnhancedWords() {
    return _enhancedWords.keys.toList();
  }

  // Get words by category
  static List<String> getWordsByCategory(String category) {
    return _enhancedWords.entries
        .where((entry) => entry.value['category'] == category)
        .map((entry) => entry.key)
        .toList();
  }

  // Get words by difficulty
  static List<String> getWordsByDifficulty(int difficulty) {
    return _enhancedWords.entries
        .where((entry) => entry.value['difficulty'] == difficulty)
        .map((entry) => entry.key)
        .toList();
  }

  // Play audio for a word
  Future<void> playWordAudio(String amharicWord) async {
    final wordData = getWordData(amharicWord);
    if (wordData != null) {
      final audioFile = wordData['audioFile'] as String?;
      if (audioFile != null) {
        try {
          await _audioService.playAmharicAudio(audioFile);
        } catch (e) {
          // Fallback to TTS
          await _audioService.speakAmharic(amharicWord);
        }
      } else {
        // Fallback to TTS
        await _audioService.speakAmharic(amharicWord);
      }
    } else {
      // Fallback to TTS
      await _audioService.speakAmharic(amharicWord);
    }
  }

  // Get picture path for a word
  static String? getWordPicture(String amharicWord) {
    final wordData = getWordData(amharicWord);
    return wordData?['pictureFile'] as String?;
  }

  // Get pronunciation guide
  static String? getPronunciation(String amharicWord) {
    final wordData = getWordData(amharicWord);
    return wordData?['pronunciation'] as String?;
  }

  // Get cultural context
  static String? getCulturalContext(String amharicWord) {
    final wordData = getWordData(amharicWord);
    return wordData?['culturalContext'] as String?;
  }

  // Get difficulty level
  static int? getDifficulty(String amharicWord) {
    final wordData = getWordData(amharicWord);
    return wordData?['difficulty'] as int?;
  }

  // Get all categories
  static List<String> getAllCategories() {
    final categories = _enhancedWords.values
        .map((data) => data['category'] as String)
        .toSet()
        .toList();
    categories.sort();
    return categories;
  }

  // Search words
  static List<String> searchWords(String query) {
    final lowercaseQuery = query.toLowerCase();
    return _enhancedWords.entries
        .where((entry) {
          final amharic = entry.key.toLowerCase();
          final english = (entry.value['english'] as String).toLowerCase();
          final pronunciation = (entry.value['pronunciation'] as String).toLowerCase();
          return amharic.contains(lowercaseQuery) ||
                 english.contains(lowercaseQuery) ||
                 pronunciation.contains(lowercaseQuery);
        })
        .map((entry) => entry.key)
        .toList();
  }

  // Get random words for practice
  static List<String> getRandomWords(int count) {
    final allWords = getAllEnhancedWords();
    allWords.shuffle();
    return allWords.take(count).toList();
  }

  // Get words for lesson
  static List<String> getWordsForLesson(String category, int difficulty, int count) {
    final categoryWords = getWordsByCategory(category);
    final difficultyWords = categoryWords
        .where((word) => getDifficulty(word) == difficulty)
        .toList();
    
    difficultyWords.shuffle();
    return difficultyWords.take(count).toList();
  }
}
