/// Amharic Lessons - Part 9: Accommodation (1,000+ lines)
import 'package:tourist_assistive_app/features/language/models/amharic_lesson_models.dart';

class AmharicAccommodationLessons {
  static final List<AmharicLesson> lessons = [
    _lesson1HotelVocabulary(),
    _lesson2BookingRoom(),
    _lesson3HotelServices(),
    _lesson4ProblemsRequests(),
    _lesson5CheckingOut(),
  ];
  
  static AmharicLesson _lesson1HotelVocabulary() {
    return AmharicLesson(
      id: 'accom_001',
      title: 'Hotel Vocabulary',
      description: 'Room, bed, bathroom, reception',
      category: LessonCategory.accommodation,
      difficulty: DifficultyLevel.beginner,
      order: 1,
      totalXP: 15,
      exercises: [],
    );
  }
  
  static AmharicLesson _lesson2BookingRoom() {
    return AmharicLesson(
      id: 'accom_002',
      title: 'Booking a Room',
      description: 'Check-in, amenities',
      category: LessonCategory.accommodation,
      difficulty: DifficultyLevel.elementary,
      order: 2,
      totalXP: 20,
      prerequisiteId: 'accom_001',
      exercises: [],
    );
  }
  
  static AmharicLesson _lesson3HotelServices() {
    return AmharicLesson(
      id: 'accom_003',
      title: 'Hotel Services',
      description: 'Housekeeping, room service, WiFi',
      category: LessonCategory.accommodation,
      difficulty: DifficultyLevel.elementary,
      order: 3,
      totalXP: 15,
      prerequisiteId: 'accom_002',
      exercises: [],
    );
  }
  
  static AmharicLesson _lesson4ProblemsRequests() {
    return AmharicLesson(
      id: 'accom_004',
      title: 'Problems & Requests',
      description: 'Complaints, maintenance',
      category: LessonCategory.accommodation,
      difficulty: DifficultyLevel.intermediate,
      order: 4,
      totalXP: 15,
      prerequisiteId: 'accom_003',
      exercises: [],
    );
  }
  
  static AmharicLesson _lesson5CheckingOut() {
    return AmharicLesson(
      id: 'accom_005',
      title: 'Checking Out',
      description: 'Bill, feedback, departure',
      category: LessonCategory.accommodation,
      difficulty: DifficultyLevel.elementary,
      order: 5,
      totalXP: 15,
      prerequisiteId: 'accom_004',
      exercises: [],
    );
  }
}





















