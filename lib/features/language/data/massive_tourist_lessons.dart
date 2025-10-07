import 'package:tourist_assistive_app/features/language/models/amharic_lesson_model.dart';
import 'package:tourist_assistive_app/features/language/data/amharic_vocabulary_database.dart';

class MassiveTouristLessons {
  static List<AmharicLesson> getMassiveLessons() {
    final allWords = AmharicVocabularyDatabase.getAllWords();
    
    return [
      // ===== BEGINNER LEVEL (Tourist Essentials) =====
      
      // Lesson 1: First Words (Tourist Basics)
      AmharicLesson(
        id: 1,
        title: 'First Words',
        description: 'Essential greetings and basic words every tourist needs',
        category: 'Tourist Basics',
        difficulty: 'Beginner',
        estimatedTime: 5,
        xpReward: 20,
        icon: '👋',
        isUnlocked: true,
        isCompleted: false,
        words: allWords.where((word) => 
          word.category == 'Greetings' || 
          word.category == 'Basics'
        ).take(15).toList(),
      ),

      // Lesson 2: Numbers 1-10
      AmharicLesson(
        id: 2,
        title: 'Numbers 1-10',
        description: 'Learn to count from 1 to 10 in Amharic',
        category: 'Numbers',
        difficulty: 'Beginner',
        estimatedTime: 6,
        xpReward: 25,
        icon: '🔢',
        isUnlocked: true,
        isCompleted: false,
        words: allWords.where((word) => 
          word.category == 'Numbers' && 
          ['አንድ', 'ሁለት', 'ሦስት', 'አራት', 'አምስት', 'ስድስት', 'ሰባት', 'ስምንት', 'ዘጠኝ', 'አስር'].contains(word.amharic)
        ).toList(),
      ),

      // Lesson 3: Family
      AmharicLesson(
        id: 3,
        title: 'Family',
        description: 'Learn family members and relationships',
        category: 'Family',
        difficulty: 'Beginner',
        estimatedTime: 7,
        xpReward: 25,
        icon: '👨‍👩‍👧‍👦',
        isUnlocked: true,
        isCompleted: false,
        words: allWords.where((word) => word.category == 'Family').take(12).toList(),
      ),

      // Lesson 4: Colors
      AmharicLesson(
        id: 4,
        title: 'Colors',
        description: 'Learn basic colors in Amharic',
        category: 'Colors',
        difficulty: 'Beginner',
        estimatedTime: 5,
        xpReward: 20,
        icon: '🎨',
        isUnlocked: true,
        isCompleted: false,
        words: allWords.where((word) => word.category == 'Colors').take(10).toList(),
      ),

      // Lesson 5: Animals
      AmharicLesson(
        id: 5,
        title: 'Animals',
        description: 'Learn common animals in Ethiopia',
        category: 'Animals',
        difficulty: 'Beginner',
        estimatedTime: 6,
        xpReward: 25,
        icon: '🐾',
        isUnlocked: true,
        isCompleted: false,
        words: allWords.where((word) => word.category == 'Animals').take(12).toList(),
      ),

      // Lesson 6: Body Parts
      AmharicLesson(
        id: 6,
        title: 'Body Parts',
        description: 'Learn body parts for medical situations',
        category: 'Body',
        difficulty: 'Beginner',
        estimatedTime: 6,
        xpReward: 25,
        icon: '👤',
        isUnlocked: true,
        isCompleted: false,
        words: allWords.where((word) => word.category == 'Body').take(10).toList(),
      ),

      // ===== INTERMEDIATE LEVEL (Travel Essentials) =====

      // Lesson 7: Travel Basics
      AmharicLesson(
        id: 7,
        title: 'Travel Basics',
        description: 'Essential travel phrases and directions',
        category: 'Travel',
        difficulty: 'Intermediate',
        estimatedTime: 10,
        xpReward: 35,
        icon: '✈️',
        isUnlocked: false,
        isCompleted: false,
        words: allWords.where((word) => 
          word.category == 'Travel' && 
          ['የት ነው', 'ስንት ነው', 'መኪና', 'መንገድ', 'ቤት', 'ሆቴል', 'መጣ', 'ሂድ'].contains(word.amharic)
        ).toList(),
      ),

      // Lesson 8: Food & Dining
      AmharicLesson(
        id: 8,
        title: 'Food & Dining',
        description: 'Learn Ethiopian food and restaurant phrases',
        category: 'Food',
        difficulty: 'Intermediate',
        estimatedTime: 12,
        xpReward: 40,
        icon: '🍽️',
        isUnlocked: false,
        isCompleted: false,
        words: allWords.where((word) => 
          word.category == 'Food' && 
          ['እንጀራ', 'ዶሮ ወጥ', 'ቡና', 'ውሃ', 'ምግብ', 'ጣፋጭ', 'ተፈላጊ', 'ጠጣ'].contains(word.amharic)
        ).toList(),
      ),

      // Lesson 9: Shopping
      AmharicLesson(
        id: 9,
        title: 'Shopping',
        description: 'Learn shopping phrases and bargaining',
        category: 'Shopping',
        difficulty: 'Intermediate',
        estimatedTime: 10,
        xpReward: 35,
        icon: '🛒',
        isUnlocked: false,
        isCompleted: false,
        words: allWords.where((word) => 
          word.category == 'Shopping' && 
          ['ገዝ', 'ሽግ', 'ዋጋ', 'ብር', 'ገበያ', 'ሱቅ', 'ሂሳብ', 'ቅናሽ'].contains(word.amharic)
        ).toList(),
      ),

      // Lesson 10: Time & Calendar
      AmharicLesson(
        id: 10,
        title: 'Time & Calendar',
        description: 'Learn time expressions and scheduling',
        category: 'Time',
        difficulty: 'Intermediate',
        estimatedTime: 8,
        xpReward: 30,
        icon: '⏰',
        isUnlocked: false,
        isCompleted: false,
        words: allWords.where((word) => 
          word.category == 'Time' && 
          ['ዛሬ', 'ነገ', 'ትናንት', 'ሰአት', 'ቀን', 'ሌሊት', 'ጠዋት', 'ማታ'].contains(word.amharic)
        ).toList(),
      ),

      // Lesson 11: Weather
      AmharicLesson(
        id: 11,
        title: 'Weather',
        description: 'Learn weather expressions for travel planning',
        category: 'Weather',
        difficulty: 'Intermediate',
        estimatedTime: 7,
        xpReward: 25,
        icon: '🌤️',
        isUnlocked: false,
        isCompleted: false,
        words: allWords.where((word) => 
          word.category == 'Weather' && 
          ['ፀሐይ', 'ዝናብ', 'ንፋስ', 'ቀዝቃዛ', 'ሙቅ', 'ደመና', 'ጨረቃ', 'ኮከብ'].contains(word.amharic)
        ).toList(),
      ),

      // Lesson 12: Transportation
      AmharicLesson(
        id: 12,
        title: 'Transportation',
        description: 'Learn transportation and navigation',
        category: 'Travel',
        difficulty: 'Intermediate',
        estimatedTime: 9,
        xpReward: 30,
        icon: '🚗',
        isUnlocked: false,
        isCompleted: false,
        words: allWords.where((word) => 
          word.category == 'Travel' && 
          ['አውቶቡስ', 'ታክሲ', 'አውሮፕላን', 'ባቡር', 'መርከብ', 'ብስክሌት', 'ጣቢያ', 'አውሮፕላን ማረፊያ'].contains(word.amharic)
        ).toList(),
      ),

      // Lesson 13: Accommodation
      AmharicLesson(
        id: 13,
        title: 'Accommodation',
        description: 'Learn hotel and accommodation phrases',
        category: 'Travel',
        difficulty: 'Intermediate',
        estimatedTime: 8,
        xpReward: 30,
        icon: '🏨',
        isUnlocked: false,
        isCompleted: false,
        words: allWords.where((word) => 
          word.category == 'Travel' && 
          ['ሆቴል', 'ቤት', 'ክፍል', 'አልጋ', 'መታጠቢያ', 'መግቢያ', 'መውጫ', 'ቁልፍ'].contains(word.amharic)
        ).toList(),
      ),

      // Lesson 14: Emotions & Feelings
      AmharicLesson(
        id: 14,
        title: 'Emotions & Feelings',
        description: 'Learn to express emotions and feelings',
        category: 'Emotions',
        difficulty: 'Intermediate',
        estimatedTime: 7,
        xpReward: 25,
        icon: '😊',
        isUnlocked: false,
        isCompleted: false,
        words: allWords.where((word) => 
          word.category == 'Emotions' && 
          ['ደስተኛ', 'ሐዘን', 'ፈርቶ', 'ተናደደ', 'ተስፋ', 'ፍቅር', 'ተገረመ', 'ደከመ'].contains(word.amharic)
        ).toList(),
      ),

      // Lesson 15: Actions & Verbs
      AmharicLesson(
        id: 15,
        title: 'Actions & Verbs',
        description: 'Learn essential action verbs',
        category: 'Actions',
        difficulty: 'Intermediate',
        estimatedTime: 8,
        xpReward: 30,
        icon: '🏃',
        isUnlocked: false,
        isCompleted: false,
        words: allWords.where((word) => 
          word.category == 'Actions' && 
          ['ተመልከት', 'ሰም', 'ተናገር', 'አንብብ', 'ጻፍ', 'ሩጥ', 'ተራመድ', 'ዝላይ'].contains(word.amharic)
        ).toList(),
      ),

      // ===== ADVANCED LEVEL (Professional & Cultural) =====

      // Lesson 16: Emergency & Safety
      AmharicLesson(
        id: 16,
        title: 'Emergency & Safety',
        description: 'Critical emergency phrases for safety',
        category: 'Emergency',
        difficulty: 'Advanced',
        estimatedTime: 8,
        xpReward: 40,
        icon: '🚨',
        isUnlocked: false,
        isCompleted: false,
        words: allWords.where((word) => 
          word.category == 'Emergency' && 
          ['ረዳት', 'ፖሊስ', 'ሆስፒታል', 'ዶክተር', 'እሳት', 'አደጋ', 'እርዳታ', 'አምቢዩላንስ'].contains(word.amharic)
        ).toList(),
      ),

      // Lesson 17: Medical & Health
      AmharicLesson(
        id: 17,
        title: 'Medical & Health',
        description: 'Learn medical terms and health phrases',
        category: 'Medical',
        difficulty: 'Advanced',
        estimatedTime: 10,
        xpReward: 40,
        icon: '🏥',
        isUnlocked: false,
        isCompleted: false,
        words: allWords.where((word) => 
          word.category == 'Medical' && 
          ['ህክምና', 'ዶክተር', 'ነርስ', 'ሆስፒታል', 'ክሊኒክ', 'መድኃኒት', 'ህመም', 'ጤንነት'].contains(word.amharic)
        ).toList(),
      ),

      // Lesson 18: Business & Professional
      AmharicLesson(
        id: 18,
        title: 'Business & Professional',
        description: 'Learn business and professional communication',
        category: 'Business',
        difficulty: 'Advanced',
        estimatedTime: 12,
        xpReward: 45,
        icon: '💼',
        isUnlocked: false,
        isCompleted: false,
        words: allWords.where((word) => 
          word.category == 'Business' && 
          ['ስራ', 'ቢዝነስ', 'ኩባንያ', 'ቢሮ', 'ስብሰባ', 'ሰራተኛ', 'አሰሪ', 'ደሞዝ'].contains(word.amharic)
        ).toList(),
      ),

      // Lesson 19: Technology & Communication
      AmharicLesson(
        id: 19,
        title: 'Technology & Communication',
        description: 'Learn technology and communication terms',
        category: 'Technology',
        difficulty: 'Advanced',
        estimatedTime: 9,
        xpReward: 35,
        icon: '📱',
        isUnlocked: false,
        isCompleted: false,
        words: allWords.where((word) => 
          word.category == 'Technology' && 
          ['ቴክኖሎጂ', 'ኮምፒዩተር', 'ኢንተርኔት', 'ኢሜይል', 'ወብሳይት', 'አፕሊኬሽን', 'ሶፍትዌር', 'ሃርድዌር'].contains(word.amharic)
        ).toList(),
      ),

      // Lesson 20: Education & Learning
      AmharicLesson(
        id: 20,
        title: 'Education & Learning',
        description: 'Learn education and learning terminology',
        category: 'Education',
        difficulty: 'Advanced',
        estimatedTime: 8,
        xpReward: 35,
        icon: '🎓',
        isUnlocked: false,
        isCompleted: false,
        words: allWords.where((word) => 
          word.category == 'Education' && 
          ['ትምህርት', 'ትምህርት ቤት', 'ዩኒቨርሲቲ', 'መምህር', 'ተማሪ', 'ፈተና', 'ክፍል', 'መጽሐፍ'].contains(word.amharic)
        ).toList(),
      ),

      // Lesson 21: Nature & Environment
      AmharicLesson(
        id: 21,
        title: 'Nature & Environment',
        description: 'Learn about Ethiopian nature and environment',
        category: 'Nature',
        difficulty: 'Advanced',
        estimatedTime: 9,
        xpReward: 35,
        icon: '🌿',
        isUnlocked: false,
        isCompleted: false,
        words: allWords.where((word) => 
          word.category == 'Nature' && 
          ['ተፈጥሮ', 'ገደል', 'ወንዝ', 'ባህር', 'ጫካ', 'ዛፍ', 'አበባ', 'ቅጠል'].contains(word.amharic)
        ).toList(),
      ),

      // Lesson 22: Sports & Recreation
      AmharicLesson(
        id: 22,
        title: 'Sports & Recreation',
        description: 'Learn sports and recreation vocabulary',
        category: 'Sports',
        difficulty: 'Advanced',
        estimatedTime: 7,
        xpReward: 30,
        icon: '⚽',
        isUnlocked: false,
        isCompleted: false,
        words: allWords.where((word) => 
          word.category == 'Sports' && 
          ['ስፖርት', 'እግር ኳስ', 'ቅርጫት ኳስ', 'ቴኒስ', 'ዋና', 'ሩጫ', 'ሳይክል', 'ጨዋታ'].contains(word.amharic)
        ).toList(),
      ),

      // Lesson 23: Arts & Culture
      AmharicLesson(
        id: 23,
        title: 'Arts & Culture',
        description: 'Learn Ethiopian arts and cultural terms',
        category: 'Arts',
        difficulty: 'Advanced',
        estimatedTime: 8,
        xpReward: 35,
        icon: '🎭',
        isUnlocked: false,
        isCompleted: false,
        words: allWords.where((word) => 
          word.category == 'Arts' && 
          ['ሙዚቃ', 'ዘፈን', 'ጭፈራ', 'ሰዋስው', 'ሪም', 'ቀለም', 'ፎቶ', 'ፊልም'].contains(word.amharic)
        ).toList(),
      ),

      // Lesson 24: Legal & Government
      AmharicLesson(
        id: 24,
        title: 'Legal & Government',
        description: 'Learn legal and government terminology',
        category: 'Legal',
        difficulty: 'Advanced',
        estimatedTime: 10,
        xpReward: 40,
        icon: '⚖️',
        isUnlocked: false,
        isCompleted: false,
        words: allWords.where((word) => 
          word.category == 'Legal' && 
          ['ህግ', 'መንግስት', 'ፖሊሲ', 'ውል', 'ፍርድ ቤት', 'ዳኛ', 'ጠበቃ', 'ደንብ'].contains(word.amharic)
        ).toList(),
      ),

      // Lesson 25: Religion & Culture
      AmharicLesson(
        id: 25,
        title: 'Religion & Culture',
        description: 'Learn religious and cultural expressions',
        category: 'Religion',
        difficulty: 'Advanced',
        estimatedTime: 9,
        xpReward: 35,
        icon: '⛪',
        isUnlocked: false,
        isCompleted: false,
        words: allWords.where((word) => 
          word.category == 'Religion' && 
          ['ሃይማኖት', 'ኦርቶዶክስ', 'ሙስሊም', 'ካቶሊክ', 'ፕሮቴስታንት', 'ቤተ ክርስቲያን', 'መስጊድ', 'ጸሎት'].contains(word.amharic)
        ).toList(),
      ),

      // ===== EXPERT LEVEL (Specialized Tourist Scenarios) =====

      // Lesson 26: Tourist Phrases Master
      AmharicLesson(
        id: 26,
        title: 'Tourist Phrases Master',
        description: 'Master comprehensive tourist communication',
        category: 'Phrases',
        difficulty: 'Expert',
        estimatedTime: 15,
        xpReward: 50,
        icon: '🗣️',
        isUnlocked: false,
        isCompleted: false,
        words: allWords.where((word) => 
          word.category == 'Phrases' && 
          ['እንዴት አደርክ?', 'የት ላይ ነው?', 'ስንት ሰአት ነው?', 'ይህ ስንት ይከፍላል?', 'እኔ ዓመሪካዊ ነኝ', 'እኔ እንግሊዝኛ ተናጋሪ ነኝ'].contains(word.amharic)
        ).toList(),
      ),

      // Lesson 27: Cultural Immersion
      AmharicLesson(
        id: 27,
        title: 'Cultural Immersion',
        description: 'Deep dive into Ethiopian culture and traditions',
        category: 'Culture',
        difficulty: 'Expert',
        estimatedTime: 12,
        xpReward: 45,
        icon: '🏛️',
        isUnlocked: false,
        isCompleted: false,
        words: allWords.where((word) => 
          word.category == 'Culture' && 
          ['ባህል', 'ወግ', 'ክብረ በዓል', 'መስዋእት', 'ጸደይ', 'አስተሳሰብ', 'ስርዓት', 'ባህላዊ'].contains(word.amharic)
        ).toList(),
      ),

      // Lesson 28: Advanced Business Travel
      AmharicLesson(
        id: 28,
        title: 'Advanced Business Travel',
        description: 'Professional business communication in Ethiopia',
        category: 'Business',
        difficulty: 'Expert',
        estimatedTime: 14,
        xpReward: 50,
        icon: '💼',
        isUnlocked: false,
        isCompleted: false,
        words: allWords.where((word) => 
          word.category == 'Business' && 
          ['ንግድ', 'ግብይት', 'መሸጥ', 'መግዛት', 'ውል', 'ፕሮግራም', 'ፕሮጀክት', 'ደንበኛ'].contains(word.amharic)
        ).toList(),
      ),

      // Lesson 29: Emergency Mastery
      AmharicLesson(
        id: 29,
        title: 'Emergency Mastery',
        description: 'Master all emergency and safety situations',
        category: 'Emergency',
        difficulty: 'Expert',
        estimatedTime: 10,
        xpReward: 45,
        icon: '🚑',
        isUnlocked: false,
        isCompleted: false,
        words: allWords.where((word) => 
          word.category == 'Emergency' && 
          ['ደወል', 'አውዳሚ', 'ጤና', 'ህመም', 'ኃይለኛ', 'መድኃኒት ቤት', 'ፖሊስ ጣቢያ', 'እሳት አደጋ መከላከያ'].contains(word.amharic)
        ).toList(),
      ),

      // Lesson 30: Language Mastery
      AmharicLesson(
        id: 30,
        title: 'Language Mastery',
        description: 'Master advanced Amharic for fluent communication',
        category: 'Advanced',
        difficulty: 'Expert',
        estimatedTime: 16,
        xpReward: 60,
        icon: '🎯',
        isUnlocked: false,
        isCompleted: false,
        words: allWords.where((word) => 
          word.difficulty >= 4
        ).take(20).toList(),
      ),

      // ===== SPECIALIZED TOURIST SCENARIOS =====

      // Lesson 31: Airport & Immigration
      AmharicLesson(
        id: 31,
        title: 'Airport & Immigration',
        description: 'Navigate airports and immigration in Ethiopia',
        category: 'Travel',
        difficulty: 'Intermediate',
        estimatedTime: 8,
        xpReward: 30,
        icon: '🛫',
        isUnlocked: false,
        isCompleted: false,
        words: allWords.where((word) => 
          word.category == 'Travel' && 
          ['አውሮፕላን', 'መርከብ', 'ጣቢያ', 'መግቢያ', 'መውጫ', 'ፓስፖርት', 'ቪዛ', 'መጣበቂያ'].contains(word.amharic)
        ).toList(),
      ),

      // Lesson 32: Hotel & Accommodation
      AmharicLesson(
        id: 32,
        title: 'Hotel & Accommodation',
        description: 'Complete hotel and accommodation vocabulary',
        category: 'Travel',
        difficulty: 'Intermediate',
        estimatedTime: 9,
        xpReward: 35,
        icon: '🏨',
        isUnlocked: false,
        isCompleted: false,
        words: allWords.where((word) => 
          word.category == 'Travel' && 
          ['ሆቴል', 'ክፍል', 'አልጋ', 'መታጠቢያ', 'መግቢያ', 'መውጫ', 'ቁልፍ', 'መጠጣጣ'].contains(word.amharic)
        ).toList(),
      ),

      // Lesson 33: Restaurant & Dining
      AmharicLesson(
        id: 33,
        title: 'Restaurant & Dining',
        description: 'Master restaurant and dining experiences',
        category: 'Food',
        difficulty: 'Intermediate',
        estimatedTime: 11,
        xpReward: 40,
        icon: '🍴',
        isUnlocked: false,
        isCompleted: false,
        words: allWords.where((word) => 
          word.category == 'Food' && 
          ['ርስቶራንት', 'ካፌ', 'ባር', 'መንገድ', 'ምግብ', 'ጠጣ', 'መስጠት', 'ሂሳብ'].contains(word.amharic)
        ).toList(),
      ),

      // Lesson 34: Shopping & Markets
      AmharicLesson(
        id: 34,
        title: 'Shopping & Markets',
        description: 'Navigate markets and shopping in Ethiopia',
        category: 'Shopping',
        difficulty: 'Intermediate',
        estimatedTime: 10,
        xpReward: 35,
        icon: '🛍️',
        isUnlocked: false,
        isCompleted: false,
        words: allWords.where((word) => 
          word.category == 'Shopping' && 
          ['ገበያ', 'ሱቅ', 'ሱፐር ማርኬት', 'ደንበኛ', 'ሻጭ', 'ገንዘብ', 'ሂሳብ', 'ደረሰኝ'].contains(word.amharic)
        ).toList(),
      ),

      // Lesson 35: Transportation Master
      AmharicLesson(
        id: 35,
        title: 'Transportation Master',
        description: 'Master all forms of transportation',
        category: 'Travel',
        difficulty: 'Advanced',
        estimatedTime: 12,
        xpReward: 45,
        icon: '🚌',
        isUnlocked: false,
        isCompleted: false,
        words: allWords.where((word) => 
          word.category == 'Travel' && 
          ['አውቶቡስ', 'ታክሲ', 'ባቡር', 'መርከብ', 'ብስክሌት', 'ሞተር ሳይክል', 'መኪና', 'መንገድ'].contains(word.amharic)
        ).toList(),
      ),

      // Lesson 36: Tourist Attractions
      AmharicLesson(
        id: 36,
        title: 'Tourist Attractions',
        description: 'Learn about Ethiopian tourist attractions',
        category: 'Travel',
        difficulty: 'Advanced',
        estimatedTime: 10,
        xpReward: 40,
        icon: '🏛️',
        isUnlocked: false,
        isCompleted: false,
        words: allWords.where((word) => 
          word.category == 'Travel' && 
          ['ሙዚየም', 'ቤተ መጻሕፍት', 'ፓርክ', 'ትርግታ', 'አቅራቢያ', 'ቦታ', 'መስተዋት', 'መስተዋት'].contains(word.amharic)
        ).toList(),
      ),

      // Lesson 37: Health & Medical
      AmharicLesson(
        id: 37,
        title: 'Health & Medical',
        description: 'Comprehensive health and medical vocabulary',
        category: 'Medical',
        difficulty: 'Advanced',
        estimatedTime: 12,
        xpReward: 45,
        icon: '🏥',
        isUnlocked: false,
        isCompleted: false,
        words: allWords.where((word) => 
          word.category == 'Medical' && 
          ['ቀዶ ሐኪም', 'አይን ሀኪም', 'ጥርስ ሀኪም', 'ቀዶ ጥገና', 'ምርመራ', 'ፈተና', 'ደም', 'ትንፋሽ'].contains(word.amharic)
        ).toList(),
      ),

      // Lesson 38: Communication & Technology
      AmharicLesson(
        id: 38,
        title: 'Communication & Technology',
        description: 'Modern communication and technology terms',
        category: 'Technology',
        difficulty: 'Advanced',
        estimatedTime: 10,
        xpReward: 40,
        icon: '📡',
        isUnlocked: false,
        isCompleted: false,
        words: allWords.where((word) => 
          word.category == 'Technology' && 
          ['ላፕቶፕ', 'ሞባይል', 'ካሜራ', 'ቴሌቪዥን', 'ሬዲዮ', 'ሙዚቃ', 'ፎቶ', 'ፊልም'].contains(word.amharic)
        ).toList(),
      ),

      // Lesson 39: Social & Relationships
      AmharicLesson(
        id: 39,
        title: 'Social & Relationships',
        description: 'Build relationships and social connections',
        category: 'Social',
        difficulty: 'Advanced',
        estimatedTime: 9,
        xpReward: 35,
        icon: '👥',
        isUnlocked: false,
        isCompleted: false,
        words: allWords.where((word) => 
          word.category == 'Social' && 
          ['ጓደኛ', 'ተወዳጅ', 'ጎረቤት', 'ዋዜማ', 'ማህበረሰብ', 'ግንኙነት', 'መስተጋብር', 'መገናኘት'].contains(word.amharic)
        ).toList(),
      ),

      // Lesson 40: Final Mastery
      AmharicLesson(
        id: 40,
        title: 'Final Mastery',
        description: 'Complete mastery of Amharic for tourists',
        category: 'Mastery',
        difficulty: 'Expert',
        estimatedTime: 20,
        xpReward: 100,
        icon: '🏆',
        isUnlocked: false,
        isCompleted: false,
        words: allWords.where((word) => 
          word.difficulty >= 3
        ).take(25).toList(),
      ),
    ];
  }

  // Get lessons by difficulty level
  static List<AmharicLesson> getLessonsByDifficulty(String difficulty) {
    return getMassiveLessons().where((lesson) => lesson.difficulty == difficulty).toList();
  }

  // Get lessons by category
  static List<AmharicLesson> getLessonsByCategory(String category) {
    return getMassiveLessons().where((lesson) => lesson.category == category).toList();
  }

  // Get total lesson count
  static int getTotalLessonCount() {
    return getMassiveLessons().length;
  }

  // Get total XP available
  static int getTotalXPAvailable() {
    return getMassiveLessons().fold(0, (sum, lesson) => sum + lesson.xpReward);
  }

  // Get lesson statistics
  static Map<String, dynamic> getLessonStatistics() {
    final lessons = getMassiveLessons();
    return {
      'totalLessons': lessons.length,
      'totalXP': lessons.fold(0, (sum, lesson) => sum + lesson.xpReward),
      'totalTime': lessons.fold(0, (sum, lesson) => sum + lesson.estimatedTime),
      'byDifficulty': {
        'Beginner': lessons.where((l) => l.difficulty == 'Beginner').length,
        'Intermediate': lessons.where((l) => l.difficulty == 'Intermediate').length,
        'Advanced': lessons.where((l) => l.difficulty == 'Advanced').length,
        'Expert': lessons.where((l) => l.difficulty == 'Expert').length,
      },
      'byCategory': Map.fromEntries(
        lessons.map((lesson) => MapEntry(lesson.category, 
          lessons.where((l) => l.category == lesson.category).length))
      ),
    };
  }
}
