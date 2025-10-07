import 'package:flutter/material.dart';
import 'package:tourist_assistive_app/core/theme/app_theme.dart';
import 'package:tourist_assistive_app/features/language/models/lesson.dart';

class ExerciseWidget extends StatefulWidget {
  final Exercise exercise;
  final Function(bool) onAnswerSelected;

  const ExerciseWidget({
    super.key,
    required this.exercise,
    required this.onAnswerSelected,
  });

  @override
  State<ExerciseWidget> createState() => _ExerciseWidgetState();
}

class _ExerciseWidgetState extends State<ExerciseWidget> {
  String? _selectedAnswer;
  bool _answered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Exercise Type Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.3),
              ),
            ),
            child: Text(
              _getExerciseTypeText(),
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Question
          Text(
            widget.exercise.question,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: 8),

          // Translations (if available)
          if (widget.exercise.translations.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.info.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.info.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.translate,
                    color: AppColors.info,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.exercise.translations.values.join(', '),
                      style: const TextStyle(
                        color: AppColors.info,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          const SizedBox(height: 32),

          // Audio Button (if audio available)
          if (widget.exercise.audioUrl != null)
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: Play audio
                },
                icon: const Icon(Icons.volume_up),
                label: const Text('Play Audio'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.info,
                  foregroundColor: AppColors.white,
                ),
              ),
            ),

          if (widget.exercise.audioUrl != null) const SizedBox(height: 24),

          // Answer Options
          Expanded(
            child: ListView.builder(
              itemCount: widget.exercise.options.length,
              itemBuilder: (context, index) {
                final option = widget.exercise.options[index];
                final isSelected = _selectedAnswer == option;
                final isCorrect = option == widget.exercise.correctAnswer;
                
                Color backgroundColor = AppColors.white;
                Color borderColor = AppColors.grey.withValues(alpha: 0.3);
                Color textColor = AppColors.textPrimary;

                if (_answered) {
                  if (isCorrect) {
                    backgroundColor = AppColors.success.withValues(alpha: 0.1);
                    borderColor = AppColors.success;
                    textColor = AppColors.success;
                  } else if (isSelected && !isCorrect) {
                    backgroundColor = AppColors.error.withValues(alpha: 0.1);
                    borderColor = AppColors.error;
                    textColor = AppColors.error;
                  }
                } else if (isSelected) {
                  backgroundColor = AppColors.primary.withValues(alpha: 0.1);
                  borderColor = AppColors.primary;
                  textColor = AppColors.primary;
                }

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: GestureDetector(
                    onTap: _answered ? null : () => _selectAnswer(option),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: borderColor,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          // Option indicator
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: borderColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                String.fromCharCode(65 + index), // A, B, C, D
                                style: TextStyle(
                                  color: _answered && isCorrect 
                                      ? AppColors.white 
                                      : (isSelected || (_answered && isCorrect) 
                                          ? AppColors.white 
                                          : borderColor),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          
                          const SizedBox(width: 16),
                          
                          // Option text
                          Expanded(
                            child: Text(
                              option,
                              style: TextStyle(
                                color: textColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          
                          // Check/Cross icon for answered state
                          if (_answered) ...[
                            Icon(
                              isCorrect ? Icons.check_circle : 
                              (isSelected ? Icons.cancel : null),
                              color: isCorrect ? AppColors.success : AppColors.error,
                              size: 24,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Explanation (shown after answering)
          if (_answered) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.info.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.info.withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.lightbulb_outline,
                        color: AppColors.info,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Explanation',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.info,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.exercise.explanation,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _selectAnswer(String answer) {
    if (_answered) return;

    setState(() {
      _selectedAnswer = answer;
      _answered = true;
    });

    final isCorrect = answer == widget.exercise.correctAnswer;
    
    // Delay callback to show visual feedback
    Future.delayed(const Duration(milliseconds: 500), () {
      widget.onAnswerSelected(isCorrect);
    });
  }

  String _getExerciseTypeText() {
    switch (widget.exercise.type) {
      case ExerciseType.multipleChoice:
        return 'Multiple Choice';
      case ExerciseType.fillInTheBlank:
        return 'Fill in the Blank';
      case ExerciseType.matchPairs:
        return 'Match Pairs';
      case ExerciseType.listening:
        return 'Listening';
      case ExerciseType.speaking:
        return 'Speaking';
      case ExerciseType.translation:
        return 'Translation';
      case ExerciseType.ordering:
        return 'Put in Order';
      case ExerciseType.imageSelection:
        return 'Image Selection';
    }
  }
}




















