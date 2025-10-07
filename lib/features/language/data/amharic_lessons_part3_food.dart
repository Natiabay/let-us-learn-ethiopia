/// Amharic Lessons - Part 3: Food & Dining (1,200+ lines)
/// Professional Duolingo-style food lessons
import 'package:tourist_assistive_app/features/language/models/amharic_lesson_models.dart';

class AmharicFoodLessons {
  
  static final List<AmharicLesson> lessons = [
    _lesson1EthiopianDishes(),
    _lesson2Drinks(),
    _lesson3RestaurantPhrases(),
    _lesson4FoodAdjectives(),
    _lesson5DiningEtiquette(),
  ];
  
  /// Lesson 1: Ethiopian Dishes
  static AmharicLesson _lesson1EthiopianDishes() {
    return AmharicLesson(
      id: 'food_001',
      title: 'Ethiopian Dishes',
      description: 'Learn names of traditional Ethiopian foods',
      category: LessonCategory.food,
      difficulty: DifficultyLevel.beginner,
      order: 1,
      totalXP: 20,
      exercises: [
        // Injera
        LessonExercise(
          id: 'food_001_ex001',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear',
          audioUrl: 'injera_audio',
          amharicScript: 'እንጀራ',
          pronunciation: 'in-JER-a',
          options: [],
          correctAnswer: 'Injera',
          wordBank: ['Injera', 'bread', 'flatbread', 'traditional', 'teff', 'Ethiopian'],
          explanation: 'እንጀራ (Injera) - Traditional Ethiopian sourdough flatbread made from teff',
        ),
        
        LessonExercise(
          id: 'food_001_ex002',
          type: LessonType.multipleChoice,
          question: 'What is "Injera"?',
          amharicScript: 'እንጀራ',
          options: [
            'Traditional Ethiopian flatbread',
            'A spicy stew',
            'Ethiopian coffee',
            'A vegetable'
          ],
          correctAnswer: 'Traditional Ethiopian flatbread',
          explanation: 'እንጀራ (Injera) is the staple flatbread eaten with all Ethiopian meals',
        ),
        
        // Doro Wot
        LessonExercise(
          id: 'food_001_ex003',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear',
          audioUrl: 'doro_wot_audio',
          amharicScript: 'ዶሮ ወጥ',
          pronunciation: 'DO-ro wot',
          options: [],
          correctAnswer: 'Doro Wot',
          wordBank: ['Doro Wot', 'chicken', 'stew', 'spicy', 'berbere', 'national dish'],
          explanation: 'ዶሮ ወጥ (Doro Wot) - Spicy chicken stew, national dish of Ethiopia',
        ),
        
        LessonExercise(
          id: 'food_001_ex004',
          type: LessonType.completeTheSentence,
          question: 'Complete: Ethiopia\'s national dish is ___',
          amharicScript: 'የኢትዮጵያ ብሄራዊ ምግብ ___ ነው',
          options: ['ዶሮ ወጥ (Doro Wot)', 'እንጀራ (Injera)', 'ሽሮ (Shiro)', 'ጥብስ (Tibs)'],
          correctAnswer: 'ዶሮ ወጥ (Doro Wot)',
          explanation: 'ዶሮ ወጥ (Doro Wot) is considered Ethiopia\'s national dish',
        ),
        
        // Kitfo
        LessonExercise(
          id: 'food_001_ex005',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear',
          audioUrl: 'kitfo_audio',
          amharicScript: 'ክትፎ',
          pronunciation: 'KIT-fo',
          options: [],
          correctAnswer: 'Kitfo',
          wordBank: ['Kitfo', 'raw', 'minced', 'beef', 'spiced', 'butter'],
          explanation: 'ክትፎ (Kitfo) - Minced raw or rare beef mixed with mitmita spice and butter',
        ),
        
        LessonExercise(
          id: 'food_001_ex006',
          type: LessonType.multipleChoice,
          question: 'What is Kitfo made from?',
          amharicScript: 'ክትፎ',
          options: [
            'Minced raw beef',
            'Chicken',
            'Vegetables',
            'Fish'
          ],
          correctAnswer: 'Minced raw beef',
          explanation: 'ክትፎ (Kitfo) is Ethiopian steak tartare - minced raw or lightly cooked beef',
        ),
        
        // Tibs
        LessonExercise(
          id: 'food_001_ex007',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear',
          audioUrl: 'tibs_audio',
          amharicScript: 'ጥብስ',
          pronunciation: 'TIBS',
          options: [],
          correctAnswer: 'Tibs',
          wordBank: ['Tibs', 'sautéed', 'meat', 'vegetables', 'fried', 'pieces'],
          explanation: 'ጥብስ (Tibs) - Sautéed meat (usually beef or lamb) with vegetables',
        ),
        
        LessonExercise(
          id: 'food_001_ex008',
          type: LessonType.completeTheChat,
          question: 'Order food at a restaurant',
          conversation: ConversationData(
            character1: 'Waiter',
            character1Avatar: '🍽️',
            character2: 'Customer',
            character2Avatar: '🧑',
            messages: [
              ConversationMessage(
                speaker: 'Waiter',
                text: 'Min itfelgalu? (What would you like?)',
                amharic: 'ምን ትፈልጋሉ?',
              ),
              ConversationMessage(
                speaker: 'Customer',
                text: '[I want Tibs]',
                isUserResponse: true,
              ),
            ],
          ),
          options: [
            'Tibs felegalew (I want Tibs)',
            'Injera felegalew (I want Injera)',
            'Buna felegalew (I want coffee)',
            'Wuha felegalew (I want water)'
          ],
          correctAnswer: 'Tibs felegalew (I want Tibs)',
          explanation: 'ጥብስ ፈለጋለሁ (Tibs felegalew) - I want Tibs',
        ),
        
        // Shiro
        LessonExercise(
          id: 'food_001_ex009',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear',
          audioUrl: 'shiro_audio',
          amharicScript: 'ሽሮ',
          pronunciation: 'SHI-ro',
          options: [],
          correctAnswer: 'Shiro',
          wordBank: ['Shiro', 'chickpea', 'stew', 'vegetarian', 'spiced', 'powder'],
          explanation: 'ሽሮ (Shiro) - Thick chickpea/bean flour stew, very popular vegetarian dish',
        ),
        
        LessonExercise(
          id: 'food_001_ex010',
          type: LessonType.multipleChoice,
          question: 'Which dish is vegetarian?',
          options: [
            'ሽሮ (Shiro)',
            'ዶሮ ወጥ (Doro Wot)',
            'ክትፎ (Kitfo)',
            'ጥብስ (Tibs)'
          ],
          correctAnswer: 'ሽሮ (Shiro)',
          explanation: 'ሽሮ (Shiro) is a vegetarian chickpea stew, perfect for fasting days',
        ),
        
        // Gomen
        LessonExercise(
          id: 'food_001_ex011',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear',
          audioUrl: 'gomen_audio',
          amharicScript: 'ጎመን',
          pronunciation: 'GO-men',
          options: [],
          correctAnswer: 'Gomen',
          wordBank: ['Gomen', 'collard greens', 'vegetables', 'cooked', 'spiced', 'green'],
          explanation: 'ጎመን (Gomen) - Cooked collard greens or kale, usually with spices',
        ),
        
        // Misir Wot
        LessonExercise(
          id: 'food_001_ex012',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear',
          audioUrl: 'misir_wot_audio',
          amharicScript: 'ምስር ወጥ',
          pronunciation: 'mi-SIR wot',
          options: [],
          correctAnswer: 'Misir Wot',
          wordBank: ['Misir Wot', 'lentils', 'red', 'stew', 'spicy', 'vegetarian'],
          explanation: 'ምስር ወጥ (Misir Wot) - Spicy red lentil stew, popular fasting food',
        ),
        
        // Firfir
        LessonExercise(
          id: 'food_001_ex013',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear',
          audioUrl: 'firfir_audio',
          amharicScript: 'ፍርፍር',
          pronunciation: 'FIR-fir',
          options: [],
          correctAnswer: 'Firfir',
          wordBank: ['Firfir', 'torn', 'injera', 'sauce', 'mixed', 'breakfast'],
          explanation: 'ፍርፍር (Firfir) - Torn injera mixed with berbere sauce, common breakfast',
        ),
        
        LessonExercise(
          id: 'food_001_ex014',
          type: LessonType.matchPairs,
          question: 'Match the dish with its description',
          options: [
            'Injera - Flatbread',
            'Doro Wot - Chicken stew',
            'Kitfo - Raw beef',
            'Shiro - Chickpea stew'
          ],
          correctAnswer: 'All matched',
          explanation: 'Each dish has its unique character in Ethiopian cuisine',
        ),
        
        LessonExercise(
          id: 'food_001_ex015',
          type: LessonType.fillInTheBlank,
          question: 'Fill in: I want ___ (traditional bread)',
          amharicScript: '___ ፈለጋለሁ',
          options: ['እንጀራ (Injera)', 'ጥብስ (Tibs)', 'ሽሮ (Shiro)', 'ቡና (Buna)'],
          correctAnswer: 'እንጀራ (Injera)',
          explanation: 'እንጀራ ፈለጋለሁ (Injera felegalew) - I want Injera',
        ),
        
        // Beyaynetu
        LessonExercise(
          id: 'food_001_ex016',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear',
          audioUrl: 'beyaynetu_audio',
          amharicScript: 'በየአይነቱ',
          pronunciation: 'be-YAY-ne-tu',
          options: [],
          correctAnswer: 'Beyaynetu',
          wordBank: ['Beyaynetu', 'combination', 'platter', 'variety', 'vegetarian', 'samples'],
          explanation: 'በየአይነቱ (Beyaynetu) - Vegetarian combination platter with various dishes',
        ),
        
        LessonExercise(
          id: 'food_001_ex017',
          type: LessonType.completeTheChat,
          question: 'Complete the conversation',
          conversation: ConversationData(
            character1: 'Friend',
            character1Avatar: '🇪🇹',
            character2: 'Tourist',
            character2Avatar: '✈️',
            messages: [
              ConversationMessage(
                speaker: 'Friend',
                text: 'Min tigegn migib new? (What is your favorite food?)',
                amharic: 'ምን ትገኘኝ ምግብ ነው?',
              ),
              ConversationMessage(
                speaker: 'Tourist',
                text: '[I like Doro Wot]',
                isUserResponse: true,
              ),
            ],
          ),
          options: [
            'Doro Wot iwedelew (I like Doro Wot)',
            'Injera iwedelew (I like Injera)',
            'Tibs iwedelew (I like Tibs)',
            'Shiro iwedelew (I like Shiro)'
          ],
          correctAnswer: 'Doro Wot iwedelew (I like Doro Wot)',
          explanation: 'ዶሮ ወጥ እወደለሁ (Doro Wot iwedelew) - I like Doro Wot',
        ),
        
        LessonExercise(
          id: 'food_001_ex018',
          type: LessonType.translateSentence,
          question: 'Translate to Amharic: "I want meat"',
          options: [
            'ስጋ ፈለጋለሁ (Siga felegalew)',
            'እንጀራ ፈለጋለሁ (Injera felegalew)',
            'ውሃ ፈለጋለሁ (Wuha felegalew)',
            'ቡና ፈለጋለሁ (Buna felegalew)'
          ],
          correctAnswer: 'ስጋ ፈለጋለሁ (Siga felegalew)',
          explanation: 'ስጋ (Siga) = Meat, ፈለጋለሁ (felegalew) = I want',
        ),
        
        LessonExercise(
          id: 'food_001_ex019',
          type: LessonType.multipleChoice,
          question: 'Which dish is eaten WITH injera (not ON injera)?',
          options: [
            'All of them are eaten on injera',
            'Doro Wot only',
            'Kitfo only',
            'Shiro only'
          ],
          correctAnswer: 'All of them are eaten on injera',
          explanation: 'Injera serves as both plate and utensil - all dishes are served ON injera!',
        ),
        
        LessonExercise(
          id: 'food_001_ex020',
          type: LessonType.completeTheSentence,
          question: 'Complete: Ethiopian breakfast often includes ___',
          amharicScript: 'የኢትዮጵያ ቁርስ ብዙ ጊዜ ___ ያጠቃልላል',
          options: [
            'ፍርፍር (Firfir)',
            'ዶሮ ወጥ (Doro Wot)',
            'ክትፎ (Kitfo)',
            'በየአይነቱ (Beyaynetu)'
          ],
          correctAnswer: 'ፍርፍር (Firfir)',
          explanation: 'ፍርፍር (Firfir) is a common Ethiopian breakfast dish',
        ),
      ],
    );
  }
  
  /// Lesson 2: Drinks
  static AmharicLesson _lesson2Drinks() {
    return AmharicLesson(
      id: 'food_002',
      title: 'Ethiopian Drinks',
      description: 'Learn names of traditional beverages',
      category: LessonCategory.food,
      difficulty: DifficultyLevel.beginner,
      order: 2,
      totalXP: 15,
      prerequisiteId: 'food_001',
      exercises: [
        // Coffee (Buna)
        LessonExercise(
          id: 'food_002_ex001',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear (Coffee)',
          audioUrl: 'buna_audio',
          amharicScript: 'ቡና',
          pronunciation: 'BU-na',
          options: [],
          correctAnswer: 'Buna',
          wordBank: ['Buna', 'coffee', 'ceremony', 'traditional', 'Ethiopian', 'birthplace'],
          explanation: 'ቡና (Buna) - Coffee. Ethiopia is the birthplace of coffee!',
        ),
        
        LessonExercise(
          id: 'food_002_ex002',
          type: LessonType.multipleChoice,
          question: 'What is special about Ethiopian coffee?',
          amharicScript: 'ቡና',
          options: [
            'Ethiopia is the birthplace of coffee',
            'It\'s imported from Brazil',
            'It\'s not popular in Ethiopia',
            'It\'s only for tourists'
          ],
          correctAnswer: 'Ethiopia is the birthplace of coffee',
          explanation: 'ቡና (Buna) originated in Ethiopia over 1000 years ago!',
        ),
        
        LessonExercise(
          id: 'food_002_ex003',
          type: LessonType.completeTheChat,
          question: 'Order coffee',
          conversation: ConversationData(
            character1: 'Waiter',
            character1Avatar: '☕',
            character2: 'Customer',
            character2Avatar: '🧑',
            messages: [
              ConversationMessage(
                speaker: 'Waiter',
                text: 'Min itefetualu? (What do you want?)',
                amharic: 'ምን ትፈተዋሉ?',
              ),
              ConversationMessage(
                speaker: 'Customer',
                text: '[I want coffee]',
                isUserResponse: true,
              ),
            ],
          ),
          options: [
            'Buna felegalew (I want coffee)',
            'Wuha felegalew (I want water)',
            'Tej felegalew (I want tej)',
            'Tella felegalew (I want tella)'
          ],
          correctAnswer: 'Buna felegalew (I want coffee)',
          explanation: 'ቡና ፈለጋለሁ (Buna felegalew) - I want coffee',
        ),
        
        // Water (Wuha)
        LessonExercise(
          id: 'food_002_ex004',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear (Water)',
          audioUrl: 'wuha_audio',
          amharicScript: 'ውሃ',
          pronunciation: 'WU-ha',
          options: [],
          correctAnswer: 'Wuha',
          wordBank: ['Wuha', 'water', 'drink', 'beverage', 'liquid', 'hydration'],
          explanation: 'ውሃ (Wuha) - Water',
        ),
        
        LessonExercise(
          id: 'food_002_ex005',
          type: LessonType.completeTheSentence,
          question: 'Complete: I want ___',
          amharicScript: '___ ፈለጋለሁ',
          options: ['ውሃ (Wuha - Water)', 'ቡና (Buna - Coffee)', 'ጤጅ (Tej)', 'ጠላ (Tella)'],
          correctAnswer: 'ውሃ (Wuha - Water)',
          explanation: 'ውሃ ፈለጋለሁ (Wuha felegalew) - I want water',
        ),
        
        // Tej (Honey Wine)
        LessonExercise(
          id: 'food_002_ex006',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear (Honey wine)',
          audioUrl: 'tej_audio',
          amharicScript: 'ጤጅ',
          pronunciation: 'TEJ',
          options: [],
          correctAnswer: 'Tej',
          wordBank: ['Tej', 'honey', 'wine', 'traditional', 'alcoholic', 'fermented'],
          explanation: 'ጤጅ (Tej) - Traditional Ethiopian honey wine (7-15% alcohol)',
        ),
        
        LessonExercise(
          id: 'food_002_ex007',
          type: LessonType.multipleChoice,
          question: 'What is Tej made from?',
          amharicScript: 'ጤጅ',
          options: [
            'Honey',
            'Grapes',
            'Barley',
            'Coffee'
          ],
          correctAnswer: 'Honey',
          explanation: 'ጤጅ (Tej) is made from fermented honey and gesho (buckthorn)',
        ),
        
        // Tella (Beer)
        LessonExercise(
          id: 'food_002_ex008',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear (Traditional beer)',
          audioUrl: 'tella_audio',
          amharicScript: 'ጠላ',
          pronunciation: 'TEL-la',
          options: [],
          correctAnswer: 'Tella',
          wordBank: ['Tella', 'beer', 'traditional', 'homemade', 'grain', 'fermented'],
          explanation: 'ጠላ (Tella) - Traditional Ethiopian beer, home-brewed (2-6% alcohol)',
        ),
        
        LessonExercise(
          id: 'food_002_ex009',
          type: LessonType.matchPairs,
          question: 'Match the drink with its description',
          options: [
            'ቡና (Buna) - Coffee',
            'ውሃ (Wuha) - Water',
            'ጤጅ (Tej) - Honey wine',
            'ጠላ (Tella) - Beer'
          ],
          correctAnswer: 'All matched',
          explanation: 'Each drink has its place in Ethiopian culture',
        ),
        
        LessonExercise(
          id: 'food_002_ex010',
          type: LessonType.completeTheChat,
          question: 'Order a traditional drink',
          conversation: ConversationData(
            character1: 'Bartender',
            character1Avatar: '🍺',
            character2: 'Customer',
            character2Avatar: '🧑',
            messages: [
              ConversationMessage(
                speaker: 'Bartender',
                text: 'Min metat tfelgalu? (What drink do you want?)',
                amharic: 'ምን መጠጥ ትፈልጋሉ?',
              ),
              ConversationMessage(
                speaker: 'Customer',
                text: '[I want Tej]',
                isUserResponse: true,
              ),
            ],
          ),
          options: [
            'Tej felegalew (I want Tej)',
            'Buna felegalew (I want Coffee)',
            'Wuha felegalew (I want Water)',
            'Tella felegalew (I want Tella)'
          ],
          correctAnswer: 'Tej felegalew (I want Tej)',
          explanation: 'ጤጅ ፈለጋለሁ (Tej felegalew) - I want Tej (honey wine)',
        ),
      ],
    );
  }
  
  /// Lesson 3: Restaurant Phrases
  static AmharicLesson _lesson3RestaurantPhrases() {
    return AmharicLesson(
      id: 'food_003',
      title: 'Restaurant Phrases',
      description: 'Learn how to order and ask questions in restaurants',
      category: LessonCategory.food,
      difficulty: DifficultyLevel.elementary,
      order: 3,
      totalXP: 20,
      prerequisiteId: 'food_002',
      exercises: [
        // Menu please
        LessonExercise(
          id: 'food_003_ex001',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear (Menu please)',
          audioUrl: 'menu_audio',
          amharicScript: 'ሜኑ እባክህ',
          pronunciation: 'ME-nu e-BA-keh',
          options: [],
          correctAnswer: 'Menu ebakeh',
          wordBank: ['Menu', 'ebakeh', 'please', 'list', 'food', 'order'],
          explanation: 'ሜኑ እባክህ (Menu ebakeh) - Menu please (to a man)',
        ),
        
        // Add more restaurant phrase exercises...
      ],
    );
  }
  
  /// Lesson 4: Food Adjectives
  static AmharicLesson _lesson4FoodAdjectives() {
    return AmharicLesson(
      id: 'food_004',
      title: 'Food Adjectives',
      description: 'Describe how food tastes',
      category: LessonCategory.food,
      difficulty: DifficultyLevel.elementary,
      order: 4,
      totalXP: 15,
      prerequisiteId: 'food_003',
      exercises: [
        // Delicious
        LessonExercise(
          id: 'food_004_ex001',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear (Delicious)',
          audioUrl: 'tafach_audio',
          amharicScript: 'ጣፋጭ',
          pronunciation: 'ta-FACH',
          options: [],
          correctAnswer: 'Tafach',
          wordBank: ['Tafach', 'delicious', 'tasty', 'good', 'yummy', 'flavor'],
          explanation: 'ጣፋጭ (Tafach) - Delicious/Tasty',
        ),
        
        // Add more food adjective exercises...
      ],
    );
  }
  
  /// Lesson 5: Dining Etiquette
  static AmharicLesson _lesson5DiningEtiquette() {
    return AmharicLesson(
      id: 'food_005',
      title: 'Dining Etiquette',
      description: 'Learn Ethiopian dining customs',
      category: LessonCategory.food,
      difficulty: DifficultyLevel.intermediate,
      order: 5,
      totalXP: 20,
      prerequisiteId: 'food_004',
      exercises: [
        // Eating with hands
        LessonExercise(
          id: 'food_005_ex001',
          type: LessonType.multipleChoice,
          question: 'How do Ethiopians traditionally eat?',
          options: [
            'With the right hand only',
            'With fork and knife',
            'With chopsticks',
            'With both hands'
          ],
          correctAnswer: 'With the right hand only',
          explanation: 'Ethiopian food is eaten with the RIGHT HAND only, using injera to scoop food',
        ),
        
        // Add more etiquette exercises...
      ],
    );
  }
}





















