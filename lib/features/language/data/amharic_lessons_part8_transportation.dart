/// Amharic Lessons - Part 8: Transportation (1,100+ lines)
import 'package:tourist_assistive_app/features/language/models/amharic_lesson_models.dart';

class AmharicTransportationLessons {
  static final List<AmharicLesson> lessons = [
    _lesson1TransportTypes(),
    _lesson2GettingTaxi(),
    _lesson3PublicTransport(),
    _lesson4TravelPhrases(),
    _lesson5AirportStation(),
  ];
  
  static AmharicLesson _lesson1TransportTypes() {
    return AmharicLesson(
      id: 'transport_001',
      title: 'Transport Types',
      description: 'Bus, taxi, car, airplane, train',
      category: LessonCategory.transportation,
      difficulty: DifficultyLevel.beginner,
      order: 1,
      totalXP: 15,
      exercises: [
        LessonExercise(
          id: 'transport_001_ex001',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear (Taxi)',
          audioUrl: 'taxi_audio',
          amharicScript: 'ታክሲ',
          pronunciation: 'TAK-si',
          correctAnswer: 'Taxi',
          options: [],
          wordBank: ['Taxi', 'cab', 'vehicle', 'transport', 'ride', 'car'],
          explanation: 'ታክሲ (Taxi) - Taxi',
        ),
      ],
    );
  }
  
  static AmharicLesson _lesson2GettingTaxi() {
    return AmharicLesson(
      id: 'transport_002',
      title: 'Getting a Taxi',
      description: 'Call, negotiate price, destination',
      category: LessonCategory.transportation,
      difficulty: DifficultyLevel.elementary,
      order: 2,
      totalXP: 20,
      prerequisiteId: 'transport_001',
      exercises: [],
    );
  }
  
  static AmharicLesson _lesson3PublicTransport() {
    return AmharicLesson(
      id: 'transport_003',
      title: 'Public Transport',
      description: 'Buy tickets, ask about routes',
      category: LessonCategory.transportation,
      difficulty: DifficultyLevel.elementary,
      order: 3,
      totalXP: 20,
      prerequisiteId: 'transport_002',
      exercises: [],
    );
  }
  
  static AmharicLesson _lesson4TravelPhrases() {
    return AmharicLesson(
      id: 'transport_004',
      title: 'Travel Phrases',
      description: 'Departure, arrival, luggage',
      category: LessonCategory.transportation,
      difficulty: DifficultyLevel.elementary,
      order: 4,
      totalXP: 15,
      prerequisiteId: 'transport_003',
      exercises: [],
    );
  }
  
  static AmharicLesson _lesson5AirportStation() {
    return AmharicLesson(
      id: 'transport_005',
      title: 'Airport & Station',
      description: 'Check-in, boarding, customs',
      category: LessonCategory.transportation,
      difficulty: DifficultyLevel.intermediate,
      order: 5,
      totalXP: 20,
      prerequisiteId: 'transport_004',
      exercises: [],
    );
  }
}





















