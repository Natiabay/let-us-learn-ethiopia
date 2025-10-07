import 'package:flutter/material.dart';
import 'package:tourist_assistive_app/features/language/services/professional_audio_service.dart';

class ProfessionalAudioWidget extends StatefulWidget {
  final String amharicText;
  final String englishText;
  final bool showEnglish;
  final Color? buttonColor;
  final double? size;
  final bool showText;
  final bool autoPlay;

  const ProfessionalAudioWidget({
    super.key,
    required this.amharicText,
    this.englishText = '',
    this.showEnglish = false,
    this.buttonColor,
    this.size = 60.0,
    this.showText = true,
    this.autoPlay = false,
  });

  @override
  State<ProfessionalAudioWidget> createState() => _ProfessionalAudioWidgetState();
}

class _ProfessionalAudioWidgetState extends State<ProfessionalAudioWidget>
    with TickerProviderStateMixin {
  final ProfessionalAudioService _audioService = ProfessionalAudioService();
  late AnimationController _pulseController;
  late AnimationController _waveController;
  
  bool _isPlaying = false;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _initializeAudio();
  }

  void _initializeAnimations() {
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _waveController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
  }

  Future<void> _initializeAudio() async {
    await _audioService.initialize();
    setState(() {
      _isInitialized = true;
    });
    
    if (widget.autoPlay) {
      Future.delayed(const Duration(milliseconds: 500), () {
        _playAudio();
      });
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _waveController.dispose();
    super.dispose();
  }

  Future<void> _playAudio() async {
    if (!_isInitialized || _isPlaying) return;

    setState(() {
      _isPlaying = true;
    });

    // Start animations
    _pulseController.repeat(reverse: true);
    _waveController.repeat();

    try {
      // Check if we have pre-recorded audio
      final audioPath = AmharicAudioDatabase.getAudioPath(widget.amharicText);
      
      if (audioPath != null) {
        // Play pre-recorded audio
        await _audioService.playAmharicAudio(audioPath);
      } else {
        // Use TTS as fallback
        await _audioService.speakAmharic(widget.amharicText);
      }

      // If English text is provided, play it after Amharic
      if (widget.englishText.isNotEmpty && widget.showEnglish) {
        await Future.delayed(const Duration(milliseconds: 1000));
        await _audioService.speakEnglish(widget.englishText);
      }
    } catch (e) {
      print('Error playing audio: $e');
    } finally {
      // Stop animations
      _pulseController.stop();
      _waveController.stop();
      
      setState(() {
        _isPlaying = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Audio button
        GestureDetector(
          onTap: _playAudio,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: _isPlaying 
                  ? (widget.buttonColor ?? const Color(0xFF58CC02)).withValues(alpha: 0.8)
                  : (widget.buttonColor ?? const Color(0xFF58CC02)),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: (widget.buttonColor ?? const Color(0xFF58CC02)).withValues(alpha: 0.3),
                  blurRadius: _isPlaying ? 15 : 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Pulse animation
                if (_isPlaying)
                  AnimatedBuilder(
                    animation: _pulseController,
                    builder: (context, child) {
                      return Container(
                        width: widget.size! * (1 + _pulseController.value * 0.3),
                        height: widget.size! * (1 + _pulseController.value * 0.3),
                        decoration: BoxDecoration(
                          color: (widget.buttonColor ?? const Color(0xFF58CC02))
                              .withValues(alpha: 0.3 * (1 - _pulseController.value)),
                          shape: BoxShape.circle,
                        ),
                      );
                    },
                  ),
                
                // Wave animation
                if (_isPlaying)
                  AnimatedBuilder(
                    animation: _waveController,
                    builder: (context, child) {
                      return Container(
                        width: widget.size! * (1 + _waveController.value * 0.2),
                        height: widget.size! * (1 + _waveController.value * 0.2),
                        decoration: BoxDecoration(
                          color: (widget.buttonColor ?? const Color(0xFF58CC02))
                              .withValues(alpha: 0.2 * (1 - _waveController.value)),
                          shape: BoxShape.circle,
                        ),
                      );
                    },
                  ),
                
                // Icon
                Icon(
                  _isPlaying ? Icons.volume_up : Icons.play_arrow,
                  color: Colors.white,
                  size: widget.size! * 0.4,
                ),
              ],
            ),
          ),
        ),
        
        // Text display
        if (widget.showText) ...[
          const SizedBox(height: 8),
          
          // Amharic text
          Text(
            widget.amharicText,
            style: TextStyle(
              fontSize: widget.size! * 0.25,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1A1A1A),
            ),
            textAlign: TextAlign.center,
          ),
          
          // English translation
          if (widget.englishText.isNotEmpty && widget.showEnglish) ...[
            const SizedBox(height: 4),
            Text(
              widget.englishText,
              style: TextStyle(
                fontSize: widget.size! * 0.2,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ],
    );
  }
}

// Professional Picture Widget
class ProfessionalPictureWidget extends StatelessWidget {
  final String amharicWord;
  final String englishTranslation;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final bool showLabel;
  final VoidCallback? onTap;

  const ProfessionalPictureWidget({
    super.key,
    required this.amharicWord,
    this.englishTranslation = '',
    this.width = 120.0,
    this.height = 120.0,
    this.borderRadius,
    this.showLabel = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final picturePath = AmharicPictureDatabase.getPicturePath(amharicWord);
    final hasPicture = picturePath != null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(16),
          child: Stack(
            children: [
              // Picture or placeholder
              Container(
                width: double.infinity,
                height: double.infinity,
                color: const Color(0xFFF5F5F5),
                child: hasPicture
                    ? Image.asset(
                        picturePath!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildPlaceholder();
                        },
                      )
                    : _buildPlaceholder(),
              ),
              
              // Gradient overlay for text readability
              if (showLabel)
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.7),
                      ],
                    ),
                  ),
                ),
              
              // Labels
              if (showLabel)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          amharicWord,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (englishTranslation.isNotEmpty) ...[
                          const SizedBox(height: 2),
                          Text(
                            englishTranslation,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.9),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: const Color(0xFFE0E0E0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image,
            size: 40,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 8),
          Text(
            amharicWord,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Combined Audio and Picture Widget
class AudioPictureWidget extends StatelessWidget {
  final String amharicWord;
  final String englishTranslation;
  final double? size;
  final bool showAudio;
  final bool showPicture;
  final VoidCallback? onTap;

  const AudioPictureWidget({
    super.key,
    required this.amharicWord,
    this.englishTranslation = '',
    this.size = 150.0,
    this.showAudio = true,
    this.showPicture = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            // Picture section
            if (showPicture)
              Expanded(
                flex: 3,
                child: ProfessionalPictureWidget(
                  amharicWord: amharicWord,
                  englishTranslation: englishTranslation,
                  width: double.infinity,
                  height: double.infinity,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  showLabel: false,
                ),
              ),
            
            // Audio section
            if (showAudio)
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: ProfessionalAudioWidget(
                    amharicText: amharicWord,
                    englishText: englishTranslation,
                    showEnglish: true,
                    size: 40,
                    showText: true,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
