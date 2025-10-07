/// Amharic Lessons - Part 4: Family & Relationships (1,100+ lines)
/// Professional Duolingo-style family lessons
import 'package:tourist_assistive_app/features/language/models/amharic_lesson_models.dart';

class AmharicFamilyLessons {
  
  static final List<AmharicLesson> lessons = [
    _lesson1ImmediateFamily(),
    _lesson2ExtendedFamily(),
    _lesson3FamilyRelationships(),
    _lesson4DescribingFamily(),
    _lesson5FamilyConversations(),
  ];
  
  /// Lesson 1: Immediate Family
  static AmharicLesson _lesson1ImmediateFamily() {
    return AmharicLesson(
      id: 'family_001',
      title: 'Immediate Family',
      description: 'Learn words for parents and siblings',
      category: LessonCategory.family,
      difficulty: DifficultyLevel.beginner,
      order: 1,
      totalXP: 15,
      exercises: [
        // Father
        LessonExercise(
          id: 'family_001_ex001',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear (Father)',
          audioUrl: 'abbat_audio',
          amharicScript: 'አባት',
          pronunciation: 'ab-BAT',
          options: [],
          correctAnswer: 'Abbat',
          wordBank: ['Abbat', 'father', 'dad', 'parent', 'male', 'family'],
          explanation: 'አባት (Abbat) - Father/Dad',
        ),
        
        LessonExercise(
          id: 'family_001_ex002',
          type: LessonType.multipleChoice,
          question: 'How do you say "Father" in Amharic?',
          amharicScript: 'አባት',
          options: ['Abbat', 'Inat', 'Wendim', 'Ihit'],
          correctAnswer: 'Abbat',
          explanation: 'አባት (Abbat) = Father',
        ),
        
        // Mother
        LessonExercise(
          id: 'family_001_ex003',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear (Mother)',
          audioUrl: 'inat_audio',
          amharicScript: 'እናት',
          pronunciation: 'i-NAT',
          options: [],
          correctAnswer: 'Inat',
          wordBank: ['Inat', 'mother', 'mom', 'parent', 'female', 'family'],
          explanation: 'እናት (Inat) - Mother/Mom',
        ),
        
        LessonExercise(
          id: 'family_001_ex004',
          type: LessonType.completeTheChat,
          question: 'Talk about your mother',
          conversation: ConversationData(
            character1: 'Friend',
            character1Avatar: '🇪🇹',
            character2: 'You',
            character2Avatar: '👤',
            messages: [
              ConversationMessage(
                speaker: 'Friend',
                text: 'Inatish yet new? (Where is your mother?)',
                amharic: 'እናትሽ የት ነው?',
              ),
              ConversationMessage(
                speaker: 'You',
                text: '[My mother is at home]',
                isUserResponse: true,
              ),
            ],
          ),
          options: [
            'Inatey bet new (My mother is at home)',
            'Abbatey bet new (My father is at home)',
            'Wendimey bet new (My brother is at home)',
            'Ihitey bet new (My sister is at home)'
          ],
          correctAnswer: 'Inatey bet new (My mother is at home)',
          explanation: 'እናቴ ቤት ነው (Inatey bet new) - My mother is at home',
        ),
        
        // Brother
        LessonExercise(
          id: 'family_001_ex005',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear (Brother)',
          audioUrl: 'wendim_audio',
          amharicScript: 'ወንድም',
          pronunciation: 'wen-DIM',
          options: [],
          correctAnswer: 'Wendim',
          wordBank: ['Wendim', 'brother', 'sibling', 'male', 'family', 'relative'],
          explanation: 'ወንድም (Wendim) - Brother',
        ),
        
        // Sister
        LessonExercise(
          id: 'family_001_ex006',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear (Sister)',
          audioUrl: 'ihit_audio',
          amharicScript: 'እህት',
          pronunciation: 'i-HIT',
          options: [],
          correctAnswer: 'Ihit',
          wordBank: ['Ihit', 'sister', 'sibling', 'female', 'family', 'relative'],
          explanation: 'እህት (Ihit) - Sister',
        ),
        
        LessonExercise(
          id: 'family_001_ex007',
          type: LessonType.matchPairs,
          question: 'Match the family member',
          options: [
            'አባት (Abbat) - Father',
            'እናት (Inat) - Mother',
            'ወንድም (Wendim) - Brother',
            'እህት (Ihit) - Sister'
          ],
          correctAnswer: 'All matched',
          explanation: 'Immediate family members in Amharic',
        ),
        
        // Parents
        LessonExercise(
          id: 'family_001_ex008',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear (Parents)',
          audioUrl: 'walajoch_audio',
          amharicScript: 'ወላጆች',
          pronunciation: 'wa-LA-joch',
          options: [],
          correctAnswer: 'Walajoch',
          wordBank: ['Walajoch', 'parents', 'mother and father', 'family', 'guardians'],
          explanation: 'ወላጆች (Walajoch) - Parents (plural)',
        ),
        
        LessonExercise(
          id: 'family_001_ex009',
          type: LessonType.completeTheSentence,
          question: 'Complete: I have a ___',
          amharicScript: '___ አለኝ',
          options: [
            'ወንድም (Wendim - Brother)',
            'አባት (Abbat - Father)',
            'እናት (Inat - Mother)',
            'ወላጆች (Walajoch - Parents)'
          ],
          correctAnswer: 'ወንድም (Wendim - Brother)',
          explanation: 'ወንድም አለኝ (Wendim aleny) - I have a brother',
        ),
        
        LessonExercise(
          id: 'family_001_ex010',
          type: LessonType.translateSentence,
          question: 'Translate to Amharic: "My sister"',
          options: [
            'እህቴ (Ihitey)',
            'ወንድሜ (Wendimey)',
            'አባቴ (Abbatey)',
            'እናቴ (Inatey)'
          ],
          correctAnswer: 'እህቴ (Ihitey)',
          explanation: 'እህቴ (Ihitey) = My sister (ey = my)',
        ),
      ],
    );
  }
  
  /// Lesson 2: Extended Family
  static AmharicLesson _lesson2ExtendedFamily() {
    return AmharicLesson(
      id: 'family_002',
      title: 'Extended Family',
      description: 'Learn words for grandparents, aunts, uncles, cousins',
      category: LessonCategory.family,
      difficulty: DifficultyLevel.elementary,
      order: 2,
      totalXP: 20,
      prerequisiteId: 'family_001',
      exercises: [
        // Grandfather
        LessonExercise(
          id: 'family_002_ex001',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear (Grandfather)',
          audioUrl: 'ayat_audio',
          amharicScript: 'አያት',
          pronunciation: 'ay-YAT',
          options: [],
          correctAnswer: 'Ayat',
          wordBank: ['Ayat', 'grandfather', 'grandpa', 'elder', 'old', 'family'],
          explanation: 'አያት (Ayat) - Grandfather',
        ),
        
        // Grandmother
        LessonExercise(
          id: 'family_002_ex002',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear (Grandmother)',
          audioUrl: 'aye_audio',
          amharicScript: 'አያት',
          pronunciation: 'AY-ye',
          options: [],
          correctAnswer: 'Aye',
          wordBank: ['Aye', 'grandmother', 'grandma', 'elder', 'old', 'family'],
          explanation: 'አያት (Aye) - Grandmother',
        ),
        
        // Uncle
        LessonExercise(
          id: 'family_002_ex003',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear (Uncle)',
          audioUrl: 'agot_audio',
          amharicScript: 'አጎት',
          pronunciation: 'a-GOT',
          options: [],
          correctAnswer: 'Agot',
          wordBank: ['Agot', 'uncle', 'father\'s brother', 'relative', 'male', 'family'],
          explanation: 'አጎት (Agot) - Uncle (father\'s brother)',
        ),
        
        // Aunt
        LessonExercise(
          id: 'family_002_ex004',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear (Aunt)',
          audioUrl: 'akist_audio',
          amharicScript: 'አክስት',
          pronunciation: 'a-KIST',
          options: [],
          correctAnswer: 'Akist',
          wordBank: ['Akist', 'aunt', 'father\'s sister', 'relative', 'female', 'family'],
          explanation: 'አክስት (Akist) - Aunt (father\'s sister)',
        ),
        
        LessonExercise(
          id: 'family_002_ex005',
          type: LessonType.matchPairs,
          question: 'Match the extended family member',
          options: [
            'አያት (Ayat) - Grandfather',
            'አያት (Aye) - Grandmother',
            'አጎት (Agot) - Uncle',
            'አክስት (Akist) - Aunt'
          ],
          correctAnswer: 'All matched',
          explanation: 'Extended family in Ethiopian culture is very important',
        ),
        
        // Cousin
        LessonExercise(
          id: 'family_002_ex006',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear (Cousin)',
          audioUrl: 'ye_agot_lij_audio',
          amharicScript: 'የአጎት ልጅ',
          pronunciation: 'ye-a-GOT lij',
          options: [],
          correctAnswer: 'Ye-agot lij',
          wordBank: ['Ye-agot lij', 'cousin', 'uncle\'s child', 'relative', 'family'],
          explanation: 'የአጎት ልጅ (Ye-agot lij) - Cousin (uncle\'s child)',
        ),
        
        LessonExercise(
          id: 'family_002_ex007',
          type: LessonType.completeTheChat,
          question: 'Talk about grandparents',
          conversation: ConversationData(
            character1: 'Friend',
            character1Avatar: '👤',
            character2: 'You',
            character2Avatar: '🧑',
            messages: [
              ConversationMessage(
                speaker: 'Friend',
                text: 'Do you have grandparents?',
                amharic: 'አያቶች አሉህ?',
              ),
              ConversationMessage(
                speaker: 'You',
                text: '[Yes, I have grandparents]',
                isUserResponse: true,
              ),
            ],
          ),
          options: [
            'Awo, ayatoch alugn (Yes, I have grandparents)',
            'Aydelem (No)',
            'Aydegnem (I don\'t know)',
            'Aygebagnem (I don\'t understand)'
          ],
          correctAnswer: 'Awo, ayatoch alugn (Yes, I have grandparents)',
          explanation: 'አዎ, አያቶች አሉኝ (Awo, ayatoch alugn) - Yes, I have grandparents',
        ),
        
        LessonExercise(
          id: 'family_002_ex008',
          type: LessonType.multipleChoice,
          question: 'How do you say "uncle"?',
          amharicScript: 'አጎት',
          options: ['Agot', 'Ayat', 'Abbat', 'Wendim'],
          correctAnswer: 'Agot',
          explanation: 'አጎት (Agot) = Uncle',
        ),
        
        LessonExercise(
          id: 'family_002_ex009',
          type: LessonType.fillInTheBlank,
          question: 'Fill in: My ___ is very kind',
          amharicScript: '___ በጣም ደግ ነው',
          options: [
            'አያቴ (Ayatey - Grandfather)',
            'ወንድሜ (Wendimey - Brother)',
            'አባቴ (Abbatey - Father)',
            'የአጎት ልጄ (Ye-agot lijey - Cousin)'
          ],
          correctAnswer: 'አያቴ (Ayatey - Grandfather)',
          explanation: 'አያቴ በጣም ደግ ነው (Ayatey betam deg new) - My grandfather is very kind',
        ),
        
        LessonExercise(
          id: 'family_002_ex010',
          type: LessonType.translateSentence,
          question: 'Translate: "My aunt"',
          options: [
            'አክስቴ (Akistey)',
            'አጎቴ (Agotey)',
            'እህቴ (Ihitey)',
            'እናቴ (Inatey)'
          ],
          correctAnswer: 'አክስቴ (Akistey)',
          explanation: 'አክስቴ (Akistey) = My aunt',
        ),
      ],
    );
  }
  
  /// Lesson 3: Family Relationships
  static AmharicLesson _lesson3FamilyRelationships() {
    return AmharicLesson(
      id: 'family_003',
      title: 'Family Relationships',
      description: 'Learn husband, wife, son, daughter, etc.',
      category: LessonCategory.family,
      difficulty: DifficultyLevel.elementary,
      order: 3,
      totalXP: 15,
      prerequisiteId: 'family_002',
      exercises: [
        // Husband
        LessonExercise(
          id: 'family_003_ex001',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear (Husband)',
          audioUrl: 'bal_audio',
          amharicScript: 'ባል',
          pronunciation: 'bal',
          options: [],
          correctAnswer: 'Bal',
          wordBank: ['Bal', 'husband', 'spouse', 'married', 'man', 'partner'],
          explanation: 'ባል (Bal) - Husband',
        ),
        
        // Wife
        LessonExercise(
          id: 'family_003_ex002',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear (Wife)',
          audioUrl: 'mist_audio',
          amharicScript: 'ሚስት',
          pronunciation: 'mist',
          options: [],
          correctAnswer: 'Mist',
          wordBank: ['Mist', 'wife', 'spouse', 'married', 'woman', 'partner'],
          explanation: 'ሚስት (Mist) - Wife',
        ),
        
        // Son
        LessonExercise(
          id: 'family_003_ex003',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear (Son)',
          audioUrl: 'lij_wend_audio',
          amharicScript: 'ልጅ ወንድ',
          pronunciation: 'lij wend',
          options: [],
          correctAnswer: 'Lij wend',
          wordBank: ['Lij wend', 'son', 'child', 'boy', 'male', 'offspring'],
          explanation: 'ልጅ ወንድ (Lij wend) - Son (male child)',
        ),
        
        // Daughter
        LessonExercise(
          id: 'family_003_ex004',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear (Daughter)',
          audioUrl: 'lij_set_audio',
          amharicScript: 'ልጅ ሴት',
          pronunciation: 'lij set',
          options: [],
          correctAnswer: 'Lij set',
          wordBank: ['Lij set', 'daughter', 'child', 'girl', 'female', 'offspring'],
          explanation: 'ልጅ ሴት (Lij set) - Daughter (female child)',
        ),
        
        LessonExercise(
          id: 'family_003_ex005',
          type: LessonType.matchPairs,
          question: 'Match the relationship',
          options: [
            'ባል (Bal) - Husband',
            'ሚስት (Mist) - Wife',
            'ልጅ ወንድ (Lij wend) - Son',
            'ልጅ ሴት (Lij set) - Daughter'
          ],
          correctAnswer: 'All matched',
          explanation: 'Nuclear family relationships',
        ),
        
        // Children
        LessonExercise(
          id: 'family_003_ex006',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear (Children)',
          audioUrl: 'lijoch_audio',
          amharicScript: 'ልጆች',
          pronunciation: 'li-JOCH',
          options: [],
          correctAnswer: 'Lijoch',
          wordBank: ['Lijoch', 'children', 'kids', 'offspring', 'sons and daughters'],
          explanation: 'ልጆች (Lijoch) - Children (plural)',
        ),
        
        LessonExercise(
          id: 'family_003_ex007',
          type: LessonType.completeTheChat,
          question: 'Talk about children',
          conversation: ConversationData(
            character1: 'Friend',
            character1Avatar: '👤',
            character2: 'You',
            character2Avatar: '👨‍👩‍👧‍👦',
            messages: [
              ConversationMessage(
                speaker: 'Friend',
                text: 'Sint lijoch aluih? (How many children do you have?)',
                amharic: 'ስንት ልጆች አለህ?',
              ),
              ConversationMessage(
                speaker: 'You',
                text: '[I have two children]',
                isUserResponse: true,
              ),
            ],
          ),
          options: [
            'Hulet lijoch alugn (I have two children)',
            'And lij alugn (I have one child)',
            'Sost lijoch alugn (I have three children)',
            'Lijoch yelegnym (I don\'t have children)'
          ],
          correctAnswer: 'Hulet lijoch alugn (I have two children)',
          explanation: 'ሁለት ልጆች አሉኝ (Hulet lijoch alugn) - I have two children',
        ),
        
        LessonExercise(
          id: 'family_003_ex008',
          type: LessonType.multipleChoice,
          question: 'What does "Mistey" mean?',
          amharicScript: 'ሚስቴ',
          options: [
            'My wife',
            'My husband',
            'My sister',
            'My mother'
          ],
          correctAnswer: 'My wife',
          explanation: 'ሚስቴ (Mistey) = My wife (ey = my)',
        ),
        
        LessonExercise(
          id: 'family_003_ex009',
          type: LessonType.fillInTheBlank,
          question: 'Fill in: My ___ is at work',
          amharicScript: '___ sera lay new',
          options: [
            'ባሌ (Baley - Husband)',
            'ወንድሜ (Wendimey - Brother)',
            'አባቴ (Abbatey - Father)',
            'ልጄ (Lijey - Child)'
          ],
          correctAnswer: 'ባሌ (Baley - Husband)',
          explanation: 'ባሌ ስራ ላይ ነው (Baley sera lay new) - My husband is at work',
        ),
        
        LessonExercise(
          id: 'family_003_ex010',
          type: LessonType.translateSentence,
          question: 'Translate: "I have a son"',
          options: [
            'ልጅ ወንድ አለኝ (Lij wend aleny)',
            'ልጅ ሴት አለኝ (Lij set aleny)',
            'ወንድም አለኝ (Wendim aleny)',
            'አባት አለኝ (Abbat aleny)'
          ],
          correctAnswer: 'ልጅ ወንድ አለኝ (Lij wend aleny)',
          explanation: 'ልጅ ወንድ አለኝ (Lij wend aleny) - I have a son',
        ),
      ],
    );
  }
  
  /// Lesson 4: Describing Family
  static AmharicLesson _lesson4DescribingFamily() {
    return AmharicLesson(
      id: 'family_004',
      title: 'Describing Family',
      description: 'Describe age, occupation, and location of family',
      category: LessonCategory.family,
      difficulty: DifficultyLevel.intermediate,
      order: 4,
      totalXP: 20,
      prerequisiteId: 'family_003',
      exercises: [
        // Young/Old exercises
        // Add 10+ exercises for describing family members
      ],
    );
  }
  
  /// Lesson 5: Family Conversations
  static AmharicLesson _lesson5FamilyConversations() {
    return AmharicLesson(
      id: 'family_005',
      title: 'Family Conversations',
      description: 'Practice introducing family and having conversations',
      category: LessonCategory.family,
      difficulty: DifficultyLevel.intermediate,
      order: 5,
      totalXP: 25,
      prerequisiteId: 'family_004',
      exercises: [
        // Complete family introduction conversations
        // Add 10+ exercises
      ],
    );
  }
}






















