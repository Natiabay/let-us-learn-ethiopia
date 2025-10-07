import 'package:tourist_assistive_app/features/language/models/comprehensive_lesson_model.dart';

/// Comprehensive Amharic Lessons for English Speakers
/// Professional tourist-focused lessons with real images and voice integration
class AmharicLessonsData {
  
  /// Get all comprehensive Amharic lessons
  static List<Lesson> getAllAmharicLessons() {
    return [
      // BEGINNER LESSONS
      _createBeginnerLesson1(),
      _createBeginnerLesson2(),
      _createBeginnerLesson3(),
      _createBeginnerLesson4(),
      _createBeginnerLesson5(),
      
      // INTERMEDIATE LESSONS
      _createIntermediateLesson1(),
      _createIntermediateLesson2(),
      _createIntermediateLesson3(),
      _createIntermediateLesson4(),
      _createIntermediateLesson5(),
      
      // ADVANCED LESSONS
      _createAdvancedLesson1(),
      _createAdvancedLesson2(),
      _createAdvancedLesson3(),
      _createAdvancedLesson4(),
      _createAdvancedLesson5(),
    ];
  }

  // BEGINNER LESSONS
  static Lesson _createBeginnerLesson1() {
    return Lesson(
      id: 'amharic_beginner_1',
      title: 'Essential Greetings',
      description: 'Master basic greetings for daily interactions in Ethiopia',
      level: LanguageLevel.beginner,
      languageCode: 'en',
      estimatedMinutes: 8,
      xpReward: 150,
      category: 'Greetings',
      vocabulary: [
        'ሰላም (selam) - Hello/Peace',
        'እንደምን ነህ? (endemen neh?) - How are you? (to male)',
        'እንደምን ነሽ? (endemen nesh?) - How are you? (to female)',
        'ደህና ነኝ (dehna neny) - I am fine',
        'ቻው (chaw) - Goodbye',
        'አመሰግናለሁ (amesegnalehu) - Thank you',
        'እባክህ (ebakih) - Please',
        'ይቅርታ (yiqerta) - Excuse me',
      ],
      exercises: [
        Exercise(
          id: 'ex1_greeting_listen',
          type: ExerciseType.listen,
          instruction: 'Listen and repeat: "ሰላም"',
          amharicText: 'ሰላም',
          translation: 'Hello/Peace',
          audioUrl: 'audio/amharic/beginner/selam.mp3',
          options: [
            ExerciseOption(text: 'ሰላም', isCorrect: true),
            ExerciseOption(text: 'ቻው', isCorrect: false),
            ExerciseOption(text: 'እንደምን', isCorrect: false),
          ],
          correctAnswer: 'ሰላም',
          explanation: 'ሰላም means "hello" or "peace" - the most common greeting in Amharic',
        ),
        Exercise(
          id: 'ex2_greeting_translate',
          type: ExerciseType.translate,
          instruction: 'Translate: "How are you?" (to a male)',
          amharicText: 'እንደምን ነህ?',
          translation: 'How are you? (to male)',
          options: [
            ExerciseOption(text: 'እንደምን ነህ?', isCorrect: true),
            ExerciseOption(text: 'እንደምን ነሽ?', isCorrect: false),
            ExerciseOption(text: 'ደህና ነኝ', isCorrect: false),
          ],
          correctAnswer: 'እንደምን ነህ?',
          explanation: 'እንደምን ነህ? is used when asking "How are you?" to a male',
        ),
        Exercise(
          id: 'ex3_greeting_response',
          type: ExerciseType.multipleChoice,
          instruction: 'What is the correct response to "እንደምን ነህ?"',
          amharicText: 'እንደምን ነህ?',
          translation: 'How are you?',
          options: [
            ExerciseOption(text: 'ደህና ነኝ', isCorrect: true),
            ExerciseOption(text: 'ሰላም', isCorrect: false),
            ExerciseOption(text: 'ቻው', isCorrect: false),
          ],
          correctAnswer: 'ደህና ነኝ',
          explanation: 'ደህና ነኝ means "I am fine" - the standard response',
        ),
      ],
    );
  }

  static Lesson _createBeginnerLesson2() {
    return Lesson(
      id: 'amharic_beginner_2',
      title: 'Numbers 1-20',
      description: 'Learn essential numbers for shopping, prices, and basic counting',
      level: LanguageLevel.beginner,
      languageCode: 'en',
      estimatedMinutes: 10,
      xpReward: 180,
      category: 'Numbers',
      vocabulary: [
        'አንድ (and) - One',
        'ሁለት (hulet) - Two',
        'ሦስት (sost) - Three',
        'አራት (arat) - Four',
        'አምስት (amest) - Five',
        'ስድስት (sedest) - Six',
        'ሰባት (sebat) - Seven',
        'ስምንት (semint) - Eight',
        'ዘጠኝ (zeten) - Nine',
        'አስር (asir) - Ten',
        'አስራ አንድ (asra and) - Eleven',
        'ሃያ (haya) - Twenty',
      ],
      exercises: [
        Exercise(
          id: 'ex1_number_listen',
          type: ExerciseType.listen,
          instruction: 'Listen and identify the number: "ሁለት"',
          amharicText: 'ሁለት',
          translation: 'Two',
          audioUrl: 'audio/amharic/beginner/hulet.mp3',
          options: [
            ExerciseOption(text: 'One', isCorrect: false),
            ExerciseOption(text: 'Two', isCorrect: true),
            ExerciseOption(text: 'Three', isCorrect: false),
            ExerciseOption(text: 'Four', isCorrect: false),
          ],
          correctAnswer: 'Two',
          explanation: 'ሁለት means "two" in Amharic',
        ),
        Exercise(
          id: 'ex2_number_pronunciation',
          type: ExerciseType.pronunciation,
          instruction: 'Practice pronouncing: "አምስት"',
          amharicText: 'አምስት',
          translation: 'Five',
          audioUrl: 'audio/amharic/beginner/amest.mp3',
          options: [],
          correctAnswer: 'amest',
          explanation: 'አምስት means "five" - pronounced "ah-mest"',
        ),
      ],
    );
  }

  static Lesson _createBeginnerLesson3() {
    return Lesson(
      id: 'amharic_beginner_3',
      title: 'Family Members',
      description: 'Learn family relationships and how to address people respectfully',
      level: LanguageLevel.beginner,
      languageCode: 'en',
      estimatedMinutes: 12,
      xpReward: 200,
      category: 'Family',
      vocabulary: [
        'አባት (abat) - Father',
        'እናት (enat) - Mother',
        'ወንድም (wendim) - Brother',
        'እህት (ehet) - Sister',
        'ልጅ (lij) - Child',
        'ልጅ ወንድ (lij wend) - Son',
        'ልጅ ሴት (lij set) - Daughter',
        'አያት (ayat) - Grandfather',
        'ጓደኛ (gwadenya) - Friend',
      ],
      exercises: [
        Exercise(
          id: 'ex1_family_identification',
          type: ExerciseType.multipleChoice,
          instruction: 'What is "አባት" in English?',
          amharicText: 'አባት',
          translation: 'Father',
          audioUrl: 'audio/amharic/beginner/abat.mp3',
          options: [
            ExerciseOption(text: 'Mother', isCorrect: false),
            ExerciseOption(text: 'Father', isCorrect: true),
            ExerciseOption(text: 'Brother', isCorrect: false),
            ExerciseOption(text: 'Sister', isCorrect: false),
          ],
          correctAnswer: 'Father',
          explanation: 'አባት means "father" in Amharic',
        ),
      ],
    );
  }

  static Lesson _createBeginnerLesson4() {
    return Lesson(
      id: 'amharic_beginner_4',
      title: 'Colors',
      description: 'Learn colors to describe objects, clothing, and surroundings',
      level: LanguageLevel.beginner,
      languageCode: 'en',
      estimatedMinutes: 9,
      xpReward: 160,
      category: 'Colors',
      vocabulary: [
        'ቀይ (qey) - Red',
        'ሰማያዊ (semayawi) - Blue',
        'አረንጓዴ (arengewade) - Green',
        'ቢጫ (bicha) - Yellow',
        'ጥቁር (tequr) - Black',
        'ነጭ (nech) - White',
        'ቡናዊ (bunawi) - Brown',
        'ሐምራዊ (hamrawi) - Orange',
      ],
      exercises: [
        Exercise(
          id: 'ex1_color_identification',
          type: ExerciseType.multipleChoice,
          instruction: 'What color is "ቀይ"?',
          amharicText: 'ቀይ',
          translation: 'Red',
          audioUrl: 'audio/amharic/beginner/qey.mp3',
          options: [
            ExerciseOption(text: 'Blue', isCorrect: false),
            ExerciseOption(text: 'Red', isCorrect: true),
            ExerciseOption(text: 'Green', isCorrect: false),
            ExerciseOption(text: 'Yellow', isCorrect: false),
          ],
          correctAnswer: 'Red',
          explanation: 'ቀይ means "red" in Amharic',
        ),
      ],
    );
  }

  static Lesson _createBeginnerLesson5() {
    return Lesson(
      id: 'amharic_beginner_5',
      title: 'Food and Drinks',
      description: 'Essential food vocabulary for dining and shopping',
      level: LanguageLevel.beginner,
      languageCode: 'en',
      estimatedMinutes: 15,
      xpReward: 220,
      category: 'Food',
      vocabulary: [
        'አመር (amer) - Bread',
        'ውሃ (wha) - Water',
        'ቡና (buna) - Coffee',
        'ሻይ (shay) - Tea',
        'ማር (mar) - Honey',
        'ስኳር (sukar) - Sugar',
        'ጨው (chew) - Salt',
        'በርበሬ (berbere) - Spice',
        'እንስሳ (insisa) - Meat',
        'ዶሮ (doro) - Chicken',
      ],
      exercises: [
        Exercise(
          id: 'ex1_food_identification',
          type: ExerciseType.multipleChoice,
          instruction: 'What is "ቡና" in English?',
          amharicText: 'ቡና',
          translation: 'Coffee',
          audioUrl: 'audio/amharic/beginner/buna.mp3',
          options: [
            ExerciseOption(text: 'Tea', isCorrect: false),
            ExerciseOption(text: 'Coffee', isCorrect: true),
            ExerciseOption(text: 'Water', isCorrect: false),
            ExerciseOption(text: 'Milk', isCorrect: false),
          ],
          correctAnswer: 'Coffee',
          explanation: 'ቡና means "coffee" - very important in Ethiopian culture',
        ),
      ],
    );
  }

  // INTERMEDIATE LESSONS
  static Lesson _createIntermediateLesson1() {
    return Lesson(
      id: 'amharic_intermediate_1',
      title: 'Shopping and Markets',
      description: 'Master shopping vocabulary and negotiation skills for Ethiopian markets',
      level: LanguageLevel.intermediate,
      languageCode: 'en',
      estimatedMinutes: 15,
      xpReward: 300,
      category: 'Shopping',
      vocabulary: [
        'ገበያ (gebea) - Market',
        'ሱቅ (suq) - Shop',
        'ዋጋ (waga) - Price',
        'ተሸጣ (tesheta) - Seller',
        'ገዢ (gezi) - Buyer',
        'ገንዘብ (genzeb) - Money',
        'ብር (birr) - Ethiopian currency',
        'ምን ዋጋ ነው? (min waga new?) - What is the price?',
        'በጣም ውድ ነው (betam wud new) - It is very expensive',
        'ተቀናጅ (teqenaj) - Discount',
      ],
      exercises: [
        Exercise(
          id: 'ex1_shopping_price',
          type: ExerciseType.translate,
          instruction: 'How do you ask "What is the price?" in Amharic?',
          amharicText: 'ምን ዋጋ ነው?',
          translation: 'What is the price?',
          audioUrl: 'audio/amharic/intermediate/min_waga_new.mp3',
          options: [
            ExerciseOption(text: 'ምን ዋጋ ነው?', isCorrect: true),
            ExerciseOption(text: 'በጣም ውድ ነው', isCorrect: false),
            ExerciseOption(text: 'እባክህ ተቀናጅ', isCorrect: false),
          ],
          correctAnswer: 'ምን ዋጋ ነው?',
          explanation: 'ምን ዋጋ ነው? is the correct way to ask for the price',
        ),
      ],
    );
  }

  static Lesson _createIntermediateLesson2() {
    return Lesson(
      id: 'amharic_intermediate_2',
      title: 'Transportation',
      description: 'Learn transportation vocabulary for getting around Ethiopia',
      level: LanguageLevel.intermediate,
      languageCode: 'en',
      estimatedMinutes: 12,
      xpReward: 250,
      category: 'Transportation',
      vocabulary: [
        'መኪና (mekina) - Car',
        'አውቶቡስ (awtobus) - Bus',
        'ታክሲ (taksi) - Taxi',
        'ባቡር (babur) - Train',
        'አውሮፕላን (awroplan) - Airplane',
        'መንገድ (menged) - Road',
        'ጣቢያ (tabiya) - Station',
        'ወደ የት ነው? (wede yet new?) - Where are you going?',
        'ወደ አዲስ አበባ (wede adis abeba) - To Addis Ababa',
      ],
      exercises: [
        Exercise(
          id: 'ex1_transport_destination',
          type: ExerciseType.translate,
          instruction: 'How do you say "To Addis Ababa" in Amharic?',
          amharicText: 'ወደ አዲስ አበባ',
          translation: 'To Addis Ababa',
          audioUrl: 'audio/amharic/intermediate/wede_adis_abeba.mp3',
          options: [
            ExerciseOption(text: 'ወደ አዲስ አበባ', isCorrect: true),
            ExerciseOption(text: 'ወደ ላሊበላ', isCorrect: false),
            ExerciseOption(text: 'ወደ አክሱም', isCorrect: false),
          ],
          correctAnswer: 'ወደ አዲስ አበባ',
          explanation: 'ወደ አዲስ አበባ means "To Addis Ababa"',
        ),
      ],
    );
  }

  static Lesson _createIntermediateLesson3() {
    return Lesson(
      id: 'amharic_intermediate_3',
      title: 'Accommodation',
      description: 'Learn hotel and accommodation vocabulary for booking and staying',
      level: LanguageLevel.intermediate,
      languageCode: 'en',
      estimatedMinutes: 14,
      xpReward: 280,
      category: 'Accommodation',
      vocabulary: [
        'ሆቴል (hotel) - Hotel',
        'መኝታ (menjta) - Room',
        'አንድ ሰው (and sew) - Single person',
        'ሁለት ሰው (hulet sew) - Two people',
        'ለስንት ቀን? (lesint qen?) - For how many days?',
        'አንድ ቀን (and qen) - One day',
        'ሁለት ቀን (hulet qen) - Two days',
        'ምን ዋጋ ነው? (min waga new?) - What is the price?',
      ],
      exercises: [
        Exercise(
          id: 'ex1_accommodation_booking',
          type: ExerciseType.translate,
          instruction: 'How do you say "For how many days?" in Amharic?',
          amharicText: 'ለስንት ቀን?',
          translation: 'For how many days?',
          audioUrl: 'audio/amharic/intermediate/lesint_qen.mp3',
          options: [
            ExerciseOption(text: 'ለስንት ቀን?', isCorrect: true),
            ExerciseOption(text: 'ምን ዋጋ ነው?', isCorrect: false),
            ExerciseOption(text: 'የት ነው?', isCorrect: false),
          ],
          correctAnswer: 'ለስንት ቀን?',
          explanation: 'ለስንት ቀን? means "For how many days?"',
        ),
      ],
    );
  }

  static Lesson _createIntermediateLesson4() {
    return Lesson(
      id: 'amharic_intermediate_4',
      title: 'Emergency Situations',
      description: 'Essential phrases for emergency situations and getting help',
      level: LanguageLevel.intermediate,
      languageCode: 'en',
      estimatedMinutes: 10,
      xpReward: 200,
      category: 'Emergency',
      vocabulary: [
        'እርዳታ (erdeta) - Help',
        'አስቸኳይ (aschekway) - Emergency',
        'ዶክተር (dokter) - Doctor',
        'ሆስፒታል (hospital) - Hospital',
        'ፖሊስ (polis) - Police',
        'እርዳታ ያስፈልገኛል (erdeta yasfelgenyal) - I need help',
        'ዶክተር ያስፈልገኛል (dokter yasfelgenyal) - I need a doctor',
        'የት ነው ሆስፒታል? (yet new hospital?) - Where is the hospital?',
      ],
      exercises: [
        Exercise(
          id: 'ex1_emergency_help',
          type: ExerciseType.translate,
          instruction: 'How do you say "I need help" in Amharic?',
          amharicText: 'እርዳታ ያስፈልገኛል',
          translation: 'I need help',
          audioUrl: 'audio/amharic/intermediate/erdeta_yasfelgenyal.mp3',
          options: [
            ExerciseOption(text: 'እርዳታ ያስፈልገኛል', isCorrect: true),
            ExerciseOption(text: 'ዶክተር ያስፈልገኛል', isCorrect: false),
            ExerciseOption(text: 'ፖሊስ ይጥራ', isCorrect: false),
          ],
          correctAnswer: 'እርዳታ ያስፈልገኛል',
          explanation: 'እርዳታ ያስፈልገኛል means "I need help"',
        ),
      ],
    );
  }

  static Lesson _createIntermediateLesson5() {
    return Lesson(
      id: 'amharic_intermediate_5',
      title: 'Cultural Etiquette',
      description: 'Learn important cultural norms and respectful behavior in Ethiopia',
      level: LanguageLevel.intermediate,
      languageCode: 'en',
      estimatedMinutes: 16,
      xpReward: 320,
      category: 'Culture',
      vocabulary: [
        'እባክህ (ebakih) - Please',
        'አመሰግናለሁ (amesegnalehu) - Thank you',
        'ይቅርታ (yiqerta) - Excuse me',
        'አይ (ay) - No',
        'አዎ (awo) - Yes',
        'እባክህ ይቅርታ (ebakih yiqerta) - Please excuse me',
        'አመሰግናለሁ በጣም (amesegnalehu betam) - Thank you very much',
        'እንደምን ነህ? (endemen neh?) - How are you?',
        'ደህና ነኝ (dehna neny) - I am fine',
      ],
      exercises: [
        Exercise(
          id: 'ex1_cultural_politeness',
          type: ExerciseType.translate,
          instruction: 'How do you say "Please excuse me" in Amharic?',
          amharicText: 'እባክህ ይቅርታ',
          translation: 'Please excuse me',
          audioUrl: 'audio/amharic/intermediate/ebakih_yiqerta.mp3',
          options: [
            ExerciseOption(text: 'እባክህ ይቅርታ', isCorrect: true),
            ExerciseOption(text: 'አመሰግናለሁ', isCorrect: false),
            ExerciseOption(text: 'ይቅርታ', isCorrect: false),
          ],
          correctAnswer: 'እባክህ ይቅርታ',
          explanation: 'እባክህ ይቅርታ means "Please excuse me"',
        ),
      ],
    );
  }

  // ADVANCED LESSONS
  static Lesson _createAdvancedLesson1() {
    return Lesson(
      id: 'amharic_advanced_1',
      title: 'Business Communication',
      description: 'Master professional Amharic for business meetings and formal interactions',
      level: LanguageLevel.advanced,
      languageCode: 'en',
      estimatedMinutes: 20,
      xpReward: 400,
      category: 'Business',
      vocabulary: [
        'ስራ (sra) - Work',
        'መስራት (mesrat) - To work',
        'ኩባንያ (kubanya) - Company',
        'አመራር (amerar) - Management',
        'ስራ አለኝ (sra aleny) - I have work',
        'ኩባንያ አለኝ (kubanya aleny) - I have a company',
        'አመራር አለኝ (amerar aleny) - I have management',
      ],
      exercises: [
        Exercise(
          id: 'ex1_business_work',
          type: ExerciseType.translate,
          instruction: 'How do you say "I have work" in Amharic?',
          amharicText: 'ስራ አለኝ',
          translation: 'I have work',
          audioUrl: 'audio/amharic/advanced/sra_aleny.mp3',
          options: [
            ExerciseOption(text: 'ስራ አለኝ', isCorrect: true),
            ExerciseOption(text: 'ስራ የለኝም', isCorrect: false),
            ExerciseOption(text: 'ኩባንያ አለኝ', isCorrect: false),
          ],
          correctAnswer: 'ስራ አለኝ',
          explanation: 'ስራ አለኝ means "I have work"',
        ),
      ],
    );
  }

  static Lesson _createAdvancedLesson2() {
    return Lesson(
      id: 'amharic_advanced_2',
      title: 'Tourism and Heritage',
      description: 'Learn vocabulary for discussing Ethiopia\'s rich cultural heritage',
      level: LanguageLevel.advanced,
      languageCode: 'en',
      estimatedMinutes: 18,
      xpReward: 380,
      category: 'Tourism',
      vocabulary: [
        'ቱሪዝም (turizm) - Tourism',
        'ቱሪስት (turist) - Tourist',
        'ታሪክ (tarik) - History',
        'ባህል (bahil) - Culture',
        'አርክቴክቸር (arkitekcher) - Architecture',
        'ሙዚየም (muzeym) - Museum',
        'ቤተ ክርስቲያን (bete kristiyan) - Church',
        'የታሪክ ቦታ (yetarik bota) - Historical place',
      ],
      exercises: [
        Exercise(
          id: 'ex1_tourism_history',
          type: ExerciseType.translate,
          instruction: 'How do you say "Historical place" in Amharic?',
          amharicText: 'የታሪክ ቦታ',
          translation: 'Historical place',
          audioUrl: 'audio/amharic/advanced/yetarik_bota.mp3',
          options: [
            ExerciseOption(text: 'የታሪክ ቦታ', isCorrect: true),
            ExerciseOption(text: 'የባህል ቦታ', isCorrect: false),
            ExerciseOption(text: 'የአርክቴክቸር ቦታ', isCorrect: false),
          ],
          correctAnswer: 'የታሪክ ቦታ',
          explanation: 'የታሪክ ቦታ means "Historical place"',
        ),
      ],
    );
  }

  static Lesson _createAdvancedLesson3() {
    return Lesson(
      id: 'amharic_advanced_3',
      title: 'Technology and Modern Life',
      description: 'Learn modern technology vocabulary and digital communication',
      level: LanguageLevel.advanced,
      languageCode: 'en',
      estimatedMinutes: 16,
      xpReward: 350,
      category: 'Technology',
      vocabulary: [
        'ቴክኖሎጂ (teknoloji) - Technology',
        'ኮምፒዩተር (kompiyuter) - Computer',
        'ሞባይል (mobayl) - Mobile phone',
        'ኢንተርኔት (internet) - Internet',
        'ኢሜይል (imeyl) - Email',
        'ሙዚቃ (muziqa) - Music',
        'መዝሙር (mezmur) - Song',
      ],
      exercises: [
        Exercise(
          id: 'ex1_technology_computer',
          type: ExerciseType.translate,
          instruction: 'How do you say "Computer" in Amharic?',
          amharicText: 'ኮምፒዩተር',
          translation: 'Computer',
          audioUrl: 'audio/amharic/advanced/kompiyuter.mp3',
          options: [
            ExerciseOption(text: 'ኮምፒዩተር', isCorrect: true),
            ExerciseOption(text: 'ሞባይል', isCorrect: false),
            ExerciseOption(text: 'ኢንተርኔት', isCorrect: false),
          ],
          correctAnswer: 'ኮምፒዩተር',
          explanation: 'ኮምፒዩተር means "Computer"',
        ),
      ],
    );
  }

  static Lesson _createAdvancedLesson4() {
    return Lesson(
      id: 'amharic_advanced_4',
      title: 'Health and Medical',
      description: 'Learn medical vocabulary for health situations and doctor visits',
      level: LanguageLevel.advanced,
      languageCode: 'en',
      estimatedMinutes: 14,
      xpReward: 300,
      category: 'Health',
      vocabulary: [
        'ጤና (tena) - Health',
        'በሽታ (beshita) - Disease',
        'ህመም (hmmam) - Pain',
        'ዶክተር (dokter) - Doctor',
        'ነርስ (ners) - Nurse',
        'ፋርማሲ (farmasi) - Pharmacy',
        'መድሃኒት (medhanit) - Medicine',
        'ጤና አለኝ (tena aleny) - I have health',
        'በሽታ አለኝ (beshita aleny) - I have disease',
      ],
      exercises: [
        Exercise(
          id: 'ex1_health_health',
          type: ExerciseType.translate,
          instruction: 'How do you say "I have health" in Amharic?',
          amharicText: 'ጤና አለኝ',
          translation: 'I have health',
          audioUrl: 'audio/amharic/advanced/tena_aleny.mp3',
          options: [
            ExerciseOption(text: 'ጤና አለኝ', isCorrect: true),
            ExerciseOption(text: 'ጤና የለኝም', isCorrect: false),
            ExerciseOption(text: 'በሽታ አለኝ', isCorrect: false),
          ],
          correctAnswer: 'ጤና አለኝ',
          explanation: 'ጤና አለኝ means "I have health"',
        ),
      ],
    );
  }

  static Lesson _createAdvancedLesson5() {
    return Lesson(
      id: 'amharic_advanced_5',
      title: 'Education and Learning',
      description: 'Learn vocabulary for discussing education and academic topics',
      level: LanguageLevel.advanced,
      languageCode: 'en',
      estimatedMinutes: 17,
      xpReward: 370,
      category: 'Education',
      vocabulary: [
        'ትምህርት (tmhrt) - Education',
        'ትምህርት ቤት (tmhrt bet) - School',
        'ዩኒቨርሲቲ (yuniversiti) - University',
        'መምህር (memhr) - Teacher',
        'ተማሪ (temari) - Student',
        'መጽሐፍ (metshaf) - Book',
        'ጽሑፍ (tshuf) - Writing',
        'ንባት (nbat) - Reading',
        'መማር (memar) - Learning',
      ],
      exercises: [
        Exercise(
          id: 'ex1_education_learning',
          type: ExerciseType.translate,
          instruction: 'How do you say "I have learning" in Amharic?',
          amharicText: 'መማር አለኝ',
          translation: 'I have learning',
          audioUrl: 'audio/amharic/advanced/memar_aleny.mp3',
          options: [
            ExerciseOption(text: 'መማር አለኝ', isCorrect: true),
            ExerciseOption(text: 'መማር የለኝም', isCorrect: false),
            ExerciseOption(text: 'ትምህርት አለኝ', isCorrect: false),
          ],
          correctAnswer: 'መማር አለኝ',
          explanation: 'መማር አለኝ means "I have learning"',
        ),
      ],
    );
  }
}
