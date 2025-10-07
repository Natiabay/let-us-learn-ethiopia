import '../models/comprehensive_lesson_model.dart';
import 'comprehensive_lesson_expansion.dart';

/// Comprehensive German to Amharic Learning Lessons
/// 60+ authentic lessons for German speakers learning Amharic
class GermanAmharicLessons {
  static List<Lesson> getGermanAmharicLessons() {
    List<Lesson> lessons = [
      // BEGINNER LEVEL (Lessons 1-20)
      Lesson(
        id: 'de_beginner_1',
        title: 'Grundlegende Begrüßungen',
        description: 'Lernen Sie grundlegende Begrüßungen auf Amharisch',
        level: LanguageLevel.beginner,
        languageCode: 'de',
        estimatedMinutes: 5,
        xpReward: 10,
        category: 'Begrüßungen',
        isUnlocked: true,
        isCompleted: false,
        progress: 0.0,
        vocabulary: [
          'ሰላም - Hallo',
          'እንደምን አደርክ - Guten Morgen',
          'ቻው - Auf Wiedersehen',
          'አመሰግናለሁ - Danke',
          'እባክህ - Bitte',
          'አዎ - Ja',
          'አይ - Nein',
          'ይቅርታ - Entschuldigung',
        ],
        exercises: [
          Exercise(
            id: 'ex1',
            type: ExerciseType.translate,
            instruction: 'Wie sagt man "Hallo" auf Amharisch?',
            amharicText: 'ሰላም',
            translation: 'Hallo',
            options: [
              ExerciseOption(text: 'ሰላም', isCorrect: true),
              ExerciseOption(text: 'ቻው', isCorrect: false),
              ExerciseOption(text: 'አመሰግናለሁ', isCorrect: false),
              ExerciseOption(text: 'እባክህ', isCorrect: false),
            ],
            correctAnswer: 'ሰላም',
            explanation: 'ሰላም (selam) ist die häufigste Art, Hallo auf Amharisch zu sagen.',
          ),
          Exercise(
            id: 'ex2',
            type: ExerciseType.translate,
            instruction: 'Was bedeutet "አመሰግናለሁ"?',
            amharicText: 'አመሰግናለሁ',
            translation: 'Danke',
            options: [
              ExerciseOption(text: 'Hallo', isCorrect: false),
              ExerciseOption(text: 'Danke', isCorrect: true),
              ExerciseOption(text: 'Auf Wiedersehen', isCorrect: false),
              ExerciseOption(text: 'Bitte', isCorrect: false),
            ],
            correctAnswer: 'Danke',
            explanation: 'አመሰግናለሁ (ameseginalehu) bedeutet "danke" auf Amharisch.',
          ),
        ],
      ),

      Lesson(
        id: 'de_beginner_2',
        title: 'Zahlen 1-10',
        description: 'Lernen Sie, von 1 bis 10 auf Amharisch zu zählen',
        level: LanguageLevel.beginner,
        languageCode: 'de',
        estimatedMinutes: 6,
        xpReward: 12,
        category: 'Zahlen',
        isUnlocked: false,
        isCompleted: false,
        progress: 0.0,
        vocabulary: [
          'አንድ - Eins',
          'ሁለት - Zwei',
          'ሶስት - Drei',
          'አራት - Vier',
          'አምስት - Fünf',
          'ስድስት - Sechs',
          'ሰባት - Sieben',
          'ስምንት - Acht',
          'ዘጠኝ - Neun',
          'አስር - Zehn',
        ],
        exercises: [
          Exercise(
            id: 'ex3',
            type: ExerciseType.translate,
            instruction: 'Wie sagt man "Fünf" auf Amharisch?',
            amharicText: 'አምስት',
            translation: 'Fünf',
            options: [
              ExerciseOption(text: 'አራት', isCorrect: false),
              ExerciseOption(text: 'አምስት', isCorrect: true),
              ExerciseOption(text: 'ስድስት', isCorrect: false),
              ExerciseOption(text: 'ሰባት', isCorrect: false),
            ],
            correctAnswer: 'አምስት',
            explanation: 'አምስት (amist) bedeutet "fünf" auf Amharisch.',
          ),
        ],
      ),

      // Continue with more lessons...
    ];
    
    // Add additional lessons to reach 50+ total
    lessons.addAll(ComprehensiveLessonExpansion.generateAdditionalGermanLessons());
    
    return lessons;
  }
}