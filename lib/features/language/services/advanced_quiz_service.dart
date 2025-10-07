import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_assistive_app/features/language/models/word_model.dart';
import 'package:tourist_assistive_app/features/language/models/quiz_models.dart';

final advancedQuizServiceProvider = Provider<AdvancedQuizService>((ref) {
  return AdvancedQuizService();
});

class AdvancedQuizService {
  final Random _random = Random();

  // Generate quiz questions based on words
  List<QuizQuestion> generateQuizQuestions(List<Word> words, int questionCount) {
    final questions = <QuizQuestion>[];
    final questionTypes = [
      QuestionType.translation,
      QuestionType.reverseTranslation,
      QuestionType.listening,
      QuestionType.speaking,
      QuestionType.multipleChoice,
      QuestionType.fillInTheBlank,
      QuestionType.pictureAssociation,
      QuestionType.pronunciation,
      QuestionType.sentenceCompletion,
      QuestionType.trueFalse,
    ];

    for (int i = 0; i < questionCount && i < words.length; i++) {
      final word = words[i];
      final questionType = questionTypes[_random.nextInt(questionTypes.length)];
      
      switch (questionType) {
        case QuestionType.translation:
          questions.add(_generateTranslationQuestion(word, words));
          break;
        case QuestionType.reverseTranslation:
          questions.add(_generateReverseTranslationQuestion(word, words));
          break;
        case QuestionType.listening:
          questions.add(_generateListeningQuestion(word, words));
          break;
        case QuestionType.speaking:
          questions.add(_generateSpeakingQuestion(word));
          break;
        case QuestionType.multipleChoice:
          questions.add(_generateMultipleChoiceQuestion(word, words));
          break;
        case QuestionType.fillInTheBlank:
          questions.add(_generateFillInTheBlankQuestion(word, words));
          break;
        case QuestionType.fillInBlank:
          questions.add(_generateFillInTheBlankQuestion(word, words));
          break;
        case QuestionType.pictureAssociation:
          questions.add(_generatePictureAssociationQuestion(word, words));
          break;
        case QuestionType.pronunciation:
          questions.add(_generatePronunciationQuestion(word));
          break;
        case QuestionType.sentenceCompletion:
          questions.add(_generateSentenceCompletionQuestion(word, words));
          break;
        case QuestionType.trueFalse:
          questions.add(_generateTrueFalseQuestion(word, words));
          break;
        case QuestionType.audioRecognition:
          questions.add(_generateListeningQuestion(word, words));
          break;
        case QuestionType.imageRecognition:
          questions.add(_generatePictureAssociationQuestion(word, words));
          break;
        case QuestionType.writing:
          questions.add(_generateFillInTheBlankQuestion(word, words));
          break;
      }
    }

    questions.shuffle();
    return questions;
  }

  QuizQuestion _generateTranslationQuestion(Word word, List<Word> allWords) {
    final wrongOptions = allWords
        .where((w) => w.id != word.id)
        .map((w) => w.english)
        .toList()
        ..shuffle();
    
    final options = [word.english, ...wrongOptions.take(3)];
    options.shuffle();

    return QuizQuestion(
      id: '${word.id}_translation_${DateTime.now().millisecondsSinceEpoch}',
      type: QuestionType.translation,
      question: 'What does "${word.amharic}" mean?',
      correctAnswer: word.english,
      options: options,
      explanation: '${word.amharic} means "${word.english}" in English.',
      timeLimit: 30,
      points: 10,
    );
  }

  QuizQuestion _generateReverseTranslationQuestion(Word word, List<Word> allWords) {
    final wrongOptions = allWords
        .where((w) => w.id != word.id)
        .map((w) => w.amharic)
        .toList()
        ..shuffle();
    
    final options = [word.amharic, ...wrongOptions.take(3)];
    options.shuffle();

    return QuizQuestion(
      id: '${word.id}_reverse_${DateTime.now().millisecondsSinceEpoch}',
      type: QuestionType.reverseTranslation,
      question: 'How do you say "${word.english}" in Amharic?',
      correctAnswer: word.amharic,
      options: options,
      explanation: '${word.english} is "${word.amharic}" in Amharic.',
      timeLimit: 30,
      points: 10,
    );
  }

  QuizQuestion _generateListeningQuestion(Word word, List<Word> allWords) {
    final wrongOptions = allWords
        .where((w) => w.id != word.id)
        .map((w) => w.english)
        .toList()
        ..shuffle();
    
    final options = [word.english, ...wrongOptions.take(3)];
    options.shuffle();

    return QuizQuestion(
      id: '${word.id}_listening_${DateTime.now().millisecondsSinceEpoch}',
      type: QuestionType.listening,
      question: 'Listen to the audio and choose the correct meaning.',
      correctAnswer: word.english,
      options: options,
      explanation: 'The audio said "${word.amharic}" which means "${word.english}".',
      timeLimit: 20,
      points: 10,
      audioUrl: word.audioUrl,
    );
  }

  QuizQuestion _generateSpeakingQuestion(Word word) {
    return QuizQuestion(
      id: '${word.id}_speaking_${DateTime.now().millisecondsSinceEpoch}',
      type: QuestionType.speaking,
      question: 'Say "${word.english}" in Amharic.',
      correctAnswer: word.amharic,
      options: [],
      explanation: '${word.english} is pronounced "${word.amharic}" in Amharic.',
      timeLimit: 15,
      points: 10,
    );
  }

  QuizQuestion _generateMultipleChoiceQuestion(Word word, List<Word> allWords) {
    final wrongOptions = allWords
        .where((w) => w.id != word.id)
        .map((w) => w.english)
        .toList()
        ..shuffle();
    
    final options = [word.english, ...wrongOptions.take(3)];
    options.shuffle();

    return QuizQuestion(
      id: '${word.id}_multiple_${DateTime.now().millisecondsSinceEpoch}',
      type: QuestionType.multipleChoice,
      question: 'Choose the correct translation for "${word.amharic}":',
      correctAnswer: word.english,
      options: options,
      explanation: '${word.amharic} translates to "${word.english}".',
      timeLimit: 25,
      points: 10,
    );
  }

  QuizQuestion _generateFillInTheBlankQuestion(Word word, List<Word> allWords) {
    final sentence = _generateSentenceWithWord(word);
    final blankedSentence = sentence.replaceAll(word.english, '_____');

    return QuizQuestion(
      id: '${word.id}_fill_${DateTime.now().millisecondsSinceEpoch}',
      type: QuestionType.fillInTheBlank,
      question: 'Complete the sentence: $blankedSentence',
      correctAnswer: word.english,
      options: [word.english],
      explanation: 'The missing word is "${word.english}".',
      timeLimit: 30,
      points: 10,
    );
  }

  QuizQuestion _generatePictureAssociationQuestion(Word word, List<Word> allWords) {
    final wrongOptions = allWords
        .where((w) => w.id != word.id)
        .map((w) => w.english)
        .toList()
        ..shuffle();
    
    final options = [word.english, ...wrongOptions.take(3)];
    options.shuffle();

    return QuizQuestion(
      id: '${word.id}_picture_${DateTime.now().millisecondsSinceEpoch}',
      type: QuestionType.pictureAssociation,
      question: 'What is shown in the picture?',
      correctAnswer: word.english,
      options: options,
      explanation: 'The picture shows "${word.english}".',
      timeLimit: 20,
      points: 10,
      imageUrl: word.imageUrl,
    );
  }

  QuizQuestion _generatePronunciationQuestion(Word word) {
    final wrongPronunciations = _generateWrongPronunciations(word.pronunciation);
    final options = [word.pronunciation, ...wrongPronunciations];
    options.shuffle();

    return QuizQuestion(
      id: '${word.id}_pronunciation_${DateTime.now().millisecondsSinceEpoch}',
      type: QuestionType.pronunciation,
      question: 'How is "${word.amharic}" pronounced?',
      correctAnswer: word.pronunciation,
      options: options,
      explanation: '${word.amharic} is pronounced "${word.pronunciation}".',
      timeLimit: 25,
      points: 10,
    );
  }

  QuizQuestion _generateSentenceCompletionQuestion(Word word, List<Word> allWords) {
    final sentence = _generateSentenceWithWord(word);
    final blankedSentence = sentence.replaceAll(word.english, '_____');
    
    final wrongOptions = allWords
        .where((w) => w.id != word.id)
        .map((w) => w.english)
        .toList()
        ..shuffle();
    
    final options = [word.english, ...wrongOptions.take(3)];
    options.shuffle();

    return QuizQuestion(
      id: '${word.id}_sentence_${DateTime.now().millisecondsSinceEpoch}',
      type: QuestionType.sentenceCompletion,
      question: 'Complete the sentence: $blankedSentence',
      correctAnswer: word.english,
      options: options,
      explanation: 'The correct word to complete the sentence is "${word.english}".',
      timeLimit: 30,
      points: 10,
    );
  }

  QuizQuestion _generateTrueFalseQuestion(Word word, List<Word> allWords) {
    final isTrue = _random.nextBool();
    String question;
    String correctAnswer;
    String explanation;

    if (isTrue) {
      question = '"${word.amharic}" means "${word.english}" in English.';
      correctAnswer = 'True';
      explanation = 'Correct! ${word.amharic} does mean "${word.english}".';
    } else {
      final wrongWords = allWords
          .where((w) => w.id != word.id)
          .toList();
      wrongWords.shuffle();
      final wrongWord = wrongWords.first;
      question = '"${word.amharic}" means "${wrongWord.english}" in English.';
      correctAnswer = 'False';
      explanation = 'Incorrect! ${word.amharic} means "${word.english}", not "${wrongWord.english}".';
    }

    return QuizQuestion(
      id: '${word.id}_truefalse_${DateTime.now().millisecondsSinceEpoch}',
      type: QuestionType.trueFalse,
      question: question,
      correctAnswer: correctAnswer,
      options: ['True', 'False'],
      explanation: explanation,
      timeLimit: 15,
      points: 10,
    );
  }

  String _generateSentenceWithWord(Word word) {
    final sentences = {
      'Hello': 'I said ${word.english} to my friend.',
      'Thank you': 'I said ${word.english} for the help.',
      'Coffee': 'I drink ${word.english} every morning.',
      'One': 'I have ${word.english} apple.',
      'Two': 'I have ${word.english} books.',
      'Three': 'I have ${word.english} cats.',
      'Milk': 'I drink ${word.english} with my cereal.',
      'Water': 'I need ${word.english} to stay hydrated.',
      'Food': 'I am hungry and need ${word.english}.',
      'Hotel': 'I am staying at a ${word.english}.',
      'Restaurant': 'I am eating at a ${word.english}.',
      'Market': 'I am shopping at the ${word.english}.',
      'Hospital': 'I need to go to the ${word.english}.',
      'Police': 'I need to call the ${word.english}.',
    };

    return sentences[word.english] ?? 'This is about ${word.english}.';
  }

  List<String> _generateWrongPronunciations(String correctPronunciation) {
    final wrongPronunciations = <String>[];
    
    // Generate variations by changing vowels
    final vowels = ['a', 'e', 'i', 'o', 'u'];
    for (int i = 0; i < 3; i++) {
      String wrong = correctPronunciation;
      for (int j = 0; j < wrong.length; j++) {
        if (vowels.contains(wrong[j].toLowerCase())) {
          final randomVowel = vowels[_random.nextInt(vowels.length)];
          wrong = wrong.replaceRange(j, j + 1, randomVowel);
          break;
        }
      }
      if (wrong != correctPronunciation) {
        wrongPronunciations.add(wrong);
      }
    }

    return wrongPronunciations;
  }

  // Calculate quiz score
  QuizResult calculateQuizResult(List<QuizQuestion> questions, List<QuizAnswer> answers) {
    int correctAnswers = 0;
    int totalQuestions = questions.length;
    int totalTime = 0;
    Map<QuestionType, int> typeStats = {};

    for (final answer in answers) {
      final question = questions.firstWhere((q) => q.id == answer.questionId);
      
      if (answer.isCorrect) {
        correctAnswers++;
      }
      
      totalTime += answer.timeSpent;
      
      typeStats[question.type] = (typeStats[question.type] ?? 0) + 1;
    }

    final accuracy = totalQuestions > 0 ? (correctAnswers / totalQuestions) * 100 : 0.0;
    final averageTime = totalQuestions > 0 ? totalTime / totalQuestions : 0.0;

    return QuizResult(
      totalQuestions: totalQuestions,
      correctAnswers: correctAnswers,
      accuracy: accuracy.toDouble(),
      totalTime: totalTime,
      averageTime: averageTime.toDouble(),
      typeStats: typeStats,
      timestamp: DateTime.now(),
    );
  }

  // Get quiz recommendations based on performance
  List<String> getQuizRecommendations(QuizResult result) {
    final recommendations = <String>[];

    if (result.accuracy < 60) {
      recommendations.add('Practice more basic vocabulary');
      recommendations.add('Review previous lessons');
    } else if (result.accuracy < 80) {
      recommendations.add('Good progress! Keep practicing');
      recommendations.add('Try more challenging questions');
    } else {
      recommendations.add('Excellent work! You\'re ready for advanced lessons');
      recommendations.add('Try speaking exercises');
    }

    if (result.averageTime > 25) {
      recommendations.add('Try to answer questions faster');
    }

    return recommendations;
  }
}
