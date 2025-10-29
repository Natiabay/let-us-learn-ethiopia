import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/models/lesson_model.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/models/exercise_model.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/services/enhanced_tts_service.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/providers/progress_provider.dart';
import 'package:tourist_assistive_app/features/language/widgets/speaker_button.dart';

/// Interactive Lesson Screen - Exactly like Duolingo
/// Features: Multiple choice, translation, listening, speaking, matching
class InteractiveLessonScreen extends ConsumerStatefulWidget {
  final Lesson lesson;

  const InteractiveLessonScreen({
    super.key,
    required this.lesson,
  });

  @override
  ConsumerState<InteractiveLessonScreen> createState() => _InteractiveLessonScreenState();
}

class _InteractiveLessonScreenState extends ConsumerState<InteractiveLessonScreen>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late AnimationController _heartController;
  late AnimationController _correctController;
  late AnimationController _wrongController;
  
  final EnhancedTTSService _ttsService = EnhancedTTSService();
  
  int _currentExerciseIndex = 0;
  int _hearts = 5;
  int _xpEarned = 0;
  int _correctAnswers = 0;
  bool _isAnswerSelected = false;
  bool _isCorrect = false;
  String? _selectedAnswer;
  List<String> _userAnswer = [];
  bool _showResult = false;
  bool _lessonCompleted = false;
  late DateTime _startTime;

  @override
  void initState() {
    super.initState();
    _startTime = DateTime.now();
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _heartController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _correctController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _wrongController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    
    _ttsService.initialize();
    _updateProgress();
  }

  @override
  void dispose() {
    _progressController.dispose();
    _heartController.dispose();
    _correctController.dispose();
    _wrongController.dispose();
    _ttsService.stop();
    super.dispose();
  }

  void _updateProgress() {
    final progress = (_currentExerciseIndex + 1) / widget.lesson.exercises.length;
    _progressController.animateTo(progress);
  }

  Exercise get _currentExercise => widget.lesson.exercises[_currentExerciseIndex];

  @override
  Widget build(BuildContext context) {
    if (_lessonCompleted) {
      return _buildCompletionScreen();
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            _buildProgressBar(),
            Expanded(
              child: _buildExerciseContent(),
            ),
            _buildBottomSection(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF1A1A1A),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.close_rounded, color: Colors.white),
        onPressed: () => _showExitDialog(),
      ),
      title: Row(
        children: [
          // Hearts
          Row(
            children: List.generate(5, (index) {
              final hasHeart = index < _hearts;
              return Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Icon(
                  hasHeart ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  color: hasHeart ? const Color(0xFFFF4B4B) : Colors.white30,
                  size: 20,
                ),
              );
            }),
          ),
          const Spacer(),
          // XP Counter
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFFFD43B).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.star_rounded, color: Color(0xFFFFD43B), size: 16),
                const SizedBox(width: 4),
                Text(
                  '+$_xpEarned',
                  style: const TextStyle(
                    color: Color(0xFFFFD43B),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '${_currentExerciseIndex + 1}/${widget.lesson.exercises.length}',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                widget.lesson.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AnimatedBuilder(
              animation: _progressController,
              builder: (context, child) {
                return LinearProgressIndicator(
                  value: _progressController.value,
                  minHeight: 8,
                  backgroundColor: Colors.white.withValues(alpha: 0.2),
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF58CC02)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseContent() {
    switch (_currentExercise.type) {
      case ExerciseType.multipleChoice:
        return _buildMultipleChoiceExercise();
      case ExerciseType.translateToAmharic:
        return _buildTranslationExercise();
      case ExerciseType.listening:
        return _buildListeningExercise();
      case ExerciseType.fillBlank:
        return _buildWordOrderExercise();
      case ExerciseType.matchImage:
        return _buildMatchingExercise();
      case ExerciseType.fillBlank:
        return _buildFillInBlankExercise();
      default:
        return _buildMultipleChoiceExercise();
    }
  }

  Widget _buildMultipleChoiceExercise() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select the correct translation',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _currentExercise.question,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    CompactSpeakerButton(
                      text: _currentExercise.question,
                      languageCode: 'am',
                      color: const Color(0xFF58CC02),
                      size: 24.0,
                    ),
                  ],
                ),
              ],
            ),
          ).animate().fadeIn().slideY(begin: -0.2, end: 0),
          
          const SizedBox(height: 32),
          
          // Answer Options
          Expanded(
            child: ListView.builder(
              itemCount: _currentExercise.options.length,
              itemBuilder: (context, index) {
                final option = _currentExercise.options[index];
                final isSelected = _selectedAnswer == option.text;
                final isCorrect = option.text == _currentExercise.correctAnswer;
                
                Color backgroundColor = const Color(0xFF2A2A2A);
                Color borderColor = Colors.transparent;
                Color textColor = Colors.white;
                
                if (_showResult && isSelected) {
                  if (isCorrect) {
                    backgroundColor = const Color(0xFF58CC02).withValues(alpha: 0.2);
                    borderColor = const Color(0xFF58CC02);
                    textColor = const Color(0xFF58CC02);
                  } else {
                    backgroundColor = const Color(0xFFFF4B4B).withValues(alpha: 0.2);
                    borderColor = const Color(0xFFFF4B4B);
                    textColor = const Color(0xFFFF4B4B);
                  }
                } else if (_showResult && isCorrect) {
                  backgroundColor = const Color(0xFF58CC02).withValues(alpha: 0.2);
                  borderColor = const Color(0xFF58CC02);
                  textColor = const Color(0xFF58CC02);
                } else if (isSelected) {
                  backgroundColor = const Color(0xFF1CB0F6).withValues(alpha: 0.2);
                  borderColor = const Color(0xFF1CB0F6);
                  textColor = const Color(0xFF1CB0F6);
                }
                
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: InkWell(
                    onTap: _showResult ? null : () => _selectAnswer(option.text),
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: borderColor, width: 2),
                      ),
                      child: Text(
                        option.text,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ).animate(delay: (index * 100).ms).fadeIn().slideX(begin: -0.3, end: 0),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTranslationExercise() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Translate this sentence',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _currentExercise.question,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    CompactSpeakerButton(
                      text: _currentExercise.question,
                      languageCode: 'en',
                      color: const Color(0xFF58CC02),
                      size: 24.0,
                    ),
                  ],
                ),
              ],
            ),
          ).animate().fadeIn().slideY(begin: -0.2, end: 0),
          
          const SizedBox(height: 32),
          
          // Word Bank
          Text(
            'Tap the words in the correct order',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          
          // User's answer area
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: 60),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _userAnswer.isNotEmpty 
                    ? const Color(0xFF58CC02).withValues(alpha: 0.3)
                    : Colors.white.withValues(alpha: 0.2),
              ),
            ),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _userAnswer.map((word) {
                return InkWell(
                  onTap: () => _removeWordFromAnswer(word),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF58CC02).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFF58CC02)),
                    ),
                    child: Text(
                      word,
                      style: const TextStyle(
                        color: Color(0xFF58CC02),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Word bank
          Expanded(
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _currentExercise.options.where((word) => !_userAnswer.contains(word.text)).map((word) {
                return InkWell(
                  onTap: () => _addWordToAnswer(word.text),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A2A),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                    ),
                    child: Text(
                      word.text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListeningExercise() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          
          // Audio icon and instruction
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.volume_up_rounded,
              color: const Color(0xFF58CC02),
              size: 80,
            ),
          ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
          
          const SizedBox(height: 32),
          
          Text(
            'What do you hear?',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Play button
          ElevatedButton.icon(
            onPressed: () => _playAudio(_currentExercise.question),
            icon: const Icon(Icons.play_arrow_rounded),
            label: const Text('Play Audio'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF58CC02),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          
          const Spacer(),
          
          // Answer options
          ...List.generate(_currentExercise.options.length, (index) {
            final option = _currentExercise.options[index];
            final isSelected = _selectedAnswer == option.text;
            final isCorrect = option.text == _currentExercise.correctAnswer;
            
            Color backgroundColor = const Color(0xFF2A2A2A);
            Color borderColor = Colors.transparent;
            Color textColor = Colors.white;
            
            if (_showResult && isSelected) {
              if (isCorrect) {
                backgroundColor = const Color(0xFF58CC02).withValues(alpha: 0.2);
                borderColor = const Color(0xFF58CC02);
                textColor = const Color(0xFF58CC02);
              } else {
                backgroundColor = const Color(0xFFFF4B4B).withValues(alpha: 0.2);
                borderColor = const Color(0xFFFF4B4B);
                textColor = const Color(0xFFFF4B4B);
              }
            } else if (_showResult && isCorrect) {
              backgroundColor = const Color(0xFF58CC02).withValues(alpha: 0.2);
              borderColor = const Color(0xFF58CC02);
              textColor = const Color(0xFF58CC02);
            } else if (isSelected) {
              backgroundColor = const Color(0xFF1CB0F6).withValues(alpha: 0.2);
              borderColor = const Color(0xFF1CB0F6);
              textColor = const Color(0xFF1CB0F6);
            }
            
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                onTap: _showResult ? null : () => _selectAnswer(option.text),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: borderColor, width: 2),
                  ),
                  child: Text(
                    option.text,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ).animate(delay: (index * 100).ms).fadeIn().slideX(begin: -0.3, end: 0),
            );
          }),
          
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildWordOrderExercise() {
    return _buildTranslationExercise(); // Same UI as translation
  }

  Widget _buildMatchingExercise() {
    return _buildMultipleChoiceExercise(); // Simplified for now
  }

  Widget _buildFillInBlankExercise() {
    return _buildMultipleChoiceExercise(); // Simplified for now
  }

  Widget _buildBottomSection() {
    if (!_showResult) {
      return Container(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: _canSubmitAnswer() ? _checkAnswer : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _canSubmitAnswer() 
                  ? const Color(0xFF58CC02) 
                  : Colors.grey.withValues(alpha: 0.3),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            child: const Text(
              'CHECK',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _isCorrect 
            ? const Color(0xFF58CC02).withValues(alpha: 0.1)
            : const Color(0xFFFF4B4B).withValues(alpha: 0.1),
        border: Border(
          top: BorderSide(
            color: _isCorrect ? const Color(0xFF58CC02) : const Color(0xFFFF4B4B),
            width: 3,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                _isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
                color: _isCorrect ? const Color(0xFF58CC02) : const Color(0xFFFF4B4B),
                size: 32,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _isCorrect ? 'Correct!' : 'Incorrect',
                      style: TextStyle(
                        color: _isCorrect ? const Color(0xFF58CC02) : const Color(0xFFFF4B4B),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (!_isCorrect) ...[
                      const SizedBox(height: 4),
                      Text(
                        'Correct answer: ${_currentExercise.correctAnswer}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _nextExercise,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isCorrect ? const Color(0xFF58CC02) : const Color(0xFFFF4B4B),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                _currentExerciseIndex < widget.lesson.exercises.length - 1 
                    ? 'CONTINUE' 
                    : 'FINISH',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.3, end: 0);
  }

  Widget _buildCompletionScreen() {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Success animation
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: const Color(0xFF58CC02),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF58CC02).withValues(alpha: 0.3),
                      blurRadius: 30,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 60,
                ),
              ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
              
              const SizedBox(height: 32),
              
              Text(
                'Lesson Complete!',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ).animate().fadeIn(delay: 300.ms),
              
              const SizedBox(height: 16),
              
              Text(
                'Great job! You earned $_xpEarned XP',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ).animate().fadeIn(delay: 500.ms),
              
              const SizedBox(height: 32),
              
              // Stats
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2A2A),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Correct Answers',
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                        Text(
                          '$_correctAnswers/${widget.lesson.exercises.length}',
                          style: const TextStyle(
                            color: Color(0xFF58CC02),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'XP Earned',
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                        Text(
                          '+$_xpEarned',
                          style: const TextStyle(
                            color: Color(0xFFFFD43B),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.3, end: 0),
              
              const SizedBox(height: 32),
              
              // Continue button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // Update progress and return to dashboard
                    ref.read(progressProvider.notifier).completeLesson(
                      lessonId: widget.lesson.id,
                      result: LessonResult(
                        lessonId: widget.lesson.id,
                        totalExercises: widget.lesson.exercises.length,
                        correctAnswers: _correctAnswers,
                        mistakes: widget.lesson.exercises.length - _correctAnswers,
                        xpEarned: _xpEarned,
                        timeSpent: DateTime.now().difference(_startTime),
                        isPerfect: _correctAnswers == widget.lesson.exercises.length,
                        completedAt: DateTime.now(),
                      ),
                    );
                    context.go('/language');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF58CC02),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'CONTINUE',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ).animate().fadeIn(delay: 900.ms).slideY(begin: 0.3, end: 0),
            ],
          ),
        ),
      ),
    );
  }

  void _selectAnswer(String answer) {
    if (_showResult) return;
    
    setState(() {
      _selectedAnswer = answer;
      _isAnswerSelected = true;
    });
  }

  void _addWordToAnswer(String word) {
    if (_showResult) return;
    
    setState(() {
      _userAnswer.add(word);
      _isAnswerSelected = _userAnswer.isNotEmpty;
    });
  }

  void _removeWordFromAnswer(String word) {
    if (_showResult) return;
    
    setState(() {
      _userAnswer.remove(word);
      _isAnswerSelected = _userAnswer.isNotEmpty;
    });
  }

  bool _canSubmitAnswer() {
    switch (_currentExercise.type) {
      case ExerciseType.multipleChoice:
      case ExerciseType.listening:
        return _selectedAnswer != null;
      case ExerciseType.translateToAmharic:
      case ExerciseType.fillBlank:
        return _userAnswer.isNotEmpty;
      default:
        return _isAnswerSelected;
    }
  }

  void _checkAnswer() {
    if (!_canSubmitAnswer()) return;
    
    bool isCorrect = false;
    
    switch (_currentExercise.type) {
      case ExerciseType.multipleChoice:
      case ExerciseType.listening:
        isCorrect = _selectedAnswer == _currentExercise.correctAnswer;
        break;
      case ExerciseType.translateToAmharic:
      case ExerciseType.fillBlank:
        final userAnswerString = _userAnswer.join(' ');
        isCorrect = userAnswerString.toLowerCase() == _currentExercise.correctAnswer.toLowerCase();
        break;
      default:
        isCorrect = _selectedAnswer == _currentExercise.correctAnswer;
    }
    
    setState(() {
      _isCorrect = isCorrect;
      _showResult = true;
    });
    
    if (isCorrect) {
      _correctAnswers++;
      _xpEarned += 10;
      _correctController.forward();
    } else {
      _hearts = (_hearts - 1).clamp(0, 5);
      _heartController.forward().then((_) => _heartController.reset());
      _wrongController.forward().then((_) => _wrongController.reset());
      
      if (_hearts == 0) {
        _showGameOverDialog();
        return;
      }
    }
  }

  void _nextExercise() {
    if (_currentExerciseIndex < widget.lesson.exercises.length - 1) {
      setState(() {
        _currentExerciseIndex++;
        _selectedAnswer = null;
        _userAnswer.clear();
        _isAnswerSelected = false;
        _showResult = false;
        _isCorrect = false;
      });
      _updateProgress();
    } else {
      setState(() {
        _lessonCompleted = true;
      });
    }
  }

  void _playAudio(String text) async {
    try {
      // Use word with emphasis for better pronunciation learning
      if (_currentExercise.type == ExerciseType.listening) {
        await _ttsService.speakWordWithEmphasis(text);
      } else {
        await _ttsService.speakAmharic(text, speed: 0.7);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Audio not available: ${e.toString()}'),
            backgroundColor: Colors.orange,
            behavior: SnackBarBehavior.floating,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
            margin: const EdgeInsets.all(16),
          ),
        );
      }
    }
  }

  void _showExitDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A2A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Quit lesson?',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Your progress will be lost if you quit now.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'STAY',
              style: TextStyle(color: Color(0xFF58CC02)),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/language');
            },
            child: const Text(
              'QUIT',
              style: TextStyle(color: Color(0xFFFF4B4B)),
            ),
          ),
        ],
      ),
    );
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A2A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.favorite_border_rounded, color: Color(0xFFFF4B4B)),
            const SizedBox(width: 8),
            const Text(
              'Out of hearts!',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        content: const Text(
          'You\'ve run out of hearts. Wait for them to regenerate or practice previous lessons.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/language');
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
}
