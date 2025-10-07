import 'package:tourist_assistive_app/features/language/models/amharic_lesson_model.dart';

class ComprehensiveLessonSystem {
  // Generate 400+ minutes of lessons for each language
  static List<AmharicLesson> generateComprehensiveLessons(String nativeLanguage) {
    final allWords = _getWordsForLanguage(nativeLanguage);
    
    return [
      // BEGINNER LEVEL (120 minutes)
      ..._generateBeginnerLessons(allWords, nativeLanguage),
      
      // INTERMEDIATE LEVEL (150 minutes)
      ..._generateIntermediateLessons(allWords, nativeLanguage),
      
      // ADVANCED LEVEL (130 minutes)
      ..._generateAdvancedLessons(allWords, nativeLanguage),
    ];
  }

  static List<AmharicWord> _getWordsForLanguage(String nativeLanguage) {
    // Return words with native language context
    return [
      // Greetings
      AmharicWord(
        id: 1,
        amharic: 'ሰላም',
        english: 'Hello/Peace',
        pronunciation: 'seh-lam',
        audioUrl: 'audio/amharic/selam.mp3',
        imageUrl: 'images/amharic/greetings/hello.jpg',
        category: 'Greetings',
        examples: ['ሰላም እንዴት ነህ?', 'Hello, how are you?'],
        partOfSpeech: 'Interjection',
        difficulty: 1,
      ),
      AmharicWord(
        id: 2,
        amharic: 'እንደምን ነህ',
        english: 'How are you (male)',
        pronunciation: 'en-dem-en neh',
        audioUrl: 'audio/amharic/endemen_neh.mp3',
        imageUrl: 'images/amharic/greetings/how_are_you_male.jpg',
        category: 'Greetings',
        examples: ['እንደምን ነህ? ደህና ነኝ', 'How are you? I am fine'],
        partOfSpeech: 'Phrase',
        difficulty: 2,
      ),
      // Add more words...
    ];
  }


  static List<AmharicLesson> _generateBeginnerLessons(List<AmharicWord> words, String nativeLanguage) {
    return [
      // Lesson 1: First Words (10 minutes)
      AmharicLesson(
        id: 1,
        title: _getLessonTitle('First Words', nativeLanguage),
        description: _getLessonDescription('Learn your first Amharic words', nativeLanguage),
        category: 'Basics',
        difficulty: 'Beginner',
        estimatedTime: 10,
        xpReward: 20,
        icon: '👋',
        isUnlocked: true,
        isCompleted: false,
        words: words.where((w) => w.category == 'Greetings').take(5).toList(),
      ),
      
      // Lesson 2: Numbers 1-5 (15 minutes)
      AmharicLesson(
        id: 2,
        title: _getLessonTitle('Numbers 1-5', nativeLanguage),
        description: _getLessonDescription('Learn to count from 1 to 5', nativeLanguage),
        category: 'Numbers',
        difficulty: 'Beginner',
        estimatedTime: 15,
        xpReward: 25,
        icon: '🔢',
        isUnlocked: true,
        isCompleted: false,
        words: words.where((w) => w.category == 'Numbers').take(5).toList(),
      ),
      
      // Lesson 3: Family (20 minutes)
      AmharicLesson(
        id: 3,
        title: _getLessonTitle('Family', nativeLanguage),
        description: _getLessonDescription('Learn family relationships', nativeLanguage),
        category: 'Family',
        difficulty: 'Beginner',
        estimatedTime: 20,
        xpReward: 30,
        icon: '👨‍👩‍👧‍👦',
        isUnlocked: true,
        isCompleted: false,
        words: words.where((w) => w.category == 'Family').take(6).toList(),
      ),
      
      // Lesson 4: Colors (15 minutes)
      AmharicLesson(
        id: 4,
        title: _getLessonTitle('Colors', nativeLanguage),
        description: _getLessonDescription('Learn basic colors', nativeLanguage),
        category: 'Colors',
        difficulty: 'Beginner',
        estimatedTime: 15,
        xpReward: 25,
        icon: '🎨',
        isUnlocked: true,
        isCompleted: false,
        words: words.where((w) => w.category == 'Colors').take(5).toList(),
      ),
      
      // Lesson 5: Food Basics (20 minutes)
      AmharicLesson(
        id: 5,
        title: _getLessonTitle('Food Basics', nativeLanguage),
        description: _getLessonDescription('Learn about Ethiopian food', nativeLanguage),
        category: 'Food',
        difficulty: 'Beginner',
        estimatedTime: 20,
        xpReward: 30,
        icon: '🍽️',
        isUnlocked: true,
        isCompleted: false,
        words: words.where((w) => w.category == 'Food').take(6).toList(),
      ),
      
      // Lesson 6: Directions (15 minutes)
      AmharicLesson(
        id: 6,
        title: _getLessonTitle('Directions', nativeLanguage),
        description: _getLessonDescription('Learn basic directions', nativeLanguage),
        category: 'Directions',
        difficulty: 'Beginner',
        estimatedTime: 15,
        xpReward: 25,
        icon: '🧭',
        isUnlocked: true,
        isCompleted: false,
        words: words.where((w) => w.category == 'Directions').take(5).toList(),
      ),
      
      // Lesson 7: Time (15 minutes)
      AmharicLesson(
        id: 7,
        title: _getLessonTitle('Time', nativeLanguage),
        description: _getLessonDescription('Learn about time', nativeLanguage),
        category: 'Time',
        difficulty: 'Beginner',
        estimatedTime: 15,
        xpReward: 25,
        icon: '⏰',
        isUnlocked: true,
        isCompleted: false,
        words: words.where((w) => w.category == 'Time').take(5).toList(),
      ),
      
      // Lesson 8: Review (10 minutes)
      AmharicLesson(
        id: 8,
        title: _getLessonTitle('Beginner Review', nativeLanguage),
        description: _getLessonDescription('Review what you learned', nativeLanguage),
        category: 'Review',
        difficulty: 'Beginner',
        estimatedTime: 10,
        xpReward: 20,
        icon: '📚',
        isUnlocked: true,
        isCompleted: false,
        words: words.take(10).toList(),
      ),
    ];
  }

  static List<AmharicLesson> _generateIntermediateLessons(List<AmharicWord> words, String nativeLanguage) {
    return [
      // Lesson 9: Advanced Greetings (20 minutes)
      AmharicLesson(
        id: 9,
        title: _getLessonTitle('Advanced Greetings', nativeLanguage),
        description: _getLessonDescription('Learn formal and informal greetings', nativeLanguage),
        category: 'Greetings',
        difficulty: 'Intermediate',
        estimatedTime: 20,
        xpReward: 35,
        icon: '🤝',
        isUnlocked: false,
        isCompleted: false,
        words: words.where((w) => w.category == 'Greetings').skip(5).take(8).toList(),
      ),
      
      // Lesson 10: Numbers 6-20 (25 minutes)
      AmharicLesson(
        id: 10,
        title: _getLessonTitle('Numbers 6-20', nativeLanguage),
        description: _getLessonDescription('Learn to count from 6 to 20', nativeLanguage),
        category: 'Numbers',
        difficulty: 'Intermediate',
        estimatedTime: 25,
        xpReward: 40,
        icon: '🔢',
        isUnlocked: false,
        isCompleted: false,
        words: words.where((w) => w.category == 'Numbers').skip(5).take(15).toList(),
      ),
      
      // Lesson 11: Extended Family (20 minutes)
      AmharicLesson(
        id: 11,
        title: _getLessonTitle('Extended Family', nativeLanguage),
        description: _getLessonDescription('Learn extended family relationships', nativeLanguage),
        category: 'Family',
        difficulty: 'Intermediate',
        estimatedTime: 20,
        xpReward: 35,
        icon: '👨‍👩‍👧‍👦',
        isUnlocked: false,
        isCompleted: false,
        words: words.where((w) => w.category == 'Family').skip(6).take(8).toList(),
      ),
      
      // Lesson 12: Ethiopian Cuisine (25 minutes)
      AmharicLesson(
        id: 12,
        title: _getLessonTitle('Ethiopian Cuisine', nativeLanguage),
        description: _getLessonDescription('Learn about traditional Ethiopian dishes', nativeLanguage),
        category: 'Food',
        difficulty: 'Intermediate',
        estimatedTime: 25,
        xpReward: 40,
        icon: '🍽️',
        isUnlocked: false,
        isCompleted: false,
        words: words.where((w) => w.category == 'Food').skip(6).take(10).toList(),
      ),
      
      // Lesson 13: Places in Ethiopia (20 minutes)
      AmharicLesson(
        id: 13,
        title: _getLessonTitle('Places in Ethiopia', nativeLanguage),
        description: _getLessonDescription('Learn about Ethiopian places', nativeLanguage),
        category: 'Places',
        difficulty: 'Intermediate',
        estimatedTime: 20,
        xpReward: 35,
        icon: '🏛️',
        isUnlocked: false,
        isCompleted: false,
        words: words.where((w) => w.category == 'Places').take(8).toList(),
      ),
      
      // Lesson 14: Transportation (20 minutes)
      AmharicLesson(
        id: 14,
        title: _getLessonTitle('Transportation', nativeLanguage),
        description: _getLessonDescription('Learn about transportation', nativeLanguage),
        category: 'Transportation',
        difficulty: 'Intermediate',
        estimatedTime: 20,
        xpReward: 35,
        icon: '🚗',
        isUnlocked: false,
        isCompleted: false,
        words: words.where((w) => w.category == 'Transportation').take(8).toList(),
      ),
      
      // Lesson 15: Weather (15 minutes)
      AmharicLesson(
        id: 15,
        title: _getLessonTitle('Weather', nativeLanguage),
        description: _getLessonDescription('Learn about weather', nativeLanguage),
        category: 'Weather',
        difficulty: 'Intermediate',
        estimatedTime: 15,
        xpReward: 30,
        icon: '🌤️',
        isUnlocked: false,
        isCompleted: false,
        words: words.where((w) => w.category == 'Weather').take(6).toList(),
      ),
      
      // Lesson 16: Intermediate Review (15 minutes)
      AmharicLesson(
        id: 16,
        title: _getLessonTitle('Intermediate Review', nativeLanguage),
        description: _getLessonDescription('Review intermediate lessons', nativeLanguage),
        category: 'Review',
        difficulty: 'Intermediate',
        estimatedTime: 15,
        xpReward: 30,
        icon: '📚',
        isUnlocked: false,
        isCompleted: false,
        words: words.skip(10).take(15).toList(),
      ),
    ];
  }

  static List<AmharicLesson> _generateAdvancedLessons(List<AmharicWord> words, String nativeLanguage) {
    return [
      // Lesson 17: Business Amharic (30 minutes)
      AmharicLesson(
        id: 17,
        title: _getLessonTitle('Business Amharic', nativeLanguage),
        description: _getLessonDescription('Learn business vocabulary', nativeLanguage),
        category: 'Business',
        difficulty: 'Advanced',
        estimatedTime: 30,
        xpReward: 50,
        icon: '💼',
        isUnlocked: false,
        isCompleted: false,
        words: words.where((w) => w.category == 'Business').take(12).toList(),
      ),
      
      // Lesson 18: Medical Terms (25 minutes)
      AmharicLesson(
        id: 18,
        title: _getLessonTitle('Medical Terms', nativeLanguage),
        description: _getLessonDescription('Learn medical vocabulary', nativeLanguage),
        category: 'Medical',
        difficulty: 'Advanced',
        estimatedTime: 25,
        xpReward: 45,
        icon: '🏥',
        isUnlocked: false,
        isCompleted: false,
        words: words.where((w) => w.category == 'Medical').take(10).toList(),
      ),
      
      // Lesson 19: Legal Terms (25 minutes)
      AmharicLesson(
        id: 19,
        title: _getLessonTitle('Legal Terms', nativeLanguage),
        description: _getLessonDescription('Learn legal vocabulary', nativeLanguage),
        category: 'Legal',
        difficulty: 'Advanced',
        estimatedTime: 25,
        xpReward: 45,
        icon: '⚖️',
        isUnlocked: false,
        isCompleted: false,
        words: words.where((w) => w.category == 'Legal').take(10).toList(),
      ),
      
      // Lesson 20: Cultural Expressions (20 minutes)
      AmharicLesson(
        id: 20,
        title: _getLessonTitle('Cultural Expressions', nativeLanguage),
        description: _getLessonDescription('Learn cultural expressions', nativeLanguage),
        category: 'Culture',
        difficulty: 'Advanced',
        estimatedTime: 20,
        xpReward: 40,
        icon: '🎭',
        isUnlocked: false,
        isCompleted: false,
        words: words.where((w) => w.category == 'Culture').take(8).toList(),
      ),
      
      // Lesson 21: Technology (20 minutes)
      AmharicLesson(
        id: 21,
        title: _getLessonTitle('Technology', nativeLanguage),
        description: _getLessonDescription('Learn technology vocabulary', nativeLanguage),
        category: 'Technology',
        difficulty: 'Advanced',
        estimatedTime: 20,
        xpReward: 40,
        icon: '💻',
        isUnlocked: false,
        isCompleted: false,
        words: words.where((w) => w.category == 'Technology').take(8).toList(),
      ),
      
      // Lesson 22: Advanced Review (10 minutes)
      AmharicLesson(
        id: 22,
        title: _getLessonTitle('Advanced Review', nativeLanguage),
        description: _getLessonDescription('Review advanced lessons', nativeLanguage),
        category: 'Review',
        difficulty: 'Advanced',
        estimatedTime: 10,
        xpReward: 35,
        icon: '📚',
        isUnlocked: false,
        isCompleted: false,
        words: words.skip(25).take(10).toList(),
      ),
    ];
  }

  static String _getLessonTitle(String title, String nativeLanguage) {
    final titles = {
      'English': title,
      'Mandarin': _getMandarinTitle(title),
      'French': _getFrenchTitle(title),
      'German': _getGermanTitle(title),
      'Italian': _getItalianTitle(title),
      'Spanish': _getSpanishTitle(title),
      'Arabic': _getArabicTitle(title),
      'Portuguese': _getPortugueseTitle(title),
      'Russian': _getRussianTitle(title),
      'Japanese': _getJapaneseTitle(title),
    };
    
    return titles[nativeLanguage] ?? title;
  }

  static String _getLessonDescription(String description, String nativeLanguage) {
    final descriptions = {
      'English': description,
      'Mandarin': _getMandarinDescription(description),
      'French': _getFrenchDescription(description),
      'German': _getGermanDescription(description),
      'Italian': _getItalianDescription(description),
      'Spanish': _getSpanishDescription(description),
      'Arabic': _getArabicDescription(description),
      'Portuguese': _getPortugueseDescription(description),
      'Russian': _getRussianDescription(description),
      'Japanese': _getJapaneseDescription(description),
    };
    
    return descriptions[nativeLanguage] ?? description;
  }

  // Language-specific title translations
  static String _getMandarinTitle(String title) {
    switch (title) {
      case 'First Words': return '第一个单词';
      case 'Numbers 1-5': return '数字1-5';
      case 'Family': return '家庭';
      case 'Colors': return '颜色';
      case 'Food Basics': return '食物基础';
      case 'Directions': return '方向';
      case 'Time': return '时间';
      default: return title;
    }
  }

  static String _getFrenchTitle(String title) {
    switch (title) {
      case 'First Words': return 'Premiers Mots';
      case 'Numbers 1-5': return 'Nombres 1-5';
      case 'Family': return 'Famille';
      case 'Colors': return 'Couleurs';
      case 'Food Basics': return 'Nourriture de Base';
      case 'Directions': return 'Directions';
      case 'Time': return 'Temps';
      default: return title;
    }
  }

  static String _getGermanTitle(String title) {
    switch (title) {
      case 'First Words': return 'Erste Wörter';
      case 'Numbers 1-5': return 'Zahlen 1-5';
      case 'Family': return 'Familie';
      case 'Colors': return 'Farben';
      case 'Food Basics': return 'Grundnahrung';
      case 'Directions': return 'Richtungen';
      case 'Time': return 'Zeit';
      default: return title;
    }
  }

  static String _getItalianTitle(String title) {
    switch (title) {
      case 'First Words': return 'Prime Parole';
      case 'Numbers 1-5': return 'Numeri 1-5';
      case 'Family': return 'Famiglia';
      case 'Colors': return 'Colori';
      case 'Food Basics': return 'Cibo Base';
      case 'Directions': return 'Direzioni';
      case 'Time': return 'Tempo';
      default: return title;
    }
  }

  static String _getSpanishTitle(String title) {
    switch (title) {
      case 'First Words': return 'Primeras Palabras';
      case 'Numbers 1-5': return 'Números 1-5';
      case 'Family': return 'Familia';
      case 'Colors': return 'Colores';
      case 'Food Basics': return 'Comida Básica';
      case 'Directions': return 'Direcciones';
      case 'Time': return 'Tiempo';
      default: return title;
    }
  }

  static String _getArabicTitle(String title) {
    switch (title) {
      case 'First Words': return 'الكلمات الأولى';
      case 'Numbers 1-5': return 'الأرقام 1-5';
      case 'Family': return 'العائلة';
      case 'Colors': return 'الألوان';
      case 'Food Basics': return 'الطعام الأساسي';
      case 'Directions': return 'الاتجاهات';
      case 'Time': return 'الوقت';
      default: return title;
    }
  }

  static String _getPortugueseTitle(String title) {
    switch (title) {
      case 'First Words': return 'Primeiras Palavras';
      case 'Numbers 1-5': return 'Números 1-5';
      case 'Family': return 'Família';
      case 'Colors': return 'Cores';
      case 'Food Basics': return 'Comida Básica';
      case 'Directions': return 'Direções';
      case 'Time': return 'Tempo';
      default: return title;
    }
  }

  static String _getRussianTitle(String title) {
    switch (title) {
      case 'First Words': return 'Первые Слова';
      case 'Numbers 1-5': return 'Числа 1-5';
      case 'Family': return 'Семья';
      case 'Colors': return 'Цвета';
      case 'Food Basics': return 'Основная Еда';
      case 'Directions': return 'Направления';
      case 'Time': return 'Время';
      default: return title;
    }
  }

  static String _getJapaneseTitle(String title) {
    switch (title) {
      case 'First Words': return '最初の単語';
      case 'Numbers 1-5': return '数字1-5';
      case 'Family': return '家族';
      case 'Colors': return '色';
      case 'Food Basics': return '基本の食べ物';
      case 'Directions': return '方向';
      case 'Time': return '時間';
      default: return title;
    }
  }

  // Language-specific description translations
  static String _getMandarinDescription(String description) {
    switch (description) {
      case 'Learn your first Amharic words': return '学习你的第一个阿姆哈拉语单词';
      case 'Learn to count from 1 to 5': return '学习从1数到5';
      case 'Learn family relationships': return '学习家庭关系';
      case 'Learn basic colors': return '学习基本颜色';
      case 'Learn about Ethiopian food': return '了解埃塞俄比亚食物';
      case 'Learn basic directions': return '学习基本方向';
      case 'Learn about time': return '了解时间';
      default: return description;
    }
  }

  static String _getFrenchDescription(String description) {
    switch (description) {
      case 'Learn your first Amharic words': return 'Apprenez vos premiers mots amhariques';
      case 'Learn to count from 1 to 5': return 'Apprenez à compter de 1 à 5';
      case 'Learn family relationships': return 'Apprenez les relations familiales';
      case 'Learn basic colors': return 'Apprenez les couleurs de base';
      case 'Learn about Ethiopian food': return 'Apprenez sur la nourriture éthiopienne';
      case 'Learn basic directions': return 'Apprenez les directions de base';
      case 'Learn about time': return 'Apprenez sur le temps';
      default: return description;
    }
  }

  static String _getGermanDescription(String description) {
    switch (description) {
      case 'Learn your first Amharic words': return 'Lernen Sie Ihre ersten amharischen Wörter';
      case 'Learn to count from 1 to 5': return 'Lernen Sie von 1 bis 5 zu zählen';
      case 'Learn family relationships': return 'Lernen Sie Familienbeziehungen';
      case 'Learn basic colors': return 'Lernen Sie Grundfarben';
      case 'Learn about Ethiopian food': return 'Lernen Sie über äthiopisches Essen';
      case 'Learn basic directions': return 'Lernen Sie Grundrichtungen';
      case 'Learn about time': return 'Lernen Sie über Zeit';
      default: return description;
    }
  }

  static String _getItalianDescription(String description) {
    switch (description) {
      case 'Learn your first Amharic words': return 'Impara le tue prime parole amariche';
      case 'Learn to count from 1 to 5': return 'Impara a contare da 1 a 5';
      case 'Learn family relationships': return 'Impara le relazioni familiari';
      case 'Learn basic colors': return 'Impara i colori di base';
      case 'Learn about Ethiopian food': return 'Impara sul cibo etiope';
      case 'Learn basic directions': return 'Impara le direzioni di base';
      case 'Learn about time': return 'Impara sul tempo';
      default: return description;
    }
  }

  static String _getSpanishDescription(String description) {
    switch (description) {
      case 'Learn your first Amharic words': return 'Aprende tus primeras palabras amáricas';
      case 'Learn to count from 1 to 5': return 'Aprende a contar del 1 al 5';
      case 'Learn family relationships': return 'Aprende las relaciones familiares';
      case 'Learn basic colors': return 'Aprende los colores básicos';
      case 'Learn about Ethiopian food': return 'Aprende sobre la comida etíope';
      case 'Learn basic directions': return 'Aprende las direcciones básicas';
      case 'Learn about time': return 'Aprende sobre el tiempo';
      default: return description;
    }
  }

  static String _getArabicDescription(String description) {
    switch (description) {
      case 'Learn your first Amharic words': return 'تعلم كلماتك الأمهرية الأولى';
      case 'Learn to count from 1 to 5': return 'تعلم العد من 1 إلى 5';
      case 'Learn family relationships': return 'تعلم العلاقات العائلية';
      case 'Learn basic colors': return 'تعلم الألوان الأساسية';
      case 'Learn about Ethiopian food': return 'تعلم عن الطعام الإثيوبي';
      case 'Learn basic directions': return 'تعلم الاتجاهات الأساسية';
      case 'Learn about time': return 'تعلم عن الوقت';
      default: return description;
    }
  }

  static String _getPortugueseDescription(String description) {
    switch (description) {
      case 'Learn your first Amharic words': return 'Aprenda suas primeiras palavras amáricas';
      case 'Learn to count from 1 to 5': return 'Aprenda a contar de 1 a 5';
      case 'Learn family relationships': return 'Aprenda relacionamentos familiares';
      case 'Learn basic colors': return 'Aprenda cores básicas';
      case 'Learn about Ethiopian food': return 'Aprenda sobre comida etíope';
      case 'Learn basic directions': return 'Aprenda direções básicas';
      case 'Learn about time': return 'Aprenda sobre tempo';
      default: return description;
    }
  }

  static String _getRussianDescription(String description) {
    switch (description) {
      case 'Learn your first Amharic words': return 'Изучите ваши первые амхарские слова';
      case 'Learn to count from 1 to 5': return 'Научитесь считать от 1 до 5';
      case 'Learn family relationships': return 'Изучите семейные отношения';
      case 'Learn basic colors': return 'Изучите основные цвета';
      case 'Learn about Ethiopian food': return 'Изучите эфиопскую еду';
      case 'Learn basic directions': return 'Изучите основные направления';
      case 'Learn about time': return 'Изучите время';
      default: return description;
    }
  }

  static String _getJapaneseDescription(String description) {
    switch (description) {
      case 'Learn your first Amharic words': return '最初のアムハラ語の単語を学びましょう';
      case 'Learn to count from 1 to 5': return '1から5まで数えることを学びましょう';
      case 'Learn family relationships': return '家族関係を学びましょう';
      case 'Learn basic colors': return '基本的な色を学びましょう';
      case 'Learn about Ethiopian food': return 'エチオピアの食べ物について学びましょう';
      case 'Learn basic directions': return '基本的な方向を学びましょう';
      case 'Learn about time': return '時間について学びましょう';
      default: return description;
    }
  }
}
