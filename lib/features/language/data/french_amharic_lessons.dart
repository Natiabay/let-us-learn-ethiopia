import '../models/comprehensive_lesson_model.dart';
import 'comprehensive_lesson_expansion.dart';

/// Comprehensive French to Amharic Learning Lessons
/// 60+ authentic lessons for French speakers learning Amharic
class FrenchAmharicLessons {
  static List<Lesson> getFrenchAmharicLessons() {
    List<Lesson> lessons = [
      // BEGINNER LEVEL (Lessons 1-20)
      Lesson(
        id: 'fr_beginner_1',
        title: 'Salutations de Base',
        description: 'Apprenez les salutations essentielles en amharique',
        level: LanguageLevel.beginner,
        languageCode: 'fr',
        estimatedMinutes: 5,
        xpReward: 10,
        category: 'Salutations',
        isUnlocked: true,
        isCompleted: false,
        progress: 0.0,
        vocabulary: [
          'ሰላም - Bonjour',
          'እንደምን አደርክ - Bonjour (matin)',
          'ቻው - Au revoir',
          'አመሰግናለሁ - Merci',
          'እባክህ - S\'il vous plaît',
          'አዎ - Oui',
          'አይ - Non',
          'ይቅርታ - Excusez-moi',
        ],
        exercises: [
          Exercise(
            id: 'ex1',
            type: ExerciseType.translate,
            instruction: 'Comment dit-on "Bonjour" en amharique ?',
            amharicText: 'ሰላም',
            translation: 'Bonjour',
            options: [
              ExerciseOption(text: 'ሰላም', isCorrect: true),
              ExerciseOption(text: 'ቻው', isCorrect: false),
              ExerciseOption(text: 'አመሰግናለሁ', isCorrect: false),
              ExerciseOption(text: 'እባክህ', isCorrect: false),
            ],
            correctAnswer: 'ሰላም',
            explanation: 'ሰላም (selam) est la façon la plus courante de dire bonjour en amharique.',
          ),
          Exercise(
            id: 'ex2',
            type: ExerciseType.translate,
            instruction: 'Que signifie "አመሰግናለሁ" ?',
            amharicText: 'አመሰግናለሁ',
            translation: 'Merci',
            options: [
              ExerciseOption(text: 'Bonjour', isCorrect: false),
              ExerciseOption(text: 'Merci', isCorrect: true),
              ExerciseOption(text: 'Au revoir', isCorrect: false),
              ExerciseOption(text: 'S\'il vous plaît', isCorrect: false),
            ],
            correctAnswer: 'Merci',
            explanation: 'አመሰግናለሁ (ameseginalehu) signifie "merci" en amharique.',
          ),
        ],
      ),

      Lesson(
        id: 'fr_beginner_2',
        title: 'Nombres 1-10',
        description: 'Apprenez à compter de 1 à 10 en amharique',
        level: LanguageLevel.beginner,
        languageCode: 'fr',
        estimatedMinutes: 6,
        xpReward: 12,
        category: 'Nombres',
        isUnlocked: false,
        isCompleted: false,
        progress: 0.0,
        vocabulary: [
          'አንድ - Un',
          'ሁለት - Deux',
          'ሶስት - Trois',
          'አራት - Quatre',
          'አምስት - Cinq',
          'ስድስት - Six',
          'ሰባት - Sept',
          'ስምንት - Huit',
          'ዘጠኝ - Neuf',
          'አስር - Dix',
        ],
        exercises: [
          Exercise(
            id: 'ex3',
            type: ExerciseType.translate,
            instruction: 'Comment dit-on "Cinq" en amharique ?',
            amharicText: 'አምስት',
            translation: 'Cinq',
            options: [
              ExerciseOption(text: 'አራት', isCorrect: false),
              ExerciseOption(text: 'አምስት', isCorrect: true),
              ExerciseOption(text: 'ስድስት', isCorrect: false),
              ExerciseOption(text: 'ሰባት', isCorrect: false),
            ],
            correctAnswer: 'አምስት',
            explanation: 'አምስት (amist) signifie "cinq" en amharique.',
          ),
        ],
      ),

      // Continue with more lessons...
    ];
    
    // Add additional lessons to reach 50+ total
    lessons.addAll(ComprehensiveLessonExpansion.generateAdditionalFrenchLessons());
    
    return lessons;
  }
}