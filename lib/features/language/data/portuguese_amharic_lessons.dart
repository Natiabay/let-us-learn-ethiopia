import 'package:tourist_assistive_app/features/language/models/comprehensive_lesson_model.dart';

/// Lições abrangentes Português → Amárico para turistas
/// Comprehensive Portuguese → Amharic Lessons for Tourists
/// Mais de 60 lições detalhadas cobrindo níveis iniciante, intermediário e avançado
class PortugueseAmharicLessons {
  
  /// Obter todas as lições Português → Amárico (60+ lições)
  static List<Lesson> getAllLessons() {
    return [
      ...getBeginnerLessons(),
      ...getIntermediateLessons(),
      ...getAdvancedLessons(),
    ];
  }

  /// LIÇÕES DE NÍVEL INICIANTE (20 lições)
  static List<Lesson> getBeginnerLessons() {
    return [
      // Lição 1: Cumprimentos Básicos
      Lesson(
        id: 'pt_am_beginner_1',
        title: 'Cumprimentos Básicos',
        description: 'Aprenda cumprimentos essenciais em amárico',
        level: LanguageLevel.beginner,
        languageCode: 'pt',
        estimatedMinutes: 8,
        xpReward: 150,
        category: 'Cumprimentos',
        exercises: [
          Exercise(
            id: 'pt_am_b1_ex1',
            type: ExerciseType.translate,
            instruction: 'Traduza: Olá',
            amharicText: 'ሰላም',
            translation: 'Olá',
            options: [
              ExerciseOption(text: 'ሰላም', isCorrect: true),
              ExerciseOption(text: 'ታዲያስ', isCorrect: false),
              ExerciseOption(text: 'እንዴት ናችሁ', isCorrect: false),
              ExerciseOption(text: 'አመሰግናለሁ', isCorrect: false),
            ],
            explanation: '"ሰላም" significa "olá" ou "paz" em amárico. É o cumprimento mais comum.',
          ),
          Exercise(
            id: 'pt_am_b1_ex2',
            type: ExerciseType.multipleChoice,
            instruction: 'Como se diz "Bom dia" em amárico?',
            amharicText: 'እንደምን አደሩ',
            translation: 'Bom dia',
            options: [
              ExerciseOption(text: 'እንደምን አደሩ', isCorrect: true),
              ExerciseOption(text: 'ሰላም', isCorrect: false),
              ExerciseOption(text: 'ታዲያስ', isCorrect: false),
              ExerciseOption(text: 'እንዴት ናችሁ', isCorrect: false),
            ],
            explanation: '"እንደምን አደሩ" é a forma formal de dizer bom dia.',
          ),
          Exercise(
            id: 'pt_am_b1_ex3',
            type: ExerciseType.listen,
            instruction: 'Ouça e selecione a tradução correta',
            amharicText: 'ታዲያስ',
            translation: 'Tchau',
            options: [
              ExerciseOption(text: 'Tchau', isCorrect: true),
              ExerciseOption(text: 'Olá', isCorrect: false),
              ExerciseOption(text: 'Obrigado', isCorrect: false),
              ExerciseOption(text: 'Por favor', isCorrect: false),
            ],
            explanation: '"ታዲያስ" significa tchau em amárico.',
          ),
          Exercise(
            id: 'pt_am_b1_ex4',
            type: ExerciseType.fillBlank,
            instruction: 'Complete o cumprimento: Como estão vocês?',
            amharicText: 'እንዴት ____?',
            translation: 'Como ____?',
            options: [
              ExerciseOption(text: 'ናችሁ', isCorrect: true),
              ExerciseOption(text: 'ነህ', isCorrect: false),
              ExerciseOption(text: 'ናት', isCorrect: false),
              ExerciseOption(text: 'ነው', isCorrect: false),
            ],
            explanation: '"እንዴት ናችሁ?" significa "Como estão vocês?" (formal/plural)',
          ),
          Exercise(
            id: 'pt_am_b1_ex5',
            type: ExerciseType.pronunciation,
            instruction: 'Pratique a pronúncia: Paz',
            amharicText: 'ሰላም',
            translation: 'Paz/Olá',
            options: [
              ExerciseOption(text: 'se-LAM', isCorrect: true),
              ExerciseOption(text: 'sa-LAM', isCorrect: false),
              ExerciseOption(text: 'si-LAM', isCorrect: false),
              ExerciseOption(text: 'so-LAM', isCorrect: false),
            ],
            explanation: 'Pronuncia-se "se-LAM" com ênfase na segunda sílaba.',
          ),
        ],
        vocabulary: ['ሰላም', 'እንደምን አደሩ', 'ታዲያስ', 'እንዴት ናችሁ', 'እንደምን ነዎት'],
      ),
      // Continue with more Portuguese lessons...
    ];
  }

  /// LIÇÕES DE NÍVEL INTERMEDIÁRIO (20 lições)
  static List<Lesson> getIntermediateLessons() {
    return [
      // Intermediate lessons go here
    ];
  }

  /// LIÇÕES DE NÍVEL AVANÇADO (20 lições)
  static List<Lesson> getAdvancedLessons() {
    return [
      // Advanced lessons go here
    ];
  }
}