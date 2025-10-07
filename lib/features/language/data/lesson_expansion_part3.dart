import 'package:tourist_assistive_app/features/language/models/comprehensive_lesson_model.dart';

/// Part 3: Emergency, Health, and Cultural Lessons
class LessonExpansionPart3 {
  
  static List<Lesson> getEmergencyAndHealth(String languageCode) {
    return [
      _createLesson(
        id: '${languageCode}_emergency_001',
        title: _getTitle('Emergency Situations', languageCode),
        description: _getDescription('Essential phrases for emergency situations', languageCode),
        level: LanguageLevel.beginner,
        languageCode: languageCode,
        estimatedMinutes: 10,
        xpReward: 200,
        category: 'Emergency',
        vocabulary: [
          'እርዳታ (erdeta) - ${_getTranslation("Help", languageCode)}',
          'አስቸኳይ (aschekway) - ${_getTranslation("Emergency", languageCode)}',
          'ዶክተር (dokter) - ${_getTranslation("Doctor", languageCode)}',
          'ሆስፒታል (hospital) - ${_getTranslation("Hospital", languageCode)}',
          'ፖሊስ (polis) - ${_getTranslation("Police", languageCode)}',
          'እርዳታ ያስፈልገኛል (erdeta yasfelgenyal) - ${_getTranslation("I need help", languageCode)}',
          'ዶክተር ያስፈልገኛል (dokter yasfelgenyal) - ${_getTranslation("I need a doctor", languageCode)}',
        ],
        exercises: [
          Exercise(
            id: 'ex_emergency_001',
            type: ExerciseType.translate,
            instruction: _getTranslation('How do you say "I need help" in Amharic?', languageCode),
            amharicText: 'እርዳታ ያስፈልገኛል',
            translation: _getTranslation('I need help', languageCode),
            audioUrl: 'audio/amharic/beginner/erdeta_yasfelgenyal.mp3',
            options: [
              ExerciseOption(text: 'እርዳታ ያስፈልገኛል', isCorrect: true),
              ExerciseOption(text: 'ዶክተር ያስፈልገኛል', isCorrect: false),
              ExerciseOption(text: 'ፖሊስ ይጥራ', isCorrect: false),
            ],
            correctAnswer: 'እርዳታ ያስፈልገኛል',
            explanation: _getTranslation('This means "I need help" in Amharic', languageCode),
          ),
        ],
      ),
      _createLesson(
        id: '${languageCode}_health_001',
        title: _getTitle('Health and Medical', languageCode),
        description: _getDescription('Learn medical vocabulary and health-related phrases', languageCode),
        level: LanguageLevel.intermediate,
        languageCode: languageCode,
        estimatedMinutes: 14,
        xpReward: 220,
        category: 'Health',
        vocabulary: [
          'ጤና (tena) - ${_getTranslation("Health", languageCode)}',
          'በሽታ (beshita) - ${_getTranslation("Disease", languageCode)}',
          'ህመም (hmmam) - ${_getTranslation("Pain", languageCode)}',
          'ነርስ (ners) - ${_getTranslation("Nurse", languageCode)}',
          'ፋርማሲ (farmasi) - ${_getTranslation("Pharmacy", languageCode)}',
          'መድሃኒት (medhanit) - ${_getTranslation("Medicine", languageCode)}',
          'ጤና አለኝ (tena aleny) - ${_getTranslation("I have health", languageCode)}',
        ],
        exercises: [
          Exercise(
            id: 'ex_health_001',
            type: ExerciseType.translate,
            instruction: _getTranslation('How do you say "I have health" in Amharic?', languageCode),
            amharicText: 'ጤና አለኝ',
            translation: _getTranslation('I have health', languageCode),
            audioUrl: 'audio/amharic/intermediate/tena_aleny.mp3',
            options: [
              ExerciseOption(text: 'ጤና አለኝ', isCorrect: true),
              ExerciseOption(text: 'ጤና የለኝም', isCorrect: false),
              ExerciseOption(text: 'በሽታ አለኝ', isCorrect: false),
            ],
            correctAnswer: 'ጤና አለኝ',
            explanation: _getTranslation('This means "I have health" in Amharic', languageCode),
          ),
        ],
      ),
    ];
  }

  static List<Lesson> getCulturalEtiquette(String languageCode) {
    return [
      _createLesson(
        id: '${languageCode}_culture_001',
        title: _getTitle('Cultural Etiquette', languageCode),
        description: _getDescription('Learn proper cultural etiquette and customs', languageCode),
        level: LanguageLevel.intermediate,
        languageCode: languageCode,
        estimatedMinutes: 16,
        xpReward: 250,
        category: 'Culture',
        vocabulary: [
          'እባክህ (ebakih) - ${_getTranslation("Please", languageCode)}',
          'አመሰግናለሁ (amesegnalehu) - ${_getTranslation("Thank you", languageCode)}',
          'ይቅርታ (yiqerta) - ${_getTranslation("Excuse me", languageCode)}',
          'አይ (ay) - ${_getTranslation("No", languageCode)}',
          'አዎ (awo) - ${_getTranslation("Yes", languageCode)}',
          'እባክህ ይቅርታ (ebakih yiqerta) - ${_getTranslation("Please excuse me", languageCode)}',
          'አመሰግናለሁ በጣም (amesegnalehu betam) - ${_getTranslation("Thank you very much", languageCode)}',
        ],
        exercises: [
          Exercise(
            id: 'ex_culture_001',
            type: ExerciseType.translate,
            instruction: _getTranslation('How do you say "Please excuse me" in Amharic?', languageCode),
            amharicText: 'እባክህ ይቅርታ',
            translation: _getTranslation('Please excuse me', languageCode),
            audioUrl: 'audio/amharic/intermediate/ebakih_yiqerta.mp3',
            options: [
              ExerciseOption(text: 'እባክህ ይቅርታ', isCorrect: true),
              ExerciseOption(text: 'አመሰግናለሁ', isCorrect: false),
              ExerciseOption(text: 'ይቅርታ', isCorrect: false),
            ],
            correctAnswer: 'እባክህ ይቅርታ',
            explanation: _getTranslation('This means "Please excuse me" in Amharic', languageCode),
          ),
        ],
      ),
      _createLesson(
        id: '${languageCode}_culture_002',
        title: _getTitle('Religious Customs', languageCode),
        description: _getDescription('Learn about religious customs and practices', languageCode),
        level: LanguageLevel.advanced,
        languageCode: languageCode,
        estimatedMinutes: 18,
        xpReward: 300,
        category: 'Culture',
        vocabulary: [
          'ቤተ ክርስቲያን (bete kristiyan) - ${_getTranslation("Church", languageCode)}',
          'መስጊድ (mesgid) - ${_getTranslation("Mosque", languageCode)}',
          'ጸሎት (tselot) - ${_getTranslation("Prayer", languageCode)}',
          'አባት (abat) - ${_getTranslation("Priest", languageCode)}',
          'አማን (aman) - ${_getTranslation("Amen", languageCode)}',
          'እግዚአብሔር (egziabher) - ${_getTranslation("God", languageCode)}',
        ],
        exercises: [
          Exercise(
            id: 'ex_religious_001',
            type: ExerciseType.multipleChoice,
            instruction: _getTranslation('What is "ቤተ ክርስቲያን" in English?', languageCode),
            amharicText: 'ቤተ ክርስቲያን',
            translation: _getTranslation('Church', languageCode),
            audioUrl: 'audio/amharic/advanced/bete_kristiyan.mp3',
            options: [
              ExerciseOption(text: _getTranslation('Church', languageCode), isCorrect: true),
              ExerciseOption(text: _getTranslation('Mosque', languageCode), isCorrect: false),
              ExerciseOption(text: _getTranslation('Temple', languageCode), isCorrect: false),
            ],
            correctAnswer: _getTranslation('Church', languageCode),
            explanation: _getTranslation('This means church in Amharic', languageCode),
          ),
        ],
      ),
    ];
  }

  static List<Lesson> getHistoricalSites(String languageCode) {
    return [
      _createLesson(
        id: '${languageCode}_history_001',
        title: _getTitle('Historical Sites', languageCode),
        description: _getDescription('Learn about Ethiopia\'s rich historical heritage', languageCode),
        level: LanguageLevel.advanced,
        languageCode: languageCode,
        estimatedMinutes: 20,
        xpReward: 350,
        category: 'History',
        vocabulary: [
          'ታሪክ (tarik) - ${_getTranslation("History", languageCode)}',
          'ባህል (bahil) - ${_getTranslation("Culture", languageCode)}',
          'አርክቴክቸር (arkitekcher) - ${_getTranslation("Architecture", languageCode)}',
          'ሙዚየም (muzeym) - ${_getTranslation("Museum", languageCode)}',
          'የታሪክ ቦታ (yetarik bota) - ${_getTranslation("Historical place", languageCode)}',
          'አክሱም (aksum) - ${_getTranslation("Axum", languageCode)}',
          'ላሊበላ (lalibela) - ${_getTranslation("Lalibela", languageCode)}',
        ],
        exercises: [
          Exercise(
            id: 'ex_history_001',
            type: ExerciseType.translate,
            instruction: _getTranslation('How do you say "Historical place" in Amharic?', languageCode),
            amharicText: 'የታሪክ ቦታ',
            translation: _getTranslation('Historical place', languageCode),
            audioUrl: 'audio/amharic/advanced/yetarik_bota.mp3',
            options: [
              ExerciseOption(text: 'የታሪክ ቦታ', isCorrect: true),
              ExerciseOption(text: 'የባህል ቦታ', isCorrect: false),
              ExerciseOption(text: 'የአርክቴክቸር ቦታ', isCorrect: false),
            ],
            correctAnswer: 'የታሪክ ቦታ',
            explanation: _getTranslation('This means "Historical place" in Amharic', languageCode),
          ),
        ],
      ),
      _createLesson(
        id: '${languageCode}_history_002',
        title: _getTitle('UNESCO World Heritage', languageCode),
        description: _getDescription('Learn about Ethiopia\'s UNESCO World Heritage sites', languageCode),
        level: LanguageLevel.advanced,
        languageCode: languageCode,
        estimatedMinutes: 22,
        xpReward: 400,
        category: 'History',
        vocabulary: [
          'ዩኔስኮ (unesco) - ${_getTranslation("UNESCO", languageCode)}',
          'የዓለም ቅርስ (yealem qrs) - ${_getTranslation("World heritage", languageCode)}',
          'ጎንደር (gonder) - ${_getTranslation("Gondar", languageCode)}',
          'ባህር ዳር (bahir dar) - ${_getTranslation("Bahir Dar", languageCode)}',
          'ሲሚን ተራሮች (simin teraroch) - ${_getTranslation("Simien Mountains", languageCode)}',
          'ኦሞ ሸለቆ (omo sheleko) - ${_getTranslation("Omo Valley", languageCode)}',
        ],
        exercises: [
          Exercise(
            id: 'ex_unesco_001',
            type: ExerciseType.multipleChoice,
            instruction: _getTranslation('What is "ዩኔስኮ" in English?', languageCode),
            amharicText: 'ዩኔስኮ',
            translation: _getTranslation('UNESCO', languageCode),
            audioUrl: 'audio/amharic/advanced/unesco.mp3',
            options: [
              ExerciseOption(text: _getTranslation('UNESCO', languageCode), isCorrect: true),
              ExerciseOption(text: _getTranslation('UNICEF', languageCode), isCorrect: false),
              ExerciseOption(text: _getTranslation('WHO', languageCode), isCorrect: false),
            ],
            correctAnswer: _getTranslation('UNESCO', languageCode),
            explanation: _getTranslation('This is UNESCO in Amharic', languageCode),
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
      case 'Emergency Situations': return 'حالات الطوارئ';
      case 'Health and Medical': return 'الصحة والطبية';
      case 'Cultural Etiquette': return 'آداب ثقافية';
      case 'Religious Customs': return 'العادات الدينية';
      case 'Historical Sites': return 'المواقع التاريخية';
      case 'UNESCO World Heritage': return 'التراث العالمي لليونسكو';
      default: return title;
    }
  }

  static String _getArabicDescription(String description) {
    switch (description) {
      case 'Essential phrases for emergency situations': return 'العبارات الأساسية لحالات الطوارئ';
      case 'Learn medical vocabulary and health-related phrases': return 'تعلم المفردات الطبية والعبارات المتعلقة بالصحة';
      case 'Learn proper cultural etiquette and customs': return 'تعلم الآداب والعادات الثقافية المناسبة';
      case 'Learn about religious customs and practices': return 'تعلم عن العادات والممارسات الدينية';
      case 'Learn about Ethiopia\'s rich historical heritage': return 'تعلم عن التراث التاريخي الغني لإثيوبيا';
      case 'Learn about Ethiopia\'s UNESCO World Heritage sites': return 'تعلم عن مواقع التراث العالمي لليونسكو في إثيوبيا';
      default: return description;
    }
  }

  static String _getArabicTranslation(String text) {
    switch (text) {
      case 'Help': return 'مساعدة';
      case 'Emergency': return 'طوارئ';
      case 'Doctor': return 'طبيب';
      case 'Hospital': return 'مستشفى';
      case 'Police': return 'شرطة';
      case 'I need help': return 'أحتاج مساعدة';
      case 'I need a doctor': return 'أحتاج طبيب';
      case 'Health': return 'صحة';
      case 'Disease': return 'مرض';
      case 'Pain': return 'ألم';
      case 'Nurse': return 'ممرض';
      case 'Pharmacy': return 'صيدلية';
      case 'Medicine': return 'دواء';
      case 'I have health': return 'لدي صحة';
      case 'Please': return 'من فضلك';
      case 'Thank you': return 'شكرا';
      case 'Excuse me': return 'اعذرني';
      case 'No': return 'لا';
      case 'Yes': return 'نعم';
      case 'Please excuse me': return 'من فضلك اعذرني';
      case 'Thank you very much': return 'شكرا جزيلا';
      case 'Church': return 'كنيسة';
      case 'Mosque': return 'مسجد';
      case 'Prayer': return 'صلاة';
      case 'Priest': return 'كاهن';
      case 'Amen': return 'آمين';
      case 'God': return 'الله';
      case 'Temple': return 'معبد';
      case 'History': return 'تاريخ';
      case 'Culture': return 'ثقافة';
      case 'Architecture': return 'عمارة';
      case 'Museum': return 'متحف';
      case 'Historical place': return 'مكان تاريخي';
      case 'Axum': return 'أكسوم';
      case 'Lalibela': return 'لاليبيلا';
      case 'UNESCO': return 'اليونسكو';
      case 'World heritage': return 'تراث عالمي';
      case 'Gondar': return 'جوندر';
      case 'Bahir Dar': return 'بحر دار';
      case 'Simien Mountains': return 'جبال سيمين';
      case 'Omo Valley': return 'وادي أومو';
      case 'UNICEF': return 'اليونيسف';
      case 'WHO': return 'منظمة الصحة العالمية';
      case 'This means "I need help" in Amharic': return 'هذا يعني "أحتاج مساعدة" بالأمهرية';
      case 'This means "I have health" in Amharic': return 'هذا يعني "لدي صحة" بالأمهرية';
      case 'This means "Please excuse me" in Amharic': return 'هذا يعني "من فضلك اعذرني" بالأمهرية';
      case 'This means church in Amharic': return 'هذا يعني كنيسة بالأمهرية';
      case 'This means "Historical place" in Amharic': return 'هذا يعني "مكان تاريخي" بالأمهرية';
      case 'This is UNESCO in Amharic': return 'هذا هو اليونسكو بالأمهرية';
      default: return text;
    }
  }

  // French translations
  static String _getFrenchTitle(String title) {
    switch (title) {
      case 'Emergency Situations': return 'Situations d\'Urgence';
      case 'Health and Medical': return 'Santé et Médical';
      case 'Cultural Etiquette': return 'Étiquette Culturelle';
      case 'Religious Customs': return 'Coutumes Religieuses';
      case 'Historical Sites': return 'Sites Historiques';
      case 'UNESCO World Heritage': return 'Patrimoine Mondial de l\'UNESCO';
      default: return title;
    }
  }

  static String _getFrenchDescription(String description) {
    switch (description) {
      case 'Essential phrases for emergency situations': return 'Phrases essentielles pour les situations d\'urgence';
      case 'Learn medical vocabulary and health-related phrases': return 'Apprenez le vocabulaire médical et les phrases liées à la santé';
      case 'Learn proper cultural etiquette and customs': return 'Apprenez l\'étiquette culturelle et les coutumes appropriées';
      case 'Learn about religious customs and practices': return 'Apprenez sur les coutumes et pratiques religieuses';
      case 'Learn about Ethiopia\'s rich historical heritage': return 'Apprenez sur le riche patrimoine historique de l\'Éthiopie';
      case 'Learn about Ethiopia\'s UNESCO World Heritage sites': return 'Apprenez sur les sites du patrimoine mondial de l\'UNESCO en Éthiopie';
      default: return description;
    }
  }

  static String _getFrenchTranslation(String text) {
    switch (text) {
      case 'Help': return 'Aide';
      case 'Emergency': return 'Urgence';
      case 'Doctor': return 'Médecin';
      case 'Hospital': return 'Hôpital';
      case 'Police': return 'Police';
      case 'I need help': return 'J\'ai besoin d\'aide';
      case 'I need a doctor': return 'J\'ai besoin d\'un médecin';
      case 'Health': return 'Santé';
      case 'Disease': return 'Maladie';
      case 'Pain': return 'Douleur';
      case 'Nurse': return 'Infirmière';
      case 'Pharmacy': return 'Pharmacie';
      case 'Medicine': return 'Médecine';
      case 'I have health': return 'J\'ai la santé';
      case 'Please': return 'S\'il vous plaît';
      case 'Thank you': return 'Merci';
      case 'Excuse me': return 'Excusez-moi';
      case 'No': return 'Non';
      case 'Yes': return 'Oui';
      case 'Please excuse me': return 'S\'il vous plaît, excusez-moi';
      case 'Thank you very much': return 'Merci beaucoup';
      case 'Church': return 'Église';
      case 'Mosque': return 'Mosquée';
      case 'Prayer': return 'Prière';
      case 'Priest': return 'Prêtre';
      case 'Amen': return 'Amen';
      case 'God': return 'Dieu';
      case 'Temple': return 'Temple';
      case 'History': return 'Histoire';
      case 'Culture': return 'Culture';
      case 'Architecture': return 'Architecture';
      case 'Museum': return 'Musée';
      case 'Historical place': return 'Lieu historique';
      case 'Axum': return 'Axoum';
      case 'Lalibela': return 'Lalibela';
      case 'UNESCO': return 'UNESCO';
      case 'World heritage': return 'Patrimoine mondial';
      case 'Gondar': return 'Gondar';
      case 'Bahir Dar': return 'Bahir Dar';
      case 'Simien Mountains': return 'Montagnes du Simien';
      case 'Omo Valley': return 'Vallée de l\'Omo';
      case 'UNICEF': return 'UNICEF';
      case 'WHO': return 'OMS';
      case 'This means "I need help" in Amharic': return 'Cela signifie "J\'ai besoin d\'aide" en amharique';
      case 'This means "I have health" in Amharic': return 'Cela signifie "J\'ai la santé" en amharique';
      case 'This means "Please excuse me" in Amharic': return 'Cela signifie "S\'il vous plaît, excusez-moi" en amharique';
      case 'This means church in Amharic': return 'Cela signifie église en amharique';
      case 'This means "Historical place" in Amharic': return 'Cela signifie "Lieu historique" en amharique';
      case 'This is UNESCO in Amharic': return 'C\'est l\'UNESCO en amharique';
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
