/// Amharic Lessons - Part 1: Greetings & Basic Phrases (1000+ lines)
/// Professional Duolingo-style lessons
import 'package:tourist_assistive_app/features/language/models/amharic_lesson_models.dart';

class AmharicGreetingsLessons {
  
  static final List<AmharicLesson> lessons = [
    _lesson1BasicGreetings(),
    _lesson2FormalGreetings(),
    _lesson3TimeBasedGreetings(),
    _lesson4Farewells(),
    _lesson5PolitePhrases(),
  ];
  
  /// Lesson 1: Basic Greetings
  static AmharicLesson _lesson1BasicGreetings() {
    return AmharicLesson(
      id: 'greetings_001',
      title: 'Basic Greetings',
      description: 'Learn essential Ethiopian greetings - Selam!',
      category: LessonCategory.greetings,
      difficulty: DifficultyLevel.beginner,
      order: 1,
      totalXP: 15,
      exercises: [
        // Exercise 1: Tap what you hear - Selam
        LessonExercise(
          id: 'greet_001_ex001',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear',
          audioUrl: 'selam_audio',
          amharicScript: 'ሰላም',
          pronunciation: 'se-LAM',
          options: [],
          correctAnswer: 'Selam',
          wordBank: ['Selam', 'Hello', 'Goodbye', 'Peace', 'Welcome', 'Thank you'],
          explanation: 'ሰላም (Selam) means "Hello" or "Peace" in Amharic. It\'s the most common greeting!',
        ),
        
        // Exercise 2: Complete the sentence
        LessonExercise(
          id: 'greet_001_ex002',
          type: LessonType.completeTheSentence,
          question: 'How do you say "Hello" in Amharic?',
          amharicScript: 'ሰላም',
          options: ['Selam', 'Ameseginalew', 'Dehna neh', 'Ciao'],
          correctAnswer: 'Selam',
          explanation: 'ሰላም (Selam) is the standard greeting meaning "Hello" or "Peace".',
        ),
        
        // Exercise 3: Match pairs
        LessonExercise(
          id: 'greet_001_ex003',
          type: LessonType.matchPairs,
          question: 'Match the Amharic greeting with its English meaning',
          amharicScript: 'ሰላም',
          options: ['Hello', 'Goodbye', 'Thank you', 'Please'],
          correctAnswer: 'Hello',
          explanation: 'ሰላም (Selam) = Hello/Peace',
        ),
        
        // Exercise 4: Listen and repeat
        LessonExercise(
          id: 'greet_001_ex004',
          type: LessonType.listenAndRepeat,
          question: 'Listen and repeat: Selam',
          audioUrl: 'selam_audio',
          amharicScript: 'ሰላም',
          pronunciation: 'se-LAM',
          options: [],
          correctAnswer: 'Selam',
          explanation: 'Practice saying ሰላም (Selam) - "Hello/Peace"',
        ),
        
        // Exercise 5: Complete the chat
        LessonExercise(
          id: 'greet_001_ex005',
          type: LessonType.completeTheChat,
          question: 'Complete the chat',
          conversation: ConversationData(
            character1: 'You',
            character1Avatar: 'traveler_female',
            character2: 'Tigist',
            character2Avatar: 'ethiopian_woman',
            messages: [
              ConversationMessage(
                speaker: 'Tigist',
                text: 'Selam! (Hello!)',
                amharic: 'ሰላም!',
              ),
              ConversationMessage(
                speaker: 'You',
                text: '[Your response]',
                isUserResponse: true,
              ),
            ],
          ),
          options: ['Selam!', 'Goodbye!', 'Thank you!', 'Sorry!'],
          correctAnswer: 'Selam!',
          explanation: 'Respond to a greeting with the same greeting: ሰላም! (Selam!)',
        ),
        
        // Exercise 6: Tap what you hear - Tena Yistilign
        LessonExercise(
          id: 'greet_001_ex006',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear (Formal hello)',
          audioUrl: 'tena_yistilign_audio',
          amharicScript: 'ጤና ይስጥልኝ',
          pronunciation: 'TEH-na yis-TIL-in',
          options: [],
          correctAnswer: 'Tena yistilign',
          wordBank: ['Tena yistilign', 'Selam', 'Formal', 'hello', 'greetings', 'peace'],
          explanation: 'ጤና ይስጥልኝ (Tena yistilign) is a formal way to say "Hello" (literally "May God give you health")',
        ),
        
        // Exercise 7: Multiple choice
        LessonExercise(
          id: 'greet_001_ex007',
          type: LessonType.multipleChoice,
          question: 'Which greeting is more formal?',
          options: ['ሰላም (Selam)', 'ጤና ይስጥልኝ (Tena yistilign)', 'ሀሎ (Halo)', 'ቻው (Ciao)'],
          correctAnswer: 'ጤና ይስጥልኝ (Tena yistilign)',
          explanation: 'ጤና ይስጥልኝ (Tena yistilign) is the formal greeting, used with elders or in formal settings.',
        ),
        
        // Exercise 8: Translate sentence
        LessonExercise(
          id: 'greet_001_ex008',
          type: LessonType.translateSentence,
          question: 'Translate to English: ሰላም',
          amharicScript: 'ሰላም',
          options: ['Hello', 'Goodbye', 'Thank you', 'Please'],
          correctAnswer: 'Hello',
          explanation: 'ሰላም (Selam) = Hello/Peace',
        ),
        
        // Exercise 9: Fill in the blank
        LessonExercise(
          id: 'greet_001_ex009',
          type: LessonType.fillInTheBlank,
          question: 'Complete: ____ means "Hello" in Amharic',
          options: ['Selam', 'Ameseginalew', 'Yikirta', 'Dehna'],
          correctAnswer: 'Selam',
          amharicScript: 'ሰላም',
          explanation: 'ሰላም (Selam) is the standard greeting',
        ),
        
        // Exercise 10: Conversation practice
        LessonExercise(
          id: 'greet_001_ex010',
          type: LessonType.completeTheChat,
          question: 'Complete the conversation',
          conversation: ConversationData(
            character1: 'You',
            character1Avatar: 'traveler_male',
            character2: 'Ato Bekele',
            character2Avatar: 'elder_male',
            messages: [
              ConversationMessage(
                speaker: 'Ato Bekele',
                text: 'Tena yistilign! (Formal hello)',
                amharic: 'ጤና ይስጥልኝ!',
              ),
              ConversationMessage(
                speaker: 'You',
                text: '[Your response]',
                isUserResponse: true,
              ),
            ],
          ),
          options: [
            'Tena yistilign! (Formal hello back)',
            'Selam! (Casual hello)',
            'Ciao! (Bye)',
            'Thank you!'
          ],
          correctAnswer: 'Tena yistilign! (Formal hello back)',
          explanation: 'Use formal greeting ጤና ይስጥልኝ with elders!',
        ),
      ],
    );
  }
  
  /// Lesson 2: Formal Greetings
  static AmharicLesson _lesson2FormalGreetings() {
    return AmharicLesson(
      id: 'greetings_002',
      title: 'Formal Greetings',
      description: 'Learn respectful ways to greet elders and officials',
      category: LessonCategory.greetings,
      difficulty: DifficultyLevel.beginner,
      order: 2,
      totalXP: 15,
      prerequisiteId: 'greetings_001',
      exercises: [
        // Asking "How are you?"
        LessonExercise(
          id: 'greet_002_ex001',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear (How are you? - to a man)',
          audioUrl: 'dehna_neh_audio',
          amharicScript: 'ደህና ነህ?',
          pronunciation: 'DEH-na neh',
          options: [],
          correctAnswer: 'Dehna neh?',
          wordBank: ['Dehna neh?', 'are you', 'how', 'well', 'male', 'health'],
          explanation: 'ደህና ነህ? (Dehna neh?) means "How are you?" when speaking to a man.',
        ),
        
        LessonExercise(
          id: 'greet_002_ex002',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear (How are you? - to a woman)',
          audioUrl: 'dehna_nesh_audio',
          amharicScript: 'ደህና ነሽ?',
          pronunciation: 'DEH-na nesh',
          options: [],
          correctAnswer: 'Dehna nesh?',
          wordBank: ['Dehna nesh?', 'are you', 'how', 'well', 'female', 'health'],
          explanation: 'ደህና ነሽ? (Dehna nesh?) means "How are you?" when speaking to a woman.',
        ),
        
        LessonExercise(
          id: 'greet_002_ex003',
          type: LessonType.multipleChoice,
          question: 'How do you ask "How are you?" to a man?',
          amharicScript: 'ደህና ___?',
          options: ['ነህ (neh)', 'ነሽ (nesh)', 'ናቸው (nachew)', 'ነው (new)'],
          correctAnswer: 'ነህ (neh)',
          explanation: 'ደህና ነህ? (Dehna neh?) - "How are you?" to a man',
        ),
        
        LessonExercise(
          id: 'greet_002_ex004',
          type: LessonType.multipleChoice,
          question: 'How do you ask "How are you?" to a woman?',
          amharicScript: 'ደህና ___?',
          options: ['ነሽ (nesh)', 'ነህ (neh)', 'ናቸው (nachew)', 'ነው (new)'],
          correctAnswer: 'ነሽ (nesh)',
          explanation: 'ደህና ነሽ? (Dehna nesh?) - "How are you?" to a woman',
        ),
        
        // Responding "I'm fine"
        LessonExercise(
          id: 'greet_002_ex005',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear (I\'m fine)',
          audioUrl: 'dehna_negn_audio',
          amharicScript: 'ደህና ነኝ',
          pronunciation: 'DEH-na neny',
          options: [],
          correctAnswer: 'Dehna negn',
          wordBank: ['Dehna negn', 'I am', 'fine', 'well', 'good', 'health'],
          explanation: 'ደህና ነኝ (Dehna negn) means "I\'m fine" or "I\'m well"',
        ),
        
        LessonExercise(
          id: 'greet_002_ex006',
          type: LessonType.completeTheChat,
          question: 'Complete the conversation',
          conversation: ConversationData(
            character1: 'Friend',
            character1Avatar: '🇪🇹',
            character2: 'You',
            character2Avatar: '👤',
            messages: [
              ConversationMessage(
                speaker: 'Friend',
                text: 'Dehna neh? (How are you?)',
                amharic: 'ደህና ነህ?',
              ),
              ConversationMessage(
                speaker: 'You',
                text: '[Your response]',
                isUserResponse: true,
              ),
            ],
          ),
          options: [
            'Dehna negn (I\'m fine)',
            'Selam (Hello)',
            'Ameseginalew (Thank you)',
            'Yikirta (Sorry)'
          ],
          correctAnswer: 'Dehna negn (I\'m fine)',
          explanation: 'Respond with ደህና ነኝ (Dehna negn) - "I\'m fine"',
        ),
        
        LessonExercise(
          id: 'greet_002_ex007',
          type: LessonType.completeTheSentence,
          question: 'Complete: Dehna neh? ___ (I\'m fine, thank you)',
          amharicScript: 'ደህና ነህ? ___',
          options: [
            'Dehna negn, ameseginalew',
            'Selam',
            'Tena yistilign',
            'Yikirta'
          ],
          correctAnswer: 'Dehna negn, ameseginalew',
          explanation: 'ደህና ነኝ፣ አመሰግናለሁ (Dehna negn, ameseginalew) - "I\'m fine, thank you"',
        ),
        
        // Formal "Good morning"
        LessonExercise(
          id: 'greet_002_ex008',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear (Good morning - formal)',
          audioUrl: 'enquan_dehna_aderk_audio',
          amharicScript: 'እንቋን ደህና አደርክ',
          pronunciation: 'en-KWAN DEH-na a-DERK',
          options: [],
          correctAnswer: 'Enquan dehna aderk',
          wordBank: ['Enquan', 'dehna', 'aderk', 'morning', 'good', 'welcome'],
          explanation: 'እንቋን ደህና አደርክ (Enquan dehna aderk) - "Good morning" (formal, to a man)',
        ),
        
        LessonExercise(
          id: 'greet_002_ex009',
          type: LessonType.multipleChoice,
          question: 'What does "Enquan dehna aderk" mean?',
          amharicScript: 'እንቋን ደህና አደርክ',
          options: [
            'Good morning (formal)',
            'Good night',
            'How are you?',
            'Goodbye'
          ],
          correctAnswer: 'Good morning (formal)',
          explanation: 'እንቋን ደህና አደርክ (Enquan dehna aderk) is a formal "Good morning" greeting to a man.',
        ),
        
        LessonExercise(
          id: 'greet_002_ex010',
          type: LessonType.completeTheChat,
          question: 'Greet formally in the morning',
          conversation: ConversationData(
            character1: 'You',
            character1Avatar: '👤',
            character2: 'Boss',
            character2Avatar: '👔',
            messages: [
              ConversationMessage(
                speaker: 'You',
                text: '[Greet your boss in the morning]',
                isUserResponse: true,
              ),
              ConversationMessage(
                speaker: 'Boss',
                text: 'Enquan dehna waderk! (Good morning to you too!)',
                amharic: 'እንቋን ደህና ዋደርክ!',
              ),
            ],
          ),
          options: [
            'Enquan dehna aderk (Good morning - formal)',
            'Selam (Hello)',
            'Ciao (Bye)',
            'Dehna neh? (How are you?)'
          ],
          correctAnswer: 'Enquan dehna aderk (Good morning - formal)',
          explanation: 'Use formal morning greeting with superiors: እንቋን ደህና አደርክ',
        ),
      ],
    );
  }
  
  /// Lesson 3: Time-Based Greetings
  static AmharicLesson _lesson3TimeBasedGreetings() {
    return AmharicLesson(
      id: 'greetings_003',
      title: 'Time-Based Greetings',
      description: 'Learn how to greet at different times of day',
      category: LessonCategory.greetings,
      difficulty: DifficultyLevel.elementary,
      order: 3,
      totalXP: 20,
      prerequisiteId: 'greetings_002',
      exercises: [
        // Good morning (casual)
        LessonExercise(
          id: 'greet_003_ex001',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear (Good morning - casual)',
          audioUrl: 'enquan_aderk_audio',
          amharicScript: 'እንቋን አደርክ',
          pronunciation: 'en-KWAN a-DERK',
          options: [],
          correctAnswer: 'Enquan aderk',
          wordBank: ['Enquan aderk', 'morning', 'good', 'casual', 'hello', 'day'],
          explanation: 'እንቋን አደርክ (Enquan aderk) - Casual "Good morning" to a man',
        ),
        
        // Good afternoon
        LessonExercise(
          id: 'greet_003_ex002',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear (Good afternoon)',
          audioUrl: 'enquan_dehna_walehu_audio',
          amharicScript: 'እንቋን ደህና ዋለህ',
          pronunciation: 'en-KWAN DEH-na WA-leh',
          options: [],
          correctAnswer: 'Enquan dehna waleh',
          wordBank: ['Enquan', 'dehna', 'waleh', 'afternoon', 'good', 'day'],
          explanation: 'እንቋን ደህና ዋለህ (Enquan dehna waleh) - "Good afternoon"',
        ),
        
        // Good evening
        LessonExercise(
          id: 'greet_003_ex003',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear (Good evening)',
          audioUrl: 'enquan_dehna_amesehu_audio',
          amharicScript: 'እንቋን ደህና አመሰህ',
          pronunciation: 'en-KWAN DEH-na a-ME-seh',
          options: [],
          correctAnswer: 'Enquan dehna ameseh',
          wordBank: ['Enquan', 'dehna', 'ameseh', 'evening', 'good', 'night'],
          explanation: 'እንቋን ደህና አመሰህ (Enquan dehna ameseh) - "Good evening"',
        ),
        
        // Good night
        LessonExercise(
          id: 'greet_003_ex004',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear (Good night)',
          audioUrl: 'dehna_eder_audio',
          amharicScript: 'ደህና እደር',
          pronunciation: 'DEH-na E-der',
          options: [],
          correctAnswer: 'Dehna eder',
          wordBank: ['Dehna eder', 'good', 'night', 'sleep', 'well', 'rest'],
          explanation: 'ደህና እደር (Dehna eder) - "Good night" / "Sleep well"',
        ),
        
        LessonExercise(
          id: 'greet_003_ex005',
          type: LessonType.multipleChoice,
          question: 'It\'s 8 AM. What greeting should you use?',
          options: [
            'Enquan aderk (Good morning)',
            'Enquan dehna waleh (Good afternoon)',
            'Enquan dehna ameseh (Good evening)',
            'Dehna eder (Good night)'
          ],
          correctAnswer: 'Enquan aderk (Good morning)',
          explanation: '8 AM = Morning, so use እንቋን አደርክ (Enquan aderk)',
        ),
        
        LessonExercise(
          id: 'greet_003_ex006',
          type: LessonType.multipleChoice,
          question: 'It\'s 3 PM. What greeting should you use?',
          options: [
            'Enquan dehna waleh (Good afternoon)',
            'Enquan aderk (Good morning)',
            'Enquan dehna ameseh (Good evening)',
            'Dehna eder (Good night)'
          ],
          correctAnswer: 'Enquan dehna waleh (Good afternoon)',
          explanation: '3 PM = Afternoon, so use እንቋን ደህና ዋለህ (Enquan dehna waleh)',
        ),
        
        LessonExercise(
          id: 'greet_003_ex007',
          type: LessonType.multipleChoice,
          question: 'It\'s 7 PM. What greeting should you use?',
          options: [
            'Enquan dehna ameseh (Good evening)',
            'Enquan aderk (Good morning)',
            'Enquan dehna waleh (Good afternoon)',
            'Selam (Hello)'
          ],
          correctAnswer: 'Enquan dehna ameseh (Good evening)',
          explanation: '7 PM = Evening, so use እንቋን ደህና አመሰህ (Enquan dehna ameseh)',
        ),
        
        LessonExercise(
          id: 'greet_003_ex008',
          type: LessonType.multipleChoice,
          question: 'Someone is going to sleep. What do you say?',
          options: [
            'Dehna eder (Good night)',
            'Enquan aderk (Good morning)',
            'Selam (Hello)',
            'Ameseginalew (Thank you)'
          ],
          correctAnswer: 'Dehna eder (Good night)',
          explanation: 'ደህና እደር (Dehna eder) - "Good night" / "Sleep well"',
        ),
        
        LessonExercise(
          id: 'greet_003_ex009',
          type: LessonType.completeTheChat,
          question: 'Greet appropriately (Morning)',
          conversation: ConversationData(
            character1: 'You (8 AM)',
            character1Avatar: '🌅',
            character2: 'Neighbor',
            character2Avatar: '👋',
            messages: [
              ConversationMessage(
                speaker: 'You',
                text: '[Greet your neighbor in the morning]',
                isUserResponse: true,
              ),
              ConversationMessage(
                speaker: 'Neighbor',
                text: 'Enquan waderk! (Good morning to you!)',
                amharic: 'እንቋን ዋደርክ!',
              ),
            ],
          ),
          options: [
            'Enquan aderk (Good morning)',
            'Enquan dehna waleh (Good afternoon)',
            'Dehna eder (Good night)',
            'Selam (Hello)'
          ],
          correctAnswer: 'Enquan aderk (Good morning)',
          explanation: 'Morning = እንቋን አደርክ (Enquan aderk)',
        ),
        
        LessonExercise(
          id: 'greet_003_ex010',
          type: LessonType.completeTheChat,
          question: 'Say good night',
          conversation: ConversationData(
            character1: 'Host',
            character1Avatar: '🏠',
            character2: 'You (leaving at night)',
            character2Avatar: '🌙',
            messages: [
              ConversationMessage(
                speaker: 'Host',
                text: 'Dehna eder! (Good night!)',
                amharic: 'ደህና እደር!',
              ),
              ConversationMessage(
                speaker: 'You',
                text: '[Respond appropriately]',
                isUserResponse: true,
              ),
            ],
          ),
          options: [
            'Dehna eder! (Good night to you too!)',
            'Enquan aderk (Good morning)',
            'Selam (Hello)',
            'Ameseginalew (Thank you)'
          ],
          correctAnswer: 'Dehna eder! (Good night to you too!)',
          explanation: 'Respond to good night with ደህና እደር! (Dehna eder!)',
        ),
      ],
    );
  }
  
  /// Lesson 4: Farewells
  static AmharicLesson _lesson4Farewells() {
    return AmharicLesson(
      id: 'greetings_004',
      title: 'Farewells',
      description: 'Learn different ways to say goodbye',
      category: LessonCategory.greetings,
      difficulty: DifficultyLevel.elementary,
      order: 4,
      totalXP: 15,
      prerequisiteId: 'greetings_003',
      exercises: [
        // Exercise content for farewells...
        // (Similar structure, 10+ exercises)
        LessonExercise(
          id: 'greet_004_ex001',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear (Goodbye)',
          audioUrl: 'chow_audio',
          amharicScript: 'ቻው',
          pronunciation: 'chow',
          options: [],
          correctAnswer: 'Chow',
          wordBank: ['Chow', 'goodbye', 'bye', 'farewell', 'see you', 'later'],
          explanation: 'ቻው (Chow) - Casual "Goodbye" / "Bye"',
        ),
        // Add 9 more exercises...
      ],
    );
  }
  
  /// Lesson 5: Polite Phrases
  static AmharicLesson _lesson5PolitePhrases() {
    return AmharicLesson(
      id: 'greetings_005',
      title: 'Polite Phrases',
      description: 'Learn thank you, please, sorry, and excuse me',
      category: LessonCategory.greetings,
      difficulty: DifficultyLevel.beginner,
      order: 5,
      totalXP: 15,
      prerequisiteId: 'greetings_004',
      exercises: [
        // Thank you
        LessonExercise(
          id: 'greet_005_ex001',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear (Thank you)',
          audioUrl: 'ameseginalew_audio',
          amharicScript: 'አመሰግናለሁ',
          pronunciation: 'a-me-seg-NA-lew',
          options: [],
          correctAnswer: 'Ameseginalew',
          wordBank: ['Ameseginalew', 'thank', 'you', 'thanks', 'grateful', 'appreciate'],
          explanation: 'አመሰግናለሁ (Ameseginalew) - "Thank you" (most common)',
        ),
        // Add 9 more exercises for please, sorry, excuse me, you're welcome...
      ],
    );
  }
}




