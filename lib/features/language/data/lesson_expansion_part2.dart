import 'package:tourist_assistive_app/features/language/models/comprehensive_lesson_model.dart';

/// Part 2: Transportation and Accommodation Lessons
class LessonExpansionPart2 {
  
  static List<Lesson> getTransportation(String languageCode) {
    return [
      _createLesson(
        id: '${languageCode}_transport_001',
        title: _getTitle('Public Transportation', languageCode),
        description: _getDescription('Learn to use buses, taxis, and other transport', languageCode),
        level: LanguageLevel.beginner,
        languageCode: languageCode,
        estimatedMinutes: 13,
        xpReward: 200,
        category: 'Transportation',
        vocabulary: [
          'አውቶቡስ (awtobus) - ${_getTranslation("Bus", languageCode)}',
          'ታክሲ (taksi) - ${_getTranslation("Taxi", languageCode)}',
          'መኪና (mekina) - ${_getTranslation("Car", languageCode)}',
          'ባቡር (babur) - ${_getTranslation("Train", languageCode)}',
          'አውሮፕላን (awroplan) - ${_getTranslation("Airplane", languageCode)}',
          'መንገድ (menged) - ${_getTranslation("Road", languageCode)}',
          'ጣቢያ (tabiya) - ${_getTranslation("Station", languageCode)}',
        ],
        exercises: [
          Exercise(
            id: 'ex_transport_001',
            type: ExerciseType.multipleChoice,
            instruction: _getTranslation('What is "አውቶቡስ" in English?', languageCode),
            amharicText: 'አውቶቡስ',
            translation: _getTranslation('Bus', languageCode),
            audioUrl: 'audio/amharic/beginner/awtobus.mp3',
            options: [
              ExerciseOption(text: _getTranslation('Bus', languageCode), isCorrect: true),
              ExerciseOption(text: _getTranslation('Taxi', languageCode), isCorrect: false),
              ExerciseOption(text: _getTranslation('Car', languageCode), isCorrect: false),
            ],
            correctAnswer: _getTranslation('Bus', languageCode),
            explanation: _getTranslation('This means bus in Amharic', languageCode),
          ),
        ],
      ),
      _createLesson(
        id: '${languageCode}_transport_002',
        title: _getTitle('Airport and Travel', languageCode),
        description: _getDescription('Essential phrases for airport and travel situations', languageCode),
        level: LanguageLevel.beginner,
        languageCode: languageCode,
        estimatedMinutes: 11,
        xpReward: 180,
        category: 'Transportation',
        vocabulary: [
          'መንገድ ተመልከት (menged temelket) - ${_getTranslation("Ticket", languageCode)}',
          'መንገድ ተመልከት አለኝ? (menged temelket aleny?) - ${_getTranslation("Do you have a ticket?", languageCode)}',
          'ወደ የት? (wede yet?) - ${_getTranslation("Where to?", languageCode)}',
          'ወደ አዲስ አበባ (wede adis abeba) - ${_getTranslation("To Addis Ababa", languageCode)}',
          'ወደ ላሊበላ (wede lalibela) - ${_getTranslation("To Lalibela", languageCode)}',
          'ወደ አክሱም (wede aksum) - ${_getTranslation("To Axum", languageCode)}',
        ],
        exercises: [
          Exercise(
            id: 'ex_airport_001',
            type: ExerciseType.translate,
            instruction: _getTranslation('How do you say "To Addis Ababa" in Amharic?', languageCode),
            amharicText: 'ወደ አዲስ አበባ',
            translation: _getTranslation('To Addis Ababa', languageCode),
            audioUrl: 'audio/amharic/beginner/wede_adis_abeba.mp3',
            options: [
              ExerciseOption(text: 'ወደ አዲስ አበባ', isCorrect: true),
              ExerciseOption(text: 'ወደ ላሊበላ', isCorrect: false),
              ExerciseOption(text: 'ወደ አክሱም', isCorrect: false),
            ],
            correctAnswer: 'ወደ አዲስ አበባ',
            explanation: _getTranslation('This means "To Addis Ababa" in Amharic', languageCode),
          ),
        ],
      ),
    ];
  }

  static List<Lesson> getAccommodation(String languageCode) {
    return [
      _createLesson(
        id: '${languageCode}_accommodation_001',
        title: _getTitle('Hotel Booking', languageCode),
        description: _getDescription('Learn to book and discuss hotel accommodations', languageCode),
        level: LanguageLevel.beginner,
        languageCode: languageCode,
        estimatedMinutes: 15,
        xpReward: 220,
        category: 'Accommodation',
        vocabulary: [
          'ሆቴል (hotel) - ${_getTranslation("Hotel", languageCode)}',
          'መኝታ (menjta) - ${_getTranslation("Room", languageCode)}',
          'አንድ ሰው (and sew) - ${_getTranslation("Single person", languageCode)}',
          'ሁለት ሰው (hulet sew) - ${_getTranslation("Two people", languageCode)}',
          'ለስንት ቀን? (lesint qen?) - ${_getTranslation("For how many days?", languageCode)}',
          'አንድ ቀን (and qen) - ${_getTranslation("One day", languageCode)}',
          'ሁለት ቀን (hulet qen) - ${_getTranslation("Two days", languageCode)}',
        ],
        exercises: [
          Exercise(
            id: 'ex_hotel_001',
            type: ExerciseType.translate,
            instruction: _getTranslation('How do you say "For how many days?" in Amharic?', languageCode),
            amharicText: 'ለስንት ቀን?',
            translation: _getTranslation('For how many days?', languageCode),
            audioUrl: 'audio/amharic/beginner/lesint_qen.mp3',
            options: [
              ExerciseOption(text: 'ለስንት ቀን?', isCorrect: true),
              ExerciseOption(text: 'ምን ዋጋ ነው?', isCorrect: false),
              ExerciseOption(text: 'የት ነው?', isCorrect: false),
            ],
            correctAnswer: 'ለስንት ቀን?',
            explanation: _getTranslation('This means "For how many days?" in Amharic', languageCode),
          ),
        ],
      ),
      _createLesson(
        id: '${languageCode}_accommodation_002',
        title: _getTitle('Hotel Services', languageCode),
        description: _getDescription('Learn about hotel services and amenities', languageCode),
        level: LanguageLevel.intermediate,
        languageCode: languageCode,
        estimatedMinutes: 12,
        xpReward: 200,
        category: 'Accommodation',
        vocabulary: [
          'ውሃ (wha) - ${_getTranslation("Water", languageCode)}',
          'መታጠቢያ (metatebiya) - ${_getTranslation("Bathroom", languageCode)}',
          'አየር ማቀዝቀዣ (ayr maqezqeza) - ${_getTranslation("Air conditioning", languageCode)}',
          'ቴሌቪዥን (televizhn) - ${_getTranslation("Television", languageCode)}',
          'የመኝታ ክፍል (ye menjta kefl) - ${_getTranslation("Bedroom", languageCode)}',
          'ማስተር ቁልፍ (master qulf) - ${_getTranslation("Master key", languageCode)}',
        ],
        exercises: [
          Exercise(
            id: 'ex_services_001',
            type: ExerciseType.multipleChoice,
            instruction: _getTranslation('What is "ውሃ" in English?', languageCode),
            amharicText: 'ውሃ',
            translation: _getTranslation('Water', languageCode),
            audioUrl: 'audio/amharic/intermediate/wha.mp3',
            options: [
              ExerciseOption(text: _getTranslation('Water', languageCode), isCorrect: true),
              ExerciseOption(text: _getTranslation('Food', languageCode), isCorrect: false),
              ExerciseOption(text: _getTranslation('Coffee', languageCode), isCorrect: false),
            ],
            correctAnswer: _getTranslation('Water', languageCode),
            explanation: _getTranslation('This means water in Amharic', languageCode),
          ),
        ],
      ),
    ];
  }

  static List<Lesson> getShoppingAndMarkets(String languageCode) {
    return [
      _createLesson(
        id: '${languageCode}_shopping_001',
        title: _getTitle('Market Shopping', languageCode),
        description: _getDescription('Learn to shop in Ethiopian markets and negotiate prices', languageCode),
        level: LanguageLevel.intermediate,
        languageCode: languageCode,
        estimatedMinutes: 18,
        xpReward: 280,
        category: 'Shopping',
        vocabulary: [
          'ገበያ (gebea) - ${_getTranslation("Market", languageCode)}',
          'ሱቅ (suq) - ${_getTranslation("Shop", languageCode)}',
          'ዋጋ (waga) - ${_getTranslation("Price", languageCode)}',
          'ተሸጣ (tesheta) - ${_getTranslation("Seller", languageCode)}',
          'ገዢ (gezi) - ${_getTranslation("Buyer", languageCode)}',
          'ገንዘብ (genzeb) - ${_getTranslation("Money", languageCode)}',
          'ብር (birr) - ${_getTranslation("Ethiopian currency", languageCode)}',
        ],
        exercises: [
          Exercise(
            id: 'ex_market_001',
            type: ExerciseType.translate,
            instruction: _getTranslation('How do you ask "What is the price?" in Amharic?', languageCode),
            amharicText: 'ምን ዋጋ ነው?',
            translation: _getTranslation('What is the price?', languageCode),
            audioUrl: 'audio/amharic/intermediate/min_waga_new.mp3',
            options: [
              ExerciseOption(text: 'ምን ዋጋ ነው?', isCorrect: true),
              ExerciseOption(text: 'በጣም ውድ ነው', isCorrect: false),
              ExerciseOption(text: 'እባክህ ተቀናጅ', isCorrect: false),
            ],
            correctAnswer: 'ምን ዋጋ ነው?',
            explanation: _getTranslation('This is how you ask for the price in Amharic', languageCode),
          ),
        ],
      ),
      _createLesson(
        id: '${languageCode}_shopping_002',
        title: _getTitle('Bargaining and Prices', languageCode),
        description: _getDescription('Master the art of bargaining in Ethiopian markets', languageCode),
        level: LanguageLevel.intermediate,
        languageCode: languageCode,
        estimatedMinutes: 16,
        xpReward: 250,
        category: 'Shopping',
        vocabulary: [
          'በጣም ውድ ነው (betam wud new) - ${_getTranslation("It is very expensive", languageCode)}',
          'ተቀናጅ (teqenaj) - ${_getTranslation("Discount", languageCode)}',
          'እባክህ ተቀናጅ (ebakih teqenaj) - ${_getTranslation("Please give discount", languageCode)}',
          'በጣም ተቀናጅ (betam teqenaj) - ${_getTranslation("Very cheap", languageCode)}',
          'አስር ብር (asir birr) - ${_getTranslation("Ten birr", languageCode)}',
          'ሃያ ብር (haya birr) - ${_getTranslation("Twenty birr", languageCode)}',
        ],
        exercises: [
          Exercise(
            id: 'ex_bargaining_001',
            type: ExerciseType.translate,
            instruction: _getTranslation('How do you say "It is very expensive" in Amharic?', languageCode),
            amharicText: 'በጣም ውድ ነው',
            translation: _getTranslation('It is very expensive', languageCode),
            audioUrl: 'audio/amharic/intermediate/betam_wud_new.mp3',
            options: [
              ExerciseOption(text: 'በጣም ውድ ነው', isCorrect: true),
              ExerciseOption(text: 'ተቀናጅ', isCorrect: false),
              ExerciseOption(text: 'በጣም ተቀናጅ', isCorrect: false),
            ],
            correctAnswer: 'በጣም ውድ ነው',
            explanation: _getTranslation('This means "It is very expensive" in Amharic', languageCode),
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
      case 'Public Transportation': return 'النقل العام';
      case 'Airport and Travel': return 'المطار والسفر';
      case 'Hotel Booking': return 'حجز الفندق';
      case 'Hotel Services': return 'خدمات الفندق';
      case 'Market Shopping': return 'تسوق السوق';
      case 'Bargaining and Prices': return 'المساومة والأسعار';
      default: return title;
    }
  }

  static String _getArabicDescription(String description) {
    switch (description) {
      case 'Learn to use buses, taxis, and other transport': return 'تعلم استخدام الحافلات وسيارات الأجرة والنقل الآخر';
      case 'Essential phrases for airport and travel situations': return 'العبارات الأساسية لمواقف المطار والسفر';
      case 'Learn to book and discuss hotel accommodations': return 'تعلم حجز ومناقشة أماكن الإقامة في الفندق';
      case 'Learn about hotel services and amenities': return 'تعلم عن خدمات ومرافق الفندق';
      case 'Learn to shop in Ethiopian markets and negotiate prices': return 'تعلم التسوق في الأسواق الإثيوبية والتفاوض على الأسعار';
      case 'Master the art of bargaining in Ethiopian markets': return 'إتقان فن المساومة في الأسواق الإثيوبية';
      default: return description;
    }
  }

  static String _getArabicTranslation(String text) {
    switch (text) {
      case 'Bus': return 'حافلة';
      case 'Taxi': return 'سيارة أجرة';
      case 'Car': return 'سيارة';
      case 'Train': return 'قطار';
      case 'Airplane': return 'طائرة';
      case 'Road': return 'طريق';
      case 'Station': return 'محطة';
      case 'Ticket': return 'تذكرة';
      case 'Do you have a ticket?': return 'هل لديك تذكرة؟';
      case 'Where to?': return 'إلى أين؟';
      case 'To Addis Ababa': return 'إلى أديس أبابا';
      case 'To Lalibela': return 'إلى لاليبيلا';
      case 'To Axum': return 'إلى أكسوم';
      case 'Hotel': return 'فندق';
      case 'Room': return 'غرفة';
      case 'Single person': return 'شخص واحد';
      case 'Two people': return 'شخصان';
      case 'For how many days?': return 'لمدة كم يوم؟';
      case 'One day': return 'يوم واحد';
      case 'Two days': return 'يومان';
      case 'Water': return 'ماء';
      case 'Bathroom': return 'حمام';
      case 'Air conditioning': return 'تكييف الهواء';
      case 'Television': return 'تلفزيون';
      case 'Bedroom': return 'غرفة نوم';
      case 'Master key': return 'مفتاح رئيسي';
      case 'Market': return 'سوق';
      case 'Shop': return 'متجر';
      case 'Price': return 'سعر';
      case 'Seller': return 'بائع';
      case 'Buyer': return 'مشتري';
      case 'Money': return 'مال';
      case 'Ethiopian currency': return 'العملة الإثيوبية';
      case 'What is the price?': return 'ما هو السعر؟';
      case 'It is very expensive': return 'إنه مكلف جداً';
      case 'Discount': return 'خصم';
      case 'Please give discount': return 'من فضلك أعطني خصماً';
      case 'Very cheap': return 'رخيص جداً';
      case 'Ten birr': return 'عشرة بر';
      case 'Twenty birr': return 'عشرون بر';
      case 'This is how you ask for the price in Amharic': return 'هكذا تسأل عن السعر بالأمهرية';
      case 'This means "It is very expensive" in Amharic': return 'هذا يعني "إنه مكلف جداً" بالأمهرية';
      default: return text;
    }
  }

  // French translations
  static String _getFrenchTitle(String title) {
    switch (title) {
      case 'Public Transportation': return 'Transport Public';
      case 'Airport and Travel': return 'Aéroport et Voyage';
      case 'Hotel Booking': return 'Réservation d\'Hôtel';
      case 'Hotel Services': return 'Services d\'Hôtel';
      case 'Market Shopping': return 'Shopping au Marché';
      case 'Bargaining and Prices': return 'Négociation et Prix';
      default: return title;
    }
  }

  static String _getFrenchDescription(String description) {
    switch (description) {
      case 'Learn to use buses, taxis, and other transport': return 'Apprenez à utiliser les bus, taxis et autres transports';
      case 'Essential phrases for airport and travel situations': return 'Phrases essentielles pour les situations d\'aéroport et de voyage';
      case 'Learn to book and discuss hotel accommodations': return 'Apprenez à réserver et discuter des hébergements hôteliers';
      case 'Learn about hotel services and amenities': return 'Apprenez sur les services et équipements hôteliers';
      case 'Learn to shop in Ethiopian markets and negotiate prices': return 'Apprenez à faire du shopping dans les marchés éthiopiens et négocier les prix';
      case 'Master the art of bargaining in Ethiopian markets': return 'Maîtrisez l\'art de la négociation dans les marchés éthiopiens';
      default: return description;
    }
  }

  static String _getFrenchTranslation(String text) {
    switch (text) {
      case 'Bus': return 'Bus';
      case 'Taxi': return 'Taxi';
      case 'Car': return 'Voiture';
      case 'Train': return 'Train';
      case 'Airplane': return 'Avion';
      case 'Road': return 'Route';
      case 'Station': return 'Gare';
      case 'Ticket': return 'Billet';
      case 'Do you have a ticket?': return 'Avez-vous un billet?';
      case 'Where to?': return 'Où aller?';
      case 'To Addis Ababa': return 'À Addis Abeba';
      case 'To Lalibela': return 'À Lalibela';
      case 'To Axum': return 'À Axum';
      case 'Hotel': return 'Hôtel';
      case 'Room': return 'Chambre';
      case 'Single person': return 'Une personne';
      case 'Two people': return 'Deux personnes';
      case 'For how many days?': return 'Pour combien de jours?';
      case 'One day': return 'Un jour';
      case 'Two days': return 'Deux jours';
      case 'Water': return 'Eau';
      case 'Bathroom': return 'Salle de bain';
      case 'Air conditioning': return 'Climatisation';
      case 'Television': return 'Télévision';
      case 'Bedroom': return 'Chambre à coucher';
      case 'Master key': return 'Clé principale';
      case 'Market': return 'Marché';
      case 'Shop': return 'Magasin';
      case 'Price': return 'Prix';
      case 'Seller': return 'Vendeur';
      case 'Buyer': return 'Acheteur';
      case 'Money': return 'Argent';
      case 'Ethiopian currency': return 'Monnaie éthiopienne';
      case 'What is the price?': return 'Quel est le prix?';
      case 'It is very expensive': return 'C\'est très cher';
      case 'Discount': return 'Remise';
      case 'Please give discount': return 'S\'il vous plaît, donnez une remise';
      case 'Very cheap': return 'Très bon marché';
      case 'Ten birr': return 'Dix birr';
      case 'Twenty birr': return 'Vingt birr';
      case 'This is how you ask for the price in Amharic': return 'C\'est ainsi que vous demandez le prix en amharique';
      case 'This means "It is very expensive" in Amharic': return 'Cela signifie "C\'est très cher" en amharique';
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
