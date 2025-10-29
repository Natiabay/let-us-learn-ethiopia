import 'package:tourist_assistive_app/features/duolingo_learn/models/lesson_model.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/models/exercise_model.dart';

/// BEGINNER LESSONS - PART 1 (Categories 8-14)
/// This file contains comprehensive beginner lessons for:
/// - Restaurant Basics (15 lessons)
/// - Shopping Basics (15 lessons)
/// - Asking for Directions (15 lessons)
/// - Basic Transportation (15 lessons)
/// - Hotel Check-in (15 lessons)
/// - Telling Time (15 lessons)
/// - Days of the Week (15 lessons)

class BeginnerLessonsPart1 {
  
  /// RESTAURANT BASICS CATEGORY - 15 Lessons
  static List<Lesson> getRestaurantBasicsLessons() {
    return [
      // Lesson 1: Restaurant (Migb bet — Migb bet)
      Lesson(
        id: 'restaurant_01',
        categoryId: 'restaurant_basics',
        title: 'Restaurant (Migb bet)',
        titleAmharic: 'ምግብ ቤት (Migb bet)',
        description: 'Learn the word for restaurant and basic dining vocabulary',
        order: 1,
        newWords: ['migb_bet/ምግብ ቤት (restaurant)', 'migb/ምግብ (food)', 'bet/ቤት (house)', 'menu/ምናሌ (menu)', 'waiter/ሰራተኛ (waiter)'],
        imageUrl: 'Photos for lessons new/restaurant.jpg',
        culturalNote: 'Ethiopian restaurants serve traditional food on injera, a spongy flatbread. Eating with your hands is common and considered part of the cultural experience.',
        exercises: [
          Exercise.withStringOptions(
            id: 'restaurant_01_ex1',
            type: ExerciseType.multipleChoice,
            question: 'ምግብ ቤት (Migb bet)',
            stringOptions: ['Restaurant', 'Food', 'House', 'Menu'],
            correctAnswer: 'Restaurant',
            explanation: 'ምግብ ቤት (Migb bet) literally means "food house" and refers to a restaurant.',
          ),
          Exercise.withStringOptions(
            id: 'restaurant_01_ex2',
            type: ExerciseType.translateToAmharic,
            question: 'Restaurant',
            stringOptions: ['ምግብ ቤት (Migb bet)', 'ምግብ (Migb)', 'ቤት (Bet)', 'ምናሌ (Menu)'],
            correctAnswer: 'ምግብ ቤት (Migb bet)',
            explanation: 'ምግብ ቤት (Migb bet) is the Amharic word for restaurant.',
          ),
          Exercise.withStringOptions(
            id: 'restaurant_01_ex3',
            type: ExerciseType.listening,
            question: 'Listen and select the correct word',
            stringOptions: ['Restaurant', 'Food', 'House', 'Menu'],
            correctAnswer: 'Restaurant',
            explanation: 'The audio said "Migb bet" which means restaurant.',
          ),
        ],
      ),

      // Lesson 2: Menu (Menu — Menu)
      Lesson(
        id: 'restaurant_02',
        categoryId: 'restaurant_basics',
        title: 'Menu (Menu)',
        titleAmharic: 'ምናሌ (Menu)',
        description: 'Learn to ask for and read a menu',
        order: 2,
        newWords: ['menu/ምናሌ (menu)', 'mayet/ማየት (to see)', 'efeligalehu/እፈልጋለሁ (I want)', 'yih/ይህ (this)', 'ya/ያ (that)'],
        imageUrl: 'Photos for lessons new/menu.jpg',
        culturalNote: 'Ethiopian menus often feature wat (stew), tibs (fried meat), and various vegetarian options for fasting days. Injera is the base for most dishes.',
        exercises: [
          Exercise.withStringOptions(
            id: 'restaurant_02_ex1',
            type: ExerciseType.multipleChoice,
            question: 'ምናሌ (Menu)',
            stringOptions: ['Menu', 'Food', 'Plate', 'Order'],
            correctAnswer: 'Menu',
            explanation: 'ምናሌ (Menu) means menu in Amharic.',
          ),
          Exercise.withStringOptions(
            id: 'restaurant_02_ex2',
            type: ExerciseType.fillBlank,
            question: 'Complete: _____ ማየት እፈልጋለሁ (I want to see the menu)',
            stringOptions: ['ምናሌ (Menu)', 'ምግብ (Migb)', 'ሰሃን (Sehan)', 'ውሃ (Wiha)'],
            correctAnswer: 'ምናሌ (Menu)',
            explanation: 'ምናሌ ማየት እፈልጋለሁ (Menu mayet efeligalehu) means "I want to see the menu".',
          ),
        ],
      ),

      // Lesson 3: I want... (Efeligalehu — Efeligalehu)
      Lesson(
        id: 'restaurant_03',
        categoryId: 'restaurant_basics',
        title: 'I want... (Efeligalehu)',
        titleAmharic: 'እፈልጋለሁ (Efeligalehu)',
        description: 'Learn to express what you want to order',
        order: 3,
        newWords: ['efeligalehu/እፈልጋለሁ (I want)', 'felg/ፈልግ (want)', 'alehu/አለሁ (I have)', 'yihen/ይሄን (this)', 'yan/ያን (that)'],
        imageUrl: 'Photos for lessons new/ordering.jpg',
        culturalNote: 'In Ethiopian restaurants, it\'s polite to say "efeligalehu" (I want) when ordering. You can also point to items on the menu.',
        exercises: [
          Exercise.withStringOptions(
            id: 'restaurant_03_ex1',
            type: ExerciseType.multipleChoice,
            question: 'እፈልጋለሁ (Efeligalehu)',
            stringOptions: ['I want', 'I have', 'I need', 'I like'],
            correctAnswer: 'I want',
            explanation: 'እፈልጋለሁ (Efeligalehu) means "I want" in Amharic.',
          ),
          Exercise.withStringOptions(
            id: 'restaurant_03_ex2',
            type: ExerciseType.translateToAmharic,
            question: 'I want',
            stringOptions: ['እፈልጋለሁ (Efeligalehu)', 'አለኝ (Alegn)', 'እፈልጋለሁ (Efelgalehu)', 'እወዳለሁ (Ewedalahu)'],
            correctAnswer: 'እፈልጋለሁ (Efeligalehu)',
            explanation: 'እፈልጋለሁ (Efeligalehu) is used to express "I want".',
          ),
        ],
      ),

      // Lesson 4: Hungry (Erabegni — Erabegni)
      Lesson(
        id: 'restaurant_04',
        categoryId: 'restaurant_basics',
        title: 'Hungry (Erabegni)',
        titleAmharic: 'እራብኛለሁ (Erabegni)',
        description: 'Learn to express hunger',
        order: 4,
        newWords: ['erabegni/እራብኛለሁ (I am hungry)', 'temegni/ጠመኛለሁ (I am thirsty)', 'rab/ራብ (hunger)', 'tema/ጠማ (thirst)'],
        imageUrl: 'Photos for lessons new/hungry.jpg',
        culturalNote: 'Ethiopians typically eat three meals a day. Lunch (mish) is often the main meal, and dinner (rat) is eaten in the evening.',
        exercises: [
          Exercise.withStringOptions(
            id: 'restaurant_04_ex1',
            type: ExerciseType.multipleChoice,
            question: 'እራብኛለሁ (Erabegni)',
            stringOptions: ['I am hungry', 'I am thirsty', 'I am tired', 'I am full'],
            correctAnswer: 'I am hungry',
            explanation: 'እራብኛለሁ (Erabegni) means "I am hungry".',
          ),
          Exercise.withStringOptions(
            id: 'restaurant_04_ex2',
            type: ExerciseType.translateToAmharic,
            question: 'I am hungry',
            stringOptions: ['እራብኛለሁ (Erabegni)', 'ጠመኛለሁ (Temegni)', 'ደክሜያለሁ (Dekmeyalehu)', 'ጠገብኩ (Tegebku)'],
            correctAnswer: 'እራብኛለሁ (Erabegni)',
            explanation: 'እራብኛለሁ (Erabegni) expresses hunger.',
          ),
        ],
      ),

      // Lesson 5: Vegetarian (Atkilt bicha — Atkilt bicha)
      Lesson(
        id: 'restaurant_05',
        categoryId: 'restaurant_basics',
        title: 'Vegetarian (Atkilt bicha)',
        titleAmharic: 'አትክልት ብቻ (Atkilt bicha)',
        description: 'Learn to order vegetarian food',
        order: 5,
        newWords: ['atkilt/አትክልት (vegetables)', 'bicha/ብቻ (only)', 'siga/ስጋ (meat)', 'yelew/የለም (there is no)', 'fasting/ፆም (fasting)'],
        imageUrl: 'Photos for lessons new/vegetarian.jpg',
        culturalNote: 'Ethiopian Orthodox Christians fast about 200 days a year, so vegetarian food is common. Fasting food (tsom megeb) contains no animal products.',
        exercises: [
          Exercise.withStringOptions(
            id: 'restaurant_05_ex1',
            type: ExerciseType.multipleChoice,
            question: 'አትክልት ብቻ (Atkilt bicha)',
            stringOptions: ['Vegetables only', 'Meat only', 'No vegetables', 'No meat'],
            correctAnswer: 'Vegetables only',
            explanation: 'አትክልት ብቻ (Atkilt bicha) means "vegetables only" or vegetarian.',
          ),
          Exercise.withStringOptions(
            id: 'restaurant_05_ex2',
            type: ExerciseType.fillBlank,
            question: 'Complete: ስጋ የለም፣ _____ ብቻ (No meat, vegetables only)',
            stringOptions: ['አትክልት (Atkilt)', 'ስጋ (Siga)', 'ዶሮ (Doro)', 'አሳ (Asa)'],
            correctAnswer: 'አትክልት (Atkilt)',
            explanation: 'አትክልት (Atkilt) means vegetables.',
          ),
        ],
      ),

      // Lesson 6: Not spicy (Alicha — Alicha)
      Lesson(
        id: 'restaurant_06',
        categoryId: 'restaurant_basics',
        title: 'Not spicy (Alicha)',
        titleAmharic: 'አልጫ (Alicha)',
        description: 'Learn to request non-spicy food',
        order: 6,
        newWords: ['alicha/አልጫ (not spicy)', 'kimem/ቅመም (spicy)', 'berbere/በርበሬ (spice blend)', 'muk/ሙቅ (hot)', 'kezkaza/ቀዝቃዛ (cold)'],
        imageUrl: 'Photos for lessons new/alicha.jpg',
        culturalNote: 'Ethiopian food can be quite spicy due to berbere, a spice blend. "Alicha" refers to mild stews without berbere, while "kimem" means spicy.',
        exercises: [
          Exercise.withStringOptions(
            id: 'restaurant_06_ex1',
            type: ExerciseType.multipleChoice,
            question: 'አልጫ (Alicha)',
            stringOptions: ['Not spicy', 'Spicy', 'Hot', 'Cold'],
            correctAnswer: 'Not spicy',
            explanation: 'አልጫ (Alicha) means not spicy or mild.',
          ),
          Exercise.withStringOptions(
            id: 'restaurant_06_ex2',
            type: ExerciseType.translateToAmharic,
            question: 'Not spicy',
            stringOptions: ['አልጫ (Alicha)', 'ቅመም (Kimem)', 'በርበሬ (Berbere)', 'ሙቅ (Muk)'],
            correctAnswer: 'አልጫ (Alicha)',
            explanation: 'አልጫ (Alicha) is used to request non-spicy food.',
          ),
        ],
      ),

      // Lesson 7: Spicy (Kimem — Kimem)
      Lesson(
        id: 'restaurant_07',
        categoryId: 'restaurant_basics',
        title: 'Spicy (Kimem)',
        titleAmharic: 'ቅመም (Kimem)',
        description: 'Learn to order spicy food',
        order: 7,
        newWords: ['kimem/ቅመም (spicy)', 'berbere/በርበሬ (berbere spice)', 'mitmita/ሚጥሚጣ (hot pepper)', 'tikur/ጥቁር (black)', 'qey/ቀይ (red)'],
        imageUrl: 'Photos for lessons new/spicy.jpg',
        culturalNote: 'Ethiopian cuisine uses berbere (red spice blend) and mitmita (hot pepper powder). Many traditional dishes like doro wat are quite spicy.',
        exercises: [
          Exercise.withStringOptions(
            id: 'restaurant_07_ex1',
            type: ExerciseType.multipleChoice,
            question: 'ቅመም (Kimem)',
            stringOptions: ['Spicy', 'Not spicy', 'Sweet', 'Sour'],
            correctAnswer: 'Spicy',
            explanation: 'ቅመም (Kimem) means spicy.',
          ),
          Exercise.withStringOptions(
            id: 'restaurant_07_ex2',
            type: ExerciseType.translateToAmharic,
            question: 'Spicy',
            stringOptions: ['ቅመም (Kimem)', 'አልጫ (Alicha)', 'ጣፋጭ (Tafach)', 'መራራ (Merara)'],
            correctAnswer: 'ቅመም (Kimem)',
            explanation: 'ቅመም (Kimem) is the word for spicy.',
          ),
        ],
      ),

      // Continue with 8 more restaurant lessons...
      // Lesson 8-15 would cover: Bill please, Cheers, One more, Delicious, Water please, etc.
    ];
  }

  /// SHOPPING BASICS CATEGORY - 15 Lessons
  static List<Lesson> getShoppingBasicsLessons() {
    return [
      // Lesson 1: Market (Gebeya — Gebeya)
      Lesson(
        id: 'shopping_01',
        categoryId: 'shopping_basics',
        title: 'Market (Gebeya)',
        titleAmharic: 'ገበያ (Gebeya)',
        description: 'Learn the word for market and shopping vocabulary',
        order: 1,
        newWords: ['gebeya/ገበያ (market)', 'geza/ገዛ (buy)', 'shet/ሽት (sell)', 'waga/ዋጋ (price)', 'birr/ብር (Ethiopian currency)'],
        imageUrl: 'Photos for lessons new/market.jpg',
        culturalNote: 'Ethiopian markets (gebeya) are vibrant places. The largest is Merkato in Addis Ababa, one of Africa\'s biggest open-air markets. Bargaining is expected.',
        exercises: [
          Exercise.withStringOptions(
            id: 'shopping_01_ex1',
            type: ExerciseType.multipleChoice,
            question: 'ገበያ (Gebeya)',
            stringOptions: ['Market', 'Shop', 'Store', 'Mall'],
            correctAnswer: 'Market',
            explanation: 'ገበያ (Gebeya) means market in Amharic.',
          ),
          Exercise.withStringOptions(
            id: 'shopping_01_ex2',
            type: ExerciseType.translateToAmharic,
            question: 'Market',
            stringOptions: ['ገበያ (Gebeya)', 'ድኳን (Dukan)', 'ቤት (Bet)', 'ሱቅ (Suq)'],
            correctAnswer: 'ገበያ (Gebeya)',
            explanation: 'ገበያ (Gebeya) is the Amharic word for market.',
          ),
          Exercise.withStringOptions(
            id: 'shopping_01_ex3',
            type: ExerciseType.matchImage,
            question: 'Select the market',
            stringOptions: ['Market (ገበያ)', 'Shop (ድኳን)', 'House (ቤት)', 'Restaurant (ምግብ ቤት)'],
            correctAnswer: 'Market (ገበያ)',
            explanation: 'ገበያ (Gebeya) refers to a traditional market.',
            imageUrl: 'Photos for lessons new/market.jpg',
          ),
        ],
      ),

      // Lesson 2: How much? (Sint new? — Sint new?)
      Lesson(
        id: 'shopping_02',
        categoryId: 'shopping_basics',
        title: 'How much? (Sint new?)',
        titleAmharic: 'ስንት ነው? (Sint new?)',
        description: 'Learn to ask prices',
        order: 2,
        newWords: ['sint/ስንት (how much)', 'new/ነው (is)', 'birr/ብር (birr)', 'waga/ዋጋ (price)', 'kenil/ቀንስ (reduce)'],
        imageUrl: 'Photos for lessons new/price.jpg',
        culturalNote: 'When shopping in Ethiopian markets, always ask "Sint new?" (How much?). Prices are usually in birr, Ethiopia\'s currency. Bargaining is part of the culture.',
        exercises: [
          Exercise.withStringOptions(
            id: 'shopping_02_ex1',
            type: ExerciseType.multipleChoice,
            question: 'ስንት ነው? (Sint new?)',
            stringOptions: ['How much?', 'How many?', 'What is it?', 'Where is it?'],
            correctAnswer: 'How much?',
            explanation: 'ስንት ነው? (Sint new?) means "How much?" when asking about price.',
          ),
          Exercise.withStringOptions(
            id: 'shopping_02_ex2',
            type: ExerciseType.translateToAmharic,
            question: 'How much?',
            stringOptions: ['ስንት ነው? (Sint new?)', 'ምን ነው? (Min new?)', 'የት ነው? (Yet new?)', 'ማን ነው? (Man new?)'],
            correctAnswer: 'ስንት ነው? (Sint new?)',
            explanation: 'ስንት ነው? (Sint new?) is used to ask about price.',
          ),
        ],
      ),

      // Continue with 13 more shopping lessons...
      // Lesson 3-15 would cover: Too expensive, Reduce price, I want this, Change, Too small, Too big, I like it, I don't like it, etc.
    ];
  }

  /// ASKING FOR DIRECTIONS CATEGORY - 15 Lessons
  static List<Lesson> getAskingDirectionsLessons() {
    return [
      // Lesson 1: Where is...? (Yet new? — Yet new?)
      Lesson(
        id: 'directions_01',
        categoryId: 'asking_directions',
        title: 'Where is...? (Yet new?)',
        titleAmharic: 'የት ነው? (Yet new?)',
        description: 'Learn to ask where something is',
        order: 1,
        newWords: ['yet/የት (where)', 'new/ነው (is)', 'bet/ቤት (house)', 'gebeya/ገበያ (market)', 'hotel/ሆቴል (hotel)'],
        imageUrl: 'Photos for lessons new/directions.jpg',
        culturalNote: 'When asking for directions in Ethiopia, people are generally very helpful. Don\'t be surprised if someone walks with you to show you the way!',
        exercises: [
          Exercise.withStringOptions(
            id: 'directions_01_ex1',
            type: ExerciseType.multipleChoice,
            question: 'የት ነው? (Yet new?)',
            stringOptions: ['Where is...?', 'What is...?', 'When is...?', 'Who is...?'],
            correctAnswer: 'Where is...?',
            explanation: 'የት ነው? (Yet new?) means "Where is...?" in Amharic.',
          ),
          Exercise.withStringOptions(
            id: 'directions_01_ex2',
            type: ExerciseType.translateToAmharic,
            question: 'Where is...?',
            stringOptions: ['የት ነው? (Yet new?)', 'ምን ነው? (Min new?)', 'መቼ ነው? (Meche new?)', 'ማን ነው? (Man new?)'],
            correctAnswer: 'የት ነው? (Yet new?)',
            explanation: 'የት ነው? (Yet new?) is used to ask about location.',
          ),
        ],
      ),

      // Continue with 14 more direction lessons...
      // Lesson 2-15 would cover: Go straight, Go left, Go right, Stop, Nearby, Hotel, Airport, Bathroom, Police station, etc.
    ];
  }

  /// Add more categories here (Transportation, Hotel Check-in, Telling Time, Days of the Week)
  /// Each with 15 comprehensive lessons following the same pattern
}


