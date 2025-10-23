import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/models/exercise_model.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/services/enhanced_tts_service.dart';

/// Translation Exercise Widget (English ↔ Amharic)
class TranslateWidget extends StatefulWidget {
  final Exercise exercise;
  final Function(String) onAnswerSelected;
  final bool showResult;
  final bool isCorrect;
  final String userAnswer;

  const TranslateWidget({
    super.key,
    required this.exercise,
    required this.onAnswerSelected,
    required this.showResult,
    required this.isCorrect,
    required this.userAnswer,
  });

  @override
  State<TranslateWidget> createState() => _TranslateWidgetState();
}

class _TranslateWidgetState extends State<TranslateWidget> {
  final _controller = TextEditingController();
  final _ttsService = EnhancedTTSService();

  @override
  void initState() {
    super.initState();
    _ttsService.initialize();
    if (widget.exercise.type == ExerciseType.translateToEnglish) {
      _ttsService.speakAmharic(widget.exercise.question);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Instructions
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                widget.exercise.type == ExerciseType.translateToAmharic
                    ? Icons.translate_rounded
                    : Icons.record_voice_over_rounded,
                color: const Color(0xFF58CC02),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.exercise.type == ExerciseType.translateToAmharic
                      ? 'Translate to Amharic'
                      : 'Translate to English',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ).animate().fadeIn(),

        const SizedBox(height: 24),

        // Question
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFF58CC02).withValues(alpha: 0.3),
              width: 2,
            ),
          ),
          child: Row(
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
              if (widget.exercise.type == ExerciseType.translateToEnglish)
                IconButton(
                  icon: const Icon(
                    Icons.volume_up_rounded,
                    color: Color(0xFF58CC02),
                  ),
                  onPressed: () {
                    _ttsService.speakAmharic(widget.exercise.question);
                  },
                ),
            ],
          ),
        ).animate().fadeIn(delay: 100.ms).slideY(begin: -0.2, end: 0),

        const SizedBox(height: 32),

        // Answer input
        TextField(
          controller: _controller,
          enabled: !widget.showResult,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
          decoration: InputDecoration(
            hintText: 'Type your answer...',
            hintStyle: const TextStyle(color: Colors.white30),
            filled: true,
            fillColor: const Color(0xFF2A2A2A),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Colors.transparent,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Color(0xFF58CC02),
                width: 2,
              ),
            ),
            suffixIcon: !widget.showResult
                ? IconButton(
                    icon: const Icon(
                      Icons.check_circle_rounded,
                      color: Color(0xFF58CC02),
                    ),
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        widget.onAnswerSelected(_controller.text);
                      }
                    },
                  )
                : null,
          ),
          onSubmitted: (value) {
            if (value.isNotEmpty && !widget.showResult) {
              widget.onAnswerSelected(value);
            }
          },
        ).animate(delay: 200.ms).fadeIn().slideY(begin: 0.2, end: 0),

        // Show correct answer if wrong
        if (widget.showResult && !widget.isCorrect) ...[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF58CC02).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF58CC02),
                width: 2,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Correct answer:',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.exercise.correctAnswer,
                  style: const TextStyle(
                    color: Color(0xFF58CC02),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(),
        ],
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _ttsService.stop();
    super.dispose();
  }
}

