import 'package:flutter_tts/flutter_tts.dart';
import 'package:audioplayers/audioplayers.dart';

class ProfessionalAudioService {
  static final ProfessionalAudioService _instance = ProfessionalAudioService._internal();
  factory ProfessionalAudioService() => _instance;
  ProfessionalAudioService._internal();

  final FlutterTts _flutterTts = FlutterTts();
  final AudioPlayer _audioPlayer = AudioPlayer();
  
  bool _isInitialized = false;
  bool _isPlaying = false;

  // Amharic TTS configuration
  static const String _amharicLanguage = 'am-ET'; // Amharic (Ethiopia)
  static const String _englishLanguage = 'en-US'; // English (US)
  
  // Audio quality settings
  static const double _speechRate = 0.5; // Slower for learning
  static const double _volume = 0.8;
  static const double _pitch = 1.0;

  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // Configure TTS for Amharic
      await _flutterTts.setLanguage(_amharicLanguage);
      await _flutterTts.setSpeechRate(_speechRate);
      await _flutterTts.setVolume(_volume);
      await _flutterTts.setPitch(_pitch);
      
      // Set up audio session for better quality
      await _flutterTts.setIosAudioCategory(
        IosTextToSpeechAudioCategory.playback,
        [
          IosTextToSpeechAudioCategoryOptions.allowBluetooth,
          IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
          IosTextToSpeechAudioCategoryOptions.mixWithOthers,
        ],
        IosTextToSpeechAudioMode.spokenAudio,
      );

      // Set up completion handler
      _flutterTts.setCompletionHandler(() {
        _isPlaying = false;
      });

      // Set up error handler
      _flutterTts.setErrorHandler((msg) {
        print('TTS Error: $msg');
        _isPlaying = false;
      });

      _isInitialized = true;
      print('Professional Audio Service initialized successfully');
    } catch (e) {
      print('Error initializing audio service: $e');
    }
  }

  // Play Amharic text with professional pronunciation
  Future<void> speakAmharic(String text) async {
    if (!_isInitialized) await initialize();
    if (_isPlaying) return;

    try {
      _isPlaying = true;
      
      // Set Amharic language
      await _flutterTts.setLanguage(_amharicLanguage);
      
      // Speak the text
      await _flutterTts.speak(text);
      
      print('Speaking Amharic: $text');
    } catch (e) {
      print('Error speaking Amharic: $e');
      _isPlaying = false;
    }
  }

  // Play English text for translation
  Future<void> speakEnglish(String text) async {
    if (!_isInitialized) await initialize();
    if (_isPlaying) return;

    try {
      _isPlaying = true;
      
      // Set English language
      await _flutterTts.setLanguage(_englishLanguage);
      
      // Speak the text
      await _flutterTts.speak(text);
      
      print('Speaking English: $text');
    } catch (e) {
      print('Error speaking English: $e');
      _isPlaying = false;
    }
  }

  // Play pre-recorded Amharic audio files
  Future<void> playAmharicAudio(String audioPath) async {
    try {
      if (_isPlaying) {
        await _audioPlayer.stop();
      }

      _isPlaying = true;
      
      // Play from assets
      await _audioPlayer.play(AssetSource(audioPath));
      
      // Set up completion listener
      _audioPlayer.onPlayerComplete.listen((event) {
        _isPlaying = false;
      });
      
      print('Playing Amharic audio: $audioPath');
    } catch (e) {
      print('Error playing Amharic audio: $e');
      _isPlaying = false;
    }
  }

  // Stop all audio
  Future<void> stopAudio() async {
    try {
      await _flutterTts.stop();
      await _audioPlayer.stop();
      _isPlaying = false;
    } catch (e) {
      print('Error stopping audio: $e');
    }
  }

  // Check if audio is currently playing
  bool get isPlaying => _isPlaying;

  // Get available languages
  Future<List<dynamic>> getAvailableLanguages() async {
    if (!_isInitialized) await initialize();
    return await _flutterTts.getLanguages;
  }

  // Set speech rate for learning
  Future<void> setSpeechRate(double rate) async {
    await _flutterTts.setSpeechRate(rate);
  }

  // Set volume
  Future<void> setVolume(double volume) async {
    await _flutterTts.setVolume(volume);
  }

  // Dispose resources
  Future<void> dispose() async {
    await _flutterTts.stop();
    await _audioPlayer.dispose();
    _isInitialized = false;
  }
}

// Professional Amharic Audio Database
class AmharicAudioDatabase {
  // Pre-recorded audio files for common Amharic words
  static const Map<String, String> _audioFiles = {
    // Greetings
    'ሰላም': 'audio/amharic/selam.mp3',
    'እንደምን ነህ': 'audio/amharic/endemen_neh.mp3',
    'እንደምን ነሽ': 'audio/amharic/endemen_nesh.mp3',
    'እንደምን ዋልክ': 'audio/amharic/endemen_walk.mp3',
    'አመሰግናለሁ': 'audio/amharic/ameseginalehu.mp3',
    'ይቅርታ': 'audio/amharic/yikerta.mp3',
    
    // Basic words
    'አዎ': 'audio/amharic/awo.mp3',
    'አይ': 'audio/amharic/ay.mp3',
    'እሺ': 'audio/amharic/ishi.mp3',
    'በጣም': 'audio/amharic/betam.mp3',
    
    // Family
    'እናት': 'audio/amharic/enat.mp3',
    'አባት': 'audio/amharic/abat.mp3',
    'ወንድም': 'audio/amharic/wendim.mp3',
    'እህት': 'audio/amharic/ehet.mp3',
    'ልጅ': 'audio/amharic/lij.mp3',
    
    // Food
    'እንጀራ': 'audio/amharic/injera.mp3',
    'ዶሮ ወጥ': 'audio/amharic/doro_wet.mp3',
    'ቡና': 'audio/amharic/buna.mp3',
    'ውሃ': 'audio/amharic/wuha.mp3',
    
    // Numbers
    'አንድ': 'audio/amharic/and.mp3',
    'ሁለት': 'audio/amharic/hulet.mp3',
    'ሦስት': 'audio/amharic/sost.mp3',
    'አራት': 'audio/amharic/arat.mp3',
    'አምስት': 'audio/amharic/amst.mp3',
    'ስድስት': 'audio/amharic/sedest.mp3',
    'ሰባት': 'audio/amharic/sebat.mp3',
    'ስምንት': 'audio/amharic/semint.mp3',
    'ዘጠኝ': 'audio/amharic/zeten.mp3',
    'አስር': 'audio/amharic/asr.mp3',
    
    // Colors
    'ቀይ': 'audio/amharic/qey.mp3',
    'ነጭ': 'audio/amharic/nech.mp3',
    'ጥቁር': 'audio/amharic/tequr.mp3',
    'ቢጫ': 'audio/amharic/bicha.mp3',
    'አረንጓዴ': 'audio/amharic/arenguade.mp3',
    
    // Directions
    'ቀኝ': 'audio/amharic/qen.mp3',
    'ግራ': 'audio/amharic/gra.mp3',
    'ላይ': 'audio/amharic/lay.mp3',
    'ታች': 'audio/amharic/tach.mp3',
    'ፊት': 'audio/amharic/fit.mp3',
    'ኋላ': 'audio/amharic/hwala.mp3',
  };

  // Get audio file path for a word
  static String? getAudioPath(String amharicWord) {
    return _audioFiles[amharicWord];
  }

  // Check if audio file exists for a word
  static bool hasAudio(String amharicWord) {
    return _audioFiles.containsKey(amharicWord);
  }

  // Get all words with audio
  static List<String> getWordsWithAudio() {
    return _audioFiles.keys.toList();
  }
}

// Professional Picture Database
class AmharicPictureDatabase {
  // High-quality picture paths for Amharic words
  static const Map<String, String> _pictureFiles = {
    // Greetings
    'ሰላም': 'images/amharic/greetings/hello.jpg',
    'እንደምን ነህ': 'images/amharic/greetings/how_are_you_male.jpg',
    'እንደምን ነሽ': 'images/amharic/greetings/how_are_you_female.jpg',
    'እንደምን ዋልክ': 'images/amharic/greetings/good_morning.jpg',
    'አመሰግናለሁ': 'images/amharic/greetings/thank_you.jpg',
    'ይቅርታ': 'images/amharic/greetings/sorry.jpg',
    
    // Basic words
    'አዎ': 'images/amharic/basic/yes.jpg',
    'አይ': 'images/amharic/basic/no.jpg',
    'እሺ': 'images/amharic/basic/ok.jpg',
    'በጣም': 'images/amharic/basic/very_much.jpg',
    
    // Family
    'እናት': 'images/amharic/family/mother.jpg',
    'አባት': 'images/amharic/family/father.jpg',
    'ወንድም': 'images/amharic/family/brother.jpg',
    'እህት': 'images/amharic/family/sister.jpg',
    'ልጅ': 'images/amharic/family/child.jpg',
    
    // Food
    'እንጀራ': 'images/amharic/food/injera.jpg',
    'ዶሮ ወጥ': 'images/amharic/food/doro_wet.jpg',
    'ቡና': 'images/amharic/food/coffee.jpg',
    'ውሃ': 'images/amharic/food/water.jpg',
    
    // Numbers
    'አንድ': 'images/amharic/numbers/one.jpg',
    'ሁለት': 'images/amharic/numbers/two.jpg',
    'ሦስት': 'images/amharic/numbers/three.jpg',
    'አራት': 'images/amharic/numbers/four.jpg',
    'አምስት': 'images/amharic/numbers/five.jpg',
    'ስድስት': 'images/amharic/numbers/six.jpg',
    'ሰባት': 'images/amharic/numbers/seven.jpg',
    'ስምንት': 'images/amharic/numbers/eight.jpg',
    'ዘጠኝ': 'images/amharic/numbers/nine.jpg',
    'አስር': 'images/amharic/numbers/ten.jpg',
    
    // Colors
    'ቀይ': 'images/amharic/colors/red.jpg',
    'ነጭ': 'images/amharic/colors/white.jpg',
    'ጥቁር': 'images/amharic/colors/black.jpg',
    'ቢጫ': 'images/amharic/colors/yellow.jpg',
    'አረንጓዴ': 'images/amharic/colors/green.jpg',
    
    // Directions
    'ቀኝ': 'images/amharic/directions/right.jpg',
    'ግራ': 'images/amharic/directions/left.jpg',
    'ላይ': 'images/amharic/directions/up.jpg',
    'ታች': 'images/amharic/directions/down.jpg',
    'ፊት': 'images/amharic/directions/front.jpg',
    'ኋላ': 'images/amharic/directions/back.jpg',
    
    // Places
    'ሆቴል': 'images/amharic/places/hotel.jpg',
    'ባንክ': 'images/amharic/places/bank.jpg',
    'ሆስፒታል': 'images/amharic/places/hospital.jpg',
    'መርከብ': 'images/amharic/places/airport.jpg',
    'ገበያ': 'images/amharic/places/market.jpg',
    
    // Transportation
    'መኪና': 'images/amharic/transportation/car.jpg',
    'አውቶቡስ': 'images/amharic/transportation/bus.jpg',
    'ታክሲ': 'images/amharic/transportation/taxi.jpg',
    'መንገድ': 'images/amharic/transportation/road.jpg',
    
    // Time
    'ጠዋት': 'images/amharic/time/morning.jpg',
    'ቀን': 'images/amharic/time/day.jpg',
    'ምሽት': 'images/amharic/time/evening.jpg',
    'ሌሊት': 'images/amharic/time/night.jpg',
    
    // Weather
    'ፀሐይ': 'images/amharic/weather/sun.jpg',
    'ዝናብ': 'images/amharic/weather/rain.jpg',
    'አየር': 'images/amharic/weather/wind.jpg',
    'በረዶ': 'images/amharic/weather/snow.jpg',
  };

  // Get picture path for a word
  static String? getPicturePath(String amharicWord) {
    return _pictureFiles[amharicWord];
  }

  // Check if picture exists for a word
  static bool hasPicture(String amharicWord) {
    return _pictureFiles.containsKey(amharicWord);
  }

  // Get all words with pictures
  static List<String> getWordsWithPictures() {
    return _pictureFiles.keys.toList();
  }

  // Get fallback picture for categories
  static String getCategoryPicture(String category) {
    switch (category.toLowerCase()) {
      case 'greetings':
        return 'images/amharic/categories/greetings.jpg';
      case 'family':
        return 'images/amharic/categories/family.jpg';
      case 'food':
        return 'images/amharic/categories/food.jpg';
      case 'numbers':
        return 'images/amharic/categories/numbers.jpg';
      case 'colors':
        return 'images/amharic/categories/colors.jpg';
      case 'directions':
        return 'images/amharic/categories/directions.jpg';
      case 'places':
        return 'images/amharic/categories/places.jpg';
      case 'transportation':
        return 'images/amharic/categories/transportation.jpg';
      case 'time':
        return 'images/amharic/categories/time.jpg';
      case 'weather':
        return 'images/amharic/categories/weather.jpg';
      default:
        return 'images/amharic/categories/default.jpg';
    }
  }
}
