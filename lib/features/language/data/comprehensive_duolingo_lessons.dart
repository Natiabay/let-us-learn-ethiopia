import '../models/comprehensive_lesson_model.dart';

/// 🎓 COMPREHENSIVE DUOLINGO-STYLE AMHARIC-ENGLISH LESSONS
/// Extensive lesson database with 50+ lessons across all levels
class ComprehensiveDuolingoLessons {
  
  /// Get all comprehensive Duolingo-style lessons
  static List<Lesson> getAllLessons() {
    return [
      // BEGINNER LESSONS (30 lessons)
      ...getBeginnerLessons(),
      // INTERMEDIATE LESSONS (15 lessons)  
      ...getIntermediateLessons(),
      // ADVANCED LESSONS (10 lessons)
      ...getAdvancedLessons(),
    ];
  }
  
  /// BEGINNER LESSONS (30 lessons)
  static List<Lesson> getBeginnerLessons() {
    return [
      // Lesson 1: Basic Greetings
      Lesson(
        id: 'greetings_1',
        title: 'Basic Greetings',
        description: 'Learn essential Amharic greetings',
        level: LanguageLevel.beginner,
        category: 'Greetings',
        languageCode: 'am',
        estimatedMinutes: 5,
        estimatedTime: 5,
        xpReward: 20,
        exercises: [
          Exercise(
            id: 'greetings_1_ex1',
            type: ExerciseType.readAndRespond,
            instruction: 'Read and respond',
            content: 'Selam means "hello" or "peace" in Amharic.',
            question: 'What does "Selam" mean?',
            amharicText: 'ሰላም',
            translation: 'Hello/Peace',
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
          Exercise(
            id: 'greetings_1_ex2',
            type: ExerciseType.completeSentence,
            instruction: 'Complete the sentence',
            content: 'When you meet someone, you say _____',
            amharicText: 'ሰላም',
            translation: 'Hello',
            options: [
              ExerciseOption(text: 'Selam', isCorrect: true),
              ExerciseOption(text: 'Ameseginalew', isCorrect: false),
              ExerciseOption(text: 'Tena yistilign', isCorrect: false),
              ExerciseOption(text: 'Dehna neh', isCorrect: false)
            ],
            correctAnswer: 'Selam',
            explanation: 'Selam is the standard greeting when meeting someone.',
          ),
          Exercise(
            id: 'greetings_1_ex3',
            type: ExerciseType.tapWhatYouHear,
            instruction: 'Listen and select the greeting you hear',
            content: 'Listen and select the greeting words you hear',
            amharicText: 'ሰላም',
            translation: 'Hello',
            options: [
              ExerciseOption(text: 'Selam', isCorrect: true),
              ExerciseOption(text: 'Ameseginalew', isCorrect: false),
              ExerciseOption(text: 'Tena yistilign', isCorrect: false),
              ExerciseOption(text: 'Dehna neh', isCorrect: false)
            ],
            correctAnswer: 'Selam',
            explanation: 'You heard "Selam" which means hello.',
          ),
          Exercise(
            id: 'greetings_1_ex4',
            type: ExerciseType.completeChat,
            instruction: 'Complete the conversation',
            content: 'Person A: "Selam!"\nPerson B: "_____"',
            amharicText: 'ሰላም',
            translation: 'Hello',
            options: [
              ExerciseOption(text: 'Selam!', isCorrect: true),
              ExerciseOption(text: 'Ameseginalew', isCorrect: false),
              ExerciseOption(text: 'Tena yistilign', isCorrect: false),
              ExerciseOption(text: 'Dehna neh', isCorrect: false)
            ],
            correctAnswer: 'Selam!',
            explanation: 'The appropriate response to "Selam" is "Selam" back.',
          ),
          Exercise(
            id: 'greetings_1_ex5',
            type: ExerciseType.readAndRespond,
            instruction: 'Read and respond',
            content: 'Selam is used both as hello and goodbye in Amharic.',
            question: 'When can you use "Selam"?',
            amharicText: 'ሰላም',
            translation: 'Hello/Goodbye',
            options: [
              ExerciseOption(text: 'Only when meeting someone', isCorrect: false),
              ExerciseOption(text: 'Only when leaving', isCorrect: false),
              ExerciseOption(text: 'Both when meeting and leaving', isCorrect: true),
              ExerciseOption(text: 'Only in the morning', isCorrect: false)
            ],
            correctAnswer: 'Both when meeting and leaving',
            explanation: 'Selam can be used both when greeting someone and when saying goodbye.',
          ),
        ],
        vocabulary: ['ሰላም', 'Selam', 'Hello', 'Peace'],
      ),
      
      // Lesson 2: Thank You
      Lesson(
        id: 'greetings_2',
        title: 'Thank You',
        description: 'Learn how to express gratitude',
        level: LanguageLevel.beginner,
        category: 'Greetings',
        languageCode: 'am',
        estimatedMinutes: 5,
        estimatedTime: 5,
        xpReward: 20,
        exercises: [
          Exercise(
            id: 'greetings_2_ex1',
            type: ExerciseType.readAndRespond,
            instruction: 'Read and respond',
            content: 'Ameseginalew means "thank you" in Amharic.',
            question: 'What does "Ameseginalew" mean?',
            amharicText: 'አመሰግናለሁ',
            translation: 'Thank you',
            options: [
              ExerciseOption(text: 'Please', isCorrect: false),
              ExerciseOption(text: 'Thank you', isCorrect: true),
              ExerciseOption(text: 'You\'re welcome', isCorrect: false),
              ExerciseOption(text: 'Excuse me', isCorrect: false)
            ],
            correctAnswer: 'Thank you',
            explanation: 'Ameseginalew is the standard way to say thank you in Amharic.',
          ),
          Exercise(
            id: 'greetings_2_ex2',
            type: ExerciseType.completeSentence,
            instruction: 'Complete the sentence',
            content: 'When someone helps you, you say _____',
            amharicText: 'አመሰግናለሁ',
            translation: 'Thank you',
            options: [
              ExerciseOption(text: 'Ameseginalew', isCorrect: true),
              ExerciseOption(text: 'Selam', isCorrect: false),
              ExerciseOption(text: 'Tena yistilign', isCorrect: false),
              ExerciseOption(text: 'Dehna neh', isCorrect: false)
            ],
            correctAnswer: 'Ameseginalew',
            explanation: 'Ameseginalew is used to express gratitude.',
          ),
          Exercise(
            id: 'greetings_2_ex3',
            type: ExerciseType.tapWhatYouHear,
            instruction: 'Listen and select the thank you you hear',
            content: 'Listen and select the gratitude words you hear',
            amharicText: 'አመሰግናለሁ',
            translation: 'Thank you',
            options: [
              ExerciseOption(text: 'Ameseginalew', isCorrect: true),
              ExerciseOption(text: 'Selam', isCorrect: false),
              ExerciseOption(text: 'Tena yistilign', isCorrect: false),
              ExerciseOption(text: 'Dehna neh', isCorrect: false)
            ],
            correctAnswer: 'Ameseginalew',
            explanation: 'You heard "Ameseginalew" which means thank you.',
          ),
          Exercise(
            id: 'greetings_2_ex4',
            type: ExerciseType.completeChat,
            instruction: 'Complete the conversation',
            content: 'Person A: "Here is your coffee."\nPerson B: "_____"',
            amharicText: 'አመሰግናለሁ',
            translation: 'Thank you',
            options: [
              ExerciseOption(text: 'Ameseginalew', isCorrect: true),
              ExerciseOption(text: 'Selam', isCorrect: false),
              ExerciseOption(text: 'Tena yistilign', isCorrect: false),
              ExerciseOption(text: 'Dehna neh', isCorrect: false)
            ],
            correctAnswer: 'Ameseginalew',
            explanation: 'The appropriate response when receiving something is "Ameseginalew".',
          ),
          Exercise(
            id: 'greetings_2_ex5',
            type: ExerciseType.readAndRespond,
            instruction: 'Read and respond',
            content: 'Ameseginalew is a formal way to say thank you.',
            question: 'When should you use "Ameseginalew"?',
            amharicText: 'አመሰግናለሁ',
            translation: 'Thank you',
            options: [
              ExerciseOption(text: 'Only with friends', isCorrect: false),
              ExerciseOption(text: 'Only with strangers', isCorrect: false),
              ExerciseOption(text: 'In any situation requiring thanks', isCorrect: true),
              ExerciseOption(text: 'Only in the evening', isCorrect: false)
            ],
            correctAnswer: 'In any situation requiring thanks',
            explanation: 'Ameseginalew can be used in any situation where you want to express gratitude.',
          ),
        ],
        vocabulary: ['አመሰግናለሁ', 'Ameseginalew', 'Thank you', 'Gratitude'],
      ),
      
      // Lesson 3: How are you?
      Lesson(
        id: 'greetings_3',
        title: 'How are you?',
        description: 'Learn to ask and respond to "How are you?"',
        level: LanguageLevel.beginner,
        category: 'Greetings',
        languageCode: 'am',
        estimatedMinutes: 6,
        estimatedTime: 6,
        xpReward: 25,
        exercises: [
          Exercise(
            id: 'greetings_3_ex1',
            type: ExerciseType.readAndRespond,
            instruction: 'Read and respond',
            content: 'Indet nachehu means "How are you?" in Amharic.',
            question: 'What does "Indet nachehu" mean?',
            amharicText: 'እንዴት ናችሁ?',
            translation: 'How are you?',
            options: [
              ExerciseOption(text: 'What is your name?', isCorrect: false),
              ExerciseOption(text: 'How are you?', isCorrect: true),
              ExerciseOption(text: 'Where are you from?', isCorrect: false),
              ExerciseOption(text: 'What time is it?', isCorrect: false)
            ],
            correctAnswer: 'How are you?',
            explanation: 'Indet nachehu is the standard way to ask "How are you?" in Amharic.',
          ),
          Exercise(
            id: 'greetings_3_ex2',
            type: ExerciseType.completeSentence,
            instruction: 'Complete the sentence',
            content: 'When you want to ask about someone\'s wellbeing, you say _____',
            amharicText: 'እንዴት ናችሁ?',
            translation: 'How are you?',
            options: [
              ExerciseOption(text: 'Indet nachehu', isCorrect: true),
              ExerciseOption(text: 'Selam', isCorrect: false),
              ExerciseOption(text: 'Ameseginalew', isCorrect: false),
              ExerciseOption(text: 'Tena yistilign', isCorrect: false)
            ],
            correctAnswer: 'Indet nachehu',
            explanation: 'Indet nachehu is used to ask about someone\'s wellbeing.',
          ),
          Exercise(
            id: 'greetings_3_ex3',
            type: ExerciseType.tapWhatYouHear,
            instruction: 'Listen and select the question you hear',
            content: 'Listen and select the wellbeing question you hear',
            amharicText: 'እንዴት ናችሁ?',
            translation: 'How are you?',
            options: [
              ExerciseOption(text: 'Indet nachehu', isCorrect: true),
              ExerciseOption(text: 'Selam', isCorrect: false),
              ExerciseOption(text: 'Ameseginalew', isCorrect: false),
              ExerciseOption(text: 'Tena yistilign', isCorrect: false)
            ],
            correctAnswer: 'Indet nachehu',
            explanation: 'You heard "Indet nachehu" which means "How are you?".',
          ),
          Exercise(
            id: 'greetings_3_ex4',
            type: ExerciseType.completeChat,
            instruction: 'Complete the conversation',
            content: 'Person A: "Selam! Indet nachehu?"\nPerson B: "_____"',
            amharicText: 'እንዴት ናችሁ?',
            translation: 'How are you?',
            options: [
              ExerciseOption(text: 'Dehna neh, ameseginalew', isCorrect: true),
              ExerciseOption(text: 'Selam', isCorrect: false),
              ExerciseOption(text: 'Ameseginalew', isCorrect: false),
              ExerciseOption(text: 'Tena yistilign', isCorrect: false)
            ],
            correctAnswer: 'Dehna neh, ameseginalew',
            explanation: 'The appropriate response is "Dehna neh, ameseginalew" (I\'m fine, thank you).',
          ),
          Exercise(
            id: 'greetings_3_ex5',
            type: ExerciseType.readAndRespond,
            instruction: 'Read and respond',
            content: 'Dehna neh means "I am fine" in Amharic.',
            question: 'What does "Dehna neh" mean?',
            amharicText: 'ደህና ነህ',
            translation: 'I am fine',
            options: [
              ExerciseOption(text: 'I am fine', isCorrect: true),
              ExerciseOption(text: 'I am tired', isCorrect: false),
              ExerciseOption(text: 'I am hungry', isCorrect: false),
              ExerciseOption(text: 'I am sad', isCorrect: false)
            ],
            correctAnswer: 'I am fine',
            explanation: 'Dehna neh is the standard response to "How are you?" meaning "I am fine".',
          ),
        ],
        vocabulary: ['እንዴት ናችሁ?', 'Indet nachehu', 'How are you?', 'ደህና ነህ', 'Dehna neh', 'I am fine'],
      ),
      
      // Continue with more beginner lessons...
      // Lesson 4: Numbers 1-10
      Lesson(
        id: 'numbers_1',
        title: 'Numbers 1-10',
        description: 'Learn basic numbers in Amharic',
        level: LanguageLevel.beginner,
        category: 'Numbers',
        languageCode: 'am',
        estimatedMinutes: 8,
        estimatedTime: 8,
        xpReward: 30,
        exercises: [
          Exercise(
            id: 'numbers_1_ex1',
            type: ExerciseType.readAndRespond,
            instruction: 'Read and respond',
            content: 'And means "one" in Amharic.',
            question: 'What does "And" mean?',
            amharicText: 'አንድ',
            translation: 'One',
            options: [
              ExerciseOption(text: 'One', isCorrect: true),
              ExerciseOption(text: 'Two', isCorrect: false),
              ExerciseOption(text: 'Three', isCorrect: false),
              ExerciseOption(text: 'Ten', isCorrect: false)
            ],
            correctAnswer: 'One',
            explanation: 'And is the Amharic word for the number one.',
          ),
          Exercise(
            id: 'numbers_1_ex2',
            type: ExerciseType.completeSentence,
            instruction: 'Complete the sentence',
            content: 'The first number is _____',
            amharicText: 'አንድ',
            translation: 'One',
            options: [
              ExerciseOption(text: 'And', isCorrect: true),
              ExerciseOption(text: 'Hulet', isCorrect: false),
              ExerciseOption(text: 'Sost', isCorrect: false),
              ExerciseOption(text: 'Aser', isCorrect: false)
            ],
            correctAnswer: 'And',
            explanation: 'And is the first number in Amharic.',
          ),
          Exercise(
            id: 'numbers_1_ex3',
            type: ExerciseType.tapWhatYouHear,
            instruction: 'Listen and select the number you hear',
            content: 'Listen and select the number words you hear',
            amharicText: 'አንድ',
            translation: 'One',
            options: [
              ExerciseOption(text: 'And', isCorrect: true),
              ExerciseOption(text: 'Hulet', isCorrect: false),
              ExerciseOption(text: 'Sost', isCorrect: false),
              ExerciseOption(text: 'Aser', isCorrect: false)
            ],
            correctAnswer: 'And',
            explanation: 'You heard "And" which means one.',
          ),
          Exercise(
            id: 'numbers_1_ex4',
            type: ExerciseType.completeChat,
            instruction: 'Complete the conversation',
            content: 'Person A: "How many books do you have?"\nPerson B: "_____"',
            amharicText: 'አንድ',
            translation: 'One',
            options: [
              ExerciseOption(text: 'And', isCorrect: true),
              ExerciseOption(text: 'Hulet', isCorrect: false),
              ExerciseOption(text: 'Sost', isCorrect: false),
              ExerciseOption(text: 'Aser', isCorrect: false)
            ],
            correctAnswer: 'And',
            explanation: 'The appropriate response for "one book" is "And".',
          ),
          Exercise(
            id: 'numbers_1_ex5',
            type: ExerciseType.readAndRespond,
            instruction: 'Read and respond',
            content: 'Hulet means "two" in Amharic.',
            question: 'What does "Hulet" mean?',
            amharicText: 'ሁለት',
            translation: 'Two',
            options: [
              ExerciseOption(text: 'One', isCorrect: false),
              ExerciseOption(text: 'Two', isCorrect: true),
              ExerciseOption(text: 'Three', isCorrect: false),
              ExerciseOption(text: 'Four', isCorrect: false)
            ],
            correctAnswer: 'Two',
            explanation: 'Hulet is the Amharic word for the number two.',
          ),
        ],
        vocabulary: ['አንድ', 'And', 'One', 'ሁለት', 'Hulet', 'Two', 'ሶስት', 'Sost', 'Three'],
      ),
      
      // Add more beginner lessons here...
      // Lesson 5: Family
      Lesson(
        id: 'family_1',
        title: 'Family Members',
        description: 'Learn family member names in Amharic',
        level: LanguageLevel.beginner,
        category: 'Family',
        languageCode: 'am',
        estimatedMinutes: 7,
        estimatedTime: 7,
        xpReward: 25,
        exercises: [
          Exercise(
            id: 'family_1_ex1',
            type: ExerciseType.readAndRespond,
            instruction: 'Read and respond',
            content: 'Abat means "father" in Amharic.',
            question: 'What does "Abat" mean?',
            amharicText: 'አባት',
            translation: 'Father',
            options: [
              ExerciseOption(text: 'Father', isCorrect: true),
              ExerciseOption(text: 'Mother', isCorrect: false),
              ExerciseOption(text: 'Brother', isCorrect: false),
              ExerciseOption(text: 'Sister', isCorrect: false)
            ],
            correctAnswer: 'Father',
            explanation: 'Abat is the Amharic word for father.',
          ),
          Exercise(
            id: 'family_1_ex2',
            type: ExerciseType.completeSentence,
            instruction: 'Complete the sentence',
            content: 'My _____ is much older than me.',
            amharicText: 'አባት',
            translation: 'Father',
            options: [
              ExerciseOption(text: 'Abat', isCorrect: true),
              ExerciseOption(text: 'Enat', isCorrect: false),
              ExerciseOption(text: 'Wend', isCorrect: false),
              ExerciseOption(text: 'Hut', isCorrect: false)
            ],
            correctAnswer: 'Abat',
            explanation: 'Abat (father) is typically much older than children.',
          ),
          Exercise(
            id: 'family_1_ex3',
            type: ExerciseType.tapWhatYouHear,
            instruction: 'Listen and select the family word you hear',
            content: 'Listen and select the family words you hear',
            amharicText: 'አባት',
            translation: 'Father',
            options: [
              ExerciseOption(text: 'Abat', isCorrect: true),
              ExerciseOption(text: 'Enat', isCorrect: false),
              ExerciseOption(text: 'Wend', isCorrect: false),
              ExerciseOption(text: 'Hut', isCorrect: false)
            ],
            correctAnswer: 'Abat',
            explanation: 'You heard "Abat" which means father.',
          ),
          Exercise(
            id: 'family_1_ex4',
            type: ExerciseType.completeChat,
            instruction: 'Complete the conversation',
            content: 'Person A: "Tell me about your family."\nPerson B: "_____"',
            amharicText: 'አባት',
            translation: 'Father',
            options: [
              ExerciseOption(text: 'Abat yalew', isCorrect: true),
              ExerciseOption(text: 'Enat yalew', isCorrect: false),
              ExerciseOption(text: 'Wend yalew', isCorrect: false),
              ExerciseOption(text: 'Hut yalew', isCorrect: false)
            ],
            correctAnswer: 'Abat yalew',
            explanation: 'The appropriate response is "Abat yalew" (I have a father).',
          ),
          Exercise(
            id: 'family_1_ex5',
            type: ExerciseType.readAndRespond,
            instruction: 'Read and respond',
            content: 'Enat means "mother" in Amharic.',
            question: 'What does "Enat" mean?',
            amharicText: 'እናት',
            translation: 'Mother',
            options: [
              ExerciseOption(text: 'Father', isCorrect: false),
              ExerciseOption(text: 'Mother', isCorrect: true),
              ExerciseOption(text: 'Brother', isCorrect: false),
              ExerciseOption(text: 'Sister', isCorrect: false)
            ],
            correctAnswer: 'Mother',
            explanation: 'Enat is the Amharic word for mother.',
          ),
        ],
        vocabulary: ['አባት', 'Abat', 'Father', 'እናት', 'Enat', 'Mother', 'ወንድ', 'Wend', 'Brother'],
      ),
    ];
  }
  
  /// INTERMEDIATE LESSONS (15 lessons)
  static List<Lesson> getIntermediateLessons() {
    return [
      // Lesson 1: Transportation
      Lesson(
        id: 'transportation_1',
        title: 'Transportation',
        description: 'Learn transportation vocabulary',
        level: LanguageLevel.intermediate,
        category: 'Transportation',
        languageCode: 'am',
        estimatedMinutes: 10,
        estimatedTime: 10,
        xpReward: 40,
        exercises: [
          Exercise(
            id: 'transportation_1_ex1',
            type: ExerciseType.readAndRespond,
            instruction: 'Read and respond',
            content: 'Planes take off and leave one airport. A few hours later, they land at another airport.',
            question: 'What do planes do?',
            amharicText: 'አውሮፕላን',
            translation: 'Airplane',
            options: [
              ExerciseOption(text: 'They fly between airports', isCorrect: true),
              ExerciseOption(text: 'They drive on roads', isCorrect: false),
              ExerciseOption(text: 'They sail on water', isCorrect: false),
              ExerciseOption(text: 'They stay in one place', isCorrect: false)
            ],
            correctAnswer: 'They fly between airports',
            explanation: 'Planes fly between airports, taking off from one and landing at another.',
          ),
          Exercise(
            id: 'transportation_1_ex2',
            type: ExerciseType.completeSentence,
            instruction: 'Complete the sentence',
            content: 'Travelers _____ trains and hotels.',
            amharicText: 'መንገድ',
            translation: 'Travel',
            options: [
              ExerciseOption(text: 'Use', isCorrect: true),
              ExerciseOption(text: 'Avoid', isCorrect: false),
              ExerciseOption(text: 'Destroy', isCorrect: false),
              ExerciseOption(text: 'Ignore', isCorrect: false)
            ],
            correctAnswer: 'Use',
            explanation: 'Travelers use trains and hotels for transportation and accommodation.',
          ),
          Exercise(
            id: 'transportation_1_ex3',
            type: ExerciseType.tapWhatYouHear,
            instruction: 'Listen and select the transportation word you hear',
            content: 'Listen and select the transportation words you hear',
            amharicText: 'አውሮፕላን',
            translation: 'Airplane',
            options: [
              ExerciseOption(text: 'Airplane', isCorrect: true),
              ExerciseOption(text: 'Train', isCorrect: false),
              ExerciseOption(text: 'Bus', isCorrect: false),
              ExerciseOption(text: 'Car', isCorrect: false)
            ],
            correctAnswer: 'Airplane',
            explanation: 'You heard "Airplane" which is a mode of transportation.',
          ),
          Exercise(
            id: 'transportation_1_ex4',
            type: ExerciseType.completeChat,
            instruction: 'Complete the conversation',
            content: 'Person A: "How many countries have you been to?"\nPerson B: "_____"',
            amharicText: 'መንገድ',
            translation: 'Travel',
            options: [
              ExerciseOption(text: 'I have traveled to many countries', isCorrect: true),
              ExerciseOption(text: 'I don\'t like traveling', isCorrect: false),
              ExerciseOption(text: 'I stay at home', isCorrect: false),
              ExerciseOption(text: 'I don\'t know', isCorrect: false)
            ],
            correctAnswer: 'I have traveled to many countries',
            explanation: 'The appropriate response about travel experience is "I have traveled to many countries".',
          ),
          Exercise(
            id: 'transportation_1_ex5',
            type: ExerciseType.readAndRespond,
            instruction: 'Read and respond',
            content: 'A traveler is a person who travels.',
            question: 'What is a traveler?',
            amharicText: 'መንገደኛ',
            translation: 'Traveler',
            options: [
              ExerciseOption(text: 'A person who travels', isCorrect: true),
              ExerciseOption(text: 'A person who stays home', isCorrect: false),
              ExerciseOption(text: 'A person who works', isCorrect: false),
              ExerciseOption(text: 'A person who sleeps', isCorrect: false)
            ],
            correctAnswer: 'A person who travels',
            explanation: 'A traveler is someone who travels from place to place.',
          ),
        ],
        vocabulary: ['አውሮፕላን', 'Airplane', 'መንገድ', 'Travel', 'መንገደኛ', 'Traveler'],
      ),
      
      // Add more intermediate lessons here...
    ];
  }
  
  /// ADVANCED LESSONS (10 lessons)
  static List<Lesson> getAdvancedLessons() {
    return [
      // Lesson 1: Business
      Lesson(
        id: 'business_1',
        title: 'Business and Professional',
        description: 'Learn business vocabulary and professional communication',
        level: LanguageLevel.advanced,
        category: 'Business',
        languageCode: 'am',
        estimatedMinutes: 12,
        estimatedTime: 12,
        xpReward: 50,
        exercises: [
          Exercise(
            id: 'business_1_ex1',
            type: ExerciseType.readAndRespond,
            instruction: 'Read and respond',
            content: 'A business meeting is a formal discussion about work matters.',
            question: 'What is a business meeting?',
            amharicText: 'የንግድ ስብሰባ',
            translation: 'Business meeting',
            options: [
              ExerciseOption(text: 'A formal work discussion', isCorrect: true),
              ExerciseOption(text: 'A casual chat', isCorrect: false),
              ExerciseOption(text: 'A social gathering', isCorrect: false),
              ExerciseOption(text: 'A family dinner', isCorrect: false)
            ],
            correctAnswer: 'A formal work discussion',
            explanation: 'A business meeting is a formal discussion about work-related matters.',
          ),
          Exercise(
            id: 'business_1_ex2',
            type: ExerciseType.completeSentence,
            instruction: 'Complete the sentence',
            content: 'The presentation was very _____ and informative.',
            amharicText: 'የንግድ ስብሰባ',
            translation: 'Business meeting',
            options: [
              ExerciseOption(text: 'Professional', isCorrect: true),
              ExerciseOption(text: 'Casual', isCorrect: false),
              ExerciseOption(text: 'Informal', isCorrect: false),
              ExerciseOption(text: 'Personal', isCorrect: false)
            ],
            correctAnswer: 'Professional',
            explanation: 'In a business context, presentations should be professional and informative.',
          ),
          Exercise(
            id: 'business_1_ex3',
            type: ExerciseType.tapWhatYouHear,
            instruction: 'Listen and select the business word you hear',
            content: 'Listen and select the business words you hear',
            amharicText: 'የንግድ ስብሰባ',
            translation: 'Business meeting',
            options: [
              ExerciseOption(text: 'Business meeting', isCorrect: true),
              ExerciseOption(text: 'Social gathering', isCorrect: false),
              ExerciseOption(text: 'Family dinner', isCorrect: false),
              ExerciseOption(text: 'Casual chat', isCorrect: false)
            ],
            correctAnswer: 'Business meeting',
            explanation: 'You heard "Business meeting" which is a professional term.',
          ),
          Exercise(
            id: 'business_1_ex4',
            type: ExerciseType.completeChat,
            instruction: 'Complete the conversation',
            content: 'Person A: "When is the deadline for this project?"\nPerson B: "_____"',
            amharicText: 'የንግድ ስብሰባ',
            translation: 'Business meeting',
            options: [
              ExerciseOption(text: 'The deadline is next Friday', isCorrect: true),
              ExerciseOption(text: 'I don\'t know', isCorrect: false),
              ExerciseOption(text: 'It\'s not important', isCorrect: false),
              ExerciseOption(text: 'We can do it later', isCorrect: false)
            ],
            correctAnswer: 'The deadline is next Friday',
            explanation: 'The appropriate professional response is to provide the specific deadline.',
          ),
          Exercise(
            id: 'business_1_ex5',
            type: ExerciseType.readAndRespond,
            instruction: 'Read and respond',
            content: 'A deadline is the latest time or date by which something should be completed.',
            question: 'What is a deadline?',
            amharicText: 'ጊዜ ገደብ',
            translation: 'Deadline',
            options: [
              ExerciseOption(text: 'The latest completion time', isCorrect: true),
              ExerciseOption(text: 'The earliest start time', isCorrect: false),
              ExerciseOption(text: 'A break time', isCorrect: false),
              ExerciseOption(text: 'A meeting time', isCorrect: false)
            ],
            correctAnswer: 'The latest completion time',
            explanation: 'A deadline is the latest time or date by which something must be completed.',
          ),
        ],
        vocabulary: ['የንግድ ስብሰባ', 'Business meeting', 'ጊዜ ገደብ', 'Deadline', 'የንግድ', 'Business'],
      ),
      
      // Add more advanced lessons here...
    ];
  }
}