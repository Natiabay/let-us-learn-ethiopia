import '../models/comprehensive_lesson_model.dart';

/// 🎓 ENHANCED DUOLINGO-STYLE AMHARIC LESSONS
/// Complete language learning system with progression, gamification, and interactive exercises
class EnhancedDuolingoLessons {
  
  /// Get all enhanced Duolingo-style lessons
  static List<Lesson> getAllLessons() {
    return [
      // FOUNDATION LESSONS (Beginner)
      ...getFoundationLessons(),
      // PRACTICAL LESSONS (Elementary)
      ...getPracticalLessons(),
      // CONVERSATION LESSONS (Intermediate)
      ...getConversationLessons(),
      // PROFESSIONAL LESSONS (Advanced)
      ...getProfessionalLessons(),
    ];
  }
  
  /// FOUNDATION LESSONS - Basic building blocks
  static List<Lesson> getFoundationLessons() {
    return [
      // Lesson 1: Hello & Goodbye
      Lesson(
        id: 'foundation_hello',
        title: '👋 Hello & Goodbye',
        description: 'Master the basics of greeting in Amharic',
        level: LanguageLevel.beginner,
        category: 'Greetings',
        languageCode: 'am',
        estimatedMinutes: 5,
        estimatedTime: 5,
        xpReward: 20,
        isUnlocked: true,
        exercises: [
          // Exercise 1: Read and Respond
          Exercise(
            id: 'hello_ex1',
            type: ExerciseType.readAndRespond,
            instruction: 'Read and respond',
            amharicText: 'ሰላም',
            translation: 'Hello/Peace',
            content: 'ሰላም (Selam) is the most common greeting in Amharic. It means both "hello" and "peace".',
            question: 'What does "ሰላም" mean?',
            options: [
              ExerciseOption(text: 'Goodbye', isCorrect: false),
              ExerciseOption(text: 'Hello/Peace', isCorrect: true),
              ExerciseOption(text: 'Thank you', isCorrect: false),
              ExerciseOption(text: 'Please', isCorrect: false)
            ],
            correctAnswer: 'Hello/Peace',
            explanation: 'ሰላም (Selam) is the universal greeting in Amharic, meaning both "hello" and "peace".',
            audioUrl: 'audio/selam.mp3',
            imageUrl: 'images/greeting_handshake.jpg',
          ),
          // Exercise 2: Complete the sentence
          Exercise(
            id: 'hello_ex2',
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
          // Exercise 3: Tap what you hear
          Exercise(
            id: 'hello_ex3',
            type: ExerciseType.tapWhatYouHear,
            instruction: 'Tap what you hear',
            amharicText: 'አመሰግናለሁ',
            translation: 'Thank you',
            content: 'Listen and select the word you hear.',
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
          // Exercise 4: Complete the chat
          Exercise(
            id: 'hello_ex4',
            type: ExerciseType.completeChat,
            instruction: 'Complete the chat',
            amharicText: 'Person A: "ሰላም!"\nPerson B: "እንዴት ናችሁ?"\nPerson A: "_____"',
            translation: 'Person A: "Hello!"\nPerson B: "How are you?"\nPerson A: "I am fine."',
            content: 'Complete the conversation:',
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
          // Exercise 5: Match pairs
          Exercise(
            id: 'hello_ex5',
            type: ExerciseType.matchPairs,
            instruction: 'Match the pairs',
            amharicText: 'Match Amharic with English',
            translation: 'Match the pairs',
            content: 'Match the Amharic words with their English translations.',
            question: 'Match the pairs:',
            options: [
              ExerciseOption(text: 'ሰላም - Hello', isCorrect: true),
              ExerciseOption(text: 'አመሰግናለሁ - Thank you', isCorrect: true),
              ExerciseOption(text: 'ደህና ነኝ - I am fine', isCorrect: true),
              ExerciseOption(text: 'እንዴት ናችሁ? - How are you?', isCorrect: true)
            ],
            correctAnswer: 'All pairs are correct',
            explanation: 'These are the basic greeting words in Amharic.',
            audioUrl: 'audio/greeting_pairs.mp3',
          ),
        ],
        vocabulary: ['ሰላም', 'Selam', 'Hello', 'Peace', 'አመሰግናለሁ', 'Ameseginalew', 'Thank you', 'ደህና ነኝ', 'Dehna negn', 'I am fine'],
      ),
      
      // Lesson 2: Numbers 1-10
      Lesson(
        id: 'foundation_numbers',
        title: '🔢 Numbers 1-10',
        description: 'Learn to count from 1 to 10 in Amharic',
        level: LanguageLevel.beginner,
        category: 'Numbers',
        languageCode: 'am',
        estimatedMinutes: 6,
        estimatedTime: 6,
        xpReward: 25,
        isUnlocked: false,
        exercises: [
          // Exercise 1: Read and Respond
          Exercise(
            id: 'numbers_ex1',
            type: ExerciseType.readAndRespond,
            instruction: 'Read and respond',
            amharicText: 'አንድ',
            translation: 'One',
            content: 'አንድ (And) means "one" in Amharic. It is the first number.',
            question: 'What does "አንድ" mean?',
            options: [
              ExerciseOption(text: 'Two', isCorrect: false),
              ExerciseOption(text: 'One', isCorrect: true),
              ExerciseOption(text: 'Three', isCorrect: false),
              ExerciseOption(text: 'Ten', isCorrect: false)
            ],
            correctAnswer: 'One',
            explanation: 'አንድ (And) means "one" in Amharic.',
            audioUrl: 'audio/and.mp3',
            imageUrl: 'images/number_one.jpg',
          ),
          // Exercise 2: Complete the sentence
          Exercise(
            id: 'numbers_ex2',
            type: ExerciseType.completeSentence,
            instruction: 'Complete the sentence',
            amharicText: 'አንድ ተማሪ _____ አለ።',
            translation: 'One student is here.',
            content: 'Complete the Amharic sentence: "አንድ ተማሪ _____ አለ።" (One student _____ here)',
            question: 'Complete the Amharic sentence: "አንድ ተማሪ _____ አለ።"',
            options: [
              ExerciseOption(text: 'አለ', isCorrect: true),
              ExerciseOption(text: 'ነው', isCorrect: false),
              ExerciseOption(text: 'ናቸው', isCorrect: false),
              ExerciseOption(text: 'ነኝ', isCorrect: false)
            ],
            correctAnswer: 'አለ',
            explanation: 'አለ (Ale) means "is" or "exists" in Amharic.',
            audioUrl: 'audio/one_student_here.mp3',
          ),
          // Exercise 3: Tap what you hear
          Exercise(
            id: 'numbers_ex3',
            type: ExerciseType.tapWhatYouHear,
            instruction: 'Tap what you hear',
            amharicText: 'ሁለት',
            translation: 'Two',
            content: 'Listen and select the number you hear.',
            question: 'Tap the word for "two".',
            options: [
              ExerciseOption(text: 'አንድ', isCorrect: false),
              ExerciseOption(text: 'ሁለት', isCorrect: true),
              ExerciseOption(text: 'ሶስት', isCorrect: false),
              ExerciseOption(text: 'አራት', isCorrect: false)
            ],
            correctAnswer: 'ሁለት',
            explanation: 'ሁለት (Hulete) means "two" in Amharic.',
            audioUrl: 'audio/hulete.mp3',
          ),
          // Exercise 4: Complete the chat
          Exercise(
            id: 'numbers_ex4',
            type: ExerciseType.completeChat,
            instruction: 'Complete the chat',
            amharicText: 'Person A: "How many books do you have?"\nPerson B: "_____"',
            translation: 'Person A: "How many books do you have?"\nPerson B: "I have three books."',
            content: 'Complete the conversation about numbers:',
            question: 'Complete Person B\'s response:',
            options: [
              ExerciseOption(text: 'I have three books.', isCorrect: true),
              ExerciseOption(text: 'I don\'t have any books.', isCorrect: false)
            ],
            correctAnswer: 'I have three books.',
            explanation: 'This response uses numbers to answer the question.',
            audioUrl: 'audio/three_books.mp3',
          ),
          // Exercise 5: Match pairs
          Exercise(
            id: 'numbers_ex5',
            type: ExerciseType.matchPairs,
            instruction: 'Match the pairs',
            amharicText: 'Match numbers with words',
            translation: 'Match the pairs',
            content: 'Match the Amharic numbers with their English translations.',
            question: 'Match the pairs:',
            options: [
              ExerciseOption(text: 'አንድ - One', isCorrect: true),
              ExerciseOption(text: 'ሁለት - Two', isCorrect: true),
              ExerciseOption(text: 'ሶስት - Three', isCorrect: true),
              ExerciseOption(text: 'አራት - Four', isCorrect: true)
            ],
            correctAnswer: 'All pairs are correct',
            explanation: 'These are the basic numbers in Amharic.',
            audioUrl: 'audio/number_pairs.mp3',
          ),
        ],
        vocabulary: ['አንድ', 'And', 'One', 'ሁለት', 'Hulete', 'Two', 'ሶስት', 'Soste', 'Three', 'አራት', 'Arat', 'Four'],
      ),
      
      // Lesson 3: Family Members
      Lesson(
        id: 'foundation_family',
        title: '👨‍👩‍👧‍👦 Family Members',
        description: 'Learn family member names in Amharic',
        level: LanguageLevel.beginner,
        category: 'Family',
        languageCode: 'am',
        estimatedMinutes: 7,
        estimatedTime: 7,
        xpReward: 25,
        isUnlocked: false,
        exercises: [
          // Exercise 1: Read and Respond
          Exercise(
            id: 'family_ex1',
            type: ExerciseType.readAndRespond,
            instruction: 'Read and respond',
            amharicText: 'እናት',
            translation: 'Mother',
            content: 'እናት (Enat) means "mother" in Amharic. It is one of the most important family members.',
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
          // Exercise 2: Complete the sentence
          Exercise(
            id: 'family_ex2',
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
          // Exercise 3: Tap what you hear
          Exercise(
            id: 'family_ex3',
            type: ExerciseType.tapWhatYouHear,
            instruction: 'Tap what you hear',
            amharicText: 'አባት',
            translation: 'Father',
            content: 'Listen and select the family word you hear.',
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
          // Exercise 4: Complete the chat
          Exercise(
            id: 'family_ex4',
            type: ExerciseType.completeChat,
            instruction: 'Complete the chat',
            amharicText: 'Person A: "Tell me about your family."\nPerson B: "_____"',
            translation: 'Person A: "Tell me about your family."\nPerson B: "I have a big family with three siblings."',
            content: 'Complete the conversation about family:',
            question: 'Complete Person B\'s response:',
            options: [
              ExerciseOption(text: 'I don\'t like my family.', isCorrect: false),
              ExerciseOption(text: 'I have a big family with three siblings.', isCorrect: true)
            ],
            correctAnswer: 'I have a big family with three siblings.',
            explanation: 'This response provides information about the family size.',
            audioUrl: 'audio/big_family_siblings.mp3',
          ),
          // Exercise 5: Match pairs
          Exercise(
            id: 'family_ex5',
            type: ExerciseType.matchPairs,
            instruction: 'Match the pairs',
            amharicText: 'Match family members',
            translation: 'Match the pairs',
            content: 'Match the Amharic family words with their English translations.',
            question: 'Match the pairs:',
            options: [
              ExerciseOption(text: 'እናት - Mother', isCorrect: true),
              ExerciseOption(text: 'አባት - Father', isCorrect: true),
              ExerciseOption(text: 'ወንድም - Brother', isCorrect: true),
              ExerciseOption(text: 'እህት - Sister', isCorrect: true)
            ],
            correctAnswer: 'All pairs are correct',
            explanation: 'These are the basic family members in Amharic.',
            audioUrl: 'audio/family_pairs.mp3',
          ),
        ],
        vocabulary: ['እናት', 'Enat', 'Mother', 'አባት', 'Abat', 'Father', 'ወንድም', 'Wendim', 'Brother', 'እህት', 'Ehet', 'Sister'],
      ),
    ];
  }
  
  /// PRACTICAL LESSONS - Real-world scenarios
  static List<Lesson> getPracticalLessons() {
    return [
      // Lesson 1: At the Restaurant
      Lesson(
        id: 'practical_restaurant',
        title: '🍽️ At the Restaurant',
        description: 'Order food and drinks in Amharic',
        level: LanguageLevel.elementary,
        category: 'Food',
        languageCode: 'am',
        estimatedMinutes: 8,
        estimatedTime: 8,
        xpReward: 30,
        isUnlocked: false,
        exercises: [
          // Exercise 1: Read and Respond
          Exercise(
            id: 'restaurant_ex1',
            type: ExerciseType.readAndRespond,
            instruction: 'Read and respond',
            amharicText: 'ምግብ',
            translation: 'Food',
            content: 'ምግብ (Migib) means "food" in Amharic. It is essential for survival.',
            question: 'What does "ምግብ" mean?',
            options: [
              ExerciseOption(text: 'Water', isCorrect: false),
              ExerciseOption(text: 'Food', isCorrect: true),
              ExerciseOption(text: 'Drink', isCorrect: false),
              ExerciseOption(text: 'Table', isCorrect: false)
            ],
            correctAnswer: 'Food',
            explanation: 'ምግብ (Migib) means "food" in Amharic.',
            audioUrl: 'audio/migib.mp3',
            imageUrl: 'images/food.jpg',
          ),
          // Exercise 2: Complete the sentence
          Exercise(
            id: 'restaurant_ex2',
            type: ExerciseType.completeSentence,
            instruction: 'Complete the sentence',
            amharicText: 'እባክዎ ምግብ _____።',
            translation: 'Please bring food.',
            content: 'Complete the Amharic sentence: "እባክዎ ምግብ _____።" (Please food _____)',
            question: 'Complete the Amharic sentence: "እባክዎ ምግብ _____።"',
            options: [
              ExerciseOption(text: 'አምጡ', isCorrect: true),
              ExerciseOption(text: 'አምጣል', isCorrect: false),
              ExerciseOption(text: 'አምጣ', isCorrect: false),
              ExerciseOption(text: 'አምጣል', isCorrect: false)
            ],
            correctAnswer: 'አምጡ',
            explanation: 'አምጡ (Amutu) means "bring" in Amharic.',
            audioUrl: 'audio/please_bring_food.mp3',
          ),
          // Exercise 3: Tap what you hear
          Exercise(
            id: 'restaurant_ex3',
            type: ExerciseType.tapWhatYouHear,
            instruction: 'Tap what you hear',
            amharicText: 'ውሃ',
            translation: 'Water',
            content: 'Listen and select the drink you hear.',
            question: 'Tap the word for "water".',
            options: [
              ExerciseOption(text: 'ምግብ', isCorrect: false),
              ExerciseOption(text: 'ውሃ', isCorrect: true),
              ExerciseOption(text: 'ቡና', isCorrect: false),
              ExerciseOption(text: 'ሻይ', isCorrect: false)
            ],
            correctAnswer: 'ውሃ',
            explanation: 'ውሃ (Woha) means "water" in Amharic.',
            audioUrl: 'audio/woha.mp3',
          ),
          // Exercise 4: Complete the chat
          Exercise(
            id: 'restaurant_ex4',
            type: ExerciseType.completeChat,
            instruction: 'Complete the chat',
            amharicText: 'Waiter: "What would you like to order?"\nYou: "_____"',
            translation: 'Waiter: "What would you like to order?"\nYou: "I would like injera and wat."',
            content: 'Complete the restaurant conversation:',
            question: 'Complete your response:',
            options: [
              ExerciseOption(text: 'I would like injera and wat.', isCorrect: true),
              ExerciseOption(text: 'I don\'t want anything.', isCorrect: false)
            ],
            correctAnswer: 'I would like injera and wat.',
            explanation: 'This response shows you know Ethiopian food.',
            audioUrl: 'audio/injera_wat.mp3',
          ),
          // Exercise 5: Match pairs
          Exercise(
            id: 'restaurant_ex5',
            type: ExerciseType.matchPairs,
            instruction: 'Match the pairs',
            amharicText: 'Match food items',
            translation: 'Match the pairs',
            content: 'Match the Amharic food words with their English translations.',
            question: 'Match the pairs:',
            options: [
              ExerciseOption(text: 'ምግብ - Food', isCorrect: true),
              ExerciseOption(text: 'ውሃ - Water', isCorrect: true),
              ExerciseOption(text: 'ቡና - Coffee', isCorrect: true),
              ExerciseOption(text: 'ሻይ - Tea', isCorrect: true)
            ],
            correctAnswer: 'All pairs are correct',
            explanation: 'These are basic food and drink items in Amharic.',
            audioUrl: 'audio/food_pairs.mp3',
          ),
        ],
        vocabulary: ['ምግብ', 'Migib', 'Food', 'ውሃ', 'Woha', 'Water', 'ቡና', 'Buna', 'Coffee', 'ሻይ', 'Shai', 'Tea'],
      ),
      
      // Lesson 2: Shopping
      Lesson(
        id: 'practical_shopping',
        title: '🛒 Shopping',
        description: 'Buy things and ask for prices in Amharic',
        level: LanguageLevel.elementary,
        category: 'Shopping',
        languageCode: 'am',
        estimatedMinutes: 9,
        estimatedTime: 9,
        xpReward: 35,
        isUnlocked: false,
        exercises: [
          // Exercise 1: Read and Respond
          Exercise(
            id: 'shopping_ex1',
            type: ExerciseType.readAndRespond,
            instruction: 'Read and respond',
            amharicText: 'ስንት ነው?',
            translation: 'How much is it?',
            content: 'ስንት ነው? (Sint new?) means "How much is it?" in Amharic. It is essential for shopping.',
            question: 'What does "ስንት ነው?" mean?',
            options: [
              ExerciseOption(text: 'What is it?', isCorrect: false),
              ExerciseOption(text: 'How much is it?', isCorrect: true),
              ExerciseOption(text: 'Where is it?', isCorrect: false),
              ExerciseOption(text: 'When is it?', isCorrect: false)
            ],
            correctAnswer: 'How much is it?',
            explanation: 'ስንት ነው? (Sint new?) means "How much is it?" in Amharic.',
            audioUrl: 'audio/sint_new.mp3',
            imageUrl: 'images/shopping.jpg',
          ),
          // Exercise 2: Complete the sentence
          Exercise(
            id: 'shopping_ex2',
            type: ExerciseType.completeSentence,
            instruction: 'Complete the sentence',
            amharicText: 'ይህ ስንት _____?',
            translation: 'How much is this?',
            content: 'Complete the Amharic sentence: "ይህ ስንት _____?" (This how much _____?)',
            question: 'Complete the Amharic sentence: "ይህ ስንት _____?"',
            options: [
              ExerciseOption(text: 'ነው', isCorrect: true),
              ExerciseOption(text: 'ነው', isCorrect: false),
              ExerciseOption(text: 'ነው', isCorrect: false),
              ExerciseOption(text: 'ነው', isCorrect: false)
            ],
            correctAnswer: 'ነው',
            explanation: 'ነው (New) means "is" in Amharic.',
            audioUrl: 'audio/how_much_this.mp3',
          ),
          // Exercise 3: Tap what you hear
          Exercise(
            id: 'shopping_ex3',
            type: ExerciseType.tapWhatYouHear,
            instruction: 'Tap what you hear',
            amharicText: 'ገንዘብ',
            translation: 'Money',
            content: 'Listen and select the word you hear.',
            question: 'Tap the word for "money".',
            options: [
              ExerciseOption(text: 'ስንት', isCorrect: false),
              ExerciseOption(text: 'ገንዘብ', isCorrect: true),
              ExerciseOption(text: 'ምግብ', isCorrect: false),
              ExerciseOption(text: 'ውሃ', isCorrect: false)
            ],
            correctAnswer: 'ገንዘብ',
            explanation: 'ገንዘብ (Genzeb) means "money" in Amharic.',
            audioUrl: 'audio/genzeb.mp3',
          ),
          // Exercise 4: Complete the chat
          Exercise(
            id: 'shopping_ex4',
            type: ExerciseType.completeChat,
            instruction: 'Complete the chat',
            amharicText: 'Vendor: "This costs 50 birr."\nYou: "_____"',
            translation: 'Vendor: "This costs 50 birr."\nYou: "That is too expensive."',
            content: 'Complete the shopping conversation:',
            question: 'Complete your response:',
            options: [
              ExerciseOption(text: 'That is too expensive.', isCorrect: true),
              ExerciseOption(text: 'That is very cheap.', isCorrect: false)
            ],
            correctAnswer: 'That is too expensive.',
            explanation: 'This response shows you understand pricing.',
            audioUrl: 'audio/too_expensive.mp3',
          ),
          // Exercise 5: Match pairs
          Exercise(
            id: 'shopping_ex5',
            type: ExerciseType.matchPairs,
            instruction: 'Match the pairs',
            amharicText: 'Match shopping words',
            translation: 'Match the pairs',
            content: 'Match the Amharic shopping words with their English translations.',
            question: 'Match the pairs:',
            options: [
              ExerciseOption(text: 'ስንት ነው? - How much is it?', isCorrect: true),
              ExerciseOption(text: 'ገንዘብ - Money', isCorrect: true),
              ExerciseOption(text: 'ምግብ - Food', isCorrect: true),
              ExerciseOption(text: 'ውሃ - Water', isCorrect: true)
            ],
            correctAnswer: 'All pairs are correct',
            explanation: 'These are basic shopping words in Amharic.',
            audioUrl: 'audio/shopping_pairs.mp3',
          ),
        ],
        vocabulary: ['ስንት ነው?', 'Sint new?', 'How much is it?', 'ገንዘብ', 'Genzeb', 'Money', 'ምግብ', 'Migib', 'Food', 'ውሃ', 'Woha', 'Water'],
      ),
    ];
  }
  
  /// CONVERSATION LESSONS - Interactive dialogues
  static List<Lesson> getConversationLessons() {
    return [
      // Lesson 1: Meeting People
      Lesson(
        id: 'conversation_meeting',
        title: '👥 Meeting People',
        description: 'Introduce yourself and meet new people',
        level: LanguageLevel.intermediate,
        category: 'Greetings',
        languageCode: 'am',
        estimatedMinutes: 10,
        estimatedTime: 10,
        xpReward: 40,
        isUnlocked: false,
        exercises: [
          // Exercise 1: Read and Respond
          Exercise(
            id: 'meeting_ex1',
            type: ExerciseType.readAndRespond,
            instruction: 'Read and respond',
            amharicText: 'ስሜ ጆን ነው',
            translation: 'My name is John',
            content: 'ስሜ ጆን ነው (Sime John new) means "My name is John" in Amharic.',
            question: 'What does "ስሜ ጆን ነው" mean?',
            options: [
              ExerciseOption(text: 'My name is John', isCorrect: true),
              ExerciseOption(text: 'I am John', isCorrect: false),
              ExerciseOption(text: 'John is here', isCorrect: false),
              ExerciseOption(text: 'John is my friend', isCorrect: false)
            ],
            correctAnswer: 'My name is John',
            explanation: 'ስሜ ጆን ነው (Sime John new) means "My name is John" in Amharic.',
            audioUrl: 'audio/sime_john_new.mp3',
            imageUrl: 'images/introduction.jpg',
          ),
          // Exercise 2: Complete the sentence
          Exercise(
            id: 'meeting_ex2',
            type: ExerciseType.completeSentence,
            instruction: 'Complete the sentence',
            amharicText: 'ስሜ _____ ነው።',
            translation: 'My name is [name].',
            content: 'Complete the Amharic sentence: "ስሜ _____ ነው።" (My name is _____)',
            question: 'Complete the Amharic sentence: "ስሜ _____ ነው።"',
            options: [
              ExerciseOption(text: 'ጆን', isCorrect: true),
              ExerciseOption(text: 'ነው', isCorrect: false),
              ExerciseOption(text: 'ነው', isCorrect: false),
              ExerciseOption(text: 'ነው', isCorrect: false)
            ],
            correctAnswer: 'ጆን',
            explanation: 'ጆን (John) is a name that fits in this sentence.',
            audioUrl: 'audio/my_name_is.mp3',
          ),
          // Exercise 3: Tap what you hear
          Exercise(
            id: 'meeting_ex3',
            type: ExerciseType.tapWhatYouHear,
            instruction: 'Tap what you hear',
            amharicText: 'እንዴት ናችሁ?',
            translation: 'How are you?',
            content: 'Listen and select the greeting you hear.',
            question: 'Tap the word for "How are you?".',
            options: [
              ExerciseOption(text: 'ሰላም', isCorrect: false),
              ExerciseOption(text: 'እንዴት ናችሁ?', isCorrect: true),
              ExerciseOption(text: 'አመሰግናለሁ', isCorrect: false),
              ExerciseOption(text: 'ደህና ነኝ', isCorrect: false)
            ],
            correctAnswer: 'እንዴት ናችሁ?',
            explanation: 'እንዴት ናችሁ? (Indet nachehu?) means "How are you?" in Amharic.',
            audioUrl: 'audio/indet_nachehu.mp3',
          ),
          // Exercise 4: Complete the chat
          Exercise(
            id: 'meeting_ex4',
            type: ExerciseType.completeChat,
            instruction: 'Complete the chat',
            amharicText: 'Person A: "Hello, my name is Sarah."\nPerson B: "_____"',
            translation: 'Person A: "Hello, my name is Sarah."\nPerson B: "Nice to meet you, Sarah."',
            content: 'Complete the introduction conversation:',
            question: 'Complete Person B\'s response:',
            options: [
              ExerciseOption(text: 'Nice to meet you, Sarah.', isCorrect: true),
              ExerciseOption(text: 'I don\'t know you.', isCorrect: false)
            ],
            correctAnswer: 'Nice to meet you, Sarah.',
            explanation: 'This response shows politeness in introductions.',
            audioUrl: 'audio/nice_to_meet_you.mp3',
          ),
          // Exercise 5: Match pairs
          Exercise(
            id: 'meeting_ex5',
            type: ExerciseType.matchPairs,
            instruction: 'Match the pairs',
            amharicText: 'Match introduction phrases',
            translation: 'Match the pairs',
            content: 'Match the Amharic introduction phrases with their English translations.',
            question: 'Match the pairs:',
            options: [
              ExerciseOption(text: 'ስሜ ጆን ነው - My name is John', isCorrect: true),
              ExerciseOption(text: 'እንዴት ናችሁ? - How are you?', isCorrect: true),
              ExerciseOption(text: 'ደህና ነኝ - I am fine', isCorrect: true),
              ExerciseOption(text: 'አመሰግናለሁ - Thank you', isCorrect: true)
            ],
            correctAnswer: 'All pairs are correct',
            explanation: 'These are basic introduction phrases in Amharic.',
            audioUrl: 'audio/introduction_pairs.mp3',
          ),
        ],
        vocabulary: ['ስሜ', 'Sime', 'My name', 'ጆን', 'John', 'John', 'እንዴት ናችሁ?', 'Indet nachehu?', 'How are you?', 'ደህና ነኝ', 'Dehna negn', 'I am fine'],
      ),
    ];
  }
  
  /// PROFESSIONAL LESSONS - Business and formal communication
  static List<Lesson> getProfessionalLessons() {
    return [
      // Lesson 1: Business Communication
      Lesson(
        id: 'professional_business',
        title: '💼 Business Communication',
        description: 'Professional Amharic for business settings',
        level: LanguageLevel.advanced,
        category: 'Business',
        languageCode: 'am',
        estimatedMinutes: 12,
        estimatedTime: 12,
        xpReward: 50,
        isUnlocked: false,
        exercises: [
          // Exercise 1: Read and Respond
          Exercise(
            id: 'business_ex1',
            type: ExerciseType.readAndRespond,
            instruction: 'Read and respond',
            amharicText: 'እባክዎ ይጠብቁኝ።',
            translation: 'Please wait for me.',
            content: 'እባክዎ ይጠብቁኝ። (Ibakwo yitebikugn) is a polite way to ask someone to wait.',
            question: 'What does "እባክዎ ይጠብቁኝ።" mean?',
            options: [
              ExerciseOption(text: 'Please wait for me.', isCorrect: true),
              ExerciseOption(text: 'Thank you very much.', isCorrect: false),
              ExerciseOption(text: 'Excuse me.', isCorrect: false),
              ExerciseOption(text: 'Good morning.', isCorrect: false)
            ],
            correctAnswer: 'Please wait for me.',
            explanation: 'እባክዎ ይጠብቁኝ። (Ibakwo yitebikugn) is a polite way to ask someone to wait.',
            audioUrl: 'audio/please_wait.mp3',
            imageUrl: 'images/business_meeting.jpg',
          ),
          // Exercise 2: Complete the sentence
          Exercise(
            id: 'business_ex2',
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
          // Exercise 3: Tap what you hear
          Exercise(
            id: 'business_ex3',
            type: ExerciseType.tapWhatYouHear,
            instruction: 'Tap what you hear',
            amharicText: 'ስራ',
            translation: 'Work',
            content: 'Listen and select the business word you hear.',
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
          // Exercise 4: Complete the chat
          Exercise(
            id: 'business_ex4',
            type: ExerciseType.completeChat,
            instruction: 'Complete the chat',
            amharicText: 'Person A: "When is the deadline for this project?"\nPerson B: "_____"',
            translation: 'Person A: "When is the deadline for this project?"\nPerson B: "The deadline is next Friday."',
            content: 'Complete the business conversation:',
            question: 'Complete Person B\'s response:',
            options: [
              ExerciseOption(text: 'I don\'t know.', isCorrect: false),
              ExerciseOption(text: 'The deadline is next Friday.', isCorrect: true)
            ],
            correctAnswer: 'The deadline is next Friday.',
            explanation: 'A deadline is the latest time or date by which something should be completed.',
            audioUrl: 'audio/deadline_friday.mp3',
          ),
          // Exercise 5: Match pairs
          Exercise(
            id: 'business_ex5',
            type: ExerciseType.matchPairs,
            instruction: 'Match the pairs',
            amharicText: 'Match business terms',
            translation: 'Match the pairs',
            content: 'Match the Amharic business terms with their English translations.',
            question: 'Match the pairs:',
            options: [
              ExerciseOption(text: 'ንግድ - Business', isCorrect: true),
              ExerciseOption(text: 'ስራ - Work', isCorrect: true),
              ExerciseOption(text: 'ገንዘብ - Money', isCorrect: true),
              ExerciseOption(text: 'ጊዜ - Time', isCorrect: true)
            ],
            correctAnswer: 'All pairs are correct',
            explanation: 'These are basic business terms in Amharic.',
            audioUrl: 'audio/business_pairs.mp3',
          ),
        ],
        vocabulary: ['እባክዎ', 'Ibakwo', 'Please', 'ይጠብቁኝ', 'Yitebikugn', 'Wait for me', 'ንግድ', 'Nigid', 'Business', 'ስራ', 'Sira', 'Work'],
      ),
    ];
  }
}



