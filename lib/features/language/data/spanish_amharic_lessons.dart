import '../models/comprehensive_lesson_model.dart';
import 'comprehensive_lesson_expansion.dart';

/// Comprehensive Spanish to Amharic Learning Lessons
/// 60+ authentic lessons for Spanish speakers learning Amharic
class SpanishAmharicLessons {
  static List<Lesson> getSpanishAmharicLessons() {
    List<Lesson> lessons = [
      // BEGINNER LEVEL (Lessons 1-20)
      Lesson(
        id: 'es_beginner_1',
        title: 'Saludos Básicos',
        description: 'Aprende saludos esenciales en amárico',
        level: LanguageLevel.beginner,
        languageCode: 'es',
        estimatedMinutes: 5,
        xpReward: 10,
        category: 'Saludos',
        isUnlocked: true,
        isCompleted: false,
        progress: 0.0,
        vocabulary: [
          'ሰላም - Hola',
          'እንደምን አደርክ - Buenos días',
          'ቻው - Adiós',
          'አመሰግናለሁ - Gracias',
          'እባክህ - Por favor',
          'አዎ - Sí',
          'አይ - No',
          'ይቅርታ - Disculpe',
        ],
        exercises: [
          Exercise(
            id: 'ex1',
            type: ExerciseType.translate,
            instruction: '¿Cómo se dice "Hola" en amárico?',
            amharicText: 'ሰላም',
            translation: 'Hola',
            options: [
              ExerciseOption(text: 'ሰላም', isCorrect: true),
              ExerciseOption(text: 'ቻው', isCorrect: false),
              ExerciseOption(text: 'አመሰግናለሁ', isCorrect: false),
              ExerciseOption(text: 'እባክህ', isCorrect: false),
            ],
            correctAnswer: 'ሰላም',
            explanation: 'ሰላም (selam) es la forma más común de decir hola en amárico.',
          ),
          Exercise(
            id: 'ex2',
            type: ExerciseType.translate,
            instruction: '¿Qué significa "አመሰግናለሁ"?',
            amharicText: 'አመሰግናለሁ',
            translation: 'Gracias',
            options: [
              ExerciseOption(text: 'Hola', isCorrect: false),
              ExerciseOption(text: 'Gracias', isCorrect: true),
              ExerciseOption(text: 'Adiós', isCorrect: false),
              ExerciseOption(text: 'Por favor', isCorrect: false),
            ],
            correctAnswer: 'Gracias',
            explanation: 'አመሰግናለሁ (ameseginalehu) significa "gracias" en amárico.',
          ),
        ],
      ),

      Lesson(
        id: 'es_beginner_2',
        title: 'Números 1-10',
        description: 'Aprende a contar del 1 al 10 en amárico',
        level: LanguageLevel.beginner,
        languageCode: 'es',
        estimatedMinutes: 6,
        xpReward: 12,
        category: 'Números',
        isUnlocked: false,
        isCompleted: false,
        progress: 0.0,
        vocabulary: [
          'አንድ - Uno',
          'ሁለት - Dos',
          'ሶስት - Tres',
          'አራት - Cuatro',
          'አምስት - Cinco',
          'ስድስት - Seis',
          'ሰባት - Siete',
          'ስምንት - Ocho',
          'ዘጠኝ - Nueve',
          'አስር - Diez',
        ],
        exercises: [
          Exercise(
            id: 'ex3',
            type: ExerciseType.translate,
            instruction: '¿Cómo se dice "Cinco" en amárico?',
            amharicText: 'አምስት',
            translation: 'Cinco',
            options: [
              ExerciseOption(text: 'አራት', isCorrect: false),
              ExerciseOption(text: 'አምስት', isCorrect: true),
              ExerciseOption(text: 'ስድስት', isCorrect: false),
              ExerciseOption(text: 'ሰባት', isCorrect: false),
            ],
            correctAnswer: 'አምስት',
            explanation: 'አምስት (amist) significa "cinco" en amárico.',
          ),
        ],
      ),

      Lesson(
        id: 'es_beginner_3',
        title: 'Miembros de la Familia',
        description: 'Aprende términos de relaciones familiares',
        level: LanguageLevel.beginner,
        languageCode: 'es',
        estimatedMinutes: 7,
        xpReward: 14,
        category: 'Familia',
        isUnlocked: false,
        isCompleted: false,
        progress: 0.0,
        vocabulary: [
          'አባት - Padre',
          'እናት - Madre',
          'ወንድም - Hermano',
          'እህት - Hermana',
          'ወንድ ልጅ - Hijo',
          'ሴት ልጅ - Hija',
          'አያት - Abuelo',
          'አክስት - Tía',
        ],
        exercises: [
      Exercise(
            id: 'ex4',
        type: ExerciseType.translate,
            instruction: '¿Cómo se dice "Madre" en amárico?',
            amharicText: 'እናት',
            translation: 'Madre',
        options: [
              ExerciseOption(text: 'አባት', isCorrect: false),
              ExerciseOption(text: 'እናት', isCorrect: true),
          ExerciseOption(text: 'ወንድም', isCorrect: false),
          ExerciseOption(text: 'እህት', isCorrect: false),
        ],
            correctAnswer: 'እናት',
            explanation: 'እናት (inat) significa "madre" en amárico.',
          ),
        ],
      ),

      // Continue with more lessons...
    ];
    
    // Add additional lessons to reach 50+ total
    lessons.addAll(ComprehensiveLessonExpansion.generateAdditionalSpanishLessons());
    
    return lessons;
  }
}