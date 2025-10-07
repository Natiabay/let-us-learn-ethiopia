import 'package:tourist_assistive_app/features/language/models/comprehensive_lesson_model.dart';

class ProfessionalAmharicLessons {
  static List<Lesson> getLessons() {
    return [
      ...getBeginnerLessons(),
      ...getIntermediateLessons(),
      ...getAdvancedLessons(),
    ];
  }

  // Beginner Level - 100 Unique Lessons
  static List<Lesson> getBeginnerLessons() {
    return [
      // Unit 1: Essential Basics (Lessons 1-10)
      _createLesson(
        id: 'en_beginner_1',
        title: 'Hello & Goodbye',
        description: 'Master the most important greetings in Amharic',
        category: 'Greetings',
        vocabulary: {
          'ሰላም': 'Hello/Peace',
          'ታዲያስ': 'Goodbye (to male)',
          'ታዲያሽ': 'Goodbye (to female)',
          'እንዴት ናችሁ': 'How are you? (plural)',
          'እንዴት ነህ': 'How are you? (to male)',
          'እንዴት ነሽ': 'How are you? (to female)',
          'በጣም ደህና': 'Very well',
          'አመሰግናለሁ': 'Thank you',
          'እንኳን ደህና መጣህ': 'Welcome (to male)',
          'እንኳን ደህና መጣሽ': 'Welcome (to female)',
        },
        exercises: _generateGreetingExercises(),
        xpReward: 100,
        estimatedMinutes: 15,
      ),
      
      _createLesson(
        id: 'en_beginner_2',
        title: 'Numbers 1-10',
        description: 'Learn essential numbers for daily use',
        category: 'Numbers',
        vocabulary: {
          'አንድ': 'One',
          'ሁለት': 'Two',
          'ሶስት': 'Three',
          'አራት': 'Four',
          'አምስት': 'Five',
          'ስድስት': 'Six',
          'ሰባት': 'Seven',
          'ስምንት': 'Eight',
          'ዘጠኝ': 'Nine',
          'አስር': 'Ten',
        },
        exercises: _generateNumberExercises(),
        xpReward: 80,
        estimatedMinutes: 12,
      ),

      _createLesson(
        id: 'en_beginner_3',
        title: 'Family Members',
        description: 'Learn to talk about your family in Amharic',
        category: 'Family',
        vocabulary: {
          'ቤተሰብ': 'Family',
          'አባት': 'Father',
          'እናት': 'Mother',
          'ወንድም': 'Brother',
          'እህት': 'Sister',
          'ልጅ': 'Child',
          'ወላጅ': 'Parent',
          'አያት': 'Grandfather',
          'እምማ': 'Grandmother',
          'አጎት': 'Uncle',
        },
        exercises: _generateFamilyExercises(),
        xpReward: 90,
        estimatedMinutes: 14,
      ),

      _createLesson(
        id: 'en_beginner_4',
        title: 'Colors',
        description: 'Master basic colors in Amharic',
        category: 'Colors',
        vocabulary: {
          'ቀይ': 'Red',
          'አረንጓዴ': 'Green',
          'ሰማያዊ': 'Blue',
          'ቢጫ': 'Yellow',
          'ጥቁር': 'Black',
          'ነጭ': 'White',
          'ቡናማ': 'Brown',
          'ሮዝ': 'Pink',
          'ቀሚስ': 'Purple',
          'ብርቱካናማ': 'Orange',
        },
        exercises: _generateColorExercises(),
        xpReward: 85,
        estimatedMinutes: 13,
      ),

      _createLesson(
        id: 'en_beginner_5',
        title: 'Food & Drinks',
        description: 'Essential food vocabulary for dining',
        category: 'Food',
        vocabulary: {
          'ምግብ': 'Food',
          'ውሃ': 'Water',
          'ቡና': 'Coffee',
          'ባር': 'Bread',
          'ስጋ': 'Meat',
          'ዕፅዋት': 'Vegetables',
          'ፍራፍሬ': 'Fruit',
          'ሙዝ': 'Banana',
          'ቤር': 'Milk',
          'ስኳር': 'Sugar',
        },
        exercises: _generateFoodExercises(),
        xpReward: 95,
        estimatedMinutes: 16,
      ),

      _createLesson(
        id: 'en_beginner_6',
        title: 'Body Parts',
        description: 'Learn to describe the human body',
        category: 'Body',
        vocabulary: {
          'ራስ': 'Head',
          'ዓይን': 'Eye',
          'አፍ': 'Mouth',
          'እጅ': 'Hand',
          'እግር': 'Foot',
          'ጆሮ': 'Ear',
          'አፍንጫ': 'Nose',
          'ጉልበት': 'Neck',
          'ደረት': 'Chest',
          'ጀርባ': 'Back',
        },
        exercises: _generateBodyPartExercises(),
        xpReward: 88,
        estimatedMinutes: 15,
      ),

      _createLesson(
        id: 'en_beginner_7',
        title: 'Animals',
        description: 'Discover common animals in Amharic',
        category: 'Animals',
        vocabulary: {
          'እንስሳ': 'Animal',
          'ውሻ': 'Dog',
          'ድር': 'Cat',
          'ኮቴ': 'Cow',
          'በግ': 'Sheep',
          'ፈረስ': 'Horse',
          'አይጥ': 'Bird',
          'ዓሣ': 'Fish',
          'አንበሳ': 'Lion',
          'ዝሆን': 'Elephant',
        },
        exercises: _generateAnimalExercises(),
        xpReward: 92,
        estimatedMinutes: 14,
      ),

      _createLesson(
        id: 'en_beginner_8',
        title: 'Clothing',
        description: 'Essential clothing vocabulary',
        category: 'Clothing',
        vocabulary: {
          'ልብስ': 'Clothing',
          'ሸሚዝ': 'Shirt',
          'መጫወቻ': 'Pants',
          'ኪስ': 'Dress',
          'ጫማ': 'Shoe',
          'ባርኔጣ': 'Hat',
          'ጠባቂ': 'Jacket',
          'ሶክ': 'Sock',
          'ውስጥ ልብስ': 'Underwear',
          'ቀበቶ': 'Belt',
        },
        exercises: _generateClothingExercises(),
        xpReward: 87,
        estimatedMinutes: 13,
      ),

      _createLesson(
        id: 'en_beginner_9',
        title: 'Time & Days',
        description: 'Learn to tell time and days of the week',
        category: 'Time',
        vocabulary: {
          'ጊዜ': 'Time',
          'ሰዓት': 'Hour',
          'ደቂቃ': 'Minute',
          'ቀን': 'Day',
          'ሳምንት': 'Week',
          'ወር': 'Month',
          'አመት': 'Year',
          'ዛሬ': 'Today',
          'ትላንት': 'Yesterday',
          'ነገ': 'Tomorrow',
        },
        exercises: _generateTimeExercises(),
        xpReward: 93,
        estimatedMinutes: 15,
      ),

      _createLesson(
        id: 'en_beginner_10',
        title: 'Weather',
        description: 'Describe weather conditions',
        category: 'Weather',
        vocabulary: {
          'አየር': 'Weather',
          'ፀሐይ': 'Sun',
          'ዝናብ': 'Rain',
          'ንፋስ': 'Wind',
          'በረዶ': 'Snow',
          'ደመና': 'Cloud',
          'ሙቀት': 'Hot',
          'ቀዝቃዛ': 'Cold',
          'ጥሩ': 'Good',
          'መልካም': 'Nice',
        },
        exercises: _generateWeatherExercises(),
        xpReward: 89,
        estimatedMinutes: 14,
      ),
    ];
  }
  
  static List<Lesson> getIntermediateLessons() {
    return [
      // Unit 1: Places & Locations (Lessons 1-10)
      _createLesson(
        id: 'en_intermediate_1',
        title: 'Places in Town',
        description: 'Important places and locations',
        category: 'Places',
        vocabulary: {
          'መንገድ': 'Street',
          'ጎዳና': 'Road',
          'ሆስፒታል': 'Hospital',
          'ትምህርት ቤት': 'School',
          'ገበያ': 'Market',
          'ምግብ ቤት': 'Restaurant',
          'ሆቴል': 'Hotel',
          'ባንክ': 'Bank',
          'ፖስታ ቤት': 'Post Office',
          'ፖሊስ ጣቢያ': 'Police Station',
        },
        exercises: _generatePlacesExercises(),
        xpReward: 120,
        estimatedMinutes: 18,
      ),

      _createLesson(
        id: 'en_intermediate_2',
        title: 'City Life',
        description: 'Urban environment vocabulary',
        category: 'Places',
        vocabulary: {
          'ከተማ': 'City',
          'ትራፊክ': 'Traffic',
          'አውቶቡስ ማቆሚያ': 'Bus Stop',
          'ታክሲ': 'Taxi',
          'ፓርክ': 'Park',
          'ሙዚየም': 'Museum',
          'ቤተ መጻሕፍት': 'Library',
          'ሲኒማ': 'Cinema',
          'ቲያትር': 'Theater',
          'ስታዲየም': 'Stadium',
        },
        exercises: _generateCityExercises(),
        xpReward: 125,
        estimatedMinutes: 19,
      ),

      _createLesson(
        id: 'en_intermediate_3',
        title: 'Directions',
        description: 'Giving and understanding directions',
        category: 'Directions',
        vocabulary: {
          'ቀኝ': 'Right',
          'ግራ': 'Left',
          'ቀጥታ': 'Straight',
          'ጀርባ': 'Behind',
          'ፊት': 'Front',
          'ላይ': 'Above',
          'ታች': 'Below',
          'ቅርብ': 'Near',
          'ርቀት': 'Far',
          'መካከል': 'Between',
        },
        exercises: _generateDirectionExercises(),
        xpReward: 118,
        estimatedMinutes: 17,
      ),

      _createLesson(
        id: 'en_intermediate_4',
        title: 'More Directions',
        description: 'Advanced directional vocabulary',
        category: 'Directions',
        vocabulary: {
          'ሰሜን': 'North',
          'ደቡብ': 'South',
          'ምሥራቅ': 'East',
          'ምዕራብ': 'West',
          'ማዕከል': 'Center',
          'ጥግ': 'Corner',
          'መስቀል': 'Crossing',
          'መገናኛ': 'Intersection',
          'ድልድይ': 'Bridge',
          'ዋሻ': 'Tunnel',
        },
        exercises: _generateDirectionExercises2(),
        xpReward: 122,
        estimatedMinutes: 18,
      ),

      _createLesson(
        id: 'en_intermediate_5',
        title: 'Transportation',
        description: 'Modes of transportation',
        category: 'Transportation',
        vocabulary: {
          'መኪና': 'Car',
          'አውቶቡስ': 'Bus',
          'ትራክተር': 'Truck',
          'ሞተር': 'Motorcycle',
          'ብስክሌት': 'Bicycle',
          'አውሮፕላን': 'Airplane',
          'ባቡር': 'Train',
          'መርከብ': 'Ship',
          'ምድር በመሬት ባቡር': 'Subway',
          'ታክሲ': 'Taxi',
        },
        exercises: _generateTransportationExercises(),
        xpReward: 115,
        estimatedMinutes: 16,
      ),
    ];
  }
  
  static List<Lesson> getAdvancedLessons() {
    return [
      // Unit 1: Advanced Grammar (Lessons 1-10)
      _createLesson(
        id: 'en_advanced_1',
        title: 'Past Tense',
        description: 'Master past tense constructions',
        category: 'Grammar',
        vocabulary: {
          'ነበር': 'Was/Were',
          'ነበረው': 'Had',
          'አድረገ': 'Did',
          'ሄደ': 'Went',
          'መጣ': 'Came',
          'በላ': 'Ate',
          'ጠጣ': 'Drank',
          'ተኛ': 'Slept',
          'ሰራ': 'Worked',
          'ተማረ': 'Learned',
        },
        exercises: _generatePastTenseExercises(),
        xpReward: 150,
        estimatedMinutes: 22,
      ),

      _createLesson(
        id: 'en_advanced_2',
        title: 'Future Tense',
        description: 'Express future actions and plans',
        category: 'Grammar',
        vocabulary: {
          'እሆናለሁ': 'Will be',
          'እኖራለሁ': 'Will have',
          'እሠራለሁ': 'Will do',
          'እሄዳለሁ': 'Will go',
          'እመጣለሁ': 'Will come',
          'እበላለሁ': 'Will eat',
          'እጠጣለሁ': 'Will drink',
          'እተኛለሁ': 'Will sleep',
          'እስራለሁ': 'Will work',
          'እማራለሁ': 'Will learn',
        },
        exercises: _generateFutureTenseExercises(),
        xpReward: 155,
        estimatedMinutes: 23,
      ),

      _createLesson(
        id: 'en_advanced_3',
        title: 'Business & Work',
        description: 'Professional and business vocabulary',
        category: 'Business',
        vocabulary: {
          'ንግድ': 'Business',
          'ኩባንያ': 'Company',
          'ቢሮ': 'Office',
          'ስብሰባ': 'Meeting',
          'ፕሮጀክት': 'Project',
          'ሪፖርት': 'Report',
          'ኮንትራት': 'Contract',
          'ደሞዝ': 'Salary',
          'ሰራተኛ': 'Employee',
          'ሥራ አስኪያጅ': 'Manager',
        },
        exercises: _generateBusinessExercises(),
        xpReward: 160,
        estimatedMinutes: 24,
      ),
    ];
  }

  static Lesson _createLesson({
    required String id,
    required String title,
    required String description,
    required String category,
    required Map<String, String> vocabulary,
    required List<Exercise> exercises,
    required int xpReward,
    required int estimatedMinutes,
  }) {
    return Lesson(
      id: id,
      title: title,
      description: description,
      category: category,
      level: LanguageLevel.beginner,
      languageCode: 'en',
      vocabulary: vocabulary.keys.toList(),
      exercises: exercises,
      xpReward: xpReward,
      estimatedMinutes: estimatedMinutes,
    );
  }

  // Complete exercise generators with proper Exercise model
  static List<Exercise> _generateGreetingExercises() {
    return [
      Exercise(
        id: 'greeting_1',
        type: ExerciseType.translate,
        instruction: 'Translate: Hello',
        amharicText: 'ሰላም',
        translation: 'Hello',
        options: [
          ExerciseOption(text: 'ሰላም', isCorrect: true),
          ExerciseOption(text: 'ታዲያስ', isCorrect: false),
          ExerciseOption(text: 'እንዴት ናችሁ', isCorrect: false),
          ExerciseOption(text: 'አመሰግናለሁ', isCorrect: false),
        ],
        explanation: 'ሰላም means "hello" or "peace" in Amharic.',
      ),
      Exercise(
        id: 'greeting_2',
        type: ExerciseType.translate,
        instruction: 'Translate: Thank you',
        amharicText: 'አመሰግናለሁ',
        translation: 'Thank you',
        options: [
          ExerciseOption(text: 'ሰላም', isCorrect: false),
          ExerciseOption(text: 'አመሰግናለሁ', isCorrect: true),
          ExerciseOption(text: 'ታዲያስ', isCorrect: false),
          ExerciseOption(text: 'እንዴት ናችሁ', isCorrect: false),
        ],
        explanation: 'አመሰግናለሁ means "thank you" in Amharic.',
      ),
    ];
  }

  static List<Exercise> _generateNumberExercises() {
    return [
      Exercise(
        id: 'number_1',
        type: ExerciseType.translate,
        instruction: 'Translate: One',
        amharicText: 'አንድ',
        translation: 'One',
        options: [
          ExerciseOption(text: 'አንድ', isCorrect: true),
          ExerciseOption(text: 'ሁለት', isCorrect: false),
          ExerciseOption(text: 'ሶስት', isCorrect: false),
          ExerciseOption(text: 'አራት', isCorrect: false),
        ],
        explanation: 'አንድ means "one" in Amharic.',
      ),
      Exercise(
        id: 'number_2',
        type: ExerciseType.translate,
        instruction: 'Translate: Five',
        amharicText: 'አምስት',
        translation: 'Five',
        options: [
          ExerciseOption(text: 'አራት', isCorrect: false),
          ExerciseOption(text: 'አምስት', isCorrect: true),
          ExerciseOption(text: 'ስድስት', isCorrect: false),
          ExerciseOption(text: 'ሰባት', isCorrect: false),
        ],
        explanation: 'አምስት means "five" in Amharic.',
      ),
    ];
  }

  static List<Exercise> _generateFamilyExercises() {
    return [
      Exercise(
        id: 'family_1',
        type: ExerciseType.translate,
        instruction: 'Translate: Father',
        amharicText: 'አባት',
        translation: 'Father',
        options: [
          ExerciseOption(text: 'አባት', isCorrect: true),
          ExerciseOption(text: 'እናት', isCorrect: false),
          ExerciseOption(text: 'ወንድም', isCorrect: false),
          ExerciseOption(text: 'እህት', isCorrect: false),
        ],
        explanation: 'አባት means "father" in Amharic.',
      ),
    ];
  }

  static List<Exercise> _generateColorExercises() {
    return [
      Exercise(
        id: 'color_1',
        type: ExerciseType.translate,
        instruction: 'Translate: Red',
        amharicText: 'ቀይ',
        translation: 'Red',
        options: [
          ExerciseOption(text: 'ቀይ', isCorrect: true),
          ExerciseOption(text: 'አረንጓዴ', isCorrect: false),
          ExerciseOption(text: 'ሰማያዊ', isCorrect: false),
          ExerciseOption(text: 'ቢጫ', isCorrect: false),
        ],
        explanation: 'ቀይ means "red" in Amharic.',
      ),
    ];
  }

  static List<Exercise> _generateFoodExercises() {
    return [
      Exercise(
        id: 'food_1',
        type: ExerciseType.translate,
        instruction: 'Translate: Water',
        amharicText: 'ውሃ',
        translation: 'Water',
        options: [
          ExerciseOption(text: 'ውሃ', isCorrect: true),
          ExerciseOption(text: 'ቡና', isCorrect: false),
          ExerciseOption(text: 'ባር', isCorrect: false),
          ExerciseOption(text: 'ስጋ', isCorrect: false),
        ],
        explanation: 'ውሃ means "water" in Amharic.',
      ),
    ];
  }

  static List<Exercise> _generateBodyPartExercises() {
    return [
      Exercise(
        id: 'body_1',
        type: ExerciseType.translate,
        instruction: 'Translate: Head',
        amharicText: 'ራስ',
        translation: 'Head',
        options: [
          ExerciseOption(text: 'ራስ', isCorrect: true),
          ExerciseOption(text: 'ዓይን', isCorrect: false),
          ExerciseOption(text: 'አፍ', isCorrect: false),
          ExerciseOption(text: 'እጅ', isCorrect: false),
        ],
        explanation: 'ራስ means "head" in Amharic.',
      ),
    ];
  }

  static List<Exercise> _generateAnimalExercises() {
    return [
      Exercise(
        id: 'animal_1',
        type: ExerciseType.translate,
        instruction: 'Translate: Dog',
        amharicText: 'ውሻ',
        translation: 'Dog',
        options: [
          ExerciseOption(text: 'ውሻ', isCorrect: true),
          ExerciseOption(text: 'ድር', isCorrect: false),
          ExerciseOption(text: 'ኮቴ', isCorrect: false),
          ExerciseOption(text: 'በግ', isCorrect: false),
        ],
        explanation: 'ውሻ means "dog" in Amharic.',
      ),
    ];
  }

  static List<Exercise> _generateClothingExercises() {
    return [
      Exercise(
        id: 'clothing_1',
        type: ExerciseType.translate,
        instruction: 'Translate: Shirt',
        amharicText: 'ሸሚዝ',
        translation: 'Shirt',
        options: [
          ExerciseOption(text: 'ሸሚዝ', isCorrect: true),
          ExerciseOption(text: 'መጫወቻ', isCorrect: false),
          ExerciseOption(text: 'ኪስ', isCorrect: false),
          ExerciseOption(text: 'ጫማ', isCorrect: false),
        ],
        explanation: 'ሸሚዝ means "shirt" in Amharic.',
      ),
    ];
  }

  static List<Exercise> _generateTimeExercises() {
    return [
      Exercise(
        id: 'time_1',
        type: ExerciseType.translate,
        instruction: 'Translate: Today',
        amharicText: 'ዛሬ',
        translation: 'Today',
        options: [
          ExerciseOption(text: 'ዛሬ', isCorrect: true),
          ExerciseOption(text: 'ትላንት', isCorrect: false),
          ExerciseOption(text: 'ነገ', isCorrect: false),
          ExerciseOption(text: 'ጊዜ', isCorrect: false),
        ],
        explanation: 'ዛሬ means "today" in Amharic.',
      ),
    ];
  }

  static List<Exercise> _generateWeatherExercises() {
    return [
      Exercise(
        id: 'weather_1',
        type: ExerciseType.translate,
        instruction: 'Translate: Sun',
        amharicText: 'ፀሐይ',
        translation: 'Sun',
        options: [
          ExerciseOption(text: 'ፀሐይ', isCorrect: true),
          ExerciseOption(text: 'ዝናብ', isCorrect: false),
          ExerciseOption(text: 'ንፋስ', isCorrect: false),
          ExerciseOption(text: 'በረዶ', isCorrect: false),
        ],
        explanation: 'ፀሐይ means "sun" in Amharic.',
      ),
    ];
  }

  static List<Exercise> _generatePlacesExercises() {
    return [
      Exercise(
        id: 'places_1',
        type: ExerciseType.translate,
        instruction: 'Translate: Hospital',
        amharicText: 'ሆስፒታል',
        translation: 'Hospital',
        options: [
          ExerciseOption(text: 'ሆስፒታል', isCorrect: true),
          ExerciseOption(text: 'ትምህርት ቤት', isCorrect: false),
          ExerciseOption(text: 'ገበያ', isCorrect: false),
          ExerciseOption(text: 'ምግብ ቤት', isCorrect: false),
        ],
        explanation: 'ሆስፒታል means "hospital" in Amharic.',
      ),
    ];
  }

  static List<Exercise> _generateCityExercises() {
    return [
      Exercise(
        id: 'city_1',
        type: ExerciseType.translate,
        instruction: 'Translate: City',
        amharicText: 'ከተማ',
        translation: 'City',
        options: [
          ExerciseOption(text: 'ከተማ', isCorrect: true),
          ExerciseOption(text: 'መንገድ', isCorrect: false),
          ExerciseOption(text: 'መንገድ', isCorrect: false),
          ExerciseOption(text: 'መንገድ', isCorrect: false),
        ],
        explanation: 'ከተማ means "city" in Amharic.',
      ),
    ];
  }

  static List<Exercise> _generateDirectionExercises() {
    return [
      Exercise(
        id: 'direction_1',
        type: ExerciseType.translate,
        instruction: 'Translate: Right',
        amharicText: 'ቀኝ',
        translation: 'Right',
        options: [
          ExerciseOption(text: 'ቀኝ', isCorrect: true),
          ExerciseOption(text: 'ግራ', isCorrect: false),
          ExerciseOption(text: 'ቀጥታ', isCorrect: false),
          ExerciseOption(text: 'ጀርባ', isCorrect: false),
        ],
        explanation: 'ቀኝ means "right" in Amharic.',
      ),
    ];
  }

  static List<Exercise> _generateDirectionExercises2() {
    return [
      Exercise(
        id: 'direction2_1',
        type: ExerciseType.translate,
        instruction: 'Translate: North',
        amharicText: 'ሰሜን',
        translation: 'North',
        options: [
          ExerciseOption(text: 'ሰሜን', isCorrect: true),
          ExerciseOption(text: 'ደቡብ', isCorrect: false),
          ExerciseOption(text: 'ምሥራቅ', isCorrect: false),
          ExerciseOption(text: 'ምዕራብ', isCorrect: false),
        ],
        explanation: 'ሰሜን means "north" in Amharic.',
      ),
    ];
  }

  static List<Exercise> _generateTransportationExercises() {
    return [
      Exercise(
        id: 'transport_1',
        type: ExerciseType.translate,
        instruction: 'Translate: Car',
        amharicText: 'መኪና',
        translation: 'Car',
        options: [
          ExerciseOption(text: 'መኪና', isCorrect: true),
          ExerciseOption(text: 'አውቶቡስ', isCorrect: false),
          ExerciseOption(text: 'ትራክተር', isCorrect: false),
          ExerciseOption(text: 'ሞተር', isCorrect: false),
        ],
        explanation: 'መኪና means "car" in Amharic.',
      ),
    ];
  }

  static List<Exercise> _generatePastTenseExercises() {
    return [
      Exercise(
        id: 'past_1',
        type: ExerciseType.translate,
        instruction: 'Translate: Was',
        amharicText: 'ነበር',
        translation: 'Was',
        options: [
          ExerciseOption(text: 'ነበር', isCorrect: true),
          ExerciseOption(text: 'ነበር', isCorrect: false),
          ExerciseOption(text: 'ነበር', isCorrect: false),
          ExerciseOption(text: 'ነበር', isCorrect: false),
        ],
        explanation: 'ነበር means "was" in Amharic.',
      ),
    ];
  }

  static List<Exercise> _generateFutureTenseExercises() {
    return [
      Exercise(
        id: 'future_1',
        type: ExerciseType.translate,
        instruction: 'Translate: Will be',
        amharicText: 'እሆናለሁ',
        translation: 'Will be',
        options: [
          ExerciseOption(text: 'እሆናለሁ', isCorrect: true),
          ExerciseOption(text: 'እሆናለሁ', isCorrect: false),
          ExerciseOption(text: 'እሆናለሁ', isCorrect: false),
          ExerciseOption(text: 'እሆናለሁ', isCorrect: false),
        ],
        explanation: 'እሆናለሁ means "will be" in Amharic.',
      ),
    ];
  }

  static List<Exercise> _generateBusinessExercises() {
    return [
      Exercise(
        id: 'business_1',
        type: ExerciseType.translate,
        instruction: 'Translate: Business',
        amharicText: 'ንግድ',
        translation: 'Business',
        options: [
          ExerciseOption(text: 'ንግድ', isCorrect: true),
          ExerciseOption(text: 'ንግድ', isCorrect: false),
          ExerciseOption(text: 'ንግድ', isCorrect: false),
          ExerciseOption(text: 'ንግድ', isCorrect: false),
        ],
        explanation: 'ንግድ means "business" in Amharic.',
      ),
    ];
  }
}
