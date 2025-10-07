import '../models/comprehensive_lesson_model.dart';

/// 🎓 DUOLINGO-STYLE AMHARIC-ENGLISH LESSONS
/// Based on the provided Duolingo interface images with all exercise types
class DuolingoStyleLessons {
  
  /// Get all Duolingo-style lessons
  static List<Lesson> getAllLessons() {
    return [
      // BEGINNER LESSONS
      ..._getBeginnerLessons(),
      // INTERMEDIATE LESSONS  
      ..._getIntermediateLessons(),
      // ADVANCED LESSONS
      ..._getAdvancedLessons(),
    ];
  }
  
  /// BEGINNER LESSONS - Based on the images provided
  static List<Lesson> _getBeginnerLessons() {
    return [
      // Lesson 1: Basic Greetings - "Read and respond" style
      Lesson(
        id: 'greetings_basic',
        title: 'Basic Greetings',
        description: 'Learn essential Amharic greetings',
        level: LanguageLevel.beginner,
        category: 'Greetings',
        languageCode: 'am',
        estimatedMinutes: 5,
        estimatedTime: 5,
        xpReward: 20,
        exercises: [
          // Exercise 1: Read and Respond (like the image with traveler definition)
          Exercise(
            id: 'greetings_basic_ex1',
            type: ExerciseType.readAndRespond,
            instruction: 'Read and respond',
            amharicText: 'ሰላም',
            translation: 'Hello/Peace',
            content: 'Selam means "hello" or "peace" in Amharic.',
            question: 'What does "Selam" mean?',
            options: [
              ExerciseOption(text: 'Goodbye', isCorrect: false),
              ExerciseOption(text: 'Hello/Peace', isCorrect: true), 
              ExerciseOption(text: 'Thank you', isCorrect: false),
              ExerciseOption(text: 'Please', isCorrect: false)
            ],
            correctAnswer: 'Hello/Peace',
            explanation: 'Selam is the most common greeting in Amharic, meaning both "hello" and "peace".',
            audioUrl: 'audio/selam.mp3',
            imageUrl: 'images/greeting_handshake.jpg',
          ),
          // Exercise 2: Complete the sentence (like the image with suitcase)
          Exercise(
            id: 'greetings_basic_ex2',
            type: ExerciseType.completeSentence,
            instruction: 'Complete the sentence',
            amharicText: 'ሰላም፣ እንዴት _____?',
            translation: 'Hello, how are you?',
            content: 'Complete the Amharic greeting: "ሰላም፣ እንዴት _____?" (Hello, how _____?)',
            question: 'Complete the Amharic sentence: "ሰላም፣ እንዴት _____?"',
            options: [
              ExerciseOption(text: 'ናችሁ', isCorrect: true),
              ExerciseOption(text: 'ነው', isCorrect: false),
              ExerciseOption(text: 'ናቸው', isCorrect: false),
              ExerciseOption(text: 'ነኝ', isCorrect: false)
            ],
            correctAnswer: 'ናችሁ',
            explanation: 'ናችሁ (nachehu) means "are you" in Amharic.',
            audioUrl: 'audio/hello_how_are_you.mp3',
          ),
          // Exercise 3: Tap what you hear (like the image with word bank)
          Exercise(
            id: 'greetings_basic_ex3',
            type: ExerciseType.tapWhatYouHear,
            instruction: 'Tap what you hear',
            amharicText: 'አመሰግናለሁ',
            translation: 'Thank you',
            content: 'Listen and select the greeting you hear.',
            question: 'Tap the word for "thank you".',
            options: [
              ExerciseOption(text: 'ሰላም', isCorrect: false),
              ExerciseOption(text: 'አመሰግናለሁ', isCorrect: true),
              ExerciseOption(text: 'እንዴት ናችሁ?', isCorrect: false),
              ExerciseOption(text: 'አዎ', isCorrect: false)
            ],
            correctAnswer: 'አመሰግናለሁ',
            explanation: 'አመሰግናለሁ (Ameseginalew) means "thank you".',
            audioUrl: 'audio/ameseginalew.mp3',
          ),
          // Exercise 4: Complete the chat (like the image with chat interface)
          Exercise(
            id: 'greetings_basic_ex4',
            type: ExerciseType.completeChat,
            instruction: 'Complete the chat',
            amharicText: 'Person A: "ሰላም!"\nPerson B: "እንዴት ናችሁ?"\nPerson A: "_____"',
            translation: 'Person A: "Hello!"\nPerson B: "How are you?"\nPerson A: "I am fine."',
            content: 'Person A: "Hello!"\nPerson B: "How are you?"\nPerson A: "I am fine."',
            question: 'Complete Person A\'s response:',
            options: [
              ExerciseOption(text: 'አመሰግናለሁ', isCorrect: false),
              ExerciseOption(text: 'ደህና ነኝ', isCorrect: true),
              ExerciseOption(text: 'አዎ', isCorrect: false),
              ExerciseOption(text: 'አይ', isCorrect: false)
            ],
            correctAnswer: 'ደህና ነኝ',
            explanation: 'ደህና ነኝ (Dehna negn) means "I am fine."',
            audioUrl: 'audio/dehna_negn.mp3',
          ),
        ],
        vocabulary: ['ሰላም', 'Selam', 'Hello', 'Peace', 'አመሰግናለሁ', 'Ameseginalew', 'Thank you'],
      ),
      
      // Lesson 2: Transportation - "Read and respond" style
      Lesson(
        id: 'transportation_basic',
        title: 'Transportation',
        description: 'Learn transportation vocabulary',
        level: LanguageLevel.beginner,
        category: 'Transportation',
        languageCode: 'am',
        estimatedMinutes: 6,
        estimatedTime: 6,
        xpReward: 25,
        exercises: [
          // Exercise 1: Read and Respond (like the image with planes definition)
          Exercise(
            id: 'transportation_basic_ex1',
            type: ExerciseType.readAndRespond,
            instruction: 'Read and respond',
            amharicText: 'መኪና',
            translation: 'Car',
            content: 'መኪና means "car" in Amharic. It is the most common form of transportation in cities.',
            question: 'What does "መኪና" mean?',
            options: [
              ExerciseOption(text: 'Bus', isCorrect: false),
              ExerciseOption(text: 'Car', isCorrect: true),
              ExerciseOption(text: 'Train', isCorrect: false),
              ExerciseOption(text: 'Airplane', isCorrect: false)
            ],
            correctAnswer: 'Car',
            explanation: 'መኪና (Mekina) means "car" in Amharic.',
            audioUrl: 'audio/mekina.mp3',
            imageUrl: 'images/car.jpg',
          ),
          // Exercise 2: Complete the sentence (like the image with taxi)
          Exercise(
            id: 'transportation_basic_ex2',
            type: ExerciseType.completeSentence,
            instruction: 'Complete the sentence',
            amharicText: 'ወደ ከተማው ለመሄድ _____ እጠቀማለሁ።',
            translation: 'I use a car to go to the city.',
            content: 'Complete the Amharic sentence: "ወደ ከተማው ለመሄድ _____ እጠቀማለሁ።" (To go to the city, I use _____)',
            question: 'Complete the Amharic sentence: "ወደ ከተማው ለመሄድ _____ እጠቀማለሁ።"',
            options: [
              ExerciseOption(text: 'መኪና', isCorrect: true),
              ExerciseOption(text: 'ባቡር', isCorrect: false),
              ExerciseOption(text: 'አውቶቡስ', isCorrect: false),
              ExerciseOption(text: 'አውሮፕላን', isCorrect: false)
            ],
            correctAnswer: 'መኪና',
            explanation: 'መኪና (Mekina) means "car" and is the most common way to travel to the city.',
            audioUrl: 'audio/use_car_city.mp3',
          ),
          // Exercise 3: Tap what you hear (like the image with word bank)
          Exercise(
            id: 'transportation_basic_ex3',
            type: ExerciseType.tapWhatYouHear,
            instruction: 'Tap what you hear',
            amharicText: 'ባቡር',
            translation: 'Train',
            content: 'Listen and select the transportation words you hear.',
            question: 'Tap the word for "train".',
            options: [
              ExerciseOption(text: 'መኪና', isCorrect: false),
              ExerciseOption(text: 'ባቡር', isCorrect: true),
              ExerciseOption(text: 'አውቶቡስ', isCorrect: false),
              ExerciseOption(text: 'አውሮፕላን', isCorrect: false)
            ],
            correctAnswer: 'ባቡር',
            explanation: 'ባቡር (Babur) means "train".',
            audioUrl: 'audio/babur.mp3',
          ),
          // Exercise 4: Complete the chat (like the image with chat about countries)
          Exercise(
            id: 'transportation_basic_ex4',
            type: ExerciseType.completeChat,
            instruction: 'Complete the chat',
            amharicText: 'Person A: "ወዴት ትሄዳለህ?"\nPerson B: "_____"',
            translation: 'Person A: "Where are you going?"\nPerson B: "I am going to the market by bus."',
            content: 'Person A: "ወዴት ትሄዳለህ?" (Where are you going?)\nPerson B: "I am going to the market by bus."',
            question: 'Complete Person B\'s response:',
            options: [
              ExerciseOption(text: 'I am going to the market by bus.', isCorrect: true),
              ExerciseOption(text: 'I am staying home today.', isCorrect: false)
            ],
            correctAnswer: 'I am going to the market by bus.',
            explanation: 'This response uses transportation vocabulary and indicates where the person is going.',
            audioUrl: 'audio/going_market_bus.mp3',
          ),
        ],
        vocabulary: ['መኪና', 'Mekina', 'Car', 'ባቡር', 'Babur', 'Train', 'አውቶቡስ', 'Autobus', 'Bus'],
      ),
      
      // Lesson 3: Family - "Read and respond" style
      Lesson(
        id: 'family_basic',
        title: 'Family Members',
        description: 'Learn family member names in Amharic',
        level: LanguageLevel.beginner,
        category: 'Family',
        languageCode: 'am',
        estimatedMinutes: 7,
        estimatedTime: 7,
        xpReward: 25,
        exercises: [
          // Exercise 1: Read and Respond (like the image with solo definition)
          Exercise(
            id: 'family_basic_ex1',
            type: ExerciseType.readAndRespond,
            instruction: 'Read and respond',
            amharicText: 'እናት',
            translation: 'Mother',
            content: 'እናት means "mother" in Amharic. It is one of the most important family members.',
            question: 'What does "እናት" mean?',
            options: [
              ExerciseOption(text: 'Father', isCorrect: false),
              ExerciseOption(text: 'Mother', isCorrect: true),
              ExerciseOption(text: 'Brother', isCorrect: false),
              ExerciseOption(text: 'Sister', isCorrect: false)
            ],
            correctAnswer: 'Mother',
            explanation: 'እናት (Enat) means "mother" in Amharic.',
            audioUrl: 'audio/enat.mp3',
            imageUrl: 'images/mother.jpg',
          ),
          // Exercise 2: Complete the sentence (like the image with suitcase comparison)
          Exercise(
            id: 'family_basic_ex2',
            type: ExerciseType.completeSentence,
            instruction: 'Complete the sentence',
            amharicText: 'የኔ _____ በጣም ትወዳኛለች።',
            translation: 'My mother loves me very much.',
            content: 'Complete the Amharic sentence: "የኔ _____ በጣም ትወዳኛለች።" (My _____ loves me very much)',
            question: 'Complete the Amharic sentence: "የኔ _____ በጣም ትወዳኛለች።"',
            options: [
              ExerciseOption(text: 'እናት', isCorrect: true),
              ExerciseOption(text: 'አባት', isCorrect: false),
              ExerciseOption(text: 'ወንድም', isCorrect: false),
              ExerciseOption(text: 'እህት', isCorrect: false)
            ],
            correctAnswer: 'እናት',
            explanation: 'እናት (Enat) means "mother" and is the correct family member for this sentence.',
            audioUrl: 'audio/mother_loves_me.mp3',
          ),
          // Exercise 3: Tap what you hear (like the image with word bank)
          Exercise(
            id: 'family_basic_ex3',
            type: ExerciseType.tapWhatYouHear,
            instruction: 'Tap what you hear',
            amharicText: 'አባት',
            translation: 'Father',
            content: 'Listen and select the family words you hear.',
            question: 'Tap the word for "father".',
            options: [
              ExerciseOption(text: 'እናት', isCorrect: false),
              ExerciseOption(text: 'አባት', isCorrect: true),
              ExerciseOption(text: 'ወንድም', isCorrect: false),
              ExerciseOption(text: 'እህት', isCorrect: false)
            ],
            correctAnswer: 'አባት',
            explanation: 'አባት (Abat) means "father".',
            audioUrl: 'audio/abat.mp3',
          ),
          // Exercise 4: Complete the chat (like the image with chat about family)
          Exercise(
            id: 'family_basic_ex4',
            type: ExerciseType.completeChat,
            instruction: 'Complete the chat',
            amharicText: 'Person A: "Tell me about your family."\nPerson B: "_____"',
            translation: 'Person A: "Tell me about your family."\nPerson B: "I have a big family with three siblings."',
            content: 'Person A: "Tell me about your family."\nPerson B: "I have a big family with three siblings."',
            question: 'Complete Person B\'s response:',
            options: [
              ExerciseOption(text: 'I don\'t like my family.', isCorrect: false),
              ExerciseOption(text: 'I have a big family with three siblings.', isCorrect: true)
            ],
            correctAnswer: 'I have a big family with three siblings.',
            explanation: 'This response provides information about the family size.',
            audioUrl: 'audio/big_family_siblings.mp3',
          ),
        ],
        vocabulary: ['እናት', 'Enat', 'Mother', 'አባት', 'Abat', 'Father', 'ወንድም', 'Wendim', 'Brother'],
      ),
      
      // Lesson 4: Business - "Read and respond" style
      Lesson(
        id: 'business_basic',
        title: 'Business and Professional',
        description: 'Learn business vocabulary and professional communication',
        level: LanguageLevel.beginner,
        category: 'Business',
        languageCode: 'am',
        estimatedMinutes: 8,
        estimatedTime: 8,
        xpReward: 30,
        exercises: [
          // Exercise 1: Read and Respond (like the image with business meeting definition)
          Exercise(
            id: 'business_basic_ex1',
            type: ExerciseType.readAndRespond,
            instruction: 'Read and respond',
            amharicText: 'ንግድ',
            translation: 'Business',
            content: 'A business meeting is a formal discussion about work matters.',
            question: 'What does "business meeting" mean?',
            options: [
              ExerciseOption(text: 'a casual conversation', isCorrect: false),
              ExerciseOption(text: 'a formal discussion about work matters', isCorrect: true),
              ExerciseOption(text: 'a social gathering', isCorrect: false),
              ExerciseOption(text: 'a family dinner', isCorrect: false)
            ],
            correctAnswer: 'a formal discussion about work matters',
            explanation: 'A business meeting is a formal discussion about work matters.',
            audioUrl: 'audio/business_meeting.mp3',
            imageUrl: 'images/business_meeting.jpg',
          ),
          // Exercise 2: Complete the sentence (like the image with presentation)
          Exercise(
            id: 'business_basic_ex2',
            type: ExerciseType.completeSentence,
            instruction: 'Complete the sentence',
            amharicText: 'ዛሬ በ_____ ላይ እሰራለሁ።',
            translation: 'Today I work in business.',
            content: 'Complete the Amharic sentence: "ዛሬ በ_____ ላይ እሰራለሁ።" (Today I work in _____)',
            question: 'Complete the Amharic sentence: "ዛሬ በ_____ ላይ እሰራለሁ።"',
            options: [
              ExerciseOption(text: 'ንግድ', isCorrect: true),
              ExerciseOption(text: 'ስራ', isCorrect: false),
              ExerciseOption(text: 'ገንዘብ', isCorrect: false),
              ExerciseOption(text: 'ጊዜ', isCorrect: false)
            ],
            correctAnswer: 'ንግድ',
            explanation: 'ንግድ (Nigid) means "business" and is the correct word for this business context.',
            audioUrl: 'audio/work_business.mp3',
          ),
          // Exercise 3: Tap what you hear (like the image with word bank)
          Exercise(
            id: 'business_basic_ex3',
            type: ExerciseType.tapWhatYouHear,
            instruction: 'Tap what you hear',
            amharicText: 'ስራ',
            translation: 'Work',
            content: 'Listen and select the business words you hear.',
            question: 'Tap the word for "work".',
            options: [
              ExerciseOption(text: 'ንግድ', isCorrect: false),
              ExerciseOption(text: 'ስራ', isCorrect: true),
              ExerciseOption(text: 'ገንዘብ', isCorrect: false),
              ExerciseOption(text: 'ጊዜ', isCorrect: false)
            ],
            correctAnswer: 'ስራ',
            explanation: 'ስራ (Sira) means "work".',
            audioUrl: 'audio/sira.mp3',
          ),
          // Exercise 4: Complete the chat (like the image with chat about deadline)
          Exercise(
            id: 'business_basic_ex4',
            type: ExerciseType.completeChat,
            instruction: 'Complete the chat',
            amharicText: 'Person A: "When is the deadline for this project?"\nPerson B: "_____"',
            translation: 'Person A: "When is the deadline for this project?"\nPerson B: "The deadline is next Friday."',
            content: 'Person A: "When is the deadline for this project?"\nPerson B: "The deadline is next Friday."',
            question: 'Complete Person B\'s response:',
            options: [
              ExerciseOption(text: 'I don\'t know.', isCorrect: false),
              ExerciseOption(text: 'The deadline is next Friday.', isCorrect: true)
            ],
            correctAnswer: 'The deadline is next Friday.',
            explanation: 'A deadline is the latest time or date by which something should be completed.',
            audioUrl: 'audio/deadline_friday.mp3',
          ),
        ],
        vocabulary: ['ንግድ', 'Nigid', 'Business', 'ስራ', 'Sira', 'Work', 'ገንዘብ', 'Genzeb', 'Money'],
      ),
    ];
  }
  
  /// INTERMEDIATE LESSONS
  static List<Lesson> _getIntermediateLessons() {
    return [
      // Lesson 1: Advanced Greetings
      Lesson(
        id: 'greetings_advanced',
        title: 'Advanced Greetings',
        description: 'Learn formal and informal greetings',
        level: LanguageLevel.intermediate,
        category: 'Greetings',
        languageCode: 'am',
        estimatedMinutes: 10,
        estimatedTime: 10,
        xpReward: 40,
        exercises: [
          Exercise(
            id: 'greetings_advanced_ex1',
            type: ExerciseType.readAndRespond,
            instruction: 'Read and respond',
            amharicText: 'እንዴት ናችሁ?',
            translation: 'How are you? (formal)',
            content: 'እንዴት ናችሁ? is the formal way to ask "How are you?" in Amharic.',
            question: 'What does "እንዴት ናችሁ?" mean?',
            options: [
              ExerciseOption(text: 'What is your name?', isCorrect: false),
              ExerciseOption(text: 'How are you? (formal)', isCorrect: true),
              ExerciseOption(text: 'Where are you from?', isCorrect: false),
              ExerciseOption(text: 'What time is it?', isCorrect: false)
            ],
            correctAnswer: 'How are you? (formal)',
            explanation: 'እንዴት ናችሁ? is the formal way to ask "How are you?"',
            audioUrl: 'audio/indet_nachehu_formal.mp3',
          ),
          Exercise(
            id: 'greetings_advanced_ex2',
            type: ExerciseType.completeSentence,
            instruction: 'Complete the sentence',
            amharicText: 'ደህና ነኝ፣ _____',
            translation: 'I am fine, thank you.',
            content: 'Complete the response: "I am fine, _____"',
            question: 'Complete the sentence: "I am fine, _____"',
            options: [
              ExerciseOption(text: 'goodbye', isCorrect: false),
              ExerciseOption(text: 'thank you', isCorrect: true),
              ExerciseOption(text: 'please', isCorrect: false),
              ExerciseOption(text: 'excuse me', isCorrect: false)
            ],
            correctAnswer: 'thank you',
            explanation: 'Use "thank you" to express gratitude in response to "How are you?"',
            audioUrl: 'audio/fine_thank_you.mp3',
          ),
        ],
        vocabulary: ['እንዴት ናችሁ?', 'Indet nachehu', 'How are you? (formal)', 'ደህና ነኝ', 'Dehna negn', 'I am fine'],
      ),
    ];
  }
  
  /// ADVANCED LESSONS
  static List<Lesson> _getAdvancedLessons() {
    return [
      // Lesson 1: Professional Communication
      Lesson(
        id: 'professional_communication',
        title: 'Professional Communication',
        description: 'Learn professional Amharic communication',
        level: LanguageLevel.advanced,
        category: 'Business',
        languageCode: 'am',
        estimatedMinutes: 12,
        estimatedTime: 12,
        xpReward: 50,
        exercises: [
          Exercise(
            id: 'professional_communication_ex1',
            type: ExerciseType.readAndRespond,
            instruction: 'Read and respond',
            amharicText: 'እባክዎ ይጠብቁኝ።',
            translation: 'Please wait for me.',
            content: 'እባክዎ ይጠብቁኝ። is a polite way to ask someone to wait.',
            question: 'What does "እባክዎ ይጠብቁኝ።" mean?',
            options: [
              ExerciseOption(text: 'Please wait for me.', isCorrect: true),
              ExerciseOption(text: 'Thank you very much.', isCorrect: false),
              ExerciseOption(text: 'Excuse me.', isCorrect: false),
              ExerciseOption(text: 'Good morning.', isCorrect: false)
            ],
            correctAnswer: 'Please wait for me.',
            explanation: 'እባክዎ ይጠብቁኝ። is a polite way to ask someone to wait.',
            audioUrl: 'audio/please_wait.mp3',
          ),
        ],
        vocabulary: ['እባክዎ', 'Ibakwo', 'Please', 'ይጠብቁኝ', 'Yitebikugn', 'Wait for me'],
      ),
    ];
  }
}
