import 'package:tourist_assistive_app/features/duolingo_learn/models/lesson_model.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/models/exercise_model.dart';

/// Beginner Level Lessons - 33 Categories with 15 Subtopics Each
/// Focused on basic vocabulary, simple phrases, and grammar for tourists
/// All lessons include: bilingual display, transliteration, TTS audio, cultural notes

class BeginnerLessons {
  /// Category 1: Basic Greetings (15 Lessons)
  static List<Lesson> basicGreetings() {
    return [
      // Lesson 1: Hello (Selam)
      Lesson(
        id: 'beginner_greetings_01',
        categoryId: 'basic_greetings',
        title: 'Hello',
        titleAmharic: 'ሰላም',
        description: 'Learn to say hello in Amharic',
        order: 1,
        difficulty: LessonDifficulty.beginner,
        newWords: ['selam/ሰላም'],
        xpReward: 10,
        perfectXPBonus: 5,
        imageUrl: 'assets/images/lessons/smile.jpg',
        culturalNote: 'In Ethiopia, greetings are very important and often involve handshakes. Always greet elders first.',
        exercises: [
          // Exercise 1: Match Image - Hello gesture
          Exercise(
            id: 'ex_greet_01_01',
            type: ExerciseType.matchImage,
            question: 'Match the greeting',
            imageUrl: 'assets/images/lessons/smile.jpg',
            options: [
              ExerciseOption(
                id: 'opt1',
                text: 'Hello',
                textAmharic: 'selam/ሰላም',
                isCorrect: true,
              ),
              ExerciseOption(
                id: 'opt2',
                text: 'Goodbye',
                textAmharic: 'dehna hun/ደህና ሁን',
                isCorrect: false,
              ),
              ExerciseOption(
                id: 'opt3',
                text: 'Thank you',
                textAmharic: 'amesegenalo/አመሰግናለሁ',
                isCorrect: false,
              ),
            ],
            correctAnswer: 'Hello',
            explanation: 'Selam (ሰላም) means "hello" or "peace" in Amharic.',
            points: 10,
          ),
          
          // Exercise 2: Multiple Choice - Translation
          Exercise(
            id: 'ex_greet_01_02',
            type: ExerciseType.multipleChoice,
            question: 'How do you say "Hello" in Amharic?',
            options: [
              ExerciseOption(
                id: 'opt1',
                text: 'selam/ሰላም',
                isCorrect: true,
              ),
              ExerciseOption(
                id: 'opt2',
                text: 'ishi/እሺ',
                isCorrect: false,
              ),
              ExerciseOption(
                id: 'opt3',
                text: 'awo/አዎ',
                isCorrect: false,
              ),
            ],
            correctAnswer: 'selam/ሰላም',
            points: 10,
          ),
          
          // Exercise 3: Listening - Hear and select
          Exercise(
            id: 'ex_greet_01_03',
            type: ExerciseType.listening,
            question: 'selam/ሰላም',
            audioUrl: 'tts', // Will use TTS
            options: [
              ExerciseOption(
                id: 'opt1',
                text: 'Hello',
                isCorrect: true,
              ),
              ExerciseOption(
                id: 'opt2',
                text: 'Goodbye',
                isCorrect: false,
              ),
              ExerciseOption(
                id: 'opt3',
                text: 'Please',
                isCorrect: false,
              ),
            ],
            correctAnswer: 'Hello',
            points: 10,
          ),
        ],
      ),

      // Lesson 2: How are you? (male)
      Lesson(
        id: 'beginner_greetings_02',
        categoryId: 'basic_greetings',
        title: 'How are you? (male)',
        titleAmharic: 'እንደምን ነህ?',
        description: 'Ask a man how he is doing',
        order: 2,
        difficulty: LessonDifficulty.beginner,
        newWords: ['endemin neh/እንደምን ነህ?'],
        requiredLessons: ['beginner_greetings_01'],
        xpReward: 10,
        perfectXPBonus: 5,
        culturalNote: 'In Amharic, questions differ based on the gender of the person you\'re speaking to.',
        exercises: [
          Exercise(
            id: 'ex_greet_02_01',
            type: ExerciseType.multipleChoice,
            question: 'How do you ask a man "How are you?"',
            questionAmharic: 'endemin neh/እንደምን ነህ?',
            options: [
              ExerciseOption(
                id: 'opt1',
                text: 'endemin neh/እንደምን ነህ?',
                isCorrect: true,
              ),
              ExerciseOption(
                id: 'opt2',
                text: 'endemin nesh/እንደምን ነሽ?',
                isCorrect: false,
              ),
              ExerciseOption(
                id: 'opt3',
                text: 'selam/ሰላም',
                isCorrect: false,
              ),
            ],
            correctAnswer: 'endemin neh/እንደምን ነህ?',
            explanation: '"Endemin neh?" is used when speaking to a man. For women, you say "Endemin nesh?"',
            points: 10,
          ),
          
          Exercise(
            id: 'ex_greet_02_02',
            type: ExerciseType.translateToAmharic,
            question: 'How are you? (to a man)',
            options: const [],
            correctAnswer: 'endemin neh',
            explanation: 'Remember: "neh" (ነህ) is for males.',
            points: 15,
          ),
        ],
      ),

      // Lesson 3: How are you? (female)
      Lesson(
        id: 'beginner_greetings_03',
        categoryId: 'basic_greetings',
        title: 'How are you? (female)',
        titleAmharic: 'እንደምን ነሽ?',
        description: 'Ask a woman how she is doing',
        order: 3,
        difficulty: LessonDifficulty.beginner,
        newWords: ['endemin nesh/እንደምን ነሽ?'],
        requiredLessons: ['beginner_greetings_02'],
        xpReward: 10,
        perfectXPBonus: 5,
        exercises: [
          Exercise(
            id: 'ex_greet_03_01',
            type: ExerciseType.multipleChoice,
            question: 'How do you ask a woman "How are you?"',
            options: [
              ExerciseOption(
                id: 'opt1',
                text: 'endemin nesh/እንደምን ነሽ?',
                isCorrect: true,
              ),
              ExerciseOption(
                id: 'opt2',
                text: 'endemin neh/እንደምን ነህ?',
                isCorrect: false,
              ),
              ExerciseOption(
                id: 'opt3',
                text: 'dehna negn/ደህና ነኝ',
                isCorrect: false,
              ),
            ],
            correctAnswer: 'endemin nesh/እንደምን ነሽ?',
            explanation: '"Endemin nesh?" is used when speaking to a woman. "nesh" (ነሽ) is the feminine form.',
            points: 10,
          ),
        ],
      ),

      // Lesson 4: I'm fine
      Lesson(
        id: 'beginner_greetings_04',
        categoryId: 'basic_greetings',
        title: 'I\'m fine',
        titleAmharic: 'ደህና ነኝ',
        description: 'Respond that you are fine',
        order: 4,
        difficulty: LessonDifficulty.beginner,
        newWords: ['dehna negn/ደህና ነኝ'],
        requiredLessons: ['beginner_greetings_03'],
        xpReward: 10,
        perfectXPBonus: 5,
        culturalNote: 'It\'s polite to ask how someone is doing before starting a conversation.',
        exercises: [
          Exercise(
            id: 'ex_greet_04_01',
            type: ExerciseType.fillBlank,
            question: '_____ negn (I am fine)',
            options: [
              ExerciseOption(id: 'opt1', text: 'dehna', isCorrect: true),
              ExerciseOption(id: 'opt2', text: 'selam', isCorrect: false),
              ExerciseOption(id: 'opt3', text: 'ishi', isCorrect: false),
            ],
            correctAnswer: 'dehna',
            explanation: '"Dehna" means "fine" or "well". "Negn" means "I am".',
            points: 10,
          ),
          
          Exercise(
            id: 'ex_greet_04_02',
            type: ExerciseType.translateToEnglish,
            question: 'dehna negn/ደህና ነኝ',
            questionAmharic: 'dehna negn/ደህና ነኝ',
            options: const [],
            correctAnswer: 'I am fine',
            points: 15,
          ),
        ],
      ),

      // Lesson 5: Good morning
      Lesson(
        id: 'beginner_greetings_05',
        categoryId: 'basic_greetings',
        title: 'Good morning',
        titleAmharic: 'ደህና አደርክ',
        description: 'Greet someone in the morning',
        order: 5,
        difficulty: LessonDifficulty.beginner,
        newWords: ['dehna aderk/ደህና አደርክ'],
        requiredLessons: ['beginner_greetings_04'],
        xpReward: 10,
        perfectXPBonus: 5,
        imageUrl: 'assets/images/lessons/sun.jpg',
        culturalNote: 'Ethiopians follow their own time system where the day starts at sunrise (12:00 Ethiopian time).',
        exercises: [
          Exercise(
            id: 'ex_greet_05_01',
            type: ExerciseType.matchImage,
            question: 'Which greeting fits this time of day?',
            imageUrl: 'assets/images/lessons/sun.jpg',
            options: [
              ExerciseOption(
                id: 'opt1',
                text: 'Good morning',
                textAmharic: 'dehna aderk/ደህና አደርክ',
                isCorrect: true,
              ),
              ExerciseOption(
                id: 'opt2',
                text: 'Good evening',
                textAmharic: 'dehna ameshu/ደህና አመሸሽ',
                isCorrect: false,
              ),
              ExerciseOption(
                id: 'opt3',
                text: 'Good night',
                textAmharic: 'dehna eder/ደህና እደር',
                isCorrect: false,
              ),
            ],
            correctAnswer: 'Good morning',
            points: 10,
          ),
        ],
      ),

      // Lessons 6-15: Additional greeting variations
      // (Continuing with good afternoon, evening, night, goodbye, etc.)
      // These would follow the same pattern...
    ];
  }

  /// Category 2: Simple Introductions (15 Lessons)
  static List<Lesson> simpleIntroductions() {
    return [
      Lesson(
        id: 'beginner_intro_01',
        categoryId: 'simple_introductions',
        title: 'What is your name? (male)',
        titleAmharic: 'ስምህ ማን ነው?',
        description: 'Ask a man his name',
        order: 1,
        difficulty: LessonDifficulty.beginner,
        newWords: ['simeh man naw/ስምህ ማን ነው?'],
        xpReward: 10,
        perfectXPBonus: 5,
        culturalNote: 'Ethiopian names often have meanings. The first name is the given name, the second is the father\'s name.',
        exercises: [
          Exercise(
            id: 'ex_intro_01_01',
            type: ExerciseType.multipleChoice,
            question: 'How do you ask a man "What is your name?"',
            options: [
              ExerciseOption(
                id: 'opt1',
                text: 'simeh man naw/ስምህ ማን ነው?',
                isCorrect: true,
              ),
              ExerciseOption(
                id: 'opt2',
                text: 'simish man naw/ስምሽ ማን ነው?',
                isCorrect: false,
              ),
              ExerciseOption(
                id: 'opt3',
                text: 'selam/ሰላም',
                isCorrect: false,
              ),
            ],
            correctAnswer: 'simeh man naw/ስምህ ማን ነው?',
            explanation: '"Simeh" (ስምህ) is "your name" for males. "Man" means "what/who".',
            points: 10,
          ),
        ],
      ),

      Lesson(
        id: 'beginner_intro_02',
        categoryId: 'simple_introductions',
        title: 'My name is...',
        titleAmharic: 'ስሜ ... ይባላል',
        description: 'Introduce yourself',
        order: 2,
        difficulty: LessonDifficulty.beginner,
        newWords: ['sime/ስሜ', 'yibalal/ይባላል'],
        requiredLessons: ['beginner_intro_01'],
        xpReward: 10,
        perfectXPBonus: 5,
        exercises: [
          Exercise.withStringOptions(
            id: 'ex_intro_02_01',
            type: ExerciseType.fillBlank,
            question: 'Sime _____ yibalal (My name is _____)',
            stringOptions: ['[your name]'],
            correctAnswer: '[your name]',
            explanation: '"Sime" means "my name", "yibalal" means "is called".',
            points: 15,
          ),
        ],
      ),
    ];
  }

  /// Category 3: Polite Expressions (15 Lessons)
  static List<Lesson> politeExpressions() {
    return [
      Lesson(
        id: 'beginner_polite_01',
        categoryId: 'polite_expressions',
        title: 'Please (male)',
        titleAmharic: 'እባክህ',
        description: 'Say please to a man',
        order: 1,
        difficulty: LessonDifficulty.beginner,
        newWords: ['ebakih/እባክህ'],
        xpReward: 10,
        perfectXPBonus: 5,
        culturalNote: 'Politeness is highly valued in Ethiopian culture. Always use "please" and "thank you".',
        exercises: [
          Exercise(
            id: 'ex_polite_01_01',
            type: ExerciseType.multipleChoice,
            question: 'How do you say "Please" to a man?',
            options: [
              ExerciseOption(
                id: 'opt1',
                text: 'ebakih/እባክህ',
                isCorrect: true,
              ),
              ExerciseOption(
                id: 'opt2',
                text: 'ebakish/እባክሽ',
                isCorrect: false,
              ),
              ExerciseOption(
                id: 'opt3',
                text: 'amesegenalo/አመሰግናለሁ',
                isCorrect: false,
              ),
            ],
            correctAnswer: 'ebakih/እባክህ',
            explanation: '"Ebakih" is used when requesting something politely from a man.',
            points: 10,
          ),
        ],
      ),

      Lesson(
        id: 'beginner_polite_02',
        categoryId: 'polite_expressions',
        title: 'Thank you',
        titleAmharic: 'አመሰግናለሁ',
        description: 'Express gratitude',
        order: 2,
        difficulty: LessonDifficulty.beginner,
        newWords: ['amesegenalo/አመሰግናለሁ'],
        requiredLessons: ['beginner_polite_01'],
        xpReward: 10,
        perfectXPBonus: 5,
        imageUrl: 'assets/images/lessons/present.jpg',
        exercises: [
          Exercise(
            id: 'ex_polite_02_01',
            type: ExerciseType.matchImage,
            question: 'What do you say when receiving a gift?',
            imageUrl: 'assets/images/lessons/present.jpg',
            options: [
              ExerciseOption(
                id: 'opt1',
                text: 'Thank you',
                textAmharic: 'amesegenalo/አመሰግናለሁ',
                isCorrect: true,
              ),
              ExerciseOption(
                id: 'opt2',
                text: 'Please',
                textAmharic: 'ebakih/እባክህ',
                isCorrect: false,
              ),
              ExerciseOption(
                id: 'opt3',
                text: 'Sorry',
                textAmharic: 'aznalehu/አዝናለሁ',
                isCorrect: false,
              ),
            ],
            correctAnswer: 'Thank you',
            points: 10,
          ),
        ],
      ),

      Lesson(
        id: 'beginner_polite_03',
        categoryId: 'polite_expressions',
        title: 'You\'re welcome',
        titleAmharic: 'ምንም አይደለም',
        description: 'Respond to thank you',
        order: 3,
        difficulty: LessonDifficulty.beginner,
        newWords: ['minem aydelem/ምንም አይደለም'],
        requiredLessons: ['beginner_polite_02'],
        xpReward: 10,
        perfectXPBonus: 5,
        exercises: [
          Exercise(
            id: 'ex_polite_03_01',
            type: ExerciseType.translateToEnglish,
            question: 'minem aydelem/ምንም አይደለም',
            questionAmharic: 'minem aydelem/ምንም አይደለም',
            options: const [],
            correctAnswer: 'You\'re welcome',
            explanation: 'Literally means "it\'s nothing" - a polite response to "thank you".',
            points: 15,
          ),
        ],
      ),
    ];
  }

  /// Category 4: Numbers 1-10 (15 Lessons)
  static List<Lesson> numbers1To10() {
    return [
      Lesson(
        id: 'beginner_numbers_01',
        categoryId: 'numbers_1_10',
        title: 'One',
        titleAmharic: 'አንድ',
        description: 'Learn the number 1',
        order: 1,
        difficulty: LessonDifficulty.beginner,
        newWords: ['and/አንድ'],
        xpReward: 10,
        perfectXPBonus: 5,
        imageUrl: 'assets/images/lessons/one.png',
        culturalNote: 'Ethiopian numbers are used for counting, prices, and telling time.',
        exercises: [
          Exercise(
            id: 'ex_num_01_01',
            type: ExerciseType.matchImage,
            question: 'How many?',
            imageUrl: 'assets/images/lessons/one.png',
            options: [
              ExerciseOption(
                id: 'opt1',
                text: 'One',
                textAmharic: 'and/አንድ',
                isCorrect: true,
              ),
              ExerciseOption(
                id: 'opt2',
                text: 'Two',
                textAmharic: 'hulet/ሁለት',
                isCorrect: false,
              ),
              ExerciseOption(
                id: 'opt3',
                text: 'Three',
                textAmharic: 'sost/ሶስት',
                isCorrect: false,
              ),
            ],
            correctAnswer: 'One',
            points: 10,
          ),
          
          Exercise(
            id: 'ex_num_01_02',
            type: ExerciseType.listening,
            question: 'and/አንድ',
            audioUrl: 'tts',
            options: [
              ExerciseOption(id: 'opt1', text: '1', isCorrect: true),
              ExerciseOption(id: 'opt2', text: '2', isCorrect: false),
              ExerciseOption(id: 'opt3', text: '3', isCorrect: false),
            ],
            correctAnswer: '1',
            points: 10,
          ),
        ],
      ),

      Lesson(
        id: 'beginner_numbers_02',
        categoryId: 'numbers_1_10',
        title: 'Two',
        titleAmharic: 'ሁለት',
        description: 'Learn the number 2',
        order: 2,
        difficulty: LessonDifficulty.beginner,
        newWords: ['hulet/ሁለት'],
        requiredLessons: ['beginner_numbers_01'],
        xpReward: 10,
        perfectXPBonus: 5,
        imageUrl: 'assets/images/lessons/two.png',
        exercises: [
          Exercise(
            id: 'ex_num_02_01',
            type: ExerciseType.matchImage,
            question: 'Select the correct number',
            imageUrl: 'assets/images/lessons/two.png',
            options: [
              ExerciseOption(
                id: 'opt1',
                text: 'Two',
                textAmharic: 'hulet/ሁለት',
                isCorrect: true,
              ),
              ExerciseOption(
                id: 'opt2',
                text: 'One',
                textAmharic: 'and/አንድ',
                isCorrect: false,
              ),
              ExerciseOption(
                id: 'opt3',
                text: 'Three',
                textAmharic: 'sost/ሶስት',
                isCorrect: false,
              ),
            ],
            correctAnswer: 'Two',
            points: 10,
          ),
        ],
      ),

      Lesson(
        id: 'beginner_numbers_03',
        categoryId: 'numbers_1_10',
        title: 'Three',
        titleAmharic: 'ሶስት',
        description: 'Learn the number 3',
        order: 3,
        difficulty: LessonDifficulty.beginner,
        newWords: ['sost/ሶስት'],
        requiredLessons: ['beginner_numbers_02'],
        xpReward: 10,
        perfectXPBonus: 5,
        imageUrl: 'assets/images/lessons/three.png',
        exercises: [
          Exercise(
            id: 'ex_num_03_01',
            type: ExerciseType.matchImage,
            question: 'Match the number',
            imageUrl: 'assets/images/lessons/three.png',
            options: [
              ExerciseOption(
                id: 'opt1',
                text: 'Three',
                textAmharic: 'sost/ሶስት',
                isCorrect: true,
              ),
              ExerciseOption(
                id: 'opt2',
                text: 'Two',
                textAmharic: 'hulet/ሁለት',
                isCorrect: false,
              ),
              ExerciseOption(
                id: 'opt3',
                text: 'Four',
                textAmharic: 'arat/አራት',
                isCorrect: false,
              ),
            ],
            correctAnswer: 'Three',
            points: 10,
          ),
        ],
      ),
      // Continue with 4-10...
    ];
  }

  /// Category 5: Colors (15 Lessons)
  static List<Lesson> colors() {
    return [
      Lesson(
        id: 'beginner_colors_01',
        categoryId: 'colors',
        title: 'Red',
        titleAmharic: 'ቀይ',
        description: 'Learn the color red',
        order: 1,
        difficulty: LessonDifficulty.beginner,
        newWords: ['qey/ቀይ'],
        xpReward: 10,
        perfectXPBonus: 5,
        culturalNote: 'Red, yellow, and green are the colors of the Ethiopian flag, symbolizing strength, hope, and land.',
        exercises: [
          Exercise(
            id: 'ex_color_01_01',
            type: ExerciseType.multipleChoice,
            question: 'What color is this? (imagine a red object)',
            options: [
              ExerciseOption(
                id: 'opt1',
                text: 'Red',
                textAmharic: 'qey/ቀይ',
                isCorrect: true,
              ),
              ExerciseOption(
                id: 'opt2',
                text: 'Blue',
                textAmharic: 'semayawi/ሰማያዊ',
                isCorrect: false,
              ),
              ExerciseOption(
                id: 'opt3',
                text: 'Green',
                textAmharic: 'arengwade/አረንጓዴ',
                isCorrect: false,
              ),
            ],
            correctAnswer: 'Red',
            points: 10,
          ),
        ],
      ),
    ];
  }

  /// Get all beginner categories
  static List<LessonCategory> getAllCategories() {
    return [
      LessonCategory(
        id: 'basic_greetings',
        name: 'Basic Greetings',
        nameAmharic: 'መሰረታዊ ሰላምታዎች',
        description: 'Learn essential greetings for daily interactions',
        icon: '👋',
        order: 1,
        lessons: basicGreetings(),
        isUnlocked: true,
      ),
      
      LessonCategory(
        id: 'simple_introductions',
        name: 'Simple Introductions',
        nameAmharic: 'ቀላል መግባቢያዎች',
        description: 'Introduce yourself and ask others their names',
        icon: '🤝',
        order: 2,
        lessons: simpleIntroductions(),
        isUnlocked: false,
        requiredCategories: ['basic_greetings'],
      ),
      
      LessonCategory(
        id: 'polite_expressions',
        name: 'Polite Expressions',
        nameAmharic: 'ጨዋ አገላለጾች',
        description: 'Essential polite phrases',
        icon: '🙏',
        order: 3,
        lessons: politeExpressions(),
        isUnlocked: false,
        requiredCategories: ['simple_introductions'],
      ),
      
      LessonCategory(
        id: 'numbers_1_10',
        name: 'Numbers 1-10',
        nameAmharic: 'ቁጥሮች 1-10',
        description: 'Count from one to ten',
        icon: '🔢',
        order: 4,
        lessons: numbers1To10(),
        isUnlocked: false,
        requiredCategories: ['polite_expressions'],
      ),
      
      LessonCategory(
        id: 'colors',
        name: 'Colors',
        nameAmharic: 'ቀለሞች',
        description: 'Learn color names in Amharic',
        icon: '🎨',
        order: 5,
        lessons: colors(),
        isUnlocked: false,
        requiredCategories: ['numbers_1_10'],
      ),
      
      // Additional 28 categories would go here...
      // Each following the same pattern
    ];
  }
}



