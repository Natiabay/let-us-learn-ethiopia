import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:tourist_assistive_app/core/services/audio_service.dart';
import 'package:tourist_assistive_app/features/language/widgets/speaker_button.dart';
import 'package:tourist_assistive_app/features/language/services/voice_service.dart';
import 'package:tourist_assistive_app/features/language/services/lesson_avatar_service.dart';
import 'package:tourist_assistive_app/features/language/data/english_amharic_lessons.dart';
import 'package:tourist_assistive_app/features/language/models/comprehensive_lesson_model.dart';

class EnhancedAmharicLessonScreen extends ConsumerStatefulWidget {
  final String lessonId;
  final String? nativeLanguage;

  const EnhancedAmharicLessonScreen({
    super.key,
    required this.lessonId,
    this.nativeLanguage,
  });

  @override
  ConsumerState<EnhancedAmharicLessonScreen> createState() => _EnhancedAmharicLessonScreenState();
}

class _EnhancedAmharicLessonScreenState extends ConsumerState<EnhancedAmharicLessonScreen>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late AnimationController _pulseController;
  late AnimationController _slideController;
  final AudioService _audioService = AudioService();
  
  int _currentExerciseIndex = 0;
  int _score = 0;
  int _hearts = 5;
  bool _isLoading = true;
  String? _selectedAnswer;
  bool _showFeedback = false;
  bool _isCorrect = false;
  
  // ✅ NOW LOADING FROM NEW 10,000+ LINE LESSONS!
  Lesson? _currentLesson;
  List<Exercise> _exercises = [];

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    // ✅ LOAD LESSON FROM NEW 10,000+ LINE LESSONS DATABASE
    _loadLessonData();
    _slideController.forward();
  }
  
  /// Load lesson data from the new comprehensive lessons
  void _loadLessonData() {
    print('📚 Loading lesson with ID: ${widget.lessonId}');
    
    // Get lesson from NEW 60 lessons
    _currentLesson = EnglishAmharicLessons.getLessonById(widget.lessonId);
    
    if (_currentLesson != null) {
      setState(() {
        _exercises = _currentLesson!.exercises;
        _isLoading = false;
      });
      print('✅ Loaded NEW lesson: "${_currentLesson!.title}" with ${_exercises.length} exercises');
    } else {
      print('❌ ERROR: Lesson "${widget.lessonId}" not found in NEW 60 lessons!');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _progressController.dispose();
    _pulseController.dispose();
    _slideController.dispose();
    _audioService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Show loading or error state
    if (_isLoading) {
      return Scaffold(
        backgroundColor: const Color(0xFF1A1A1A),
        body: const Center(
          child: CircularProgressIndicator(color: Color(0xFF58CC02)),
        ),
      );
    }
    
    if (_currentLesson == null || _exercises.isEmpty) {
      return Scaffold(
        backgroundColor: const Color(0xFF1A1A1A),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 64),
              const SizedBox(height: 16),
              Text(
                'Lesson not found: ${widget.lessonId}',
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.pop(),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      );
    }

    final currentExercise = _exercises[_currentExerciseIndex];
    final progress = (_currentExerciseIndex + 1) / _exercises.length;

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(progress),
            Expanded(
              child: _showFeedback 
                  ? _buildFeedback(currentExercise)
                  : _buildExercise(currentExercise),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(double progress) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Top bar with hearts and close button
          Row(
            children: [
              GestureDetector(
                onTap: () => context.pop(),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
              const Spacer(),
              // Hearts
              Row(
                children: List.generate(5, (index) => 
                  Container(
                    margin: const EdgeInsets.only(left: 4),
                    child: Icon(
                      index < _hearts ? Icons.favorite : Icons.favorite_border,
                      color: const Color(0xFFFF4B4B),
                      size: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Progress bar
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF58CC02),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExercise(Exercise exercise) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // NEW WORD indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFCE82FF),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'NEW WORD',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Exercise instruction
          Text(
            _getExerciseInstruction(exercise.type),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          
          // Character and speech bubble
          Row(
            children: [
              // Character
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFF58CC02),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              const SizedBox(width: 16),
              
              // Speech bubble
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      CompactSpeakerButton(
                        text: exercise.amharicText,
                        languageCode: 'am',
                        color: Colors.white,
                        size: 20.0,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          exercise.amharicText,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          
          // Exercise content based on type
          if (exercise.type == ExerciseType.selectImage)
            _buildImageSelection(exercise)
          else if (exercise.type == ExerciseType.translate)
            _buildTranslation(exercise),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildImageSelection(Exercise exercise) {
    return Column(
      children: [
        // Image grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.0,
          ),
          itemCount: exercise.options.length,
          itemBuilder: (context, index) {
            final option = exercise.options[index];
            return GestureDetector(
              onTap: () => _selectAnswer(option),
              child: Container(
                decoration: BoxDecoration(
                  color: _selectedAnswer == option.text 
                      ? const Color(0xFF58CC02).withValues(alpha: 0.3)
                      : const Color(0xFF2A2A2A),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _selectedAnswer == option.text 
                        ? const Color(0xFF58CC02)
                        : const Color(0xFF2A2A2A),
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                        child: Image.network(
                          option.imageUrl!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: const Color(0xFF2A2A2A),
                            child: const Icon(
                              Icons.image,
                              color: Colors.white54,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        option.text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 24),
        
        // Check button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _selectedAnswer != null ? () => _checkAnswer() : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _selectedAnswer != null 
                  ? const Color(0xFF58CC02)
                  : const Color(0xFF2A2A2A),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'CHECK',
              style: TextStyle(
                color: _selectedAnswer != null ? Colors.white : Colors.white54,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTranslation(Exercise exercise) {
    return Column(
      children: [
        // Word bank
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: exercise.options.map((option) => 
            GestureDetector(
              onTap: () => _selectAnswer(option),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: _selectedAnswer == option.text 
                      ? const Color(0xFF58CC02)
                      : const Color(0xFF2A2A2A),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _selectedAnswer == option.text 
                        ? const Color(0xFF58CC02)
                        : const Color(0xFF2A2A2A),
                    width: 1,
                  ),
                ),
                child: Text(
                  option.text,
                  style: TextStyle(
                    color: _selectedAnswer == option.text ? Colors.white : Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ).toList(),
        ),
        const SizedBox(height: 24),
        
        // Check button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _selectedAnswer != null ? () => _checkAnswer() : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _selectedAnswer != null 
                  ? const Color(0xFF58CC02)
                  : const Color(0xFF2A2A2A),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'CHECK',
              style: TextStyle(
                color: _selectedAnswer != null ? Colors.white : Colors.white54,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeedback(Exercise exercise) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Feedback icon and message
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: _isCorrect ? const Color(0xFF58CC02) : const Color(0xFFFF4B4B),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _isCorrect ? Icons.check : Icons.close,
              color: Colors.white,
              size: 40,
            ),
          ),
          const SizedBox(height: 16),
          
          Text(
            _isCorrect ? 'Good job!' : 'Incorrect',
            style: TextStyle(
              color: _isCorrect ? const Color(0xFF58CC02) : const Color(0xFFFF4B4B),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          
          if (!_isCorrect) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Correct Answer: ${exercise.translation}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 8),
                CompactSpeakerButton(
                  text: exercise.translation,
                  languageCode: 'en',
                  color: Colors.white,
                  size: 16.0,
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
          
          // Continue button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _nextExercise(),
              style: ElevatedButton.styleFrom(
                backgroundColor: _isCorrect ? const Color(0xFF58CC02) : const Color(0xFFFF4B4B),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                _currentExerciseIndex < _exercises.length - 1 ? 'CONTINUE' : 'FINISH',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).scale(begin: const Offset(0.8, 0.8), end: const Offset(1.0, 1.0));
  }

  String _getExerciseInstruction(ExerciseType type) {
    switch (type) {
      case ExerciseType.selectImage:
        return 'Select the correct image';
      case ExerciseType.translate:
        return 'Translate this sentence';
      case ExerciseType.listen:
        return 'Listen and select';
      case ExerciseType.speak:
        return 'Speak the word';
      case ExerciseType.fillBlank:
        return 'Fill in the blank';
      case ExerciseType.multipleChoice:
        return 'Choose the correct answer';
      case ExerciseType.matching:
        return 'Match the pairs';
      case ExerciseType.matchPairs:
        return 'Match the pairs';
      case ExerciseType.pronunciation:
        return 'Practice pronunciation';
      case ExerciseType.readAndRespond:
        return 'Read and respond';
      case ExerciseType.completeSentence:
        return 'Complete the sentence';
      case ExerciseType.tapWhatYouHear:
        return 'Tap what you hear';
      case ExerciseType.completeChat:
        return 'Complete the chat';
    }
  }

  void _selectAnswer(ExerciseOption option) {
    setState(() {
      _selectedAnswer = option.text;
    });
  }

  void _checkAnswer() {
    if (_selectedAnswer == null) return;
    
    final currentExercise = _exercises[_currentExerciseIndex];
    final selectedOption = currentExercise.options.firstWhere(
      (option) => option.text == _selectedAnswer,
    );
    
    setState(() {
      _isCorrect = selectedOption.isCorrect;
      _showFeedback = true;
      
      if (_isCorrect) {
        _score += 10;
      } else {
        _hearts--;
      }
    });
  }

  void _nextExercise() {
    if (_currentExerciseIndex < _exercises.length - 1) {
      setState(() {
        _currentExerciseIndex++;
        _selectedAnswer = null;
        _showFeedback = false;
      });
    } else {
      _finishLesson();
    }
  }

  void _finishLesson() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A2A),
        title: const Text(
          'Lesson Complete!',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Score: $_score XP',
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Hearts remaining: $_hearts',
              style: const TextStyle(color: Colors.white70),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text(
              'Continue',
              style: TextStyle(color: Color(0xFF58CC02)),
            ),
          ),
        ],
      ),
    );
  }

  void _playAudio(String amharicText) async {
    try {
      await _audioService.playAmharicText(amharicText);
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  void _showExitConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A2A),
        title: const Text(
          'Exit Lesson?',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Your progress will be saved.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white70),
            ),
          ),
          TextButton(
            onPressed: () => context.pop(),
            child: const Text(
              'Exit',
              style: TextStyle(color: Color(0xFFFF4B4B)),
            ),
          ),
        ],
      ),
    );
  }
}

// ✅ OLD CLASSES REMOVED - NOW USING MODELS FROM comprehensive_lesson_model.dart
// The Exercise and ExerciseOption classes are now imported from the comprehensive model
