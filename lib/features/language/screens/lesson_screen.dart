import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tourist_assistive_app/core/theme/app_theme.dart';
import 'package:tourist_assistive_app/features/language/models/lesson.dart';
import 'package:tourist_assistive_app/features/language/providers/language_learning_provider.dart';
import 'package:tourist_assistive_app/features/language/widgets/exercise_widget.dart';

class LessonScreen extends ConsumerStatefulWidget {
  final String lessonId;

  const LessonScreen({
    super.key,
    required this.lessonId,
  });

  @override
  ConsumerState<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends ConsumerState<LessonScreen> {
  late PageController _pageController;
  int _currentExerciseIndex = 0;
  int _score = 0;
  List<bool> _exerciseResults = [];
  bool _isLessonCompleted = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Lesson ${widget.lessonId}'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => _showExitConfirmation(),
          ),
        ],
      ),
      body: FutureBuilder<Lesson?>(
        future: ref.read(languageServiceProvider).getLesson(widget.lessonId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            );
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: AppColors.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Failed to load lesson',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.pop(),
                    child: const Text('Go Back'),
                  ),
                ],
              ),
            );
          }

          final lesson = snapshot.data!;
          
          if (_exerciseResults.isEmpty) {
            _exerciseResults = List.filled(lesson.exercises.length, false);
          }

          if (_isLessonCompleted) {
            return _buildCompletionScreen(lesson);
          }

          return Column(
            children: [
              // Progress Bar
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Exercise ${_currentExerciseIndex + 1} of ${lesson.exercises.length}',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Score: $_score/${lesson.exercises.length}',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: (_currentExerciseIndex + 1) / lesson.exercises.length,
                      backgroundColor: AppColors.lightGrey,
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                    ),
                  ],
                ),
              ),

              // Exercise Content
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentExerciseIndex = index;
                    });
                  },
                  itemCount: lesson.exercises.length,
                  itemBuilder: (context, index) {
                    return ExerciseWidget(
                      exercise: lesson.exercises[index],
                      onAnswerSelected: (isCorrect) => _handleAnswer(isCorrect, index),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _handleAnswer(bool isCorrect, int exerciseIndex) {
    setState(() {
      if (!_exerciseResults[exerciseIndex]) {
        _exerciseResults[exerciseIndex] = isCorrect;
        if (isCorrect) {
          _score++;
        }
      }
    });

    // Show feedback and move to next exercise
    _showAnswerFeedback(isCorrect, () {
      if (_currentExerciseIndex < _exerciseResults.length - 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        _completeLesson();
      }
    });
  }

  void _showAnswerFeedback(bool isCorrect, VoidCallback onNext) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: isCorrect ? AppColors.success : AppColors.error,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isCorrect ? Icons.check_circle : Icons.cancel,
              color: AppColors.white,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              isCorrect ? 'Correct!' : 'Not quite right',
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isCorrect 
                  ? 'Great job! Keep it up!' 
                  : 'Don\'t worry, keep practicing!',
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                context.pop();
                onNext();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.white,
                foregroundColor: isCorrect ? AppColors.success : AppColors.error,
              ),
              child: Text(
                _currentExerciseIndex < _exerciseResults.length - 1 
                    ? 'Continue' 
                    : 'Finish Lesson',
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _completeLesson() {
    setState(() {
      _isLessonCompleted = true;
    });

    // Update progress
    final xpEarned = (_score / _exerciseResults.length * 50).round();
    ref.read(languageLearningProvider.notifier).completeLesson(
      widget.lessonId,
      xpEarned,
    );
  }

  Widget _buildCompletionScreen(Lesson lesson) {
    final percentage = (_score / _exerciseResults.length * 100).round();
    final xpEarned = (_score / _exerciseResults.length * lesson.xpReward).round();

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Completion Icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(60),
                border: Border.all(
                  color: AppColors.success,
                  width: 4,
                ),
              ),
              child: const Icon(
                Icons.celebration,
                color: AppColors.success,
                size: 60,
              ),
            ),

            const SizedBox(height: 32),

            // Completion Text
            Text(
              'Lesson Complete!',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),

            Text(
              'You scored $percentage% and earned $xpEarned XP!',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 32),

            // Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _StatCard(
                  icon: Icons.quiz,
                  value: '$_score/${_exerciseResults.length}',
                  label: 'Correct',
                ),
                _StatCard(
                  icon: Icons.percent,
                  value: '$percentage%',
                  label: 'Accuracy',
                ),
                _StatCard(
                  icon: Icons.star,
                  value: '$xpEarned',
                  label: 'XP Earned',
                ),
              ],
            ),

            const SizedBox(height: 48),

            // Action Buttons
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => context.pop(),
                    child: const Text('Continue Learning'),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      // Reset lesson state and restart
                      setState(() {
                        _currentExerciseIndex = 0;
                        _score = 0;
                        _exerciseResults.fillRange(0, _exerciseResults.length, false);
                        _isLessonCompleted = false;
                      });
                      _pageController.animateToPage(
                        0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: const Text('Practice Again'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showExitConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit Lesson?'),
        content: const Text(
          'Are you sure you want to exit? Your progress will be lost.',
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Continue Lesson'),
          ),
          TextButton(
            onPressed: () {
              context.pop(); // Close dialog
              context.pop(); // Exit lesson
            },
            child: const Text('Exit'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: AppColors.primary,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}















