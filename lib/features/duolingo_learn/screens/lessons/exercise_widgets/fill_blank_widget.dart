import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/models/exercise_model.dart';

/// Fill in the Blank Exercise Widget
class FillBlankWidget extends StatefulWidget {
  final Exercise exercise;
  final Function(String) onAnswerSelected;
  final bool showResult;
  final bool isCorrect;
  final String userAnswer;

  const FillBlankWidget({
    super.key,
    required this.exercise,
    required this.onAnswerSelected,
    required this.showResult,
    required this.isCorrect,
    required this.userAnswer,
  });

  @override
  State<FillBlankWidget> createState() => _FillBlankWidgetState();
}

class _FillBlankWidgetState extends State<FillBlankWidget> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Split sentence at underscore to show blank
    final parts = widget.exercise.question.split('___');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Instructions
        const Text(
          'Fill in the blank:',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ).animate().fadeIn(),

        const SizedBox(height: 24),

        // Sentence with blank
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              if (parts.isNotEmpty)
                Text(
                  parts[0],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              // Blank input
              Container(
                width: 150,
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: widget.showResult
                      ? (widget.isCorrect
                          ? const Color(0xFF58CC02).withValues(alpha: 0.2)
                          : const Color(0xFFFF4B4B).withValues(alpha: 0.2))
                      : const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: widget.showResult
                        ? (widget.isCorrect
                            ? const Color(0xFF58CC02)
                            : const Color(0xFFFF4B4B))
                        : const Color(0xFF58CC02).withValues(alpha: 0.3),
                    width: 2,
                  ),
                ),
                child: TextField(
                  controller: _controller,
                  enabled: !widget.showResult,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  ),
                  onSubmitted: (value) {
                    if (value.isNotEmpty && !widget.showResult) {
                      widget.onAnswerSelected(value);
                    }
                  },
                ),
              ),
              if (parts.length > 1)
                Text(
                  parts[1],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
            ],
          ),
        ).animate().fadeIn(delay: 100.ms).slideY(begin: -0.2, end: 0),

        const SizedBox(height: 24),

        // Word bank (if options provided)
        if (widget.exercise.options.isNotEmpty) ...[
          const Text(
            'Choose from:',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: widget.exercise.options.map((option) {
              return InkWell(
                onTap: widget.showResult
                    ? null
                    : () {
                        setState(() {
                          _controller.text = option.text;
                        });
                        widget.onAnswerSelected(option.text);
                      },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: _controller.text == option.text
                        ? const Color(0xFF58CC02).withValues(alpha: 0.2)
                        : const Color(0xFF2A2A2A),
                    border: Border.all(
                      color: _controller.text == option.text
                          ? const Color(0xFF58CC02)
                          : Colors.transparent,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    option.text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            }).toList(),
          ).animate(delay: 200.ms).fadeIn(),
        ],

        // Submit button if no word bank
        if (widget.exercise.options.isEmpty && !widget.showResult) ...[
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  widget.onAnswerSelected(_controller.text);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF58CC02),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'CHECK',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ).animate(delay: 300.ms).fadeIn(),
        ],

        // Show correct answer if wrong
        if (widget.showResult && !widget.isCorrect) ...[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF58CC02).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.lightbulb_rounded,
                  color: Color(0xFF58CC02),
                ),
                const SizedBox(width: 12),
                Expanded(
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
                      Text(
                        widget.exercise.correctAnswer,
                        style: const TextStyle(
                          color: Color(0xFF58CC02),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
    super.dispose();
  }
}

