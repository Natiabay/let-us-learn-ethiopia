import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tourist_assistive_app/core/theme/app_theme.dart';
import 'package:tourist_assistive_app/features/language/providers/duolingo_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DuolingoTranslationWidget extends ConsumerStatefulWidget {
  final dynamic question;
  final Function(String) onAnswerSelected;
  final bool showResult;
  final bool isCorrect;
  final bool isReverse;

  const DuolingoTranslationWidget({
    super.key,
    required this.question,
    required this.onAnswerSelected,
    required this.showResult,
    required this.isCorrect,
    this.isReverse = false,
  });

  @override
  ConsumerState<DuolingoTranslationWidget> createState() => _DuolingoTranslationWidgetState();
}

class _DuolingoTranslationWidgetState extends ConsumerState<DuolingoTranslationWidget>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _shakeController;
  bool isTranslating = false;
  String? translatedText;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);
    
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _shakeController.dispose();
    super.dispose();
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
          
          // Word Display
          _buildWordDisplay(),
          
          const SizedBox(height: 30),
          
          // Translation Features
          _buildTranslationFeatures(),
          
          const SizedBox(height: 20),
          
          // Pronunciation
          _buildPronunciation(),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).scale(begin: const Offset(0.9, 0.9), end: const Offset(1.0, 1.0));
  }

  Widget _buildWordDisplay() {
    final word = widget.question.word;
    final displayText = widget.isReverse ? word.english : word.amharic;
    final displayLanguage = widget.isReverse ? 'English' : 'Amharic';
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.primaryGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Language Label
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.textOnPrimary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              displayLanguage,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textOnPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Word Text
          Text(
            displayText,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: AppColors.textOnPrimary,
              fontWeight: FontWeight.w800,
              letterSpacing: 2,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 16),
          
          // Play Audio Button
          GestureDetector(
            onTap: () => _playAudio(),
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.textOnPrimary.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(
                Icons.volume_up_rounded,
                color: AppColors.textOnPrimary,
                size: 30,
              ),
            ),
          ).animate(onPlay: (controller) => controller.repeat())
            .shimmer(duration: 2000.ms, color: AppColors.textOnPrimary.withValues(alpha: 0.3)),
        ],
      ),
    );
  }

  Widget _buildTranslationFeatures() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Google Translate Button
        _buildFeatureButton(
          icon: Icons.translate_rounded,
          label: 'Translate',
          onTap: _translateWord,
          isLoading: isTranslating,
        ),
        
        // Image Button
        _buildFeatureButton(
          icon: Icons.image_rounded,
          label: 'Image',
          onTap: _showImage,
        ),
        
        // Examples Button
        _buildFeatureButton(
          icon: Icons.lightbulb_rounded,
          label: 'Examples',
          onTap: _showExamples,
        ),
      ],
    );
  }

  Widget _buildFeatureButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isLoading = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.3), width: 1),
        ),
        child: Column(
          children: [
            if (isLoading)
              SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              )
            else
              Icon(
                icon,
                color: AppColors.primary,
                size: 24,
              ),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPronunciation() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.secondary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.secondary.withValues(alpha: 0.3), width: 1),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.record_voice_over_rounded,
                color: AppColors.secondary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Pronunciation',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            widget.question.word.pronunciation,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  void _playAudio() async {
    final ttsService = ref.read(ttsServiceProvider);
    await ttsService.initialize();
    
    if (widget.isReverse) {
      await ttsService.speakEnglish(widget.question.word.english);
    } else {
      await ttsService.speakAmharic(widget.question.word.amharic);
    }
  }

  void _translateWord() async {
    setState(() {
      isTranslating = true;
    });

    try {
      final translationService = ref.read(translationServiceProvider);
      final word = widget.question.word;
      
      String result;
      if (widget.isReverse) {
        // Translate English to Amharic
        result = await translationService.translateText(
          text: word.english,
          fromLanguage: 'en',
          toLanguage: 'am',
        );
      } else {
        // Translate Amharic to English
        result = await translationService.translateText(
          text: word.amharic,
          fromLanguage: 'am',
          toLanguage: 'en',
        );
      }
      
      setState(() {
        translatedText = result;
        isTranslating = false;
      });
      
      _showTranslationResult(result, 1.0);
    } catch (e) {
      setState(() {
        isTranslating = false;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Translation failed: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  void _showTranslationResult(String translation, double confidence) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.translate, color: AppColors.primary),
            const SizedBox(width: 8),
            const Text('Translation'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              translation,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                _playTranslatedAudio(translation);
              },
              icon: const Icon(Icons.volume_up),
              label: const Text('Listen'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textOnPrimary,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _playTranslatedAudio(String text) async {
    final ttsService = ref.read(ttsServiceProvider);
    await ttsService.initialize();
    
    if (widget.isReverse) {
      await ttsService.speakAmharic(text);
    } else {
      await ttsService.speakEnglish(text);
    }
  }

  void _showImage() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('${widget.question.word.english} Image'),
        content: Container(
          width: double.maxFinite,
          height: 200,
          decoration: BoxDecoration(
            color: AppColors.grey100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: widget.question.word.imageUrl != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    widget.question.word.imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(
                          Icons.image_not_supported_rounded,
                          size: 64,
                          color: AppColors.grey400,
                        ),
                      );
                    },
                  ),
                )
              : const Center(
                  child: Icon(
                    Icons.image_rounded,
                    size: 64,
                    color: AppColors.grey400,
                  ),
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showExamples() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Examples: ${widget.question.word.english}'),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.question.word.examples.isNotEmpty)
                ...widget.question.word.examples.map((example) => 
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      example,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                )
              else
                Text(
                  'No examples available for this word.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
