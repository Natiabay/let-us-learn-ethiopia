import 'package:tourist_assistive_app/features/language/models/comprehensive_lesson_model.dart';

/// Part 1: Tourist Essentials and Food Lessons
class LessonExpansionPart1 {
  
  static List<Lesson> getTouristEssentials(String languageCode) {
    return [
      _createLesson(
        id: '${languageCode}_tourist_001',
        title: _getTitle('Tourist Essentials', languageCode),
        description: _getDescription('Essential phrases for tourists', languageCode),
        level: LanguageLevel.beginner,
        languageCode: languageCode,
        estimatedMinutes: 12,
        xpReward: 200,
        category: 'Tourist',
        vocabulary: [
          'ሰላም (selam) - ${_getTranslation("Hello", languageCode)}',
          'አመሰግናለሁ (amesegnalehu) - ${_getTranslation("Thank you", languageCode)}',
          'እባክህ (ebakih) - ${_getTranslation("Please", languageCode)}',
          'ይቅርታ (yiqerta) - ${_getTranslation("Excuse me", languageCode)}',
          'አይ (ay) - ${_getTranslation("No", languageCode)}',
          'አዎ (awo) - ${_getTranslation("Yes", languageCode)}',
        ],
        exercises: [
          Exercise(
            id: 'ex_tourist_001',
            type: ExerciseType.listen,
            instruction: _getTranslation('Listen and repeat: "ሰላም"', languageCode),
            amharicText: 'ሰላም',
            translation: _getTranslation('Hello', languageCode),
            audioUrl: 'audio/amharic/beginner/selam.mp3',
            options: [
              ExerciseOption(text: 'ሰላም', isCorrect: true),
              ExerciseOption(text: 'ቻው', isCorrect: false),
              ExerciseOption(text: 'እንደምን', isCorrect: false),
            ],
            correctAnswer: 'ሰላም',
            explanation: _getTranslation('This means hello in Amharic', languageCode),
          ),
        ],
      ),
      _createLesson(
        id: '${languageCode}_tourist_002',
        title: _getTitle('Asking for Directions', languageCode),
        description: _getDescription('Learn to ask for directions and understand responses', languageCode),
        level: LanguageLevel.beginner,
        languageCode: languageCode,
        estimatedMinutes: 15,
        xpReward: 220,
        category: 'Tourist',
        vocabulary: [
          'የት ነው? (yet new?) - ${_getTranslation("Where is it?", languageCode)}',
          'ወደ የት? (wede yet?) - ${_getTranslation("Where to?", languageCode)}',
          'በዚህ በኩል (bezi bekul) - ${_getTranslation("This way", languageCode)}',
          'በዚያ በኩል (beziya bekul) - ${_getTranslation("That way", languageCode)}',
          'ቀጥታ (qeteta) - ${_getTranslation("Straight", languageCode)}',
          'ግራ (gira) - ${_getTranslation("Left", languageCode)}',
          'ቀኝ (qeny) - ${_getTranslation("Right", languageCode)}',
        ],
        exercises: [
          Exercise(
            id: 'ex_directions_001',
            type: ExerciseType.translate,
            instruction: _getTranslation('How do you ask "Where is it?" in Amharic?', languageCode),
            amharicText: 'የት ነው?',
            translation: _getTranslation('Where is it?', languageCode),
            audioUrl: 'audio/amharic/beginner/yet_new.mp3',
            options: [
              ExerciseOption(text: 'የት ነው?', isCorrect: true),
              ExerciseOption(text: 'ወደ የት?', isCorrect: false),
              ExerciseOption(text: 'በዚህ በኩል', isCorrect: false),
            ],
            correctAnswer: 'የት ነው?',
            explanation: _getTranslation('This is how you ask where something is', languageCode),
          ),
        ],
      ),
    ];
  }

  static List<Lesson> getFoodAndDining(String languageCode) {
    return [
      _createLesson(
        id: '${languageCode}_food_001',
        title: _getTitle('Restaurant Basics', languageCode),
        description: _getDescription('Essential phrases for dining out', languageCode),
        level: LanguageLevel.beginner,
        languageCode: languageCode,
        estimatedMinutes: 14,
        xpReward: 200,
        category: 'Food',
        vocabulary: [
          'መኝታ (menjta) - ${_getTranslation("Table", languageCode)}',
          'መኝታ አለኝ? (menjta aleny?) - ${_getTranslation("Do you have a table?", languageCode)}',
          'ምን ይመጣል? (min yimetal?) - ${_getTranslation("What do you recommend?", languageCode)}',
          'ዋጋ ምን ነው? (waga min new?) - ${_getTranslation("What is the price?", languageCode)}',
          'መጀመሪያ (mejemeriya) - ${_getTranslation("First", languageCode)}',
          'ሁለተኛ (huletena) - ${_getTranslation("Second", languageCode)}',
        ],
        exercises: [
          Exercise(
            id: 'ex_restaurant_001',
            type: ExerciseType.multipleChoice,
            instruction: _getTranslation('What is "መኝታ" in English?', languageCode),
            amharicText: 'መኝታ',
            translation: _getTranslation('Table', languageCode),
            audioUrl: 'audio/amharic/beginner/menjta.mp3',
            options: [
              ExerciseOption(text: _getTranslation('Table', languageCode), isCorrect: true),
              ExerciseOption(text: _getTranslation('Chair', languageCode), isCorrect: false),
              ExerciseOption(text: _getTranslation('Food', languageCode), isCorrect: false),
            ],
            correctAnswer: _getTranslation('Table', languageCode),
            explanation: _getTranslation('This means table in Amharic', languageCode),
          ),
        ],
      ),
      _createLesson(
        id: '${languageCode}_food_002',
        title: _getTitle('Ethiopian Cuisine', languageCode),
        description: _getDescription('Learn about traditional Ethiopian dishes', languageCode),
        level: LanguageLevel.intermediate,
        languageCode: languageCode,
        estimatedMinutes: 16,
        xpReward: 250,
        category: 'Food',
        vocabulary: [
          'እንጀራ (injera) - ${_getTranslation("Injera (sourdough bread)", languageCode)}',
          'ዶሮ ዋት (doro wat) - ${_getTranslation("Chicken stew", languageCode)}',
          'ክትፎ (kitfo) - ${_getTranslation("Minced raw beef", languageCode)}',
          'ሺሮ (shiro) - ${_getTranslation("Chickpea stew", languageCode)}',
          'በርበሬ (berbere) - ${_getTranslation("Spice mix", languageCode)}',
          'ቡና (buna) - ${_getTranslation("Coffee", languageCode)}',
        ],
        exercises: [
          Exercise(
            id: 'ex_cuisine_001',
            type: ExerciseType.translate,
            instruction: _getTranslation('What is "እንጀራ" in English?', languageCode),
            amharicText: 'እንጀራ',
            translation: _getTranslation('Injera', languageCode),
            audioUrl: 'audio/amharic/intermediate/injera.mp3',
            options: [
              ExerciseOption(text: _getTranslation('Injera', languageCode), isCorrect: true),
              ExerciseOption(text: _getTranslation('Bread', languageCode), isCorrect: false),
              ExerciseOption(text: _getTranslation('Rice', languageCode), isCorrect: false),
            ],
            correctAnswer: _getTranslation('Injera', languageCode),
            explanation: _getTranslation('This is the traditional Ethiopian sourdough bread', languageCode),
          ),
        ],
      ),
    ];
  }

  static Lesson _createLesson({
    required String id,
    required String title,
    required String description,
    required LanguageLevel level,
    required String languageCode,
    required int estimatedMinutes,
    required int xpReward,
    required String category,
    required List<String> vocabulary,
    required List<Exercise> exercises,
  }) {
    return Lesson(
      id: id,
      title: title,
      description: description,
      level: level,
      languageCode: languageCode,
      estimatedMinutes: estimatedMinutes,
      xpReward: xpReward,
      category: category,
      vocabulary: vocabulary,
      exercises: exercises,
    );
  }

  static String _getTitle(String englishTitle, String languageCode) {
    switch (languageCode) {
      case 'ar':
        return _getArabicTitle(englishTitle);
      case 'fr':
        return _getFrenchTitle(englishTitle);
      case 'es':
        return _getSpanishTitle(englishTitle);
      case 'de':
        return _getGermanTitle(englishTitle);
      case 'it':
        return _getItalianTitle(englishTitle);
      case 'pt':
        return _getPortugueseTitle(englishTitle);
      case 'ru':
        return _getRussianTitle(englishTitle);
      case 'ja':
        return _getJapaneseTitle(englishTitle);
      case 'zh':
        return _getChineseTitle(englishTitle);
      case 'hi':
        return _getHindiTitle(englishTitle);
      default:
        return englishTitle;
    }
  }

  static String _getDescription(String englishDescription, String languageCode) {
    switch (languageCode) {
      case 'ar':
        return _getArabicDescription(englishDescription);
      case 'fr':
        return _getFrenchDescription(englishDescription);
      case 'es':
        return _getSpanishDescription(englishDescription);
      case 'de':
        return _getGermanDescription(englishDescription);
      case 'it':
        return _getItalianDescription(englishDescription);
      case 'pt':
        return _getPortugueseDescription(englishDescription);
      case 'ru':
        return _getRussianDescription(englishDescription);
      case 'ja':
        return _getJapaneseDescription(englishDescription);
      case 'zh':
        return _getChineseDescription(englishDescription);
      case 'hi':
        return _getHindiDescription(englishDescription);
      default:
        return englishDescription;
    }
  }

  static String _getTranslation(String englishText, String languageCode) {
    switch (languageCode) {
      case 'ar':
        return _getArabicTranslation(englishText);
      case 'fr':
        return _getFrenchTranslation(englishText);
      case 'es':
        return _getSpanishTranslation(englishText);
      case 'de':
        return _getGermanTranslation(englishText);
      case 'it':
        return _getItalianTranslation(englishText);
      case 'pt':
        return _getPortugueseTranslation(englishText);
      case 'ru':
        return _getRussianTranslation(englishText);
      case 'ja':
        return _getJapaneseTranslation(englishText);
      case 'zh':
        return _getChineseTranslation(englishText);
      case 'hi':
        return _getHindiTranslation(englishText);
      default:
        return englishText;
    }
  }

  // Arabic translations
  static String _getArabicTitle(String title) {
    switch (title) {
      case 'Tourist Essentials': return 'الأساسيات السياحية';
      case 'Asking for Directions': return 'طلب الاتجاهات';
      case 'Restaurant Basics': return 'أساسيات المطعم';
      case 'Ethiopian Cuisine': return 'المطبخ الإثيوبي';
      default: return title;
    }
  }

  static String _getArabicDescription(String description) {
    switch (description) {
      case 'Essential phrases for tourists': return 'العبارات الأساسية للسياح';
      case 'Learn to ask for directions and understand responses': return 'تعلم طلب الاتجاهات وفهم الردود';
      case 'Essential phrases for dining out': return 'العبارات الأساسية لتناول الطعام خارج المنزل';
      case 'Learn about traditional Ethiopian dishes': return 'تعلم عن الأطباق الإثيوبية التقليدية';
      default: return description;
    }
  }

  static String _getArabicTranslation(String text) {
    switch (text) {
      case 'Hello': return 'مرحبا';
      case 'Thank you': return 'شكرا';
      case 'Please': return 'من فضلك';
      case 'Excuse me': return 'اعذرني';
      case 'No': return 'لا';
      case 'Yes': return 'نعم';
      case 'Where is it?': return 'أين هو؟';
      case 'Where to?': return 'إلى أين؟';
      case 'This way': return 'بهذا الاتجاه';
      case 'That way': return 'بهذا الاتجاه';
      case 'Straight': return 'مستقيم';
      case 'Left': return 'يسار';
      case 'Right': return 'يمين';
      case 'Table': return 'طاولة';
      case 'Chair': return 'كرسي';
      case 'Food': return 'طعام';
      case 'Do you have a table?': return 'هل لديك طاولة؟';
      case 'What do you recommend?': return 'ماذا تنصح؟';
      case 'What is the price?': return 'ما هو السعر؟';
      case 'First': return 'أول';
      case 'Second': return 'ثاني';
      case 'Injera (sourdough bread)': return 'إنجيرا (خبز مخمر)';
      case 'Chicken stew': return 'يخنة الدجاج';
      case 'Minced raw beef': return 'لحم بقري نيء مفروم';
      case 'Chickpea stew': return 'يخنة الحمص';
      case 'Spice mix': return 'خليط التوابل';
      case 'Coffee': return 'قهوة';
      case 'Bread': return 'خبز';
      case 'Rice': return 'أرز';
      case 'This is the traditional Ethiopian sourdough bread': return 'هذا هو الخبز المخمر الإثيوبي التقليدي';
      default: return text;
    }
  }

  // French translations
  static String _getFrenchTitle(String title) {
    switch (title) {
      case 'Tourist Essentials': return 'Essentiels Touristiques';
      case 'Asking for Directions': return 'Demander des Directions';
      case 'Restaurant Basics': return 'Bases du Restaurant';
      case 'Ethiopian Cuisine': return 'Cuisine Éthiopienne';
      default: return title;
    }
  }

  static String _getFrenchDescription(String description) {
    switch (description) {
      case 'Essential phrases for tourists': return 'Phrases essentielles pour les touristes';
      case 'Learn to ask for directions and understand responses': return 'Apprenez à demander des directions et comprendre les réponses';
      case 'Essential phrases for dining out': return 'Phrases essentielles pour dîner au restaurant';
      case 'Learn about traditional Ethiopian dishes': return 'Apprenez sur les plats traditionnels éthiopiens';
      default: return description;
    }
  }

  static String _getFrenchTranslation(String text) {
    switch (text) {
      case 'Hello': return 'Bonjour';
      case 'Thank you': return 'Merci';
      case 'Please': return 'S\'il vous plaît';
      case 'Excuse me': return 'Excusez-moi';
      case 'No': return 'Non';
      case 'Yes': return 'Oui';
      case 'Where is it?': return 'Où est-ce?';
      case 'Where to?': return 'Où aller?';
      case 'This way': return 'Par ici';
      case 'That way': return 'Par là';
      case 'Straight': return 'Tout droit';
      case 'Left': return 'Gauche';
      case 'Right': return 'Droite';
      case 'Table': return 'Table';
      case 'Chair': return 'Chaise';
      case 'Food': return 'Nourriture';
      case 'Do you have a table?': return 'Avez-vous une table?';
      case 'What do you recommend?': return 'Que recommandez-vous?';
      case 'What is the price?': return 'Quel est le prix?';
      case 'First': return 'Premier';
      case 'Second': return 'Deuxième';
      case 'Injera (sourdough bread)': return 'Injera (pain au levain)';
      case 'Chicken stew': return 'Ragoût de poulet';
      case 'Minced raw beef': return 'Bœuf cru haché';
      case 'Chickpea stew': return 'Ragoût de pois chiches';
      case 'Spice mix': return 'Mélange d\'épices';
      case 'Coffee': return 'Café';
      case 'Bread': return 'Pain';
      case 'Rice': return 'Riz';
      case 'This is the traditional Ethiopian sourdough bread': return 'C\'est le pain au levain traditionnel éthiopien';
      default: return text;
    }
  }

  // Placeholder methods for other languages
  static String _getSpanishTitle(String title) => title;
  static String _getGermanTitle(String title) => title;
  static String _getItalianTitle(String title) => title;
  static String _getPortugueseTitle(String title) => title;
  static String _getRussianTitle(String title) => title;
  static String _getJapaneseTitle(String title) => title;
  static String _getChineseTitle(String title) => title;
  static String _getHindiTitle(String title) => title;

  static String _getSpanishDescription(String description) => description;
  static String _getGermanDescription(String description) => description;
  static String _getItalianDescription(String description) => description;
  static String _getPortugueseDescription(String description) => description;
  static String _getRussianDescription(String description) => description;
  static String _getJapaneseDescription(String description) => description;
  static String _getChineseDescription(String description) => description;
  static String _getHindiDescription(String description) => description;

  static String _getSpanishTranslation(String text) => text;
  static String _getGermanTranslation(String text) => text;
  static String _getItalianTranslation(String text) => text;
  static String _getPortugueseTranslation(String text) => text;
  static String _getRussianTranslation(String text) => text;
  static String _getJapaneseTranslation(String text) => text;
  static String _getChineseTranslation(String text) => text;
  static String _getHindiTranslation(String text) => text;
}
