import 'package:flutter/material.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/models/exercise_model.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/screens/lessons/exercise_widgets/multiple_choice_widget.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/screens/lessons/exercise_widgets/match_image_widget.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/screens/lessons/exercise_widgets/translate_widget.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/screens/lessons/exercise_widgets/fill_blank_widget.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/screens/lessons/exercise_widgets/listening_widget.dart';

/// Exercise Widget Factory - Creates appropriate widget for each exercise type
class ExerciseWidgetFactory {
  /// Build widget for given exercise type
  static Widget buildExercise({
    required Exercise exercise,
    required Function(String) onAnswerSelected,
    required bool showResult,
    required bool isCorrect,
    required String userAnswer,
  }) {
    switch (exercise.type) {
      case ExerciseType.matchImage:
        return MatchImageWidget(
          exercise: exercise,
          onAnswerSelected: onAnswerSelected,
          showResult: showResult,
          isCorrect: isCorrect,
        );

      case ExerciseType.translateToAmharic:
      case ExerciseType.translateToEnglish:
        return TranslateWidget(
          exercise: exercise,
          onAnswerSelected: onAnswerSelected,
          showResult: showResult,
          isCorrect: isCorrect,
          userAnswer: userAnswer,
        );

      case ExerciseType.multipleChoice:
      case ExerciseType.selectWord:
        return MultipleChoiceWidget(
          exercise: exercise,
          onAnswerSelected: onAnswerSelected,
          showResult: showResult,
          isCorrect: isCorrect,
        );

      case ExerciseType.fillBlank:
        return FillBlankWidget(
          exercise: exercise,
          onAnswerSelected: onAnswerSelected,
          showResult: showResult,
          isCorrect: isCorrect,
          userAnswer: userAnswer,
        );

      case ExerciseType.listening:
      case ExerciseType.typeWhatYouHear:
        return ListeningWidget(
          exercise: exercise,
          onAnswerSelected: onAnswerSelected,
          showResult: showResult,
          isCorrect: isCorrect,
          userAnswer: userAnswer,
        );

      case ExerciseType.speaking:
        // TODO: Implement speaking exercise with speech recognition
        return _buildComingSoon('Speaking Exercise');

      case ExerciseType.matchPairs:
        // TODO: Implement match pairs exercise
        return _buildComingSoon('Match Pairs Exercise');

      default:
        return _buildComingSoon('Exercise Type: ${exercise.type.name}');
    }
  }

  static Widget _buildComingSoon(String title) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.construction_rounded,
            color: Color(0xFFFFD43B),
            size: 64,
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Coming in Phase 2!',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

