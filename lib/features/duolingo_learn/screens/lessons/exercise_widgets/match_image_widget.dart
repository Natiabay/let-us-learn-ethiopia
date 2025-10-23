import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/models/exercise_model.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/services/enhanced_tts_service.dart';

/// Match Image to Word Exercise Widget
class MatchImageWidget extends StatefulWidget {
  final Exercise exercise;
  final Function(String) onAnswerSelected;
  final bool showResult;
  final bool isCorrect;

  const MatchImageWidget({
    super.key,
    required this.exercise,
    required this.onAnswerSelected,
    required this.showResult,
    required this.isCorrect,
  });

  @override
  State<MatchImageWidget> createState() => _MatchImageWidgetState();
}

class _MatchImageWidgetState extends State<MatchImageWidget> {
  String? _selectedAnswer;
  final _ttsService = EnhancedTTSService();

  @override
  void initState() {
    super.initState();
    _ttsService.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Question header
        const Text(
          'Match the image to the word:',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ).animate().fadeIn(),

        const SizedBox(height: 24),

        // Image
        if (widget.exercise.imageUrl != null)
          Center(
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFF58CC02).withValues(alpha: 0.3),
                  width: 2,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  widget.exercise.imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(
                        Icons.image_rounded,
                        color: Colors.white30,
                        size: 64,
                      ),
                    );
                  },
                ),
              ),
            ).animate().scale(duration: 400.ms, curve: Curves.easeOut),
          ),

        const SizedBox(height: 32),

        // Word options (grid layout)
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: widget.exercise.options.length,
          itemBuilder: (context, index) {
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

            return InkWell(
              onTap: widget.showResult
                  ? null
                  : () {
                      setState(() {
                        _selectedAnswer = option.text;
                      });
                      // Speak the word
                      if (option.textAmharic != null) {
                        _ttsService.speakAmharic(option.textAmharic!);
                      }
                      widget.onAnswerSelected(option.text);
                    },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  color: backgroundColor,
                  border: Border.all(color: borderColor, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          option.text,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        if (option.textAmharic != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            option.textAmharic!,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ).animate(delay: (index * 100).ms).fadeIn().scale();
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

