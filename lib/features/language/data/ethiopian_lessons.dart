import 'package:tourist_assistive_app/features/language/models/lesson.dart';

class EthiopianLessons {
  static List<Lesson> get all => [
    // Beginner Level - Basic Greetings & Phrases
    Lesson(
      id: '1',
      title: 'Essential Greetings',
      description: 'Master the most important greetings used in Ethiopia',
      type: LessonType.vocabulary,
      difficulty: 1,
      xpReward: 15,
      iconPath: 'assets/icons/greeting.png',
      exercises: [
        const Exercise(
          id: '1-1',
          type: ExerciseType.multipleChoice,
          question: 'How do you say "Hello/Peace" in Amharic?',
          options: ['ሰላም', 'እንደምን', 'ደሞ', 'ቻው'],
          correctAnswer: 'ሰላም',
          explanation: 'ሰላም (selam) means "hello" or "peace" in Amharic. It\'s the most common greeting used throughout Ethiopia.',
          translations: {'en': 'Hello/Peace', 'am': 'ሰላም'},
        ),
        const Exercise(
          id: '1-2',
          type: ExerciseType.multipleChoice,
          question: 'What does "እንደምን ነህ?" mean?',
          options: ['Hello', 'How are you? (to male)', 'Good morning', 'Goodbye'],
          correctAnswer: 'How are you? (to male)',
          explanation: 'እንደምን ነህ? (endemen neh?) means "How are you?" when speaking to a male. For females, you say "እንደምን ነሽ?" (endemen nesh?)',
          translations: {'en': 'How are you? (male)', 'am': 'እንደምን ነህ?'},
        ),
        const Exercise(
          id: '1-3',
          type: ExerciseType.translation,
          question: 'Translate "Good morning" to Amharic',
          options: ['እንደምን አደርክ', 'እንደምን ዋልክ', 'ሰላም', 'ደሞ ዋልክ'],
          correctAnswer: 'እንደምን ዋልክ',
          explanation: 'እንደምን ዋልክ (endemen walk) means "Good morning" and is commonly used as a morning greeting.',
          translations: {'en': 'Good morning', 'am': 'እንደምን ዋልክ'},
        ),
        const Exercise(
          id: '1-4',
          type: ExerciseType.multipleChoice,
          question: 'How do you say "Thank you" in Amharic?',
          options: ['አመሰግናለሁ', 'ይቅርታ', 'እሺ', 'አይደለም'],
          correctAnswer: 'አመሰግናለሁ',
          explanation: 'አመሰግናለሁ (ameseginaleh) is the formal way to say "thank you" in Amharic.',
          translations: {'en': 'Thank you', 'am': 'አመሰግናለሁ'},
        ),
      ],
    ),

    // Numbers and Time
    Lesson(
      id: '2',
      title: 'Numbers & Time',
      description: 'Learn Amharic numbers 1-20 and time expressions',
      type: LessonType.vocabulary,
      difficulty: 1,
      xpReward: 20,
      iconPath: 'assets/icons/numbers.png',
      exercises: [
        const Exercise(
          id: '2-1',
          type: ExerciseType.multipleChoice,
          question: 'What is "አንድ" in English?',
          options: ['One', 'Two', 'Three', 'Four'],
          correctAnswer: 'One',
          explanation: 'አንድ (and) means "one" in Amharic.',
          translations: {'en': 'One', 'am': 'አንድ'},
        ),
        const Exercise(
          id: '2-2',
          type: ExerciseType.multipleChoice,
          question: 'How do you say "Ten" in Amharic?',
          options: ['አስር', 'ዘጠኝ', 'ስምንት', 'ሰባት'],
          correctAnswer: 'አስር',
          explanation: 'አስር (aser) means "ten" in Amharic.',
          translations: {'en': 'Ten', 'am': 'አስር'},
        ),
        const Exercise(
          id: '2-3',
          type: ExerciseType.ordering,
          question: 'Put these numbers in order from 1-5',
          options: ['አምስት', 'ሁለት', 'አንድ', 'አራት', 'ሦስት'],
          correctAnswer: 'አንድ,ሁለት,ሦስት,አራት,አምስት',
          explanation: 'The correct order is: አንድ (1), ሁለት (2), ሦስት (3), አራት (4), አምስት (5)',
          translations: {'en': '1,2,3,4,5', 'am': 'አንድ,ሁለት,ሦስት,አራት,አምስት'},
        ),
      ],
    ),

    // Family and Relationships
    Lesson(
      id: '3',
      title: 'Family & Relationships',
      description: 'Learn family member names and relationship terms',
      type: LessonType.vocabulary,
      difficulty: 2,
      xpReward: 25,
      iconPath: 'assets/icons/family.png',
      exercises: [
        const Exercise(
          id: '3-1',
          type: ExerciseType.multipleChoice,
          question: 'What does "እናት" mean?',
          options: ['Father', 'Mother', 'Brother', 'Sister'],
          correctAnswer: 'Mother',
          explanation: 'እናት (enat) means "mother" in Amharic.',
          translations: {'en': 'Mother', 'am': 'እናት'},
        ),
        const Exercise(
          id: '3-2',
          type: ExerciseType.multipleChoice,
          question: 'How do you say "Father" in Amharic?',
          options: ['እናት', 'አባት', 'እህት', 'ወንድም'],
          correctAnswer: 'አባት',
          explanation: 'አባት (abat) means "father" in Amharic.',
          translations: {'en': 'Father', 'am': 'አባት'},
        ),
        const Exercise(
          id: '3-3',
          type: ExerciseType.matchPairs,
          question: 'Match the Amharic words with their English meanings',
          options: ['ወንድም:Brother', 'እህት:Sister', 'ልጅ:Child', 'ሴት:Woman'],
          correctAnswer: 'ወንድም:Brother,እህት:Sister,ልጅ:Child,ሴት:Woman',
          explanation: 'Family terms are essential for social interactions in Ethiopian culture.',
          translations: {'en': 'Family members', 'am': 'የቤተሰብ አባላት'},
        ),
      ],
    ),

    // Food and Dining
    Lesson(
      id: '4',
      title: 'Ethiopian Food & Dining',
      description: 'Learn names of traditional Ethiopian dishes and dining etiquette',
      type: LessonType.culture,
      difficulty: 2,
      xpReward: 30,
      iconPath: 'assets/icons/food.png',
      exercises: [
        const Exercise(
          id: '4-1',
          type: ExerciseType.multipleChoice,
          question: 'What is "እንጀራ" in English?',
          options: ['Bread', 'Injera', 'Rice', 'Pasta'],
          correctAnswer: 'Injera',
          explanation: 'እንጀራ (injera) is the traditional Ethiopian flatbread made from teff flour. It\'s the staple food of Ethiopia.',
          translations: {'en': 'Injera (Ethiopian flatbread)', 'am': 'እንጀራ'},
        ),
        const Exercise(
          id: '4-2',
          type: ExerciseType.multipleChoice,
          question: 'How do you say "spicy" in Amharic?',
          options: ['ጣፋጭ', 'ምክር', 'ጣፋጭ', 'ሚጣድ'],
          correctAnswer: 'ሚጣድ',
          explanation: 'ሚጣድ (mitad) means "spicy" in Amharic. Ethiopian cuisine is known for its spicy flavors.',
          translations: {'en': 'Spicy', 'am': 'ሚጣድ'},
        ),
        const Exercise(
          id: '4-3',
          type: ExerciseType.imageSelection,
          question: 'Which dish is "ዶሮ ወጥ" (Doro Wat)?',
          options: ['Spicy chicken stew', 'Vegetable curry', 'Raw beef', 'Fish dish'],
          correctAnswer: 'Spicy chicken stew',
          explanation: 'ዶሮ ወጥ (Doro Wat) is Ethiopia\'s national dish - a spicy chicken stew served during special occasions.',
          translations: {'en': 'Chicken stew', 'am': 'ዶሮ ወጥ'},
        ),
      ],
    ),

    // Travel and Transportation
    Lesson(
      id: '5',
      title: 'Travel & Transportation',
      description: 'Essential phrases for getting around Ethiopia',
      type: LessonType.grammar,
      difficulty: 3,
      xpReward: 35,
      iconPath: 'assets/icons/transport.png',
      isLocked: true,
      prerequisites: ['4'],
      exercises: [
        const Exercise(
          id: '5-1',
          type: ExerciseType.multipleChoice,
          question: 'How do you ask "Where is...?" in Amharic?',
          options: ['የት ነው...?', 'ምን ነው...?', 'መቼ ነው...?', 'እንዴት ነው...?'],
          correctAnswer: 'የት ነው...?',
          explanation: 'የት ነው...? (yet new...?) means "Where is...?" This is essential for asking directions.',
          translations: {'en': 'Where is...?', 'am': 'የት ነው...?'},
        ),
        const Exercise(
          id: '5-2',
          type: ExerciseType.fillInTheBlank,
          question: 'Complete: "ሆቴል ___ ነው?" (Where is the hotel?)',
          options: ['የት', 'ምን', 'መቼ', 'እንዴት'],
          correctAnswer: 'የት',
          explanation: 'ሆቴል የት ነው? (hotel yet new?) means "Where is the hotel?"',
          translations: {'en': 'Where is the hotel?', 'am': 'ሆቴል የት ነው?'},
        ),
      ],
    ),

    // Shopping and Money
    Lesson(
      id: '6',
      title: 'Shopping & Money',
      description: 'Learn to bargain and handle transactions',
      type: LessonType.vocabulary,
      difficulty: 3,
      xpReward: 30,
      iconPath: 'assets/icons/shopping.png',
      isLocked: true,
      prerequisites: ['5'],
      exercises: [
        const Exercise(
          id: '6-1',
          type: ExerciseType.multipleChoice,
          question: 'How do you ask "How much?" in Amharic?',
          options: ['ስንት ነው?', 'የት ነው?', 'ምን ነው?', 'መቼ ነው?'],
          correctAnswer: 'ስንት ነው?',
          explanation: 'ስንት ነው? (sent new?) means "How much?" - essential for shopping and bargaining.',
          translations: {'en': 'How much?', 'am': 'ስንት ነው?'},
        ),
        const Exercise(
          id: '6-2',
          type: ExerciseType.multipleChoice,
          question: 'What is the currency of Ethiopia?',
          options: ['ብር (Birr)', 'ዶላር (Dollar)', 'ዩሮ (Euro)', 'ሳንቲም (Santeem)'],
          correctAnswer: 'ብር (Birr)',
          explanation: 'The Ethiopian currency is ብር (Birr). 1 Birr = 100 Santeem.',
          translations: {'en': 'Ethiopian Birr', 'am': 'ኢትዮጵያ ብር'},
        ),
      ],
    ),

    // Cultural Expressions
    Lesson(
      id: '7',
      title: 'Cultural Expressions & Etiquette',
      description: 'Learn important cultural phrases and proper etiquette',
      type: LessonType.culture,
      difficulty: 4,
      xpReward: 40,
      iconPath: 'assets/icons/culture.png',
      isLocked: true,
      prerequisites: ['6'],
      exercises: [
        const Exercise(
          id: '7-1',
          type: ExerciseType.multipleChoice,
          question: 'How do you show respect when greeting elders?',
          options: ['Kiss both cheeks', 'Bow slightly', 'Shake hands with both hands', 'Wave from distance'],
          correctAnswer: 'Shake hands with both hands',
          explanation: 'In Ethiopian culture, showing respect to elders involves using both hands when shaking hands and slightly bowing your head.',
          translations: {'en': 'Respectful greeting', 'am': 'ክብር ያለው ሰላምታ'},
        ),
        const Exercise(
          id: '7-2',
          type: ExerciseType.multipleChoice,
          question: 'What does "እንግዲህ" express?',
          options: ['Surprise', 'Agreement/Well then', 'Anger', 'Confusion'],
          correctAnswer: 'Agreement/Well then',
          explanation: 'እንግዲህ (engdih) is a common expression meaning "well then" or showing agreement.',
          translations: {'en': 'Well then/Alright', 'am': 'እንግዲህ'},
        ),
      ],
    ),

    // Advanced Grammar
    Lesson(
      id: '8',
      title: 'Grammar Patterns',
      description: 'Master essential Amharic grammar structures',
      type: LessonType.grammar,
      difficulty: 4,
      xpReward: 45,
      iconPath: 'assets/icons/grammar.png',
      isLocked: true,
      prerequisites: ['7'],
      exercises: [
        const Exercise(
          id: '8-1',
          type: ExerciseType.multipleChoice,
          question: 'How do you make a verb past tense in Amharic?',
          options: ['Add -ed', 'Change vowel pattern', 'Add prefix', 'No change needed'],
          correctAnswer: 'Change vowel pattern',
          explanation: 'Amharic verbs change their internal vowel patterns to indicate tense, unlike English which adds suffixes.',
          translations: {'en': 'Past tense formation', 'am': 'ያለፈ ጊዜ ግንባታ'},
        ),
      ],
    ),

    // Business and Formal Language
    Lesson(
      id: '9',
      title: 'Business & Formal Language',
      description: 'Professional and formal communication in Amharic',
      type: LessonType.grammar,
      difficulty: 5,
      xpReward: 50,
      iconPath: 'assets/icons/business.png',
      isLocked: true,
      prerequisites: ['8'],
      exercises: [
        const Exercise(
          id: '9-1',
          type: ExerciseType.multipleChoice,
          question: 'How do you say "meeting" in Amharic?',
          options: ['ስብሰባ', 'ሰብሳቢ', 'ስራ', 'ቢሮ'],
          correctAnswer: 'ስብሰባ',
          explanation: 'ስብሰባ (sebseba) means "meeting" in formal/business context.',
          translations: {'en': 'Meeting', 'am': 'ስብሰባ'},
        ),
      ],
    ),

    // Religious and Traditional Expressions
    Lesson(
      id: '10',
      title: 'Religious & Traditional Expressions',
      description: 'Common religious phrases and traditional expressions',
      type: LessonType.culture,
      difficulty: 3,
      xpReward: 35,
      iconPath: 'assets/icons/religious.png',
      isLocked: true,
      prerequisites: ['9'],
      exercises: [
        const Exercise(
          id: '10-1',
          type: ExerciseType.multipleChoice,
          question: 'What does "እግዚአብሔር ይመስገን" mean?',
          options: ['Good morning', 'Thank God', 'How are you', 'Goodbye'],
          correctAnswer: 'Thank God',
          explanation: 'እግዚአብሔር ይመስገን (Egziabiher yemesgn) means "Thank God" - commonly used in Ethiopian culture.',
          translations: {'en': 'Thank God', 'am': 'እግዚአብሔር ይመስገን'},
        ),
      ],
    ),
  ];

  static List<Lesson> getByDifficulty(int difficulty) {
    return all.where((lesson) => lesson.difficulty == difficulty).toList();
  }

  static List<Lesson> getUnlocked(List<String> completedLessons) {
    return all.where((lesson) {
      if (!lesson.isLocked) return true;
      return lesson.prerequisites.every((prereq) => completedLessons.contains(prereq));
    }).toList();
  }

  static List<Lesson> getByType(LessonType type) {
    return all.where((lesson) => lesson.type == type).toList();
  }
}




















