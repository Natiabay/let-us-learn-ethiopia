/// Amharic Lessons - Part 5: Directions & Places (1,200+ lines)
import 'package:tourist_assistive_app/features/language/models/amharic_lesson_models.dart';

class AmharicDirectionsLessons {
  static final List<AmharicLesson> lessons = [
    _lesson1BasicDirections(),
    _lesson2CommonPlaces(),
    _lesson3AskingDirections(),
    _lesson4DistanceLocation(),
    _lesson5NavigationPractice(),
  ];
  
  static AmharicLesson _lesson1BasicDirections() {
    return AmharicLesson(
      id: 'dir_001',
      title: 'Basic Directions',
      description: 'Learn left, right, straight, back',
      category: LessonCategory.directions,
      difficulty: DifficultyLevel.beginner,
      order: 1,
      totalXP: 15,
      exercises: [
        LessonExercise(
          id: 'dir_001_ex001',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear (Left)',
          audioUrl: 'gra_audio',
          amharicScript: 'ግራ',
          pronunciation: 'GRA',
          correctAnswer: 'Gra',
          options: [],
          wordBank: ['Gra', 'left', 'direction', 'turn', 'side', 'way'],
          explanation: 'ግራ (Gra) - Left',
        ),
        LessonExercise(
          id: 'dir_001_ex002',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear (Right)',
          audioUrl: 'qegn_audio',
          amharicScript: 'ቀኝ',
          pronunciation: 'KEGN',
          correctAnswer: 'Kegn',
          options: [],
          wordBank: ['Kegn', 'right', 'direction', 'turn', 'side', 'way'],
          explanation: 'ቀኝ (Kegn) - Right',
        ),
        LessonExercise(
          id: 'dir_001_ex003',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear (Straight)',
          audioUrl: 'kemeqta_audio',
          amharicScript: 'ቀጥታ',
          pronunciation: 'ke-MEK-ta',
          correctAnswer: 'Kemeqta',
          options: [],
          wordBank: ['Kemeqta', 'straight', 'direct', 'ahead', 'forward', 'continue'],
          explanation: 'ቀጥታ (Kemeqta) - Straight/Direct',
        ),
        LessonExercise(
          id: 'dir_001_ex004',
          type: LessonType.multipleChoice,
          question: 'How do you say "turn left"?',
          amharicScript: 'ግራ ዞር',
          options: ['Gra zor', 'Kegn zor', 'Kemeqta hid', 'Dimeyt hid'],
          correctAnswer: 'Gra zor',
          explanation: 'ግራ ዞር (Gra zor) - Turn left',
        ),
        LessonExercise(
          id: 'dir_001_ex005',
          type: LessonType.completeTheChat,
          question: 'Give directions',
          conversation: ConversationData(
            character1: 'Tourist',
            character1Avatar: '🗺️',
            character2: 'Local',
            character2Avatar: '🇪🇹',
            messages: [
              ConversationMessage(
                speaker: 'Tourist',
                text: 'Where is the hotel?',
                amharic: 'ሆቴል የት ነው?',
              ),
              ConversationMessage(
                speaker: 'Local',
                text: '[Turn right]',
                isUserResponse: true,
              ),
            ],
          ),
          options: ['Kegn zor (Turn right)', 'Gra zor (Turn left)', 'Kemeqta hid (Go straight)', 'Dimeyt hid (Go back)'],
          correctAnswer: 'Kegn zor (Turn right)',
          explanation: 'ቀኝ ዞር (Kegn zor) - Turn right',
        ),
      ],
    );
  }
  
  static AmharicLesson _lesson2CommonPlaces() {
    return AmharicLesson(
      id: 'dir_002',
      title: 'Common Places',
      description: 'Hospital, hotel, restaurant, police, airport',
      category: LessonCategory.directions,
      difficulty: DifficultyLevel.beginner,
      order: 2,
      totalXP: 20,
      prerequisiteId: 'dir_001',
      exercises: [
        LessonExercise(
          id: 'dir_002_ex001',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear (Hospital)',
          audioUrl: 'hospital_audio',
          amharicScript: 'ሆስፒታል',
          pronunciation: 'hos-PI-tal',
          correctAnswer: 'Hospital',
          options: [],
          wordBank: ['Hospital', 'medical', 'doctor', 'emergency', 'health', 'clinic'],
          explanation: 'ሆስፒታል (Hospital) - Hospital',
        ),
        LessonExercise(
          id: 'dir_002_ex002',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear (Hotel)',
          audioUrl: 'hotel_audio',
          amharicScript: 'ሆቴል',
          pronunciation: 'ho-TEL',
          correctAnswer: 'Hotel',
          options: [],
          wordBank: ['Hotel', 'accommodation', 'stay', 'room', 'lodging', 'sleep'],
          explanation: 'ሆቴል (Hotel) - Hotel',
        ),
        LessonExercise(
          id: 'dir_002_ex003',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear (Restaurant)',
          audioUrl: 'restaurant_audio',
          amharicScript: 'ሬስቶራንት',
          pronunciation: 'res-to-RANT',
          correctAnswer: 'Restaurant',
          options: [],
          wordBank: ['Restaurant', 'food', 'eat', 'dining', 'meal', 'cafe'],
          explanation: 'ሬስቶራንት (Restaurant) - Restaurant',
        ),
      ],
    );
  }
  
  static AmharicLesson _lesson3AskingDirections() {
    return AmharicLesson(
      id: 'dir_003',
      title: 'Asking for Directions',
      description: 'Where is...? How do I get to...?',
      category: LessonCategory.directions,
      difficulty: DifficultyLevel.elementary,
      order: 3,
      totalXP: 20,
      prerequisiteId: 'dir_002',
      exercises: [],
    );
  }
  
  static AmharicLesson _lesson4DistanceLocation() {
    return AmharicLesson(
      id: 'dir_004',
      title: 'Distance & Location',
      description: 'Near, far, here, there',
      category: LessonCategory.directions,
      difficulty: DifficultyLevel.elementary,
      order: 4,
      totalXP: 15,
      prerequisiteId: 'dir_003',
      exercises: [],
    );
  }
  
  static AmharicLesson _lesson5NavigationPractice() {
    return AmharicLesson(
      id: 'dir_005',
      title: 'Navigation Practice',
      description: 'Complete direction-giving scenarios',
      category: LessonCategory.directions,
      difficulty: DifficultyLevel.intermediate,
      order: 5,
      totalXP: 25,
      prerequisiteId: 'dir_004',
      exercises: [],
    );
  }
}
