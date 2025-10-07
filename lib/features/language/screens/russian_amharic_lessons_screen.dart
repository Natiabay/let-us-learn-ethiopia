import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tourist_assistive_app/features/language/models/comprehensive_lesson_model.dart' as lesson_model;

class RussianAmharicLessonsScreen extends ConsumerStatefulWidget {
  const RussianAmharicLessonsScreen({super.key});

  @override
  ConsumerState<RussianAmharicLessonsScreen> createState() => _RussianAmharicLessonsScreenState();
}

class _RussianAmharicLessonsScreenState extends ConsumerState<RussianAmharicLessonsScreen>
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
        _lessons = _generateRussianLessons(_selectedLevel);
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
        '🇷🇺 Русский → Amharic',
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
          'Изучение амхарского с русского',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Learn Amharic from Russian',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${_selectedLevel.name.toUpperCase()} Level • ${_lessons.length} Уроков • 400+ Минут',
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
                color: const Color(0xFFCE82FF),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '$completedLessons из $totalLessons уроков завершено',
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
                  color: isSelected ? const Color(0xFFCE82FF) : Colors.transparent,
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
          color: const Color(0xFFCE82FF).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(
              'Уроки',
              '$completedLessons/${_lessons.length}',
              Icons.school,
              const Color(0xFFCE82FF),
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: Colors.white.withValues(alpha: 0.2),
          ),
          Expanded(
            child: _buildStatItem(
              'ОП',
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
              'Время',
              '${totalMinutes}мин',
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
          'Уроки Русский → Амхарский',
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
      backgroundColor = const Color(0xFFCE82FF).withValues(alpha: 0.1);
      borderColor = const Color(0xFFCE82FF).withValues(alpha: 0.3);
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
                  color: isUnlocked ? const Color(0xFFCE82FF) : const Color(0xFF2A2A2A),
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
                          '${lesson.estimatedMinutes} мин',
                          Icons.access_time,
                          isUnlocked,
                        ),
                        const SizedBox(width: 12),
                        _buildLessonStat(
                          '${lesson.exercises.length} упражнений',
                          Icons.quiz,
                          isUnlocked,
                        ),
                        const SizedBox(width: 12),
                        _buildLessonStat(
                          '${lesson.xpReward} ОП',
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
                    color: const Color(0xFFCE82FF).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      '${(lesson.progress * 100).toInt()}%',
                      style: const TextStyle(
                        color: Color(0xFFCE82FF),
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
      '/language/amharic/lesson/${lesson.id}?native=Russian',
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
              'Настройки',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            
            _buildSettingItem(
              icon: Icons.volume_up,
              title: 'Аудио',
              subtitle: 'Включить/выключить звуковые эффекты',
              onTap: () {},
            ),
            
            _buildSettingItem(
              icon: Icons.notifications,
              title: 'Уведомления',
              subtitle: 'Ежедневные напоминания',
              onTap: () {},
            ),
            
            _buildSettingItem(
              icon: Icons.help_outline,
              title: 'Помощь и поддержка',
              subtitle: 'Получить помощь с приложением',
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
      leading: Icon(icon, color: const Color(0xFFCE82FF)),
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

  List<lesson_model.Lesson> _generateRussianLessons(lesson_model.LanguageLevel level) {
    switch (level) {
      case lesson_model.LanguageLevel.beginner:
        return _generateRussianBeginnerLessons();
      case lesson_model.LanguageLevel.elementary:
        return _generateRussianBeginnerLessons(); // Use beginner lessons for elementary
      case lesson_model.LanguageLevel.intermediate:
        return _generateRussianIntermediateLessons();
      case lesson_model.LanguageLevel.advanced:
        return _generateRussianAdvancedLessons();
    }
  }

  List<lesson_model.Lesson> _generateRussianBeginnerLessons() {
    // Generate 100 beginner lessons efficiently in Russian
    final List<Map<String, dynamic>> lessonTemplates = [
      {
        'title': 'Основные приветствия',
        'description': 'Изучите основные приветствия на амхарском языке',
        'category': 'Основы',
        'vocabulary': ['ሰላም', 'እንዴት ናችሁ', 'እንደምን አለ', 'ታዲያስ', 'እንደምን አለች', 'በጣም ደህና', 'አመሰግናለሁ', 'ይቅርታ'],
        'exerciseGenerator': _generateGreetingExercises,
      },
      {
        'title': 'Числа 1-10',
        'description': 'Научитесь считать от 1 до 10 на амхарском языке',
        'category': 'Числа',
        'vocabulary': ['አንድ', 'ሁለት', 'ሶስት', 'አራት', 'አምስት', 'ስድስት', 'ሰባት', 'ስምንት', 'ዘጠኝ', 'አስር'],
        'exerciseGenerator': _generateNumberExercises,
      },
      {
        'title': 'Члены семьи',
        'description': 'Изучите названия членов семьи на амхарском языке',
        'category': 'Семья',
        'vocabulary': ['አባት', 'እናት', 'ወንድም', 'እህት', 'ልጅ', 'ወላጅ', 'አያት', 'አያት'],
        'exerciseGenerator': _generateFamilyExercises,
      },
      {
        'title': 'Цвета',
        'description': 'Изучите основные цвета на амхарском языке',
        'category': 'Цвета',
        'vocabulary': ['ቀይ', 'ነጭ', 'ጥቁር', 'ቢጫ', 'አረንጓዴ', 'ሰማያዊ', 'ቀለም', 'ጥቁር'],
        'exerciseGenerator': _generateColorExercises,
      },
      {
        'title': 'Еда и напитки',
        'description': 'Изучите распространенные слова о еде и напитках на амхарском языке',
        'category': 'Еда',
        'vocabulary': ['ውሃ', 'እንጀራ', 'ቡና', 'በርበሬ', 'ስጋ', 'ወተት', 'ቅመም', 'ጣዕም'],
        'exerciseGenerator': _generateFoodExercises,
      },
      {
        'title': 'Части тела',
        'description': 'Изучите названия частей тела на амхарском языке',
        'category': 'Тело',
        'vocabulary': ['እጅ', 'እግር', 'አይን', 'አፍ', 'አዕምሮ', 'ልብ', 'ጆሮ', 'አፍንጫ'],
        'exerciseGenerator': _generateBodyPartExercises,
      },
      {
        'title': 'Животные',
        'description': 'Изучите названия животных на амхарском языке',
        'category': 'Животные',
        'vocabulary': ['ውሻ', 'ድር', 'አህያ', 'ግምጃ', 'ኮረብታ', 'አይጥ', 'አሳ', 'አውሬ'],
        'exerciseGenerator': _generateAnimalExercises,
      },
      {
        'title': 'Одежда',
        'description': 'Изучите предметы одежды на амхарском языке',
        'category': 'Одежда',
        'vocabulary': ['ሸሚዝ', 'ጫማ', 'ቦታ', 'ካባ', 'ሱሪ', 'አልባሳት', 'አልባሳት', 'ጨርቅ'],
        'exerciseGenerator': _generateClothingExercises,
      },
      {
        'title': 'Время и дни',
        'description': 'Изучите выражения времени и дней на амхарском языке',
        'category': 'Время',
        'vocabulary': ['ሰአት', 'ቀን', 'ሳምንት', 'ወር', 'ዓመት', 'አሁን', 'አሁን', 'አሁን'],
        'exerciseGenerator': _generateTimeExercises,
      },
      {
        'title': 'Погода',
        'description': 'Изучите слова, связанные с погодой на амхарском языке',
        'category': 'Погода',
        'vocabulary': ['ፀሐይ', 'ዝናብ', 'ንፋስ', 'በረዶ', 'ደመና', 'ሙቀት', 'ቀዝቃዛ', 'አየር'],
        'exerciseGenerator': _generateWeatherExercises,
      },
      {
        'title': 'Распространенные глаголы',
        'description': 'Изучите основные глаголы на амхарском языке',
        'category': 'Глаголы',
        'vocabulary': ['መሄድ', 'መምጣት', 'መብላት', 'መጠጣት', 'መተኛት', 'መነሳት', 'መስራት', 'መጫወት'],
        'exerciseGenerator': _generateVerbExercises,
      },
      {
        'title': 'Распространенные прилагательные',
        'description': 'Изучите описательные слова на амхарском языке',
        'category': 'Прилагательные',
        'vocabulary': ['ትልቅ', 'ትንሽ', 'መልካም', 'መጥፎ', 'ፈጣን', 'ዝግተኛ', 'ቀላል', 'አስቸጋሪ'],
        'exerciseGenerator': _generateAdjectiveExercises,
      },
    ];

    // Generate 100 beginner lessons by repeating and varying the templates
    List<lesson_model.Lesson> lessons = [];
    
    for (int i = 0; i < 100; i++) {
      final template = lessonTemplates[i % lessonTemplates.length];
      final lessonNumber = i + 1;
      
      lessons.add(lesson_model.Lesson(
        id: 'ru_beginner_$lessonNumber',
        title: '${template['title']}${lessonNumber > 12 ? ' ($lessonNumber)' : ''}',
        description: template['description'],
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'ru',
        estimatedMinutes: 8,
        xpReward: 100,
        category: template['category'],
        exercises: (template['exerciseGenerator'] as Function)(),
        vocabulary: List<String>.from(template['vocabulary']),
      ));
    }
    
    return lessons;
  }

  List<lesson_model.Lesson> _generateRussianBeginnerLessonsOld() {
    return [
      lesson_model.Lesson(
        id: 'ru_beginner_1',
        title: 'Основные приветствия',
        description: 'Изучите основные приветствия на амхарском',
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'ru',
        estimatedMinutes: 6,
        xpReward: 100,
        category: 'Basics',
        exercises: _generateGreetingExercises(),
        vocabulary: ['ሰላም', 'እንዴት ናችሁ', 'እንደምን አለ', 'ታዲያስ', 'እንደምን አለች'],
      ),
      
      lesson_model.Lesson(
        id: 'ru_beginner_2',
        title: 'Числа 1-10',
        description: 'Научитесь считать от 1 до 10 на амхарском',
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'ru',
        estimatedMinutes: 6,
        xpReward: 100,
        category: 'Numbers',
        exercises: _generateNumberExercises(),
        vocabulary: ['አንድ', 'ሁለት', 'ሶስት', 'አራት', 'አምስት', 'ስድስት', 'ሰባት', 'ስምንት', 'ዘጠኝ', 'አስር'],
      ),
      
      lesson_model.Lesson(
        id: 'ru_beginner_3',
        title: 'Члены семьи',
        description: 'Изучите названия членов семьи на амхарском',
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'ru',
        estimatedMinutes: 6,
        xpReward: 100,
        category: 'Family',
        exercises: _generateFamilyExercises(),
        vocabulary: ['አባት', 'እናት', 'ወንድም', 'እህት', 'ልጅ', 'ወላጅ'],
      ),
    ];
  }

  List<lesson_model.Lesson> _generateRussianIntermediateLessons() {
    // Generate 50 intermediate lessons efficiently in Russian
    final List<Map<String, dynamic>> intermediateTemplates = [
      {
        'title': 'Путешествия и транспорт',
        'description': 'Изучите словарь, связанный с путешествиями на амхарском языке',
        'category': 'Путешествия',
        'vocabulary': ['መኪና', 'አውሮፕላን', 'ባቡር', 'አውቶቡስ', 'ታክሲ', 'መንገድ', 'መጠጣት', 'መጠጣት'],
        'exerciseGenerator': _generateTravelExercises,
      },
      {
        'title': 'Покупки и деньги',
        'description': 'Изучите словарь покупок и денег на амхарском языке',
        'category': 'Покупки',
        'vocabulary': ['ገንዘብ', 'ዋጋ', 'ገዢ', 'ሻጭ', 'ሱቅ', 'መግዛት', 'መሸጥ', 'ቅናሽ'],
        'exerciseGenerator': _generateShoppingExercises,
      },
      {
        'title': 'Здоровье и медицина',
        'description': 'Изучите термины здоровья и медицины на амхарском языке',
        'category': 'Здоровье',
        'vocabulary': ['ህመም', 'ዶክተር', 'ሆስፒታል', 'መድሃኒት', 'ጤና', 'ህመም', 'መፈወስ', 'መፈወስ'],
        'exerciseGenerator': _generateHealthExercises,
      },
      {
        'title': 'Работа и профессии',
        'description': 'Изучите словарь работы и профессий на амхарском языке',
        'category': 'Работа',
        'vocabulary': ['ስራ', 'ሰራተኛ', 'አስተዳዳሪ', 'መምህር', 'መምህር', 'መምህር', 'መምህር', 'መምህር'],
        'exerciseGenerator': _generateWorkExercises,
      },
      {
        'title': 'Образование и школа',
        'description': 'Изучите словарь, связанный с образованием на амхарском языке',
        'category': 'Образование',
        'vocabulary': ['ትምህርት', 'ትምህርት ቤት', 'መጽሐፍ', 'መጽሐፍ', 'መጽሐፍ', 'መጽሐፍ', 'መጽሐፍ', 'መጽሐፍ'],
        'exerciseGenerator': _generateEducationExercises,
      },
    ];

    List<lesson_model.Lesson> lessons = [];
    
    for (int i = 0; i < 50; i++) {
      final template = intermediateTemplates[i % intermediateTemplates.length];
      final lessonNumber = i + 1;
      
      lessons.add(lesson_model.Lesson(
        id: 'ru_intermediate_$lessonNumber',
        title: '${template['title']} ($lessonNumber)',
        description: template['description'],
        level: lesson_model.LanguageLevel.intermediate,
        languageCode: 'ru',
        estimatedMinutes: 10,
        xpReward: 150,
        category: template['category'],
        exercises: (template['exerciseGenerator'] as Function)(),
        vocabulary: List<String>.from(template['vocabulary']),
      ));
    }
    
    return lessons;
  }

  List<lesson_model.Lesson> _generateRussianAdvancedLessons() {
    // Generate 30 advanced lessons efficiently in Russian
    final List<Map<String, dynamic>> advancedTemplates = [
      {
        'title': 'Бизнес и экономика',
        'description': 'Изучите термины бизнеса и экономики на амхарском языке',
        'category': 'Бизнес',
        'vocabulary': ['ንግድ', 'ኢኮኖሚ', 'ገንዘብ', 'ገንዘብ', 'ገንዘብ', 'ገንዘብ', 'ገንዘብ', 'ገንዘብ'],
        'exerciseGenerator': _generateBusinessExercises,
      },
      {
        'title': 'Политика и правительство',
        'description': 'Изучите политический и правительственный словарь на амхарском языке',
        'category': 'Политика',
        'vocabulary': ['ፖለቲካ', 'መንግስት', 'ፕሬዚዳንት', 'ፕሬዚዳንት', 'ፕሬዚዳንት', 'ፕሬዚዳንት', 'ፕሬዚዳንት', 'ፕሬዚዳንት'],
        'exerciseGenerator': _generatePoliticsExercises,
      },
    ];

    List<lesson_model.Lesson> lessons = [];
    
    for (int i = 0; i < 30; i++) {
      final template = advancedTemplates[i % advancedTemplates.length];
      final lessonNumber = i + 1;
      
      lessons.add(lesson_model.Lesson(
        id: 'ru_advanced_$lessonNumber',
        title: '${template['title']} ($lessonNumber)',
        description: template['description'],
        level: lesson_model.LanguageLevel.advanced,
        languageCode: 'ru',
        estimatedMinutes: 12,
        xpReward: 200,
        category: template['category'],
        exercises: (template['exerciseGenerator'] as Function)(),
        vocabulary: List<String>.from(template['vocabulary']),
      ));
    }
    
    return lessons;
  }

  // Missing exercise generators
  List<lesson_model.Exercise> _generateColorExercises() {
    return [
      lesson_model.Exercise(
        id: 'color_1',
        type: lesson_model.ExerciseType.translate,
        instruction: 'Переведите "Красный" на амхарский',
        amharicText: 'ቀይ',
        translation: 'Красный',
        options: [
          lesson_model.ExerciseOption(text: 'ቀይ', isCorrect: true),
          lesson_model.ExerciseOption(text: 'ነጭ', isCorrect: false),
          lesson_model.ExerciseOption(text: 'ጥቁር', isCorrect: false),
        ],
      ),
    ];
  }

  List<lesson_model.Exercise> _generateFoodExercises() {
    return [
      lesson_model.Exercise(
        id: 'food_1',
        type: lesson_model.ExerciseType.translate,
        instruction: 'Переведите "Вода" на амхарский',
        amharicText: 'ውሃ',
        translation: 'Вода',
        options: [
          lesson_model.ExerciseOption(text: 'ውሃ', isCorrect: true),
          lesson_model.ExerciseOption(text: 'እንጀራ', isCorrect: false),
          lesson_model.ExerciseOption(text: 'ቡና', isCorrect: false),
        ],
      ),
    ];
  }

  List<lesson_model.Exercise> _generateBodyPartExercises() {
    return [
      lesson_model.Exercise(
        id: 'body_1',
        type: lesson_model.ExerciseType.translate,
        instruction: 'Переведите "Рука" на амхарский',
        amharicText: 'እጅ',
        translation: 'Рука',
        options: [
          lesson_model.ExerciseOption(text: 'እጅ', isCorrect: true),
          lesson_model.ExerciseOption(text: 'እግር', isCorrect: false),
          lesson_model.ExerciseOption(text: 'አይን', isCorrect: false),
        ],
      ),
    ];
  }

  List<lesson_model.Exercise> _generateAnimalExercises() {
    return [
      lesson_model.Exercise(
        id: 'animal_1',
        type: lesson_model.ExerciseType.translate,
        instruction: 'Переведите "Собака" на амхарский',
        amharicText: 'ውሻ',
        translation: 'Собака',
        options: [
          lesson_model.ExerciseOption(text: 'ውሻ', isCorrect: true),
          lesson_model.ExerciseOption(text: 'ድር', isCorrect: false),
          lesson_model.ExerciseOption(text: 'አህያ', isCorrect: false),
        ],
      ),
    ];
  }

  List<lesson_model.Exercise> _generateClothingExercises() {
    return [
      lesson_model.Exercise(
        id: 'clothing_1',
        type: lesson_model.ExerciseType.translate,
        instruction: 'Переведите "Рубашка" на амхарский',
        amharicText: 'ሸሚዝ',
        translation: 'Рубашка',
        options: [
          lesson_model.ExerciseOption(text: 'ሸሚዝ', isCorrect: true),
          lesson_model.ExerciseOption(text: 'ጫማ', isCorrect: false),
          lesson_model.ExerciseOption(text: 'ቦታ', isCorrect: false),
        ],
      ),
    ];
  }

  List<lesson_model.Exercise> _generateTimeExercises() {
    return [
      lesson_model.Exercise(
        id: 'time_1',
        type: lesson_model.ExerciseType.translate,
        instruction: 'Переведите "Час" на амхарский',
        amharicText: 'ሰአት',
        translation: 'Час',
        options: [
          lesson_model.ExerciseOption(text: 'ሰአት', isCorrect: true),
          lesson_model.ExerciseOption(text: 'ቀን', isCorrect: false),
          lesson_model.ExerciseOption(text: 'ሳምንት', isCorrect: false),
        ],
      ),
    ];
  }

  List<lesson_model.Exercise> _generateWeatherExercises() {
    return [
      lesson_model.Exercise(
        id: 'weather_1',
        type: lesson_model.ExerciseType.translate,
        instruction: 'Переведите "Солнце" на амхарский',
        amharicText: 'ፀሐይ',
        translation: 'Солнце',
        options: [
          lesson_model.ExerciseOption(text: 'ፀሐይ', isCorrect: true),
          lesson_model.ExerciseOption(text: 'ዝናብ', isCorrect: false),
          lesson_model.ExerciseOption(text: 'ንፋስ', isCorrect: false),
        ],
      ),
    ];
  }

  List<lesson_model.Exercise> _generateVerbExercises() {
    return [
      lesson_model.Exercise(
        id: 'verb_1',
        type: lesson_model.ExerciseType.translate,
        instruction: 'Переведите "Идти" на амхарский',
        amharicText: 'መሄድ',
        translation: 'Идти',
        options: [
          lesson_model.ExerciseOption(text: 'መሄድ', isCorrect: true),
          lesson_model.ExerciseOption(text: 'መምጣት', isCorrect: false),
          lesson_model.ExerciseOption(text: 'መብላት', isCorrect: false),
        ],
      ),
    ];
  }

  List<lesson_model.Exercise> _generateAdjectiveExercises() {
    return [
      lesson_model.Exercise(
        id: 'adjective_1',
        type: lesson_model.ExerciseType.translate,
        instruction: 'Переведите "Большой" на амхарский',
        amharicText: 'ትልቅ',
        translation: 'Большой',
        options: [
          lesson_model.ExerciseOption(text: 'ትልቅ', isCorrect: true),
          lesson_model.ExerciseOption(text: 'ትንሽ', isCorrect: false),
          lesson_model.ExerciseOption(text: 'መልካም', isCorrect: false),
        ],
      ),
    ];
  }

  List<lesson_model.Exercise> _generateTravelExercises() {
    return [
      lesson_model.Exercise(
        id: 'travel_1',
        type: lesson_model.ExerciseType.translate,
        instruction: 'Переведите "Путешествие" на амхарский',
        amharicText: 'ጉዞ',
        translation: 'Путешествие',
        options: [
          lesson_model.ExerciseOption(text: 'ጉዞ', isCorrect: true),
          lesson_model.ExerciseOption(text: 'መኪና', isCorrect: false),
          lesson_model.ExerciseOption(text: 'አውሮፕላን', isCorrect: false),
        ],
      ),
    ];
  }

  List<lesson_model.Exercise> _generateShoppingExercises() {
    return [
      lesson_model.Exercise(
        id: 'shopping_1',
        type: lesson_model.ExerciseType.translate,
        instruction: 'Переведите "Покупки" на амхарский',
        amharicText: 'ግዛት',
        translation: 'Покупки',
        options: [
          lesson_model.ExerciseOption(text: 'ግዛት', isCorrect: true),
          lesson_model.ExerciseOption(text: 'ገንዘብ', isCorrect: false),
          lesson_model.ExerciseOption(text: 'ዋጋ', isCorrect: false),
        ],
      ),
    ];
  }

  List<lesson_model.Exercise> _generateHealthExercises() {
    return [
      lesson_model.Exercise(
        id: 'health_1',
        type: lesson_model.ExerciseType.translate,
        instruction: 'Переведите "Здоровье" на амхарский',
        amharicText: 'ጤና',
        translation: 'Здоровье',
        options: [
          lesson_model.ExerciseOption(text: 'ጤና', isCorrect: true),
          lesson_model.ExerciseOption(text: 'ህመም', isCorrect: false),
          lesson_model.ExerciseOption(text: 'ዶክተር', isCorrect: false),
        ],
      ),
    ];
  }

  List<lesson_model.Exercise> _generateWorkExercises() {
    return [
      lesson_model.Exercise(
        id: 'work_1',
        type: lesson_model.ExerciseType.translate,
        instruction: 'Переведите "Работа" на амхарский',
        amharicText: 'ስራ',
        translation: 'Работа',
        options: [
          lesson_model.ExerciseOption(text: 'ስራ', isCorrect: true),
          lesson_model.ExerciseOption(text: 'ሰራተኛ', isCorrect: false),
          lesson_model.ExerciseOption(text: 'አስተዳዳሪ', isCorrect: false),
        ],
      ),
    ];
  }

  List<lesson_model.Exercise> _generateEducationExercises() {
    return [
      lesson_model.Exercise(
        id: 'education_1',
        type: lesson_model.ExerciseType.translate,
        instruction: 'Переведите "Образование" на амхарский',
        amharicText: 'ትምህርት',
        translation: 'Образование',
        options: [
          lesson_model.ExerciseOption(text: 'ትምህርት', isCorrect: true),
          lesson_model.ExerciseOption(text: 'ትምህርት ቤት', isCorrect: false),
          lesson_model.ExerciseOption(text: 'መጽሐፍ', isCorrect: false),
        ],
      ),
    ];
  }

  List<lesson_model.Exercise> _generateBusinessExercises() {
    return [
      lesson_model.Exercise(
        id: 'business_1',
        type: lesson_model.ExerciseType.translate,
        instruction: 'Переведите "Бизнес" на амхарский',
        amharicText: 'ንግድ',
        translation: 'Бизнес',
        options: [
          lesson_model.ExerciseOption(text: 'ንግድ', isCorrect: true),
          lesson_model.ExerciseOption(text: 'ኢኮኖሚ', isCorrect: false),
          lesson_model.ExerciseOption(text: 'ገንዘብ', isCorrect: false),
        ],
      ),
    ];
  }

  List<lesson_model.Exercise> _generatePoliticsExercises() {
    return [
      lesson_model.Exercise(
        id: 'politics_1',
        type: lesson_model.ExerciseType.translate,
        instruction: 'Переведите "Политика" на амхарский',
        amharicText: 'ፖለቲካ',
        translation: 'Политика',
        options: [
          lesson_model.ExerciseOption(text: 'ፖለቲካ', isCorrect: true),
          lesson_model.ExerciseOption(text: 'መንግስት', isCorrect: false),
          lesson_model.ExerciseOption(text: 'ፕሬዚዳንት', isCorrect: false),
        ],
      ),
    ];
  }

  List<lesson_model.Exercise> _generateGreetingExercises() {
    return [
      lesson_model.Exercise(
        id: 'greeting_1',
        type: lesson_model.ExerciseType.selectImage,
        instruction: 'Выберите правильное изображение для "Привет"',
        amharicText: 'ሰላም',
        translation: 'Привет',
        imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&h=300&fit=crop',
        options: [
          lesson_model.ExerciseOption(
            text: 'Привет',
            imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&h=300&fit=crop',
            isCorrect: true,
          ),
          lesson_model.ExerciseOption(
            text: 'До свидания',
            imageUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=300&h=300&fit=crop',
            isCorrect: false,
          ),
          lesson_model.ExerciseOption(
            text: 'Спасибо',
            imageUrl: 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=300&h=300&fit=crop',
            isCorrect: false,
          ),
          lesson_model.ExerciseOption(
            text: 'Пожалуйста',
            imageUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=300&h=300&fit=crop',
            isCorrect: false,
          ),
        ],
      ),
    ];
  }

  List<lesson_model.Exercise> _generateNumberExercises() {
    return [
      lesson_model.Exercise(
        id: 'number_1',
        type: lesson_model.ExerciseType.translate,
        instruction: 'Переведите "Один" на амхарский',
        amharicText: 'አንድ',
        translation: 'Один',
        options: [
          lesson_model.ExerciseOption(text: 'አንድ', isCorrect: true),
          lesson_model.ExerciseOption(text: 'ሁለት', isCorrect: false),
          lesson_model.ExerciseOption(text: 'ሶስት', isCorrect: false),
          lesson_model.ExerciseOption(text: 'አራት', isCorrect: false),
        ],
      ),
    ];
  }

  List<lesson_model.Exercise> _generateFamilyExercises() {
    return [
      lesson_model.Exercise(
        id: 'family_1',
        type: lesson_model.ExerciseType.selectImage,
        instruction: 'Выберите изображение для "Отец"',
        amharicText: 'አባት',
        translation: 'Отец',
        imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&h=300&fit=crop',
        options: [
          lesson_model.ExerciseOption(
            text: 'Отец',
            imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&h=300&fit=crop',
            isCorrect: true,
          ),
          lesson_model.ExerciseOption(
            text: 'Мать',
            imageUrl: 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=300&h=300&fit=crop',
            isCorrect: false,
          ),
          lesson_model.ExerciseOption(
            text: 'Брат',
            imageUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=300&h=300&fit=crop',
            isCorrect: false,
          ),
          lesson_model.ExerciseOption(
            text: 'Сестра',
            imageUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=300&h=300&fit=crop',
            isCorrect: false,
          ),
        ],
      ),
    ];
  }
}
