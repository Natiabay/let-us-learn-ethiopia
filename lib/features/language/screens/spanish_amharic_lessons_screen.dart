import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tourist_assistive_app/features/language/models/comprehensive_lesson_model.dart' as lesson_model;
import 'package:tourist_assistive_app/features/language/data/multilingual_amharic_lessons.dart';

class SpanishAmharicLessonsScreen extends ConsumerStatefulWidget {
  const SpanishAmharicLessonsScreen({super.key});

  @override
  ConsumerState<SpanishAmharicLessonsScreen> createState() => _SpanishAmharicLessonsScreenState();
}

class _SpanishAmharicLessonsScreenState extends ConsumerState<SpanishAmharicLessonsScreen>
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
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _lessons = _generateSpanishLessons(_selectedLevel);
        _isLoading = false;
      });
    });
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
                      const SizedBox(height: 100),
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
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => context.go('/language'),
      ),
      title: const Text(
        '🇪🇸 Español → Amharic',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings, color: Colors.white),
          onPressed: () => _showSettings(),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    final completedLessons = _lessons.where((l) => l.isCompleted).length;
    final totalLessons = _lessons.length;
    final progress = totalLessons > 0 ? completedLessons / totalLessons : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Aprender Amárico desde el Español',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Learn Amharic from Spanish',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${_selectedLevel.name.toUpperCase()} Level • ${_lessons.length} Lecciones • 400+ Minutos',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 16),
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
                color: const Color(0xFF1CB0F6),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '$completedLessons de $totalLessons lecciones completadas',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 14,
          ),
        ),
      ],
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildLevelSelector() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: lesson_model.LanguageLevel.values.map((level) {
          final isSelected = level == _selectedLevel;
          return Expanded(
            child: GestureDetector(
              onTap: () => _changeLevel(level),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF1CB0F6) : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  level.name.toUpperCase(),
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
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
    final totalXP = _lessons.fold(0, (sum, lesson) => sum + lesson.xpReward);
    final earnedXP = _lessons.where((l) => l.isCompleted).fold(0, (sum, lesson) => sum + lesson.xpReward);
    final totalMinutes = _lessons.fold(0, (sum, lesson) => sum + lesson.estimatedMinutes);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF1CB0F6).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(
              'Lecciones',
              '$completedLessons/${_lessons.length}',
              Icons.school,
              const Color(0xFF1CB0F6),
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: Colors.white.withValues(alpha: 0.2),
          ),
          Expanded(
            child: _buildStatItem(
              'XP',
              '$earnedXP/$totalXP',
              Icons.star,
              const Color(0xFFFFD700),
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: Colors.white.withValues(alpha: 0.2),
          ),
          Expanded(
            child: _buildStatItem(
              'Tiempo',
              '${totalMinutes}min',
              Icons.access_time,
              const Color(0xFF58CC02),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 1000.ms).slideX(begin: 0.3, end: 0);
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 24,
        ),
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
        const Text(
          'Lecciones Español → Amárico',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
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
    final isUnlocked = true; // All lessons are unlocked
    final isCompleted = lesson.isCompleted;
    
    Color backgroundColor = const Color(0xFF2A2A2A);
    Color borderColor = const Color(0xFF2A2A2A);
    
    if (isCompleted) {
      backgroundColor = const Color(0xFF58CC02);
      borderColor = const Color(0xFF58CC02);
    } else if (isUnlocked) {
      backgroundColor = const Color(0xFF1CB0F6).withValues(alpha: 0.1);
      borderColor = const Color(0xFF1CB0F6).withValues(alpha: 0.3);
    } else {
      backgroundColor = const Color(0xFF1A1A1A);
      borderColor = const Color(0xFF2A2A2A);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: isUnlocked ? () => _startLesson(lesson) : null,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor, width: 2),
            boxShadow: [
              BoxShadow(
                color: borderColor.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: isUnlocked ? const Color(0xFF1CB0F6) : const Color(0xFF2A2A2A),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: isCompleted
                    ? const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 24,
                      )
                    : isUnlocked
                        ? Text(
                            '${index + 1}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : const Icon(
                            Icons.lock,
                            color: Colors.white54,
                            size: 24,
                          ),
              ),
              
              const SizedBox(width: 16),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lesson.title,
                      style: TextStyle(
                        color: isUnlocked ? Colors.white : Colors.white54,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      lesson.description,
                      style: TextStyle(
                        color: isUnlocked ? Colors.white70 : Colors.white38,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildLessonStat(
                          '${lesson.estimatedMinutes} min',
                          Icons.access_time,
                          isUnlocked,
                        ),
                        const SizedBox(width: 12),
                        _buildLessonStat(
                          '${lesson.exercises.length} ejercicios',
                          Icons.quiz,
                          isUnlocked,
                        ),
                        const SizedBox(width: 12),
                        _buildLessonStat(
                          '${lesson.xpReward} XP',
                          Icons.star,
                          isUnlocked,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              if (isUnlocked && !isCompleted)
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1CB0F6).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      '${(lesson.progress * 100).toInt()}%',
                      style: const TextStyle(
                        color: Color(0xFF1CB0F6),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              else if (isCompleted)
                const Icon(
                  Icons.check_circle,
                  color: Color(0xFF58CC02),
                  size: 24,
                )
              else
                const Icon(
                  Icons.lock,
                  color: Colors.white54,
                  size: 24,
                ),
            ],
          ),
        ),
      ),
    ).animate(delay: (index * 100).ms)
        .fadeIn(duration: 600.ms)
        .slideX(begin: 0.3, end: 0);
  }

  Widget _buildLessonStat(String text, IconData icon, bool isUnlocked) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isUnlocked ? Colors.white70 : Colors.white38,
          size: 14,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            color: isUnlocked ? Colors.white70 : Colors.white38,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  void _startLesson(lesson_model.Lesson lesson) {
    context.push(
      '/language/amharic/lesson/${lesson.id}?native=Spanish',
    );
  }

  void _showSettings() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2A2A2A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Configuración',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            
            _buildSettingItem(
              icon: Icons.volume_up,
              title: 'Audio',
              subtitle: 'Activar/desactivar efectos de sonido',
              onTap: () {},
            ),
            
            _buildSettingItem(
              icon: Icons.notifications,
              title: 'Notificaciones',
              subtitle: 'Recordatorios diarios',
              onTap: () {},
            ),
            
            _buildSettingItem(
              icon: Icons.help_outline,
              title: 'Ayuda y Soporte',
              subtitle: 'Obtener ayuda con la aplicación',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF1CB0F6)),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: Colors.white70),
      ),
      onTap: onTap,
    );
  }

  List<lesson_model.Lesson> _generateSpanishLessons(lesson_model.LanguageLevel level) {
    // Get all Spanish lessons and filter by level
    final allSpanishLessons = MultilingualAmharicLessons.getSpanishLessons();
    return allSpanishLessons.where((lesson) => lesson.level == level).toList();
  }


}
