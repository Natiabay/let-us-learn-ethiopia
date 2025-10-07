import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:tourist_assistive_app/features/language/models/comprehensive_lesson_model.dart' as lesson_model;
import 'package:tourist_assistive_app/features/language/data/multilingual_amharic_lessons.dart';

class EnglishAmharicLessonsScreen extends ConsumerStatefulWidget {
  const EnglishAmharicLessonsScreen({super.key});

  @override
  ConsumerState<EnglishAmharicLessonsScreen> createState() => _EnglishAmharicLessonsScreenState();
}

class _EnglishAmharicLessonsScreenState extends ConsumerState<EnglishAmharicLessonsScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  List<lesson_model.Lesson> _lessons = [];
  bool _isLoading = true;
  lesson_model.LanguageLevel _selectedLevel = lesson_model.LanguageLevel.beginner;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _loadLessons();
    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _loadLessons() {
    // Simulate loading
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _lessons = _getProfessionalLessons(_selectedLevel);
        _isLoading = false;
      });
    });
  }
  
  List<lesson_model.Lesson> _getProfessionalLessons(lesson_model.LanguageLevel level) {
    // Get all English lessons and filter by level
    final allEnglishLessons = MultilingualAmharicLessons.getEnglishLessons();
    return allEnglishLessons.where((lesson) => lesson.level == level).toList();
  }

  void _changeLevel(lesson_model.LanguageLevel level) {
    setState(() {
      _selectedLevel = level;
      _isLoading = true;
    });
    _loadLessons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF58CC02),
                ),
              )
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 100),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 24),
                      _buildLevelSelector(),
                      const SizedBox(height: 24),
                      _buildProgressOverview(),
                      const SizedBox(height: 24),
                      _buildLessonsList(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF1A1A1A),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => context.pop(),
      ),
      title: const Text(
        'English → Amharic',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: null,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF58CC02), Color(0xFF1CB0F6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🇪🇹 Learn Amharic',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontFamily: null,
            ),
          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0),
          const SizedBox(height: 8),
          const Text(
            'Master the beautiful language of Ethiopia with our comprehensive lessons designed for English speakers.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              height: 1.5,
              fontFamily: null,
            ),
          ).animate(delay: 200.ms).fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildStatCard('${_lessons.length}', 'Lessons', Icons.school),
              const SizedBox(width: 16),
              _buildStatCard('${_lessons.where((l) => l.isCompleted).length}', 'Completed', Icons.check_circle),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: null,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 12,
                  fontFamily: null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLevelSelector() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildLevelButton('Beginner', lesson_model.LanguageLevel.beginner, 0),
          _buildLevelButton('Intermediate', lesson_model.LanguageLevel.intermediate, 1),
          _buildLevelButton('Advanced', lesson_model.LanguageLevel.advanced, 2),
        ],
      ),
    );
  }

  Widget _buildLevelButton(String label, lesson_model.LanguageLevel level, int index) {
    final isSelected = _selectedLevel == level;
    return Expanded(
      child: GestureDetector(
        onTap: () => _changeLevel(level),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF58CC02) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[400],
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontFamily: null,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressOverview() {
    final completedLessons = _lessons.where((l) => l.isCompleted).length;
    final totalLessons = _lessons.length;
    final progress = totalLessons > 0 ? completedLessons / totalLessons : 0.0;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF3A3A3A)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Progress',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: null,
                ),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: const TextStyle(
                  color: Color(0xFF58CC02),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: const Color(0xFF3A3A3A),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF58CC02)),
            minHeight: 8,
          ),
          const SizedBox(height: 8),
          Text(
            '$completedLessons of $totalLessons lessons completed',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 14,
              fontFamily: null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Lessons',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: null,
          ),
        ),
        const SizedBox(height: 16),
        ..._lessons.asMap().entries.map((entry) {
          final index = entry.key;
          final lesson = entry.value;
          return _buildLessonCard(lesson, index);
        }).toList(),
      ],
    );
  }

  Widget _buildLessonCard(lesson_model.Lesson lesson, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _startLesson(lesson),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: lesson.isCompleted 
                  ? const Color(0xFF2A2A2A).withValues(alpha: 0.5)
                  : const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: lesson.isCompleted 
                    ? const Color(0xFF58CC02).withValues(alpha: 0.3)
                    : const Color(0xFF3A3A3A),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                // Lesson Icon
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: lesson.isCompleted 
                        ? const Color(0xFF58CC02)
                        : const Color(0xFF3A3A3A),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    lesson.isCompleted ? Icons.check : Icons.play_arrow,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                // Lesson Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lesson.title,
                        style: TextStyle(
                          color: lesson.isCompleted 
                              ? Colors.grey[400]
                              : Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: null,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        lesson.description,
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 14,
                          fontFamily: null,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getCategoryColor(lesson.category).withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              lesson.category,
                              style: TextStyle(
                                color: _getCategoryColor(lesson.category),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: null,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Icon(
                                Icons.schedule,
                                color: Colors.grey[500],
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${lesson.estimatedMinutes}m',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 12,
                                  fontFamily: null,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Icon(
                                Icons.star,
                                color: const Color(0xFF58CC02),
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${lesson.xpReward} XP',
                                style: const TextStyle(
                                  color: Color(0xFF58CC02),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: null,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'greetings':
        return const Color(0xFF58CC02);
      case 'numbers':
        return const Color(0xFF1CB0F6);
      case 'family':
        return const Color(0xFFFF6B6B);
      case 'colors':
        return const Color(0xFFFFD93D);
      case 'food':
        return const Color(0xFF6BCF7F);
      case 'body':
        return const Color(0xFFA8E6CF);
      case 'animals':
        return const Color(0xFFFF8B94);
      case 'clothing':
        return const Color(0xFFB4A7D6);
      case 'time':
        return const Color(0xFF88D8C0);
      case 'weather':
        return const Color(0xFFF7DC6F);
      case 'verbs':
        return const Color(0xFFBB8FCE);
      case 'adjectives':
        return const Color(0xFF85C1E9);
      case 'places':
        return const Color(0xFFF8C471);
      case 'directions':
        return const Color(0xFF82E0AA);
      case 'transportation':
        return const Color(0xFFF1948A);
      case 'grammar':
        return const Color(0xFFD7BDE2);
      case 'business':
        return const Color(0xFFAED6F1);
      default:
        return const Color(0xFF58CC02);
    }
  }

  void _startLesson(lesson_model.Lesson lesson) {
    // Navigate to lesson screen
    context.push('/language/amharic/lesson/${lesson.id}?native=English');
  }
}

