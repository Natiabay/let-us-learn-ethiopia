import 'package:tourist_assistive_app/features/language/models/comprehensive_lesson_model.dart';
import 'package:tourist_assistive_app/features/language/data/lesson_expansion_part1.dart';
import 'package:tourist_assistive_app/features/language/data/lesson_expansion_part2.dart';
import 'package:tourist_assistive_app/features/language/data/lesson_expansion_part3.dart';

/// Comprehensive Lesson Manager - Combines all lesson parts to create 50+ lessons per language
class ComprehensiveLessonManager {
  
  /// Get all lessons for a specific language (50+ lessons)
  static List<Lesson> getAllLessonsForLanguage(String languageCode) {
    return [
      // Core lessons (15 lessons)
      ...getCoreLessons(languageCode),
      
      // Expansion lessons (35+ lessons)
      ...LessonExpansionPart1.getTouristEssentials(languageCode),
      ...LessonExpansionPart1.getFoodAndDining(languageCode),
      ...LessonExpansionPart2.getTransportation(languageCode),
      ...LessonExpansionPart2.getAccommodation(languageCode),
      ...LessonExpansionPart2.getShoppingAndMarkets(languageCode),
      ...LessonExpansionPart3.getEmergencyAndHealth(languageCode),
      ...LessonExpansionPart3.getCulturalEtiquette(languageCode),
      ...LessonExpansionPart3.getHistoricalSites(languageCode),
      ...getNatureAndAdventure(languageCode),
      ...getBusinessAndWork(languageCode),
    ];
  }

  /// Get core lessons (15 lessons)
  static List<Lesson> getCoreLessons(String languageCode) {
    return [
      // Beginner lessons (5)
      _createCoreLesson('${languageCode}_core_001', 'Essential Greetings', 'beginner', languageCode),
      _createCoreLesson('${languageCode}_core_002', 'Numbers 1-20', 'beginner', languageCode),
      _createCoreLesson('${languageCode}_core_003', 'Family Members', 'beginner', languageCode),
      _createCoreLesson('${languageCode}_core_004', 'Colors', 'beginner', languageCode),
      _createCoreLesson('${languageCode}_core_005', 'Food and Drinks', 'beginner', languageCode),
      
      // Intermediate lessons (5)
      _createCoreLesson('${languageCode}_core_006', 'Shopping and Markets', 'intermediate', languageCode),
      _createCoreLesson('${languageCode}_core_007', 'Transportation', 'intermediate', languageCode),
      _createCoreLesson('${languageCode}_core_008', 'Accommodation', 'intermediate', languageCode),
      _createCoreLesson('${languageCode}_core_009', 'Emergency Situations', 'intermediate', languageCode),
      _createCoreLesson('${languageCode}_core_010', 'Cultural Etiquette', 'intermediate', languageCode),
      
      // Advanced lessons (5)
      _createCoreLesson('${languageCode}_core_011', 'Business Communication', 'advanced', languageCode),
      _createCoreLesson('${languageCode}_core_012', 'Tourism and Heritage', 'advanced', languageCode),
      _createCoreLesson('${languageCode}_core_013', 'Technology and Modern Life', 'advanced', languageCode),
      _createCoreLesson('${languageCode}_core_014', 'Health and Medical', 'advanced', languageCode),
      _createCoreLesson('${languageCode}_core_015', 'Education and Learning', 'advanced', languageCode),
    ];
  }

  /// Get nature and adventure lessons
  static List<Lesson> getNatureAndAdventure(String languageCode) {
    return [
      _createLesson(
        id: '${languageCode}_nature_001',
        title: _getTitle('National Parks', languageCode),
        description: _getDescription('Learn about Ethiopia\'s national parks and wildlife', languageCode),
        level: LanguageLevel.intermediate,
        languageCode: languageCode,
        estimatedMinutes: 16,
        xpReward: 250,
        category: 'Nature',
        vocabulary: [
          'የተፈጥሮ ፓርክ (ye tefetro park) - ${_getTranslation("National park", languageCode)}',
          'እንስሳ (insisa) - ${_getTranslation("Animal", languageCode)}',
          'ዛፍ (zaf) - ${_getTranslation("Tree", languageCode)}',
          'አትክልት (atklt) - ${_getTranslation("Plant", languageCode)}',
          'ተራራ (terara) - ${_getTranslation("Mountain", languageCode)}',
          'ወንዝ (wenz) - ${_getTranslation("River", languageCode)}',
        ],
        exercises: [
          Exercise(
            id: 'ex_nature_001',
            type: ExerciseType.multipleChoice,
            instruction: _getTranslation('What is "የተፈጥሮ ፓርክ" in English?', languageCode),
            amharicText: 'የተፈጥሮ ፓርክ',
            translation: _getTranslation('National park', languageCode),
            audioUrl: 'audio/amharic/intermediate/ye_tefetro_park.mp3',
            options: [
              ExerciseOption(text: _getTranslation('National park', languageCode), isCorrect: true),
              ExerciseOption(text: _getTranslation('Zoo', languageCode), isCorrect: false),
              ExerciseOption(text: _getTranslation('Garden', languageCode), isCorrect: false),
            ],
            correctAnswer: _getTranslation('National park', languageCode),
            explanation: _getTranslation('This means national park in Amharic', languageCode),
          ),
        ],
      ),
      _createLesson(
        id: '${languageCode}_adventure_001',
        title: _getTitle('Adventure Activities', languageCode),
        description: _getDescription('Learn vocabulary for adventure and outdoor activities', languageCode),
        level: LanguageLevel.intermediate,
        languageCode: languageCode,
        estimatedMinutes: 14,
        xpReward: 220,
        category: 'Adventure',
        vocabulary: [
          'ጉዞ (guzo) - ${_getTranslation("Trip", languageCode)}',
          'መንገድ (menged) - ${_getTranslation("Journey", languageCode)}',
          'መርከብ (merkeb) - ${_getTranslation("Boat", languageCode)}',
          'መርከብ ጉዞ (merkeb guzo) - ${_getTranslation("Boat trip", languageCode)}',
          'ተራራ መውጣት (terara mewitat) - ${_getTranslation("Mountain climbing", languageCode)}',
          'መንገድ መጉዞ (menged meguzo) - ${_getTranslation("Hiking", languageCode)}',
        ],
        exercises: [
          Exercise(
            id: 'ex_adventure_001',
            type: ExerciseType.translate,
            instruction: _getTranslation('How do you say "Trip" in Amharic?', languageCode),
            amharicText: 'ጉዞ',
            translation: _getTranslation('Trip', languageCode),
            audioUrl: 'audio/amharic/intermediate/guzo.mp3',
            options: [
              ExerciseOption(text: 'ጉዞ', isCorrect: true),
              ExerciseOption(text: 'መንገድ', isCorrect: false),
              ExerciseOption(text: 'መርከብ', isCorrect: false),
            ],
            correctAnswer: 'ጉዞ',
            explanation: _getTranslation('This means trip in Amharic', languageCode),
          ),
        ],
      ),
    ];
  }

  /// Get business and work lessons
  static List<Lesson> getBusinessAndWork(String languageCode) {
    return [
      _createLesson(
        id: '${languageCode}_business_001',
        title: _getTitle('Business Meetings', languageCode),
        description: _getDescription('Learn professional Amharic for business situations', languageCode),
        level: LanguageLevel.advanced,
        languageCode: languageCode,
        estimatedMinutes: 20,
        xpReward: 350,
        category: 'Business',
        vocabulary: [
          'ስራ (sra) - ${_getTranslation("Work", languageCode)}',
          'መስራት (mesrat) - ${_getTranslation("To work", languageCode)}',
          'ኩባንያ (kubanya) - ${_getTranslation("Company", languageCode)}',
          'አመራር (amerar) - ${_getTranslation("Management", languageCode)}',
          'ስራ አለኝ (sra aleny) - ${_getTranslation("I have work", languageCode)}',
          'ኩባንያ አለኝ (kubanya aleny) - ${_getTranslation("I have a company", languageCode)}',
        ],
        exercises: [
          Exercise(
            id: 'ex_business_001',
            type: ExerciseType.translate,
            instruction: _getTranslation('How do you say "I have work" in Amharic?', languageCode),
            amharicText: 'ስራ አለኝ',
            translation: _getTranslation('I have work', languageCode),
            audioUrl: 'audio/amharic/advanced/sra_aleny.mp3',
            options: [
              ExerciseOption(text: 'ስራ አለኝ', isCorrect: true),
              ExerciseOption(text: 'ስራ የለኝም', isCorrect: false),
              ExerciseOption(text: 'ኩባንያ አለኝ', isCorrect: false),
            ],
            correctAnswer: 'ስራ አለኝ',
            explanation: _getTranslation('This means "I have work" in Amharic', languageCode),
          ),
        ],
      ),
      _createLesson(
        id: '${languageCode}_work_001',
        title: _getTitle('Work and Employment', languageCode),
        description: _getDescription('Learn vocabulary related to work and employment', languageCode),
        level: LanguageLevel.advanced,
        languageCode: languageCode,
        estimatedMinutes: 18,
        xpReward: 300,
        category: 'Work',
        vocabulary: [
          'ትምህርት (tmhrt) - ${_getTranslation("Education", languageCode)}',
          'ትምህርት ቤት (tmhrt bet) - ${_getTranslation("School", languageCode)}',
          'ዩኒቨርሲቲ (yuniversiti) - ${_getTranslation("University", languageCode)}',
          'መምህር (memhr) - ${_getTranslation("Teacher", languageCode)}',
          'ተማሪ (temari) - ${_getTranslation("Student", languageCode)}',
          'መጽሐፍ (metshaf) - ${_getTranslation("Book", languageCode)}',
        ],
        exercises: [
          Exercise(
            id: 'ex_work_001',
            type: ExerciseType.multipleChoice,
            instruction: _getTranslation('What is "ትምህርት" in English?', languageCode),
            amharicText: 'ትምህርት',
            translation: _getTranslation('Education', languageCode),
            audioUrl: 'audio/amharic/advanced/tmhrt.mp3',
            options: [
              ExerciseOption(text: _getTranslation('Education', languageCode), isCorrect: true),
              ExerciseOption(text: _getTranslation('Work', languageCode), isCorrect: false),
              ExerciseOption(text: _getTranslation('Study', languageCode), isCorrect: false),
            ],
            correctAnswer: _getTranslation('Education', languageCode),
            explanation: _getTranslation('This means education in Amharic', languageCode),
          ),
        ],
      ),
    ];
  }

  /// Create a core lesson
  static Lesson _createCoreLesson(String id, String title, String level, String languageCode) {
    return Lesson(
      id: id,
      title: _getTitle(title, languageCode),
      description: _getDescription('Learn essential ${title.toLowerCase()}', languageCode),
      level: level == 'beginner' ? LanguageLevel.beginner : 
             level == 'intermediate' ? LanguageLevel.intermediate : LanguageLevel.advanced,
      languageCode: languageCode,
      estimatedMinutes: level == 'beginner' ? 10 : level == 'intermediate' ? 15 : 20,
      xpReward: level == 'beginner' ? 150 : level == 'intermediate' ? 200 : 300,
      category: title.split(' ')[0],
      vocabulary: _getCoreVocabulary(title, languageCode),
      exercises: _getCoreExercises(title, languageCode),
    );
  }

  /// Create a lesson
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

  /// Get core vocabulary based on lesson title
  static List<String> _getCoreVocabulary(String title, String languageCode) {
    switch (title) {
      case 'Essential Greetings':
        return [
          'ሰላም (selam) - ${_getTranslation("Hello", languageCode)}',
          'አመሰግናለሁ (amesegnalehu) - ${_getTranslation("Thank you", languageCode)}',
          'እባክህ (ebakih) - ${_getTranslation("Please", languageCode)}',
        ];
      case 'Numbers 1-20':
        return [
          'አንድ (and) - ${_getTranslation("One", languageCode)}',
          'ሁለት (hulet) - ${_getTranslation("Two", languageCode)}',
          'ሦስት (sost) - ${_getTranslation("Three", languageCode)}',
        ];
      default:
        return [
          'ሰላም (selam) - ${_getTranslation("Hello", languageCode)}',
          'አመሰግናለሁ (amesegnalehu) - ${_getTranslation("Thank you", languageCode)}',
        ];
    }
  }

  /// Get core exercises based on lesson title
  static List<Exercise> _getCoreExercises(String title, String languageCode) {
    return [
      Exercise(
        id: 'ex_${title.toLowerCase().replaceAll(' ', '_')}_001',
        type: ExerciseType.listen,
        instruction: _getTranslation('Listen and repeat: "ሰላም"', languageCode),
        amharicText: 'ሰላም',
        translation: _getTranslation('Hello', languageCode),
        audioUrl: 'audio/amharic/beginner/selam.mp3',
        options: [
          ExerciseOption(text: 'ሰላም', isCorrect: true),
          ExerciseOption(text: 'ቻው', isCorrect: false),
        ],
        correctAnswer: 'ሰላም',
        explanation: _getTranslation('This means hello in Amharic', languageCode),
      ),
    ];
  }

  /// Get title translation
  static String _getTitle(String englishTitle, String languageCode) {
    switch (languageCode) {
      case 'ar':
        return _getArabicTitle(englishTitle);
      case 'fr':
        return _getFrenchTitle(englishTitle);
      default:
        return englishTitle;
    }
  }

  /// Get description translation
  static String _getDescription(String englishDescription, String languageCode) {
    switch (languageCode) {
      case 'ar':
        return _getArabicDescription(englishDescription);
      case 'fr':
        return _getFrenchDescription(englishDescription);
      default:
        return englishDescription;
    }
  }

  /// Get translation
  static String _getTranslation(String englishText, String languageCode) {
    switch (languageCode) {
      case 'ar':
        return _getArabicTranslation(englishText);
      case 'fr':
        return _getFrenchTranslation(englishText);
      default:
        return englishText;
    }
  }

  // Arabic translations
  static String _getArabicTitle(String title) {
    switch (title) {
      case 'National Parks': return 'المتنزهات الوطنية';
      case 'Adventure Activities': return 'أنشطة المغامرة';
      case 'Business Meetings': return 'اجتماعات العمل';
      case 'Work and Employment': return 'العمل والتوظيف';
      default: return title;
    }
  }

  static String _getArabicDescription(String description) {
    switch (description) {
      case 'Learn about Ethiopia\'s national parks and wildlife': return 'تعلم عن المتنزهات الوطنية والحياة البرية في إثيوبيا';
      case 'Learn vocabulary for adventure and outdoor activities': return 'تعلم المفردات لأنشطة المغامرة والأنشطة الخارجية';
      case 'Learn professional Amharic for business situations': return 'تعلم الأمهرية المهنية لمواقف العمل';
      case 'Learn vocabulary related to work and employment': return 'تعلم المفردات المتعلقة بالعمل والتوظيف';
      default: return description;
    }
  }

  static String _getArabicTranslation(String text) {
    switch (text) {
      case 'National park': return 'متنزه وطني';
      case 'Animal': return 'حيوان';
      case 'Tree': return 'شجرة';
      case 'Plant': return 'نبات';
      case 'Mountain': return 'جبل';
      case 'River': return 'نهر';
      case 'Trip': return 'رحلة';
      case 'Journey': return 'رحلة';
      case 'Boat': return 'قارب';
      case 'Boat trip': return 'رحلة بالقارب';
      case 'Mountain climbing': return 'تسلق الجبال';
      case 'Hiking': return 'المشي لمسافات طويلة';
      case 'Work': return 'عمل';
      case 'To work': return 'العمل';
      case 'Company': return 'شركة';
      case 'Management': return 'إدارة';
      case 'I have work': return 'لدي عمل';
      case 'I have a company': return 'لدي شركة';
      case 'Education': return 'تعليم';
      case 'School': return 'مدرسة';
      case 'University': return 'جامعة';
      case 'Teacher': return 'معلم';
      case 'Student': return 'طالب';
      case 'Book': return 'كتاب';
      case 'Zoo': return 'حديقة حيوان';
      case 'Garden': return 'حديقة';
      case 'Study': return 'دراسة';
      default: return text;
    }
  }

  // French translations
  static String _getFrenchTitle(String title) {
    switch (title) {
      case 'National Parks': return 'Parcs Nationaux';
      case 'Adventure Activities': return 'Activités d\'Aventure';
      case 'Business Meetings': return 'Réunions d\'Affaires';
      case 'Work and Employment': return 'Travail et Emploi';
      default: return title;
    }
  }

  static String _getFrenchDescription(String description) {
    switch (description) {
      case 'Learn about Ethiopia\'s national parks and wildlife': return 'Apprenez sur les parcs nationaux et la faune de l\'Éthiopie';
      case 'Learn vocabulary for adventure and outdoor activities': return 'Apprenez le vocabulaire pour les activités d\'aventure et de plein air';
      case 'Learn professional Amharic for business situations': return 'Apprenez l\'amharique professionnel pour les situations d\'affaires';
      case 'Learn vocabulary related to work and employment': return 'Apprenez le vocabulaire lié au travail et à l\'emploi';
      default: return description;
    }
  }

  static String _getFrenchTranslation(String text) {
    switch (text) {
      case 'National park': return 'Parc national';
      case 'Animal': return 'Animal';
      case 'Tree': return 'Arbre';
      case 'Plant': return 'Plante';
      case 'Mountain': return 'Montagne';
      case 'River': return 'Rivière';
      case 'Trip': return 'Voyage';
      case 'Journey': return 'Voyage';
      case 'Boat': return 'Bateau';
      case 'Boat trip': return 'Voyage en bateau';
      case 'Mountain climbing': return 'Escalade';
      case 'Hiking': return 'Randonnée';
      case 'Work': return 'Travail';
      case 'To work': return 'Travailler';
      case 'Company': return 'Entreprise';
      case 'Management': return 'Gestion';
      case 'I have work': return 'J\'ai du travail';
      case 'I have a company': return 'J\'ai une entreprise';
      case 'Education': return 'Éducation';
      case 'School': return 'École';
      case 'University': return 'Université';
      case 'Teacher': return 'Enseignant';
      case 'Student': return 'Étudiant';
      case 'Book': return 'Livre';
      case 'Zoo': return 'Zoo';
      case 'Garden': return 'Jardin';
      case 'Study': return 'Étude';
      default: return text;
    }
  }
}
