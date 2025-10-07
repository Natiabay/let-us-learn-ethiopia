import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tourist_assistive_app/features/language/services/enhanced_audio_picture_service.dart';
import 'package:tourist_assistive_app/features/language/widgets/professional_audio_widget.dart';

class EnhancedLearningWidget extends StatefulWidget {
  final String amharicWord;
  final bool showPicture;
  final bool showAudio;
  final bool showPronunciation;
  final bool showCulturalContext;
  final double? width;
  final double? height;
  final VoidCallback? onTap;
  final bool autoPlay;

  const EnhancedLearningWidget({
    super.key,
    required this.amharicWord,
    this.showPicture = true,
    this.showAudio = true,
    this.showPronunciation = true,
    this.showCulturalContext = false,
    this.width = 200.0,
    this.height = 200.0,
    this.onTap,
    this.autoPlay = false,
  });

  @override
  State<EnhancedLearningWidget> createState() => _EnhancedLearningWidgetState();
}

class _EnhancedLearningWidgetState extends State<EnhancedLearningWidget>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  
  bool _isLoading = true;
  Map<String, dynamic>? _wordData;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _loadWordData();
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _fadeController.forward();
    _scaleController.forward();
  }

  void _loadWordData() {
    _wordData = EnhancedAudioPictureService.getWordData(widget.amharicWord);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return _buildLoadingWidget();
    }

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.width,
        height: widget.height,
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
            if (widget.showPicture)
              Expanded(
                flex: 3,
                child: _buildPictureSection(),
              ),
            
            // Content section
            Expanded(
              flex: 2,
              child: _buildContentSection(),
            ),
          ],
        ),
      ),
    ).animate()
        .fadeIn(duration: 800.ms)
        .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.0, 1.0));
  }

  Widget _buildLoadingWidget() {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF58CC02),
        ),
      ),
    );
  }

  Widget _buildPictureSection() {
    final picturePath = _wordData?['pictureFile'] as String?;
    
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: picturePath != null
            ? _buildPictureWidget(picturePath)
            : _buildPlaceholderPicture(),
      ),
    );
  }

  Widget _buildPictureWidget(String picturePath) {
    return Stack(
      children: [
        // Main picture
        Container(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset(
            picturePath,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return _buildPlaceholderPicture();
            },
          ),
        ),
        
        // Gradient overlay
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withValues(alpha: 0.3),
              ],
            ),
          ),
        ),
        
        // Category badge
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF58CC02),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              _wordData?['category'] ?? '',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholderPicture() {
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
            widget.amharicWord,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildContentSection() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Amharic word
          Text(
            widget.amharicWord,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A1A),
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 4),
          
          // English translation
          Text(
            _wordData?['english'] ?? '',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          
          // Pronunciation
          if (widget.showPronunciation && _wordData?['pronunciation'] != null) ...[
            const SizedBox(height: 4),
            Text(
              '${_wordData!['pronunciation']}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ],
          
          const SizedBox(height: 8),
          
          // Audio button
          if (widget.showAudio)
            ProfessionalAudioWidget(
              amharicText: widget.amharicWord,
              englishText: _wordData?['english'] ?? '',
              showEnglish: false,
              size: 40,
              showText: false,
              autoPlay: widget.autoPlay,
            ),
          
          // Cultural context
          if (widget.showCulturalContext && _wordData?['culturalContext'] != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF58CC02).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _wordData!['culturalContext'],
                style: const TextStyle(
                  fontSize: 10,
                  color: Color(0xFF58CC02),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// Enhanced lesson card widget
class EnhancedLessonCard extends StatelessWidget {
  final String amharicWord;
  final String englishTranslation;
  final String category;
  final int difficulty;
  final VoidCallback? onTap;
  final bool isCompleted;
  final bool isUnlocked;

  const EnhancedLessonCard({
    super.key,
    required this.amharicWord,
    required this.englishTranslation,
    required this.category,
    required this.difficulty,
    this.onTap,
    this.isCompleted = false,
    this.isUnlocked = true,
  });

  @override
  Widget build(BuildContext context) {
    final wordData = EnhancedAudioPictureService.getWordData(amharicWord);
    
    return GestureDetector(
      onTap: isUnlocked ? onTap : null,
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isUnlocked ? Colors.white : Colors.grey[100],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isCompleted 
                ? const Color(0xFF58CC02)
                : isUnlocked 
                    ? Colors.grey[300]!
                    : Colors.grey[200]!,
            width: isCompleted ? 3 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // Picture
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: wordData?['pictureFile'] != null
                      ? Image.asset(
                          wordData!['pictureFile'],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return _buildPlaceholder();
                          },
                        )
                      : _buildPlaceholder(),
                ),
              ),
            ),
            
            // Content
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Amharic word
                    Text(
                      amharicWord,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isUnlocked ? const Color(0xFF1A1A1A) : Colors.grey[400],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 4),
                    
                    // English translation
                    Text(
                      englishTranslation,
                      style: TextStyle(
                        fontSize: 12,
                        color: isUnlocked ? Colors.grey[600] : Colors.grey[400],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Audio button
                    if (isUnlocked)
                      ProfessionalAudioWidget(
                        amharicText: amharicWord,
                        englishText: englishTranslation,
                        showEnglish: false,
                        size: 30,
                        showText: false,
                      ),
                  ],
                ),
              ),
            ),
          ],
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
            size: 30,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 4),
          Text(
            amharicWord,
            style: TextStyle(
              fontSize: 10,
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
