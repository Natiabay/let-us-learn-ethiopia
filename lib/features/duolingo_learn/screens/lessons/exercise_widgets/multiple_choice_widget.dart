import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/models/exercise_model.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/services/enhanced_tts_service.dart';

/// Multiple Choice Exercise Widget
class MultipleChoiceWidget extends StatefulWidget {
  final Exercise exercise;
  final Function(String) onAnswerSelected;
  final bool showResult;
  final bool isCorrect;

  const MultipleChoiceWidget({
    super.key,
    required this.exercise,
    required this.onAnswerSelected,
    required this.showResult,
    required this.isCorrect,
  });

  @override
  State<MultipleChoiceWidget> createState() => _MultipleChoiceWidgetState();
}

class _MultipleChoiceWidgetState extends State<MultipleChoiceWidget> {
  String? _selectedAnswer;
  final _ttsService = EnhancedTTSService();

  @override
  void initState() {
    super.initState();
    _initializeTTS();
  }

  Future<void> _initializeTTS() async {
    await _ttsService.initialize();
    // Auto-play question if it has audio
    if (widget.exercise.questionAmharic != null) {
      await _ttsService.speakAmharic(widget.exercise.questionAmharic!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Question
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select the correct answer:',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.exercise.question,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (widget.exercise.questionAmharic != null)
                    IconButton(
                      icon: const Icon(
                        Icons.volume_up_rounded,
                        color: Color(0xFF58CC02),
                      ),
                      onPressed: () {
                        _ttsService.speakAmharic(widget.exercise.questionAmharic!);
                      },
                    ),
                ],
              ),
            ],
          ),
        ).animate().fadeIn().slideY(begin: -0.2, end: 0),

        const SizedBox(height: 32),

        // Options
        ...List.generate(
          widget.exercise.options.length,
          (index) {
            final option = widget.exercise.options[index];
            final isSelected = _selectedAnswer == option.text;
            final isCorrectOption = option.isCorrect;

            Color? backgroundColor;
            Color? borderColor;

            if (widget.showResult && isSelected) {
              backgroundColor = widget.isCorrect
                  ? const Color(0xFF58CC02).withValues(alpha: 0.2)
                  : const Color(0xFFFF4B4B).withValues(alpha: 0.2);
              borderColor = widget.isCorrect
                  ? const Color(0xFF58CC02)
                  : const Color(0xFFFF4B4B);
            } else if (widget.showResult && isCorrectOption) {
              backgroundColor = const Color(0xFF58CC02).withValues(alpha: 0.2);
              borderColor = const Color(0xFF58CC02);
            } else if (isSelected) {
              backgroundColor = const Color(0xFF58CC02).withValues(alpha: 0.1);
              borderColor = const Color(0xFF58CC02);
            } else {
              backgroundColor = const Color(0xFF2A2A2A);
              borderColor = Colors.transparent;
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                onTap: widget.showResult
                    ? null
                    : () {
                        setState(() {
                          _selectedAnswer = option.text;
                        });
                        widget.onAnswerSelected(option.text);
                      },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    border: Border.all(color: borderColor, width: 2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          option.text,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      if (widget.showResult && isSelected)
                        Icon(
                          widget.isCorrect
                              ? Icons.check_circle_rounded
                              : Icons.cancel_rounded,
                          color: widget.isCorrect
                              ? const Color(0xFF58CC02)
                              : const Color(0xFFFF4B4B),
                        ),
                    ],
                  ),
                ),
              ).animate(delay: (index * 100).ms).fadeIn().slideX(begin: -0.2, end: 0),
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _ttsService.stop();
    super.dispose();
  }
}

