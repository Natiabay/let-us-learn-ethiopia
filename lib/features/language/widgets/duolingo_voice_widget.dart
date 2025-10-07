import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tourist_assistive_app/core/theme/app_theme.dart';
import 'package:tourist_assistive_app/features/language/providers/duolingo_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DuolingoVoiceWidget extends ConsumerStatefulWidget {
  final dynamic question;
  final Function(String) onAnswerSelected;
  final bool showResult;
  final bool isCorrect;
  final bool isSpeaking;

  const DuolingoVoiceWidget({
    super.key,
    required this.question,
    required this.onAnswerSelected,
    required this.showResult,
    required this.isCorrect,
    this.isSpeaking = false,
  });

  @override
  ConsumerState<DuolingoVoiceWidget> createState() => _DuolingoVoiceWidgetState();
}

class _DuolingoVoiceWidgetState extends ConsumerState<DuolingoVoiceWidget>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _waveController;
  late AnimationController _recordingController;
  
  bool isListening = false;
  bool isPlaying = false;
  String recognizedText = '';
  String? userSpokenText;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);
    
    _waveController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    
    _recordingController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _initializeSpeech();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _waveController.dispose();
    _recordingController.dispose();
    super.dispose();
  }

  Future<void> _initializeSpeech() async {
    final speechService = ref.read(speechServiceProvider);
    await speechService.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.grey200, width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Question Header
          Text(
            widget.question.question,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 30),
          
          // Voice Interface
          if (widget.isSpeaking)
            _buildSpeakingInterface()
          else
            _buildListeningInterface(),
          
          const SizedBox(height: 30),
          
          // Recognition Result
          if (recognizedText.isNotEmpty || userSpokenText != null)
            _buildRecognitionResult(),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).scale(begin: const Offset(0.9, 0.9), end: const Offset(1.0, 1.0));
  }

  Widget _buildSpeakingInterface() {
    return Column(
      children: [
        // Target Text
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: AppColors.secondaryGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Text(
                'Say this in Amharic:',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.textOnSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.question.word.english,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.textOnSecondary,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 30),
        
        // Recording Button
        _buildRecordingButton(),
        
        const SizedBox(height: 20),
        
        // Instructions
        Text(
          isListening 
              ? 'Listening... Speak now!'
              : 'Tap the microphone to start recording',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildListeningInterface() {
    return Column(
      children: [
        // Audio Waveform
        _buildAudioWaveform(),
        
        const SizedBox(height: 30),
        
        // Play Button
        _buildPlayButton(),
        
        const SizedBox(height: 20),
        
        // Instructions
        Text(
          'Listen to the audio and choose the correct meaning',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildAudioWaveform() {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.primaryGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return AnimatedBuilder(
              animation: _waveController,
              builder: (context, child) {
                final delay = index * 0.1;
                final animationValue = (_waveController.value + delay) % 1.0;
                final height = 20 + (animationValue * 40);
                
                return Container(
                  width: 4,
                  height: height,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: AppColors.textOnPrimary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }

  Widget _buildPlayButton() {
    return GestureDetector(
      onTap: _playAudio,
      child: AnimatedBuilder(
        animation: _pulseController,
        builder: (context, child) {
          return Transform.scale(
            scale: isPlaying ? 1.0 + (_pulseController.value * 0.1) : 1.0,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Icon(
                isPlaying ? Icons.stop_rounded : Icons.play_arrow_rounded,
                color: AppColors.textOnPrimary,
                size: 40,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRecordingButton() {
    return GestureDetector(
      onTap: isListening ? _stopRecording : _startRecording,
      child: AnimatedBuilder(
        animation: _recordingController,
        builder: (context, child) {
          return Transform.scale(
            scale: isListening ? 1.0 + (_recordingController.value * 0.2) : 1.0,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: isListening ? AppColors.error : AppColors.primary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: (isListening ? AppColors.error : AppColors.primary).withValues(alpha: 0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Icon(
                isListening ? Icons.stop_rounded : Icons.mic_rounded,
                color: AppColors.textOnPrimary,
                size: 50,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRecognitionResult() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.info.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.info.withValues(alpha: 0.3), width: 1),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.hearing_rounded,
                color: AppColors.info,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'You said:',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.info,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            userSpokenText ?? recognizedText,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          if (widget.isSpeaking)
            ElevatedButton(
              onPressed: _checkSpeakingAnswer,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textOnPrimary,
              ),
              child: const Text('Check Answer'),
            ),
        ],
      ),
    );
  }

  void _playAudio() async {
    setState(() {
      isPlaying = true;
    });

    final ttsService = ref.read(ttsServiceProvider);
    await ttsService.initialize();
    await ttsService.speakAmharic(widget.question.word.amharic);

    setState(() {
      isPlaying = false;
    });
  }

  void _startRecording() async {
    final speechService = ref.read(speechServiceProvider);
    
    if (!speechService.isAvailable) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Speech recognition not available'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() {
      isListening = true;
      recognizedText = '';
      userSpokenText = null;
    });

    _recordingController.repeat();

    await speechService.startListening(
      onResult: (result) {
        setState(() {
          recognizedText = result;
          userSpokenText = result;
        });
      },
      onError: (error) {
        setState(() {
          isListening = false;
        });
        _recordingController.stop();
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Speech recognition error: $error'),
            backgroundColor: AppColors.error,
          ),
        );
      },
    );
  }

  void _stopRecording() async {
    final speechService = ref.read(speechServiceProvider);
    await speechService.stopListening();
    
    setState(() {
      isListening = false;
    });
    
    _recordingController.stop();
  }

  void _checkSpeakingAnswer() {
    final userAnswer = userSpokenText ?? recognizedText;
    final correctAnswer = widget.question.word.amharic;
    
    widget.onAnswerSelected(userAnswer);
  }
}
