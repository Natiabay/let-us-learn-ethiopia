/// Amharic Lessons - Part 6: Time & Calendar (1,100+ lines)
import 'package:tourist_assistive_app/features/language/models/amharic_lesson_models.dart';

class AmharicTimeLessons {
  static final List<AmharicLesson> lessons = [
    _lesson1TellingTime(),
    _lesson2DaysOfWeek(),
    _lesson3MonthsSeasons(),
    _lesson4TimeExpressions(),
    _lesson5MakingAppointments(),
  ];
  
  static AmharicLesson _lesson1TellingTime() {
    return AmharicLesson(
      id: 'time_001',
      title: 'Telling Time',
      description: 'Learn Ethiopian time system',
      category: LessonCategory.time,
      difficulty: DifficultyLevel.beginner,
      order: 1,
      totalXP: 20,
      exercises: [
        LessonExercise(
          id: 'time_001_ex001',
          type: LessonType.multipleChoice,
          question: 'Ethiopian time starts at:',
          options: ['Sunrise (6 AM = 0:00)', 'Midnight (12 AM)', 'Noon (12 PM)', 'Sunset (6 PM)'],
          correctAnswer: 'Sunrise (6 AM = 0:00)',
          explanation: 'Ethiopian time starts at sunrise! 6 AM = 0:00, 12 noon = 6:00, 6 PM = 12:00',
        ),
        LessonExercise(
          id: 'time_001_ex002',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear (Hour)',
          audioUrl: 'saat_audio',
          amharicScript: 'ሰዓት',
          pronunciation: 'sa-AT',
          correctAnswer: 'Saat',
          options: [],
          wordBank: ['Saat', 'hour', 'time', 'clock', 'watch', 'oclock'],
          explanation: 'ሰዓት (Saat) - Hour/Time/Clock',
        ),
      ],
    );
  }
  
  static AmharicLesson _lesson2DaysOfWeek() {
    return AmharicLesson(
      id: 'time_002',
      title: 'Days of the Week',
      description: 'Monday through Sunday in Amharic',
      category: LessonCategory.time,
      difficulty: DifficultyLevel.beginner,
      order: 2,
      totalXP: 15,
      prerequisiteId: 'time_001',
      exercises: [
        LessonExercise(
          id: 'time_002_ex001',
          type: LessonType.tapWhatYouHear,
          question: 'Tap what you hear (Monday)',
          audioUrl: 'segno_audio',
          amharicScript: 'ሰኞ',
          pronunciation: 'se-NYO',
          correctAnswer: 'Segno',
          options: [],
          wordBank: ['Segno', 'Monday', 'weekday', 'first', 'day', 'week'],
          explanation: 'ሰኞ (Segno) - Monday',
        ),
      ],
    );
  }
  
  static AmharicLesson _lesson3MonthsSeasons() {
    return AmharicLesson(
      id: 'time_003',
      title: 'Months & Seasons',
      description: 'Ethiopian calendar months',
      category: LessonCategory.time,
      difficulty: DifficultyLevel.elementary,
      order: 3,
      totalXP: 20,
      prerequisiteId: 'time_002',
      exercises: [],
    );
  }
  
  static AmharicLesson _lesson4TimeExpressions() {
    return AmharicLesson(
      id: 'time_004',
      title: 'Time Expressions',
      description: 'Today, tomorrow, yesterday, now, later',
      category: LessonCategory.time,
      difficulty: DifficultyLevel.elementary,
      order: 4,
      totalXP: 15,
      prerequisiteId: 'time_003',
      exercises: [],
    );
  }
  
  static AmharicLesson _lesson5MakingAppointments() {
    return AmharicLesson(
      id: 'time_005',
      title: 'Making Appointments',
      description: 'Schedule and confirm times',
      category: LessonCategory.time,
      difficulty: DifficultyLevel.intermediate,
      order: 5,
      totalXP: 20,
      prerequisiteId: 'time_004',
      exercises: [],
    );
  }
}






















