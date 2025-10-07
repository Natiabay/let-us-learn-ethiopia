import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tourist_assistive_app/core/theme/app_theme.dart';
import 'package:tourist_assistive_app/features/language/models/quiz_models.dart';

class AdvancedQuestionWidget extends StatelessWidget {
  final QuizQuestion question;
  final Function(String) onAnswerSelected;
  final bool showResult;
  final bool isCorrect;

  const AdvancedQuestionWidget({
    super.key,
    required this.question,
    required this.onAnswerSelected,
    required this.showResult,
    required this.isCorrect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.grey200, width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Question Header
          _buildQuestionHeader(context),
          
          const SizedBox(height: 30),
          
          // Question Content
          _buildQuestionContent(context),
          
          const SizedBox(height: 30),
          
          // Difficulty Indicator
          _buildDifficultyIndicator(context),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).scale(begin: const Offset(0.9, 0.9), end: const Offset(1.0, 1.0));
  }

  Widget _buildQuestionHeader(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _getQuestionTypeColor().withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            _getQuestionTypeIcon(),
            color: _getQuestionTypeColor(),
            size: 24,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _getQuestionTypeTitle(),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: _getQuestionTypeColor(),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Difficulty: ${_getDifficultyText()}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionContent(BuildContext context) {
    switch (question.type) {
      case QuestionType.translation:
        return _buildTranslationContent(context);
      case QuestionType.reverseTranslation:
        return _buildReverseTranslationContent(context);
      case QuestionType.multipleChoice:
        return _buildMultipleChoiceContent(context);
      case QuestionType.fillInTheBlank:
        return _buildFillInTheBlankContent(context);
      case QuestionType.sentenceCompletion:
        return _buildSentenceCompletionContent(context);
      case QuestionType.trueFalse:
        return _buildTrueFalseContent(context);
      default:
        return _buildDefaultContent(context);
    }
  }

  Widget _buildTranslationContent(BuildContext context) {
    return Column(
      children: [
        // Amharic Text
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: AppColors.primaryGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Text(
                'Amharic',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textOnPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                question.question,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: AppColors.textOnPrimary,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'What does this mean in English?',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildReverseTranslationContent(BuildContext context) {
    return Column(
      children: [
        // English Text
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: AppColors.secondaryGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Text(
                'English',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textOnSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                question.correctAnswer,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: AppColors.textOnSecondary,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'How do you say this in Amharic?',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildMultipleChoiceContent(BuildContext context) {
    return Column(
      children: [
        Text(
          question.question,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
          ),
          child: Text(
            question.question,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildFillInTheBlankContent(BuildContext context) {
    return Column(
      children: [
        Text(
          question.question,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.info.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.info.withValues(alpha: 0.3)),
          ),
          child: Text(
            'Complete the sentence with the correct word.',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.info,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildSentenceCompletionContent(BuildContext context) {
    return Column(
      children: [
        Text(
          question.question,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.accent.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
          ),
          child: Text(
            'Choose the best word to complete the sentence.',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.accent,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildTrueFalseContent(BuildContext context) {
    return Column(
      children: [
        Text(
          question.question,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.warning.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.warning.withValues(alpha: 0.3)),
          ),
          child: Text(
            'Is this statement true or false?',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.warning,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildDefaultContent(BuildContext context) {
    return Column(
      children: [
        Text(
          question.question,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.grey100,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            'Answer the question below.',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildDifficultyIndicator(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final isActive = index < 3; // Default difficulty level
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : AppColors.grey300,
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }

  Color _getQuestionTypeColor() {
    switch (question.type) {
      case QuestionType.translation:
        return AppColors.primary;
      case QuestionType.reverseTranslation:
        return AppColors.secondary;
      case QuestionType.multipleChoice:
        return AppColors.info;
      case QuestionType.fillInTheBlank:
        return AppColors.accent;
      case QuestionType.sentenceCompletion:
        return AppColors.success;
      case QuestionType.trueFalse:
        return AppColors.warning;
      default:
        return AppColors.primary;
    }
  }

  IconData _getQuestionTypeIcon() {
    switch (question.type) {
      case QuestionType.translation:
        return Icons.translate_rounded;
      case QuestionType.reverseTranslation:
        return Icons.swap_horiz_rounded;
      case QuestionType.multipleChoice:
        return Icons.quiz_rounded;
      case QuestionType.fillInTheBlank:
        return Icons.edit_rounded;
      case QuestionType.sentenceCompletion:
        return Icons.text_fields_rounded;
      case QuestionType.trueFalse:
        return Icons.check_circle_outline_rounded;
      default:
        return Icons.help_outline_rounded;
    }
  }

  String _getQuestionTypeTitle() {
    switch (question.type) {
      case QuestionType.translation:
        return 'Translation';
      case QuestionType.reverseTranslation:
        return 'Reverse Translation';
      case QuestionType.multipleChoice:
        return 'Multiple Choice';
      case QuestionType.fillInTheBlank:
        return 'Fill in the Blank';
      case QuestionType.sentenceCompletion:
        return 'Sentence Completion';
      case QuestionType.trueFalse:
        return 'True or False';
      default:
        return 'Question';
    }
  }

  String _getDifficultyText() {
    return 'Medium'; // Default difficulty
  }
}
