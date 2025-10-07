import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:tourist_assistive_app/core/services/audio_service.dart';
import 'package:tourist_assistive_app/features/language/widgets/speaker_button.dart';
import 'package:tourist_assistive_app/features/language/data/english_amharic_lessons.dart';
import 'package:tourist_assistive_app/features/language/models/comprehensive_lesson_model.dart';

/// 🎓 DUOLINGO-STYLE INTERACTIVE LESSON SCREEN
/// Handles all exercise types with beautiful UI and proper interactivity
class DuolingoLessonScreen extends ConsumerStatefulWidget {
  final String lessonId;

  const DuolingoLessonScreen({
    super.key,
    required this.lessonId,
  });

  @override
  ConsumerState<DuolingoLessonScreen> createState() => _DuolingoLessonScreenState();
}

class _DuolingoLessonScreenState extends ConsumerState<DuolingoLessonScreen>
    with TickerProviderStateMixin {
  // Animation controllers
  late AnimationController _progressController;
  late AnimationController _slideController;
  
  // Services
  final AudioService _audioService = AudioService();
  
  // State
  int _currentExerciseIndex = 0;
  int _hearts = 5;
  bool _isLoading = true;
  String? _selectedAnswer;
  List<String> _selectedWords = []; // For fill-in-the-blank
  bool _showFeedback = false;
  bool _isCorrect = false;
  int _streak = 0;
  
  // Lesson data
  Lesson? _currentLesson;
  List<Exercise> _exercises = [];

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    
    _loadLessonData();
    _slideController.forward();
  }

  void _loadLessonData() {
    print('📚 Loading lesson with ID: ${widget.lessonId}');
    _currentLesson = EnglishAmharicLessons.getLessonById(widget.lessonId);
    
    if (_currentLesson != null) {
      setState(() {
        _exercises = _currentLesson!.exercises;
        _isLoading = false;
      });
      print('✅ Loaded lesson: "${_currentLesson!.title}" with ${_exercises.length} exercises');
    } else {
      print('❌ ERROR: Lesson "${widget.lessonId}" not found!');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _progressController.dispose();
    _slideController.dispose();
    _audioService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: const Color(0xFF1A1A1A),
        body: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF58CC02)),
          ),
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
              const Text(
                'Lesson not found',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.pop(),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      );
    }

    final progress = (_currentExerciseIndex + 1) / _exercises.length;
    final currentExercise = _exercises[_currentExerciseIndex];

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: SafeArea(
        child: Column(
          children: [
            // Header with progress and hearts
            _buildHeader(progress),
            
            // Exercise content
            Expanded(
              child: _showFeedback
                  ? _buildFeedback(currentExercise)
                  : _buildExerciseContent(currentExercise),
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
          Row(
            children: [
              // Close/Back button
              GestureDetector(
                onTap: () => context.pop(),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 24),
                ),
              ),
              const SizedBox(width: 16),
              
              // Progress bar
              Expanded(
                child: Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: progress,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF58CC02), Color(0xFF89E219)],
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              
              // Hearts
              Row(
                children: [
                  const Icon(Icons.favorite, color: Color(0xFFFF4B4B), size: 24),
                  const SizedBox(width: 4),
                  Text(
                    '$_hearts',
                    style: const TextStyle(
                      color: Color(0xFFFF4B4B),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseContent(Exercise exercise) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Streak indicator
          if (_streak >= 2)
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF6B35), Color(0xFFF7931E)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.local_fire_department, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    '$_streak IN A ROW',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          
          // NEW WORD badge
          if (_currentExerciseIndex == 0 || (_currentExerciseIndex % 5 == 0))
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFCE82FF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.auto_awesome, color: Colors.white, size: 16),
                  SizedBox(width: 6),
                  Text(
                    'NEW WORD',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          
          // Exercise instruction
          Text(
            exercise.instruction,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 32),
          
          // Exercise type-specific content
          _buildExerciseByType(exercise),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildExerciseByType(Exercise exercise) {
    switch (exercise.type) {
      case ExerciseType.multipleChoice:
        return _buildMultipleChoice(exercise);
      case ExerciseType.fillBlank:
        return _buildFillBlank(exercise);
      case ExerciseType.listen:
        return _buildListenExercise(exercise);
      case ExerciseType.speak:
        return _buildSpeakExercise(exercise);
      case ExerciseType.translate:
        return _buildTranslateExercise(exercise);
      case ExerciseType.matching:
        return _buildMatchingExercise(exercise);
      default:
        return _buildMultipleChoice(exercise); // Fallback
    }
  }

  /// 📝 MULTIPLE CHOICE - Just like Duolingo screenshot #1
  Widget _buildMultipleChoice(Exercise exercise) {
    return Column(
      children: [
        // Character with speech bubble
        if (exercise.amharicText.isNotEmpty) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Character avatar
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1CB0F6), Color(0xFF00A4E4)],
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 40),
              ),
              const SizedBox(width: 16),
              
              // Speech bubble
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2A2A),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    border: Border.all(color: const Color(0xFF3A3A3A)),
                  ),
                  child: Row(
                    children: [
                      // Speaker button
                      CompactSpeakerButton(
                        text: exercise.amharicText,
                        languageCode: 'am',
                        color: const Color(0xFF1CB0F6),
                        size: 24.0,
                      ),
                      const SizedBox(width: 12),
                      
                      // Text
                      Expanded(
                        child: Text(
                          exercise.amharicText,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
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
        ],
        
        // Multiple choice options
        ...exercise.options.asMap().entries.map((entry) {
          final index = entry.key;
          final option = entry.value;
          final isSelected = _selectedAnswer == option.text;
          
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedAnswer = option.text;
              });
              _audioService.playTapSound();
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF58CC02).withOpacity(0.15) : const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? const Color(0xFF58CC02) : const Color(0xFF3A3A3A),
                  width: 3,
                ),
              ),
              child: Text(
                option.text,
                style: TextStyle(
                  color: isSelected ? const Color(0xFF58CC02) : Colors.white,
                  fontSize: 18,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                ),
              ),
            ),
          ).animate(key: ValueKey('option_$index'))
              .fadeIn(delay: (50 * index).ms)
              .slideX(begin: -0.2, end: 0);
        }),
        
        const SizedBox(height: 32),
        
        // CHECK button
        _buildCheckButton(),
      ],
    );
  }

  /// 📝 FILL IN THE BLANK - With word bank
  Widget _buildFillBlank(Exercise exercise) {
    return Column(
      children: [
        // Sentence with blank
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF3A3A3A)),
          ),
          child: Row(
            children: [
              Text(
                exercise.instruction.split('____').first,
                style: const TextStyle(color: Colors.white70, fontSize: 18),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: _selectedWords.isNotEmpty 
                      ? const Color(0xFF58CC02).withOpacity(0.2)
                      : const Color(0xFF3A3A3A),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _selectedWords.isNotEmpty 
                        ? const Color(0xFF58CC02)
                        : const Color(0xFF4A4A4A),
                    width: 2,
                  ),
                ),
                child: Text(
                  _selectedWords.isEmpty ? '______' : _selectedWords.join(' '),
                  style: TextStyle(
                    color: _selectedWords.isNotEmpty ? const Color(0xFF58CC02) : Colors.white30,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (exercise.instruction.split('____').length > 1)
                Text(
                  exercise.instruction.split('____').last,
                  style: const TextStyle(color: Colors.white70, fontSize: 18),
                ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        
        // Word bank
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: exercise.options.map((option) {
            final isSelected = _selectedWords.contains(option.text);
            
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedWords.remove(option.text);
                  } else {
                    _selectedWords.add(option.text);
                    _selectedAnswer = _selectedWords.join(' ');
                  }
                });
                _audioService.playTapSound();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF3A3A3A) : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? const Color(0xFF3A3A3A) : const Color(0xFFE5E5E5),
                    width: 2,
                  ),
                ),
                child: Text(
                  option.text,
                  style: TextStyle(
                    color: isSelected ? Colors.white30 : const Color(0xFF1A1A1A),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 32),
        
        _buildCheckButton(),
      ],
    );
  }

  /// 🎧 LISTEN EXERCISE - Tap what you hear
  Widget _buildListenExercise(Exercise exercise) {
    return Column(
      children: [
        // Large audio button
        GestureDetector(
          onTap: () {
            _audioService.speakAmharic(exercise.amharicText);
          },
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1CB0F6), Color(0xFF00A4E4)],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1CB0F6).withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: const Icon(Icons.volume_up, color: Colors.white, size: 60),
          ),
        ).animate(onPlay: (controller) => controller.repeat())
            .scale(begin: const Offset(1.0, 1.0), end: const Offset(1.05, 1.05), duration: 1000.ms)
            .then()
            .scale(begin: const Offset(1.05, 1.05), end: const Offset(1.0, 1.0), duration: 1000.ms),
        
        const SizedBox(height: 32),
        
        // Hint text
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'Tap to see word bank',
            style: TextStyle(color: Colors.white54, fontSize: 14),
          ),
        ),
        const SizedBox(height: 24),
        
        // Word bank
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: exercise.options.map((option) {
            final isSelected = _selectedAnswer == option.text;
            
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedAnswer = option.text;
                });
                _audioService.playTapSound();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF58CC02) : const Color(0xFF2A2A2A),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? const Color(0xFF58CC02) : const Color(0xFF3A3A3A),
                    width: 2,
                  ),
                ),
                child: Text(
                  option.text,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 32),
        
        _buildCheckButton(),
      ],
    );
  }

  /// 🎤 SPEAK EXERCISE - Speech-to-text
  Widget _buildSpeakExercise(Exercise exercise) {
    return Column(
      children: [
        // Text to speak
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF3A3A3A)),
          ),
          child: Row(
            children: [
              CompactSpeakerButton(
                text: exercise.amharicText,
                languageCode: 'am',
                color: const Color(0xFF1CB0F6),
                size: 24.0,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  exercise.amharicText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        
        // Microphone button
        GestureDetector(
          onTap: () {
            // TODO: Implement STT
            _audioService.playTapSound();
            setState(() {
              _selectedAnswer = exercise.amharicText; // Auto-correct for now
            });
          },
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF4B4B), Color(0xFFFF6B6B)],
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.mic, color: Colors.white, size: 50),
          ),
        ),
        const SizedBox(height: 16),
        
        const Text(
          'Tap to speak',
          style: TextStyle(color: Colors.white54, fontSize: 16),
        ),
        const SizedBox(height: 32),
        
        _buildCheckButton(),
      ],
    );
  }

  /// 🌐 TRANSLATE EXERCISE - Word bank translation
  Widget _buildTranslateExercise(Exercise exercise) {
    return Column(
      children: [
        // Sentence to translate
        Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(bottom: 32),
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF3A3A3A)),
          ),
          child: Row(
            children: [
              CompactSpeakerButton(
                text: exercise.amharicText,
                languageCode: 'am',
                color: const Color(0xFF1CB0F6),
                size: 24.0,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  exercise.amharicText.isEmpty ? exercise.instruction : exercise.amharicText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        
        // Answer area
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF3A3A3A)),
          ),
          child: Text(
            _selectedWords.isEmpty ? 'Tap the words below...' : _selectedWords.join(' '),
            style: TextStyle(
              color: _selectedWords.isEmpty ? Colors.white30 : Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 24),
        
        // Word bank
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: exercise.options.map((option) {
            final isSelected = _selectedWords.contains(option.text);
            
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedWords.remove(option.text);
                  } else {
                    _selectedWords.add(option.text);
                  }
                  _selectedAnswer = _selectedWords.join(' ');
                });
                _audioService.playTapSound();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF3A3A3A) : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? const Color(0xFF3A3A3A) : const Color(0xFFE5E5E5),
                    width: 2,
                  ),
                ),
                child: Text(
                  option.text,
                  style: TextStyle(
                    color: isSelected ? Colors.white30 : const Color(0xFF1A1A1A),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 32),
        
        _buildCheckButton(),
      ],
    );
  }

  /// 🔗 MATCHING EXERCISE
  Widget _buildMatchingExercise(Exercise exercise) {
    // Use multiple choice as fallback for now
    return _buildMultipleChoice(exercise);
  }

  /// ✅ CHECK BUTTON - Duolingo style
  Widget _buildCheckButton() {
    final isEnabled = _selectedAnswer != null || _selectedWords.isNotEmpty;
    
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isEnabled ? _checkAnswer : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled ? const Color(0xFF58CC02) : const Color(0xFF2A2A2A),
          disabledBackgroundColor: const Color(0xFF2A2A2A),
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: isEnabled ? 4 : 0,
        ),
        child: Text(
          'CHECK',
          style: TextStyle(
            color: isEnabled ? Colors.white : Colors.white30,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }

  /// 📊 FEEDBACK SCREEN - Show correct/incorrect
  Widget _buildFeedback(Exercise exercise) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Spacer(),
          
          // Feedback content
          Column(
            children: [
              // Icon and message
              Icon(
                _isCorrect ? Icons.check_circle : Icons.cancel,
                color: _isCorrect ? const Color(0xFF58CC02) : const Color(0xFFFF4B4B),
                size: 80,
              ).animate()
                  .scale(delay: 100.ms, duration: 400.ms, curve: Curves.elasticOut),
              const SizedBox(height: 24),
              
              Text(
                _isCorrect ? 'Good job!' : 'Correct solution:',
                style: TextStyle(
                  color: _isCorrect ? const Color(0xFF58CC02) : const Color(0xFFFF4B4B),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              if (!_isCorrect) ...[
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF58CC02), width: 2),
                  ),
                  child: Text(
                    exercise.correctAnswer ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),
              ],
              
              if (exercise.explanation != null)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    exercise.explanation!,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
          const Spacer(),
          
          // CONTINUE button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _nextExercise,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isCorrect ? const Color(0xFF58CC02) : const Color(0xFF1CB0F6),
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
              ),
              child: const Text(
                'CONTINUE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _checkAnswer() {
    final currentExercise = _exercises[_currentExerciseIndex];
    final userAnswer = _selectedAnswer ?? _selectedWords.join(' ');
    final correctAnswer = currentExercise.correctAnswer?.toLowerCase().trim() ?? '';
    
    setState(() {
      _isCorrect = userAnswer.toLowerCase().trim() == correctAnswer;
      _showFeedback = true;
      
      if (_isCorrect) {
        _streak++;
        _audioService.playSuccessSound();
      } else {
        _hearts = (_hearts - 1).clamp(0, 5);
        _streak = 0;
        _audioService.playErrorSound();
      }
    });
  }

  void _nextExercise() {
    if (_currentExerciseIndex < _exercises.length - 1) {
      setState(() {
        _currentExerciseIndex++;
        _selectedAnswer = null;
        _selectedWords.clear();
        _showFeedback = false;
      });
      
      _slideController.reset();
      _slideController.forward();
    } else {
      // Lesson complete!
      _showLessonComplete();
    }
  }

  void _showLessonComplete() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Column(
          children: [
            Icon(Icons.celebration, color: Color(0xFFFFD700), size: 60),
            SizedBox(height: 16),
            Text(
              'Lesson Complete!',
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'You earned ${_currentLesson?.xpReward ?? 0} XP!',
              style: const TextStyle(color: Colors.white70, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Streak: $_streak',
              style: const TextStyle(color: Color(0xFFFF6B35), fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              context.pop(); // Close dialog
              context.pop(); // Return to lesson list
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF58CC02),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('CONTINUE', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
