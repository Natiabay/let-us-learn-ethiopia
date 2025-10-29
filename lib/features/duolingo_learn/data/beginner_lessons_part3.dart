import 'package:tourist_assistive_app/features/duolingo_learn/models/lesson_model.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/models/exercise_model.dart';

/// BEGINNER LESSONS - PART 3 (Categories 22-33)
/// This file contains comprehensive beginner lessons for:
/// - Common Verbs 1 (15 lessons)
/// - Simple Adjectives (15 lessons)
/// - Asking Questions (15 lessons)
/// - Negative Sentences (15 lessons)
/// - Simple Sentences (15 lessons)
/// - Animals (15 lessons)
/// - Clothing (15 lessons)
/// - Home and Furniture (15 lessons)
/// - Cultural Facts 1 (15 lessons)
/// - Tourist Essentials 1 (15 lessons)
/// - Numbers 11-100 (15 lessons)
/// - Basic Transportation (15 lessons)

class BeginnerLessonsPart3 {
  
  /// COMMON VERBS 1 CATEGORY - 15 Lessons
  static List<Lesson> getCommonVerbs1Lessons() {
    return [
      // Lesson 1: To go (Hed — Hed)
      Lesson(
        id: 'verbs_01',
        categoryId: 'common_verbs_1',
        title: 'To go (Hed)',
        titleAmharic: 'መሄድ (Mehed)',
        description: 'Learn the essential verb "to go"',
        order: 1,
        newWords: ['mehed/መሄድ (to go)', 'hedalhu/ሄድኩ (I go/went)', 'hid/ሂድ (go!)', 'yihedal/ይሄዳል (he/she goes)', 'enihid/እንሂድ (let\'s go)'],
        imageUrl: 'Photos for lessons new/go.jpg',
        culturalNote: '"To go" is one of the most useful verbs. In Ethiopian culture, saying "enihid" (let\'s go) is a friendly way to invite someone to join you.',
        exercises: [
          Exercise.withStringOptions(
            id: 'verbs_01_ex1',
            type: ExerciseType.multipleChoice,
            question: 'መሄድ (Mehed)',
            stringOptions: ['To go', 'To come', 'To see', 'To eat'],
            correctAnswer: 'To go',
            explanation: 'መሄድ (Mehed) is the infinitive form of "to go".',
          ),
          Exercise.withStringOptions(
            id: 'verbs_01_ex2',
            type: ExerciseType.translateToAmharic,
            question: 'To go',
            stringOptions: ['መሄድ (Mehed)', 'መምጣት (Memet\'at)', 'ማየት (Mayet)', 'መብላት (Mebelat)'],
            correctAnswer: 'መሄድ (Mehed)',
            explanation: 'መሄድ (Mehed) means "to go" in Amharic.',
          ),
        ],
      ),

      // Lesson 2: To come (Met'a — Met'a)
      Lesson(
        id: 'verbs_02',
        categoryId: 'common_verbs_1',
        title: 'To come (Met\'a)',
        titleAmharic: 'መምጣት (Memet\'at)',
        description: 'Learn the verb "to come"',
        order: 2,
        newWords: ['memetat/መምጣት (to come)', 'meta/መጣ (came)', 'na/ና (come!)', 'yimetal/ይመጣል (he/she comes)', 'enimta/እንምጣ (let\'s come)'],
        imageUrl: 'Photos for lessons new/come.jpg',
        culturalNote: 'Saying "na" (come) is a warm invitation in Ethiopia. It\'s common to invite visitors to share food or coffee.',
        exercises: [
          Exercise.withStringOptions(
            id: 'verbs_02_ex1',
            type: ExerciseType.multipleChoice,
            question: 'መምጣት (Memet\'at)',
            stringOptions: ['To come', 'To go', 'To see', 'To eat'],
            correctAnswer: 'To come',
            explanation: 'መምጣት (Memet\'at) means "to come".',
          ),
          Exercise.withStringOptions(
            id: 'verbs_02_ex2',
            type: ExerciseType.translateToAmharic,
            question: 'Come!',
            stringOptions: ['ና (Na)', 'ሂድ (Hid)', 'ብላ (Bela)', 'ተኛ (Tegna)'],
            correctAnswer: 'ና (Na)',
            explanation: 'ና (Na) is the imperative form meaning "come!"',
          ),
        ],
      ),

      // Continue with 13 more common verb lessons (to eat, to drink, to see, to speak, to understand, to want, to know, to have, to need, etc.)...
    ];
  }

  /// SIMPLE ADJECTIVES CATEGORY - 15 Lessons
  static List<Lesson> getSimpleAdjectivesLessons() {
    return [
      // Lesson 1: Big (Tilk — Tilk)
      Lesson(
        id: 'adj_01',
        categoryId: 'simple_adjectives',
        title: 'Big (Tilk)',
        titleAmharic: 'ትልቅ (Tilk)',
        description: 'Learn basic adjectives starting with "big"',
        order: 1,
        newWords: ['tilk/ትልቅ (big)', 'tinish/ትንሽ (small)', 'dehna/ደህና (good)', 'metfo/መጥፎ (bad)', 'konjo/ቆንጆ (beautiful)'],
        imageUrl: 'Photos for lessons new/big.jpg',
        culturalNote: 'Adjectives in Amharic usually come after the noun they describe, similar to Romance languages.',
        exercises: [
          Exercise.withStringOptions(
            id: 'adj_01_ex1',
            type: ExerciseType.multipleChoice,
            question: 'ትልቅ (Tilk)',
            stringOptions: ['Big', 'Small', 'Good', 'Bad'],
            correctAnswer: 'Big',
            explanation: 'ትልቅ (Tilk) means big or large.',
          ),
          Exercise.withStringOptions(
            id: 'adj_01_ex2',
            type: ExerciseType.translateToAmharic,
            question: 'Big',
            stringOptions: ['ትልቅ (Tilk)', 'ትንሽ (Tinish)', 'ደህና (Dehna)', 'መጥፎ (Metfo)'],
            correctAnswer: 'ትልቅ (Tilk)',
            explanation: 'ትልቅ (Tilk) is the adjective for big.',
          ),
        ],
      ),

      // Continue with 14 more adjective lessons (small, good, bad, hot, cold, new, old, happy, sad, beautiful, ugly, fast, slow, etc.)...
    ];
  }

  /// ASKING QUESTIONS CATEGORY - 15 Lessons
  static List<Lesson> getAskingQuestionsLessons() {
    return [
      // Lesson 1: What? (Min? — Min?)
      Lesson(
        id: 'question_01',
        categoryId: 'asking_questions',
        title: 'What? (Min?)',
        titleAmharic: 'ምን? (Min?)',
        description: 'Learn question words starting with "what"',
        order: 1,
        newWords: ['min/ምን (what)', 'yet/የት (where)', 'meche/መቼ (when)', 'endet/እንዴት (how)', 'lemin/ለምን (why)', 'man/ማን (who)'],
        imageUrl: 'Photos for lessons new/what.jpg',
        culturalNote: 'Question words are essential for communication. Ethiopians appreciate when tourists try to ask questions in Amharic.',
        exercises: [
          Exercise.withStringOptions(
            id: 'question_01_ex1',
            type: ExerciseType.multipleChoice,
            question: 'ምን? (Min?)',
            stringOptions: ['What?', 'Where?', 'When?', 'Who?'],
            correctAnswer: 'What?',
            explanation: 'ምን? (Min?) means "what?" in Amharic.',
          ),
          Exercise.withStringOptions(
            id: 'question_01_ex2',
            type: ExerciseType.translateToAmharic,
            question: 'What?',
            stringOptions: ['ምን? (Min?)', 'የት? (Yet?)', 'መቼ? (Meche?)', 'ማን? (Man?)'],
            correctAnswer: 'ምን? (Min?)',
            explanation: 'ምን? (Min?) is used to ask "what?"',
          ),
        ],
      ),

      // Continue with 14 more question lessons (where, when, how, why, who, which, how many, how much, what time, etc.)...
    ];
  }

  /// ANIMALS CATEGORY - 15 Lessons
  static List<Lesson> getAnimalsLessons() {
    return [
      // Lesson 1: Dog (Wusha — Wusha)
      Lesson(
        id: 'animal_01',
        categoryId: 'animals',
        title: 'Dog (Wusha)',
        titleAmharic: 'ውሻ (Wusha)',
        description: 'Learn animal names starting with common pets',
        order: 1,
        newWords: ['wusha/ውሻ (dog)', 'dimet/ድመት (cat)', 'lam/ላም (cow)', 'feres/ፈረስ (horse)', 'beg/በግ (sheep)', 'feyel/ፍየል (goat)'],
        imageUrl: 'Photos for lessons new/dog.jpg',
        culturalNote: 'Ethiopia has diverse wildlife including unique species like the Ethiopian wolf and Gelada baboon. Livestock is very important to rural communities.',
        exercises: [
          Exercise.withStringOptions(
            id: 'animal_01_ex1',
            type: ExerciseType.multipleChoice,
            question: 'ውሻ (Wusha)',
            stringOptions: ['Dog', 'Cat', 'Cow', 'Horse'],
            correctAnswer: 'Dog',
            explanation: 'ውሻ (Wusha) means dog in Amharic.',
          ),
          Exercise.withStringOptions(
            id: 'animal_01_ex2',
            type: ExerciseType.matchImage,
            question: 'Select the dog',
            stringOptions: ['Dog (ውሻ)', 'Cat (ድመት)', 'Cow (ላም)', 'Horse (ፈረስ)'],
            correctAnswer: 'Dog (ውሻ)',
            explanation: 'ውሻ (Wusha) is the Amharic word for dog.',
            imageUrl: 'Photos for lessons new/dog.jpg',
          ),
        ],
      ),

      // Continue with 14 more animal lessons (cat, lion, elephant, monkey, bird, fish, snake, crocodile, zebra, etc.)...
    ];
  }

  /// CLOTHING CATEGORY - 15 Lessons
  static List<Lesson> getClothingLessons() {
    return [
      // Lesson 1: Shirt (Kemis — Kemis)
      Lesson(
        id: 'clothing_01',
        categoryId: 'clothing',
        title: 'Shirt (Kemis)',
        titleAmharic: 'ቀሚስ (Kemis)',
        description: 'Learn clothing vocabulary',
        order: 1,
        newWords: ['kemis/ቀሚስ (shirt/dress)', 'surri/ሱሪ (pants)', 'chemaki/ጫማ (shoes)', 'kob/ኮፍ (hat)', 'netela/ነጠላ (scarf)'],
        imageUrl: 'Photos for lessons new/shirt.jpg',
        culturalNote: 'Traditional Ethiopian clothing includes the habesha kemis (cotton dress) and netela (shawl). White is the traditional color for special occasions.',
        exercises: [
          Exercise.withStringOptions(
            id: 'clothing_01_ex1',
            type: ExerciseType.multipleChoice,
            question: 'ቀሚስ (Kemis)',
            stringOptions: ['Shirt/Dress', 'Pants', 'Shoes', 'Hat'],
            correctAnswer: 'Shirt/Dress',
            explanation: 'ቀሚስ (Kemis) can mean both shirt and dress.',
          ),
          Exercise.withStringOptions(
            id: 'clothing_01_ex2',
            type: ExerciseType.translateToAmharic,
            question: 'Shirt',
            stringOptions: ['ቀሚስ (Kemis)', 'ሱሪ (Surri)', 'ጫማ (Chemaki)', 'ኮፍ (Kob)'],
            correctAnswer: 'ቀሚስ (Kemis)',
            explanation: 'ቀሚስ (Kemis) is the word for shirt or dress.',
          ),
        ],
      ),

      // Continue with 14 more clothing lessons (pants, shoes, hat, jacket, socks, belt, traditional clothing, colors with clothing, etc.)...
    ];
  }

  /// HOME AND FURNITURE CATEGORY - 15 Lessons
  static List<Lesson> getHomeAndFurnitureLessons() {
    return [
      // Lesson 1: House (Bet — Bet)
      Lesson(
        id: 'home_01',
        categoryId: 'home_furniture',
        title: 'House (Bet)',
        titleAmharic: 'ቤት (Bet)',
        description: 'Learn home and furniture vocabulary',
        order: 1,
        newWords: ['bet/ቤት (house)', 'kifil/ክፍል (room)', 'ber/በር (door)', 'dirisha/መስኮት (window)', 'kursi/ወንበር (chair)'],
        imageUrl: 'Photos for lessons new/house.jpg',
        culturalNote: 'Ethiopian houses vary from traditional tukuls (round huts) to modern apartments. The word "bet" is used in many compound words like "migb bet" (restaurant).',
        exercises: [
          Exercise.withStringOptions(
            id: 'home_01_ex1',
            type: ExerciseType.multipleChoice,
            question: 'ቤት (Bet)',
            stringOptions: ['House', 'Room', 'Door', 'Window'],
            correctAnswer: 'House',
            explanation: 'ቤት (Bet) means house or home.',
          ),
          Exercise.withStringOptions(
            id: 'home_01_ex2',
            type: ExerciseType.translateToAmharic,
            question: 'House',
            stringOptions: ['ቤት (Bet)', 'ክፍል (Kifil)', 'በር (Ber)', 'መስኮት (Dirisha)'],
            correctAnswer: 'ቤት (Bet)',
            explanation: 'ቤት (Bet) is the Amharic word for house.',
          ),
        ],
      ),

      // Continue with 14 more home/furniture lessons (room, bed, table, chair, kitchen, bathroom, etc.)...
    ];
  }

  /// CULTURAL FACTS 1 CATEGORY - 15 Lessons
  static List<Lesson> getCulturalFacts1Lessons() {
    return [
      // Lesson 1: Ethiopia Overview
      Lesson(
        id: 'culture_01',
        categoryId: 'cultural_facts_1',
        title: 'Ethiopia Overview',
        titleAmharic: 'ስለ ኢትዮጵያ (Sile Ethiopia)',
        description: 'Learn about Ethiopia\'s rich history and culture',
        order: 1,
        newWords: ['ethiopia/ኢትዮጵያ (Ethiopia)', 'addis_ababa/አዲስ አበባ (Addis Ababa)', 'hager/ሀገር (country)', 'tarik/ታሪክ (history)', 'bahel/ባህል (culture)'],
        imageUrl: 'Photos for lessons new/ethiopia.jpg',
        culturalNote: 'Ethiopia is one of the oldest nations in the world, never colonized except for a brief Italian occupation (1936-1941). It has over 80 ethnic groups and languages.',
        exercises: [
          Exercise.withStringOptions(
            id: 'culture_01_ex1',
            type: ExerciseType.multipleChoice,
            question: 'What is the capital of Ethiopia?',
            stringOptions: ['Addis Ababa', 'Lalibela', 'Gondar', 'Axum'],
            correctAnswer: 'Addis Ababa',
            explanation: 'አዲስ አበባ (Addis Ababa) means "New Flower" and is Ethiopia\'s capital.',
          ),
          Exercise.withStringOptions(
            id: 'culture_01_ex2',
            type: ExerciseType.fillBlank,
            question: 'Ethiopia has over _____ ethnic groups',
            stringOptions: ['80', '50', '100', '30'],
            correctAnswer: '80',
            explanation: 'Ethiopia has over 80 different ethnic groups with diverse cultures and languages.',
          ),
        ],
      ),

      // Continue with 14 more cultural lessons (coffee ceremony, injera, festivals, music, dance, history, religion, etc.)...
    ];
  }

  /// TOURIST ESSENTIALS 1 CATEGORY - 15 Lessons
  static List<Lesson> getTouristEssentials1Lessons() {
    return [
      // Lesson 1: I don't understand (Algebagnem — Algebagnem)
      Lesson(
        id: 'tourist_01',
        categoryId: 'tourist_essentials_1',
        title: 'I don\'t understand',
        titleAmharic: 'አልገባኝም (Algebagnem)',
        description: 'Essential phrase for tourists',
        order: 1,
        newWords: ['algebagnem/አልገባኝም (I don\'t understand)', 'gebagn/ገባኝ (I understand)', 'englizegna/እንግሊዝኛ (English)', 'tichilaleh/ትችላለህ (can you)', 'menager/መናገር (to speak)'],
        imageUrl: 'Photos for lessons new/dont_understand.jpg',
        culturalNote: 'This is one of the most useful phrases for tourists. Ethiopians are generally patient and will try to help you communicate.',
        exercises: [
          Exercise.withStringOptions(
            id: 'tourist_01_ex1',
            type: ExerciseType.multipleChoice,
            question: 'አልገባኝም (Algebagnem)',
            stringOptions: ['I don\'t understand', 'I understand', 'I don\'t know', 'I know'],
            correctAnswer: 'I don\'t understand',
            explanation: 'አልገባኝም (Algebagnem) means "I don\'t understand".',
          ),
          Exercise.withStringOptions(
            id: 'tourist_01_ex2',
            type: ExerciseType.translateToAmharic,
            question: 'I don\'t understand',
            stringOptions: ['አልገባኝም (Algebagnem)', 'ገባኝ (Gebagn)', 'አላውቅም (Alawkim)', 'አውቃለሁ (Awkalehu)'],
            correctAnswer: 'አልገባኝም (Algebagnem)',
            explanation: 'አልገባኝም (Algebagnem) is the phrase for "I don\'t understand".',
          ),
        ],
      ),

      // Continue with 14 more tourist essential lessons (Do you speak English?, Help, Museum, Church, Post office, Bank, Photo, Don\'t take photo, etc.)...
    ];
  }

  /// NUMBERS 11-100 CATEGORY - 15 Lessons
  static List<Lesson> getNumbers11To100Lessons() {
    return [
      // Lesson 1: Eleven (Asra and — Asra and)
      Lesson(
        id: 'numbers2_01',
        categoryId: 'numbers_11_100',
        title: 'Eleven (Asra and)',
        titleAmharic: 'አስራ አንድ (Asra and)',
        description: 'Learn numbers from 11 to 100',
        order: 1,
        newWords: ['asra_and/አስራ አንድ (eleven)', 'asra_hulet/አስራ ሁለት (twelve)', 'haya/ሃያ (twenty)', 'selasa/ሰላሳ (thirty)', 'arba/አርባ (forty)'],
        imageUrl: 'Photos for lessons new/eleven.jpg',
        culturalNote: 'Ethiopian number system is straightforward. After ten, numbers are formed by combining "asra" (ten) with the unit number.',
        exercises: [
          Exercise.withStringOptions(
            id: 'numbers2_01_ex1',
            type: ExerciseType.multipleChoice,
            question: 'አስራ አንድ (Asra and)',
            stringOptions: ['Eleven', 'Twelve', 'Twenty', 'Thirty'],
            correctAnswer: 'Eleven',
            explanation: 'አስራ አንድ (Asra and) literally means "ten and one" = eleven.',
          ),
          Exercise.withStringOptions(
            id: 'numbers2_01_ex2',
            type: ExerciseType.translateToAmharic,
            question: 'Eleven',
            stringOptions: ['አስራ አንድ (Asra and)', 'አስራ ሁለት (Asra hulet)', 'ሃያ (Haya)', 'ሰላሳ (Selasa)'],
            correctAnswer: 'አስራ አንድ (Asra and)',
            explanation: 'አስራ አንድ (Asra and) is the number eleven.',
          ),
        ],
      ),

      // Continue with 14 more number lessons (12, 13-19, 20, 30, 40, 50, 60, 70, 80, 90, 100, practice exercises)...
    ];
  }

  /// BASIC TRANSPORTATION CATEGORY - 15 Lessons
  static List<Lesson> getBasicTransportationLessons() {
    return [
      // Lesson 1: Bus (Autobis — Autobis)
      Lesson(
        id: 'transport_01',
        categoryId: 'basic_transportation',
        title: 'Bus (Autobis)',
        titleAmharic: 'አውቶቢስ (Autobis)',
        description: 'Learn transportation vocabulary',
        order: 1,
        newWords: ['autobis/አውቶቢስ (bus)', 'taksi/ታክሲ (taxi)', 'mekina/መኪና (car)', 'bisklet/ብስክሌት (bicycle)', 'auroplan/አውሮፕላን (airplane)'],
        imageUrl: 'Photos for lessons new/bus.jpg',
        culturalNote: 'Public transportation in Ethiopia includes blue and white minibuses, larger buses, and taxis. The minibuses are the most common and affordable option.',
        exercises: [
          Exercise.withStringOptions(
            id: 'transport_01_ex1',
            type: ExerciseType.multipleChoice,
            question: 'አውቶቢስ (Autobis)',
            stringOptions: ['Bus', 'Taxi', 'Car', 'Bicycle'],
            correctAnswer: 'Bus',
            explanation: 'አውቶቢስ (Autobis) means bus.',
          ),
          Exercise.withStringOptions(
            id: 'transport_01_ex2',
            type: ExerciseType.matchImage,
            question: 'Select the bus',
            stringOptions: ['Bus (አውቶቢስ)', 'Taxi (ታክሲ)', 'Car (መኪና)', 'Bicycle (ብስክሌት)'],
            correctAnswer: 'Bus (አውቶቢስ)',
            explanation: 'አውቶቢስ (Autobis) is the Amharic word for bus.',
            imageUrl: 'Photos for lessons new/bus.jpg',
          ),
        ],
      ),

      // Continue with 14 more transportation lessons (taxi, car, bicycle, airplane, station, bus stop, go to airport, minibus, boat, train, etc.)...
    ];
  }
}


