import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/models/exercise_model.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/services/enhanced_tts_service.dart';

/// Listening Exercise Widget
class ListeningWidget extends StatefulWidget {
  final Exercise exercise;
  final Function(String) onAnswerSelected;
  final bool showResult;
  final bool isCorrect;
  final String userAnswer;

  const ListeningWidget({
    super.key,
    required this.exercise,
    required this.onAnswerSelected,
    required this.showResult,
    required this.isCorrect,
    required this.userAnswer,
  });

  @override
  State<ListeningWidget> createState() => _ListeningWidgetState();
}

class _ListeningWidgetState extends State<ListeningWidget> {
  final _controller = TextEditingController();
  final _ttsService = EnhancedTTSService();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _ttsService.initialize();
    // Auto-play audio once
    Future.delayed(const Duration(milliseconds: 500), () {
      _playAudio();
    });
  }

  Future<void> _playAudio() async {
    setState(() => _isPlaying = true);
    
    // Speak the question (Amharic audio)
    await _ttsService.speakAmharic(
      widget.exercise.question,
      speed: 0.6, // Slower for listening comprehension
    );
    
    setState(() => _isPlaying = false);
  }

  @override
  Widget build(BuildContext context) {
    final isTypeExercise = widget.exercise.type == ExerciseType.typeWhatYouHear;

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
              const Icon(
                Icons.headphones_rounded,
                color: Color(0xFF58CC02),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  isTypeExercise
                      ? 'Type what you hear'
                      : 'Select what you hear',
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

        const SizedBox(height: 32),

        // Audio player button
        Center(
          child: InkWell(
            onTap: _isPlaying ? null : _playAudio,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: const Color(0xFF58CC02).withValues(alpha: 0.2),
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF58CC02),
                  width: 3,
                ),
              ),
              child: Icon(
                _isPlaying ? Icons.volume_up_rounded : Icons.play_arrow_rounded,
                color: const Color(0xFF58CC02),
                size: 64,
              ),
            ),
          ).animate(target: _isPlaying ? 1 : 0).scale().shimmer(),
        ).animate(delay: 100.ms).scale(duration: 400.ms),

        const SizedBox(height: 16),

        Center(
          child: Text(
            _isPlaying ? 'Playing...' : 'Tap to play again',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ).animate().fadeIn(delay: 200.ms),

        const SizedBox(height: 40),

        // Type answer or select from options
        if (isTypeExercise) ...[
          // Text input for typing
          TextField(
            controller: _controller,
            enabled: !widget.showResult,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
            decoration: InputDecoration(
              hintText: 'Type what you heard...',
              hintStyle: const TextStyle(color: Colors.white30),
              filled: true,
              fillColor: const Color(0xFF2A2A2A),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
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
          ).animate(delay: 300.ms).fadeIn().slideY(begin: 0.2, end: 0),
        ] else ...[
          // Multiple choice options
          ...List.generate(
            widget.exercise.options.length,
            (index) {
              final option = widget.exercise.options[index];
              final isSelected = widget.userAnswer == option.text;
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
                    child: Text(
                      option.text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ).animate(delay: (300 + index * 100).ms).fadeIn().slideX(begin: -0.2, end: 0);
            },
          ),
        ],

        // Show correct answer if wrong
        if (widget.showResult && !widget.isCorrect && isTypeExercise) ...[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF58CC02).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
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

