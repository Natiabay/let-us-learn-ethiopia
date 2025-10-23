import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/models/lesson_model.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/models/exercise_model.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/providers/progress_provider.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/widgets/gamification_widgets.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/screens/lessons/exercise_widgets/exercise_widget_factory.dart';

/// Lesson Screen - Main screen for taking lessons
/// Handles exercise flow, scoring, and completion
class LessonScreen extends ConsumerStatefulWidget {
  final Lesson lesson;

  const LessonScreen({
    super.key,
    required this.lesson,
  });

  @override
  ConsumerState<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends ConsumerState<LessonScreen> {
  late ExerciseSession _session;
  bool _showingResult = false;
  bool _isCorrect = false;
  String _userAnswer = '';
  bool _showingLessonComplete = false;
  LessonResult? _lessonResult;

  @override
  void initState() {
    super.initState();
    _session = ExerciseSession(
      lessonId: widget.lesson.id,
      exercises: widget.lesson.exercises,
      startTime: DateTime.now(),
      hearts: ref.read(heartsProvider),
    );
  }

  void _submitAnswer(String answer) {
    setState(() {
      _userAnswer = answer;
      _isCorrect = _session.currentExercise.isCorrect(answer);
      _showingResult = true;
    });

    // Record attempt
    final attempt = ExerciseAttempt(
      exerciseId: _session.currentExercise.id,
      userAnswer: answer,
      isCorrect: _isCorrect,
      attemptedAt: DateTime.now(),
    );

    setState(() {
      _session = _session.addAttempt(attempt);
    });

    // Lose heart if incorrect
    if (!_isCorrect) {
      ref.read(progressProvider.notifier).loseHeart();
    }
  }

  void _nextExercise() {
    if (!_session.canContinue) {
      _showLessonFailed();
      return;
    }

    setState(() {
      _showingResult = false;
      _isCorrect = false;
      _userAnswer = '';
    });

    if (_session.currentExerciseIndex + 1 >= _session.exercises.length) {
      // Lesson complete
      _completeLesson();
    } else {
      // Move to next exercise
      setState(() {
        _session = _session.nextExercise();
      });
    }
  }

  void _completeLesson() {
    final result = _session.calculateResult(
      widget.lesson.xpReward,
      widget.lesson.perfectXPBonus,
    );

    setState(() {
      _lessonResult = result;
      _showingLessonComplete = true;
    });

    // Update progress
    ref.read(progressProvider.notifier).completeLesson(
          lessonId: widget.lesson.id,
          result: result,
        );
  }

  void _showLessonFailed() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A2A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.heart_broken_rounded, color: Color(0xFFFF4B4B), size: 32),
            SizedBox(width: 12),
            Text(
              'Out of Hearts!',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        content: const Text(
          'You ran out of hearts. Practice again when your hearts regenerate!',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop(); // Close dialog
              context.pop(); // Go back to dashboard
            },
            child: const Text(
              'OK',
              style: TextStyle(color: Color(0xFF58CC02)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Show lesson complete summary
    if (_showingLessonComplete && _lessonResult != null) {
      return LessonCompleteSummary(
        correctAnswers: _lessonResult!.correctAnswers,
        totalQuestions: _lessonResult!.totalExercises,
        xpEarned: _lessonResult!.xpEarned,
        isPerfect: _lessonResult!.isPerfect,
        onContinue: () {
          context.pop(); // Go back to dashboard
        },
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F1F1F),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: Colors.white),
          onPressed: () {
            _showExitDialog();
          },
        ),
        title: _buildProgressBar(),
        actions: [
          // Hearts indicator
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: HeartsDisplay(
                current: _session.hearts,
                max: 5,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Exercise area
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ExerciseWidgetFactory.buildExercise(
                  exercise: _session.currentExercise,
                  onAnswerSelected: _submitAnswer,
                  showResult: _showingResult,
                  isCorrect: _isCorrect,
                  userAnswer: _userAnswer,
                ),
              ),
            ),

            // Bottom action area
            _buildBottomArea(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    final progress = (_session.currentExerciseIndex + 1) / _session.exercises.length;
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: LinearProgressIndicator(
        value: progress,
        minHeight: 8,
        backgroundColor: Colors.white.withValues(alpha: 0.2),
        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF58CC02)),
      ),
    );
  }

  Widget _buildBottomArea() {
    if (!_showingResult) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _isCorrect
            ? const Color(0xFF58CC02)
            : const Color(0xFFFF4B4B),
        boxShadow: [
          BoxShadow(
            color: (_isCorrect ? const Color(0xFF58CC02) : const Color(0xFFFF4B4B))
                .withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Result message
            Row(
              children: [
                Icon(
                  _isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
                  color: Colors.white,
                  size: 32,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _isCorrect ? 'Correct!' : 'Incorrect',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (!_isCorrect)
                        Text(
                          'Correct answer: ${_session.currentExercise.correctAnswer}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            
            // Explanation (if available)
            if (_session.currentExercise.explanation != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _session.currentExercise.explanation!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
              ),
            ],

            const SizedBox(height: 20),

            // Continue button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _nextExercise,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: _isCorrect
                      ? const Color(0xFF58CC02)
                      : const Color(0xFFFF4B4B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'CONTINUE',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showExitDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A2A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Exit Lesson?',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Your progress won\'t be saved if you exit now.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text(
              'CANCEL',
              style: TextStyle(color: Colors.white70),
            ),
          ),
          TextButton(
            onPressed: () {
              context.pop(); // Close dialog
              context.pop(); // Go back to dashboard
            },
            child: const Text(
              'EXIT',
              style: TextStyle(color: Color(0xFFFF4B4B)),
            ),
          ),
        ],
      ),
    );
  }
}

