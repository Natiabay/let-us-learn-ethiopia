import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tourist_assistive_app/core/services/google_translator_service.dart';
import 'package:tourist_assistive_app/features/language/models/comprehensive_lesson_model.dart' as lesson_model;
import 'package:tourist_assistive_app/features/language/data/amharic_lessons_data.dart';

/// Universal lesson screen that works for all 10 languages
/// Uses English lessons as master and translates to target language
class UniversalAmharicLessonsScreen extends ConsumerStatefulWidget {
  final String languageCode;

  const UniversalAmharicLessonsScreen({
    super.key,
    this.languageCode = 'en',
  });

  @override
  ConsumerState<UniversalAmharicLessonsScreen> createState() =>
      _UniversalAmharicLessonsScreenState();
}

class _UniversalAmharicLessonsScreenState
    extends ConsumerState<UniversalAmharicLessonsScreen> {
  lesson_model.LanguageLevel _currentLevel = lesson_model.LanguageLevel.beginner;
  List<lesson_model.Lesson> _lessons = const [];
  bool _isLoading = true;
  LanguageInfo? _currentLanguageInfo;

  @override
  void initState() {
    super.initState();
    _currentLanguageInfo = GoogleTranslatorService.getLanguageInfo(widget.languageCode);
    _loadLessons();
  }

  Future<void> _loadLessons() async {
    setState(() => _isLoading = true);

    try {
      // Get English lessons as master
      final englishLessons = _getEnglishLessons(_currentLevel);

      if (widget.languageCode == 'en') {
        // No translation needed for English
        setState(() {
          _lessons = englishLessons;
          _isLoading = false;
        });
      } else {
        // Translate lessons to target language
        final translatedLessons = await _translateLessons(
          englishLessons,
          widget.languageCode,
        );
        
        setState(() {
          _lessons = translatedLessons;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error loading lessons: $e');
      setState(() => _isLoading = false);
    }
  }

  List<lesson_model.Lesson> _getEnglishLessons(lesson_model.LanguageLevel level) {
    // Get English lessons from master data
    final allLessons = AmharicLessonsData.getAllAmharicLessons();
    return allLessons.where((lesson) => lesson.level == level).toList();
  }

  Future<List<lesson_model.Lesson>> _translateLessons(
    List<lesson_model.Lesson> lessons,
    String targetLanguage,
  ) async {
    final translatedLessons = <lesson_model.Lesson>[];

    for (final lesson in lessons) {
      // Translate title and description
      final translatedTitle = await GoogleTranslatorService.translateText(
        lesson.title,
        targetLanguage,
      );
      
      final translatedDescription = await GoogleTranslatorService.translateText(
        lesson.description,
        targetLanguage,
      );

      // Create translated lesson (keeping Amharic vocabulary and audio intact)
      final translatedLesson = lesson_model.Lesson(
        id: lesson.id,
        title: translatedTitle,
        description: translatedDescription,
        level: lesson.level,
        languageCode: targetLanguage, // Set to target language
        estimatedMinutes: lesson.estimatedMinutes,
        xpReward: lesson.xpReward,
        category: lesson.category,
        exercises: lesson.exercises, // Keep exercises as-is (Amharic is the same)
        vocabulary: lesson.vocabulary, // Keep Amharic vocabulary
        isCompleted: lesson.isCompleted,
      );

      translatedLessons.add(translatedLesson);
    }

    return translatedLessons;
  }

  void _changeLevel(lesson_model.LanguageLevel level) {
    setState(() {
      _currentLevel = level;
    });
    _loadLessons();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1A1A2E),
            const Color(0xFF16213E),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: _buildAppBar(),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF1CB0F6),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 20),
                    _buildLevelSelector(),
                    const SizedBox(height: 20),
                    _buildProgressOverview(),
                    const SizedBox(height: 30),
                    _buildLessonsList(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _currentLanguageInfo?.flag ?? '🇺🇸',
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(width: 8),
          Text(
            _currentLanguageInfo?.name ?? 'English',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            '→',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(width: 8),
          const Text(
            '🇪🇹',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(width: 8),
          const Text(
            'Amharic',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      centerTitle: true,
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            'Learn Amharic',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0),
          
          const SizedBox(height: 8),
          
          Text(
            'Master Ethiopian language through ${_currentLanguageInfo?.name ?? "English"}',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 800.ms, delay: 200.ms),
        ],
      ),
    );
  }

  Widget _buildLevelSelector() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: lesson_model.LanguageLevel.values.map((level) {
          final isSelected = level == _currentLevel;
          return Expanded(
            child: GestureDetector(
              onTap: () => _changeLevel(level),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? LinearGradient(
                          colors: [
                            const Color(0xFF1CB0F6),
                            const Color(0xFF00D9B8),
                          ],
                        )
                      : null,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  level.toString().split('.').last.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    ).animate().fadeIn(duration: 1000.ms).slideX(begin: 0.3, end: 0);
  }

  Widget _buildProgressOverview() {
    final completedLessons = _lessons.where((l) => l.isCompleted).length;
    final totalLessons = _lessons.length;
    final totalMinutes = _lessons.fold<int>(0, (sum, lesson) => sum + lesson.estimatedMinutes);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFCE82FF).withOpacity(0.2),
            const Color(0xFF1CB0F6).withOpacity(0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFCE82FF).withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            'Lessons',
            '$completedLessons/$totalLessons',
            Icons.book,
            const Color(0xFFCE82FF),
          ),
          Container(
            width: 1,
            height: 40,
            color: Colors.white.withOpacity(0.2),
          ),
          _buildStatItem(
            'Time',
            '$totalMinutes min',
            Icons.access_time,
            const Color(0xFF00D9B8),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 1000.ms).slideX(begin: 0.3, end: 0);
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildLessonsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '${_currentLanguageInfo?.nativeName ?? "English"} → አማርኛ Lessons',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        ..._lessons.asMap().entries.map((entry) {
          final index = entry.key;
          final lesson = entry.value;
          return _buildLessonCard(lesson, index);
        }),
      ],
    );
  }

  Widget _buildLessonCard(lesson_model.Lesson lesson, int index) {
    final isCompleted = lesson.isCompleted;
    
    Color backgroundColor = const Color(0xFF2A2A2A);
    Color borderColor = const Color(0xFF2A2A2A);
    
    if (isCompleted) {
      backgroundColor = const Color(0xFF00D9B8);
      borderColor = const Color(0xFF00D9B8);
    } else {
      backgroundColor = const Color(0xFFCE82FF).withOpacity(0.1);
      borderColor = const Color(0xFFCE82FF).withOpacity(0.3);
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: GestureDetector(
        onTap: () => _startLesson(lesson),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor, width: 2),
          ),
          child: Row(
            children: [
              // Lesson icon
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFCE82FF),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: isCompleted
                    ? const Icon(Icons.check, color: Colors.white, size: 24)
                    : Center(
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ),
              
              const SizedBox(width: 16),
              
              // Lesson info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lesson.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      lesson.description,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildLessonStat(
                          '${lesson.estimatedMinutes} min',
                          Icons.access_time,
                        ),
                        const SizedBox(width: 12),
                        _buildLessonStat(
                          '${lesson.exercises.length} exercises',
                          Icons.quiz,
                        ),
                        const SizedBox(width: 12),
                        _buildLessonStat(
                          '${lesson.xpReward} XP',
                          Icons.star,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 600.ms).slideX(begin: 0.3, end: 0);
  }

  Widget _buildLessonStat(String text, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.white54, size: 14),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  void _startLesson(lesson_model.Lesson lesson) {
    context.push(
      '/language/amharic/lesson/${lesson.id}?lang=${widget.languageCode}',
    );
  }
}

