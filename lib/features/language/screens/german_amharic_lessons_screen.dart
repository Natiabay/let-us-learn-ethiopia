import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:tourist_assistive_app/features/language/models/comprehensive_lesson_model.dart' as lesson_model;

class GermanAmharicLessonsScreen extends ConsumerStatefulWidget {
  const GermanAmharicLessonsScreen({super.key});

  @override
  ConsumerState<GermanAmharicLessonsScreen> createState() => _GermanAmharicLessonsScreenState();
}

class _GermanAmharicLessonsScreenState extends ConsumerState<GermanAmharicLessonsScreen>
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
        _lessons = _generateGermanLessons(_selectedLevel);
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
                  color: Color(0xFF00D9B8),
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
        '🇩🇪 Deutsch → Amharic',
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
          'Amharisch lernen aus dem Deutschen',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Learn Amharic from German',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${_selectedLevel.name.toUpperCase()} Level • ${_lessons.length} Lektionen • 400+ Minuten',
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
          '$completedLessons von $totalLessons Lektionen abgeschlossen',
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
              'Lektionen',
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
              'Zeit',
              '${totalMinutes}min',
              Icons.access_time,
              const Color(0xFF00D9B8),
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
          'Deutsch → Amharisch Lektionen',
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
      backgroundColor = const Color(0xFF00D9B8);
      borderColor = const Color(0xFF00D9B8);
    } else {
      backgroundColor = const Color(0xFFCE82FF).withValues(alpha: 0.1);
      borderColor = const Color(0xFFCE82FF).withValues(alpha: 0.3);
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
                          '${lesson.estimatedMinutes} min',
                          Icons.access_time,
                          isUnlocked,
                        ),
                        const SizedBox(width: 12),
                        _buildLessonStat(
                          '${lesson.exercises.length} Übungen',
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
                  color: Color(0xFF00D9B8),
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
      '/language/amharic/lesson/${lesson.id}?native=German',
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
              'Einstellungen',
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
              subtitle: 'Soundeffekte aktivieren/deaktivieren',
              onTap: () {},
            ),
            
            _buildSettingItem(
              icon: Icons.notifications,
              title: 'Benachrichtigungen',
              subtitle: 'Tägliche Erinnerungen',
              onTap: () {},
            ),
            
            _buildSettingItem(
              icon: Icons.help_outline,
              title: 'Hilfe und Support',
              subtitle: 'Hilfe zur App erhalten',
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

  List<lesson_model.Lesson> _generateGermanLessons(lesson_model.LanguageLevel level) {
    switch (level) {
      case lesson_model.LanguageLevel.beginner:
        return _generateGermanBeginnerLessons();
      case lesson_model.LanguageLevel.elementary:
        return _generateGermanBeginnerLessons(); // Use beginner lessons for elementary
      case lesson_model.LanguageLevel.intermediate:
        return _generateGermanIntermediateLessons();
      case lesson_model.LanguageLevel.advanced:
        return _generateGermanAdvancedLessons();
    }
  }

  List<lesson_model.Lesson> _generateGermanBeginnerLessons() {
    // Generate 100 beginner lessons efficiently in German
    final List<Map<String, dynamic>> lessonTemplates = [
      {
        'title': 'Grundlegende Begrüßungen',
        'description': 'Lernen Sie grundlegende Begrüßungen auf Amharisch',
        'category': 'Grundlagen',
        'vocabulary': ['ሰላም', 'እንዴት ናችሁ', 'እንደምን አለ', 'ታዲያስ', 'እንደምን አለች', 'በጣም ደህና', 'አመሰግናለሁ', 'ይቅርታ'],
        'exerciseGenerator': _generateGreetingExercises,
      },
      {
        'title': 'Zahlen 1-10',
        'description': 'Lernen Sie, von 1 bis 10 auf Amharisch zu zählen',
        'category': 'Zahlen',
        'vocabulary': ['አንድ', 'ሁለት', 'ሶስት', 'አራት', 'አምስት', 'ስድስት', 'ሰባት', 'ስምንት', 'ዘጠኝ', 'አስር'],
        'exerciseGenerator': _generateNumberExercises,
      },
      {
        'title': 'Familienmitglieder',
        'description': 'Lernen Sie die Namen der Familienmitglieder auf Amharisch',
        'category': 'Familie',
        'vocabulary': ['አባት', 'እናት', 'ወንድም', 'እህት', 'ልጅ', 'ወላጅ', 'አያት', 'አያት'],
        'exerciseGenerator': _generateFamilyExercises,
      },
      {
        'title': 'Farben',
        'description': 'Lernen Sie grundlegende Farben auf Amharisch',
        'category': 'Farben',
        'vocabulary': ['ቀይ', 'ነጭ', 'ጥቁር', 'ቢጫ', 'አረንጓዴ', 'ሰማያዊ', 'ቀለም', 'ጥቁር'],
        'exerciseGenerator': _generateColorExercises,
      },
      {
        'title': 'Essen und Getränke',
        'description': 'Lernen Sie häufige Wörter für Essen und Getränke auf Amharisch',
        'category': 'Essen',
        'vocabulary': ['ውሃ', 'እንጀራ', 'ቡና', 'በርበሬ', 'ስጋ', 'ወተት', 'ቅመም', 'ጣዕም'],
        'exerciseGenerator': _generateFoodExercises,
      },
      {
        'title': 'Körperteile',
        'description': 'Lernen Sie die Namen der Körperteile auf Amharisch',
        'category': 'Körper',
        'vocabulary': ['እጅ', 'እግር', 'አይን', 'አፍ', 'አዕምሮ', 'ልብ', 'ጆሮ', 'አፍንጫ'],
        'exerciseGenerator': _generateBodyPartExercises,
      },
      {
        'title': 'Tiere',
        'description': 'Lernen Sie die Namen der Tiere auf Amharisch',
        'category': 'Tiere',
        'vocabulary': ['ውሻ', 'ድር', 'አህያ', 'ግምጃ', 'ኮረብታ', 'አይጥ', 'አሳ', 'አውሬ'],
        'exerciseGenerator': _generateAnimalExercises,
      },
      {
        'title': 'Kleidung',
        'description': 'Lernen Sie Kleidungsstücke auf Amharisch',
        'category': 'Kleidung',
        'vocabulary': ['ሸሚዝ', 'ጫማ', 'ቦታ', 'ካባ', 'ሱሪ', 'አልባሳት', 'አልባሳት', 'ጨርቅ'],
        'exerciseGenerator': _generateClothingExercises,
      },
      {
        'title': 'Zeit und Tage',
        'description': 'Lernen Sie Zeitausdrücke und Tage auf Amharisch',
        'category': 'Zeit',
        'vocabulary': ['ሰአት', 'ቀን', 'ሳምንት', 'ወር', 'ዓመት', 'አሁን', 'አሁን', 'አሁን'],
        'exerciseGenerator': _generateTimeExercises,
      },
      {
        'title': 'Wetter',
        'description': 'Lernen Sie wetterbezogene Wörter auf Amharisch',
        'category': 'Wetter',
        'vocabulary': ['ፀሐይ', 'ዝናብ', 'ንፋስ', 'በረዶ', 'ደመና', 'ሙቀት', 'ቀዝቃዛ', 'አየር'],
        'exerciseGenerator': _generateWeatherExercises,
      },
      {
        'title': 'Häufige Verben',
        'description': 'Lernen Sie grundlegende Verben auf Amharisch',
        'category': 'Verben',
        'vocabulary': ['መሄድ', 'መምጣት', 'መብላት', 'መጠጣት', 'መተኛት', 'መነሳት', 'መስራት', 'መጫወት'],
        'exerciseGenerator': _generateVerbExercises,
      },
      {
        'title': 'Häufige Adjektive',
        'description': 'Lernen Sie beschreibende Wörter auf Amharisch',
        'category': 'Adjektive',
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
        id: 'de_beginner_$lessonNumber',
        title: '${template['title']}${lessonNumber > 12 ? ' ($lessonNumber)' : ''}',
        description: template['description'],
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'de',
        estimatedMinutes: 8,
        xpReward: 100,
        category: template['category'],
        exercises: (template['exerciseGenerator'] as Function)(),
        vocabulary: List<String>.from(template['vocabulary']),
      ));
    }
    
    return lessons;
  }

  List<lesson_model.Lesson> _generateGermanBeginnerLessonsOld() {
    return [
      lesson_model.Lesson(
        id: 'de_beginner_1',
        title: 'Grundlegende Begrüßungen',
        description: 'Lernen Sie grundlegende Begrüßungen auf Amharisch',
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'de',
        estimatedMinutes: 6,
        xpReward: 100,
        category: 'Basics',
        exercises: _generateGreetingExercises(),
        vocabulary: ['ሰላም', 'እንዴት ናችሁ', 'እንደምን አለ', 'ታዲያስ', 'እንደምን አለች'],
      ),
      
      lesson_model.Lesson(
        id: 'de_beginner_2',
        title: 'Zahlen 1-10',
        description: 'Lernen Sie, von 1 bis 10 auf Amharisch zu zählen',
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'de',
        estimatedMinutes: 6,
        xpReward: 100,
        category: 'Numbers',
        exercises: _generateNumberExercises(),
        vocabulary: ['አንድ', 'ሁለት', 'ሶስት', 'አራት', 'አምስት', 'ስድስት', 'ሰባት', 'ስምንት', 'ዘጠኝ', 'አስር'],
      ),
      
      lesson_model.Lesson(
        id: 'de_beginner_3',
        title: 'Familienmitglieder',
        description: 'Lernen Sie die Namen der Familienmitglieder auf Amharisch',
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'de',
        estimatedMinutes: 8,
        xpReward: 100,
        category: 'Family',
        exercises: _generateFamilyExercises(),
        vocabulary: ['አባት', 'እናት', 'ወንድም', 'እህት', 'ልጅ', 'ወላጅ', 'አያት', 'አያት'],
      ),
      
      // Lesson 4: Colors
      lesson_model.Lesson(
        id: 'de_beginner_4',
        title: 'Farben',
        description: 'Lernen Sie grundlegende Farben auf Amharisch',
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'de',
        estimatedMinutes: 8,
        xpReward: 100,
        category: 'Colors',
        exercises: _generateColorExercises(),
        vocabulary: ['ቀይ', 'ነጭ', 'ጥቁር', 'ቢጫ', 'አረንጓዴ', 'ሰማያዊ', 'ቀለም', 'ጥቁር'],
      ),
      
      // Lesson 5: Food and Drinks
      lesson_model.Lesson(
        id: 'de_beginner_5',
        title: 'Essen und Getränke',
        description: 'Lernen Sie häufige Wörter für Essen und Getränke auf Amharisch',
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'de',
        estimatedMinutes: 8,
        xpReward: 100,
        category: 'Food',
        exercises: _generateFoodExercises(),
        vocabulary: ['ውሃ', 'እንጀራ', 'ቡና', 'በርበሬ', 'ስጋ', 'ወተት', 'ቅመም', 'ጣዕም'],
      ),
      
      // Lesson 6: Body Parts
      lesson_model.Lesson(
        id: 'de_beginner_6',
        title: 'Körperteile',
        description: 'Lernen Sie die Namen der Körperteile auf Amharisch',
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'de',
        estimatedMinutes: 8,
        xpReward: 100,
        category: 'Body',
        exercises: _generateBodyPartExercises(),
        vocabulary: ['እጅ', 'እግር', 'አይን', 'አፍ', 'አዕምሮ', 'ልብ', 'ጆሮ', 'አፍንጫ'],
      ),
      
      // Lesson 7: Animals
      lesson_model.Lesson(
        id: 'de_beginner_7',
        title: 'Tiere',
        description: 'Lernen Sie die Namen der Tiere auf Amharisch',
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'de',
        estimatedMinutes: 8,
        xpReward: 100,
        category: 'Animals',
        exercises: _generateAnimalExercises(),
        vocabulary: ['ውሻ', 'ድር', 'አህያ', 'ግምጃ', 'ኮረብታ', 'አይጥ', 'አሳ', 'አውሬ'],
      ),
      
      // Lesson 8: Clothing
      lesson_model.Lesson(
        id: 'de_beginner_8',
        title: 'Kleidung',
        description: 'Lernen Sie Kleidungswörter auf Amharisch',
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'de',
        estimatedMinutes: 8,
        xpReward: 100,
        category: 'Clothing',
        exercises: _generateClothingExercises(),
        vocabulary: ['ሸሚዝ', 'ጫማ', 'ቦታ', 'ካባ', 'ሱሪ', 'አልባሳት', 'አልባሳት', 'ጨርቅ'],
      ),
      
      // Lesson 9: Time and Days
      lesson_model.Lesson(
        id: 'de_beginner_9',
        title: 'Zeit und Tage',
        description: 'Lernen Sie Zeitausdrücke und Tage auf Amharisch',
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'de',
        estimatedMinutes: 8,
        xpReward: 100,
        category: 'Time',
        exercises: _generateTimeExercises(),
        vocabulary: ['ሰአት', 'ቀን', 'ሳምንት', 'ወር', 'ዓመት', 'አሁን', 'አሁን', 'አሁን'],
      ),
      
      // Lesson 10: Weather
      lesson_model.Lesson(
        id: 'de_beginner_10',
        title: 'Wetter',
        description: 'Lernen Sie wetterbezogene Wörter auf Amharisch',
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'de',
        estimatedMinutes: 8,
        xpReward: 100,
        category: 'Weather',
        exercises: _generateWeatherExercises(),
        vocabulary: ['ፀሐይ', 'ዝናብ', 'ንፋስ', 'በረዶ', 'ደመና', 'ሙቀት', 'ቀዝቃዛ', 'አየር'],
      ),
      
      // Lesson 11: Common Verbs
      lesson_model.Lesson(
        id: 'de_beginner_11',
        title: 'Häufige Verben',
        description: 'Lernen Sie grundlegende Verben auf Amharisch',
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'de',
        estimatedMinutes: 8,
        xpReward: 100,
        category: 'Verbs',
        exercises: _generateVerbExercises(),
        vocabulary: ['መሄድ', 'መምጣት', 'መብላት', 'መጠጣት', 'መተኛት', 'መነሳት', 'መስራት', 'መጫወት'],
      ),
      
      // Lesson 12: Common Adjectives
      lesson_model.Lesson(
        id: 'de_beginner_12',
        title: 'Häufige Adjektive',
        description: 'Lernen Sie beschreibende Wörter auf Amharisch',
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'de',
        estimatedMinutes: 8,
        xpReward: 100,
        category: 'Adjectives',
        exercises: _generateAdjectiveExercises(),
        vocabulary: ['ትልቅ', 'ትንሽ', 'መልካም', 'መጥፎ', 'ፈጣን', 'ዝግተኛ', 'ቀላል', 'አስቸጋሪ'],
      ),
    ];
  }

  List<lesson_model.Lesson> _generateGermanIntermediateLessons() {
    // Generate 50 intermediate lessons efficiently in German
    final List<Map<String, dynamic>> intermediateTemplates = [
      {
        'title': 'Reisen und Transport',
        'description': 'Lernen Sie reisebezogenes Vokabular auf Amharisch',
        'category': 'Reisen',
        'vocabulary': ['መኪና', 'አውሮፕላን', 'ባቡር', 'አውቶቡስ', 'ታክሲ', 'መንገድ', 'መጠጣት', 'መጠጣት'],
        'exerciseGenerator': _generateTravelExercises,
      },
      {
        'title': 'Einkaufen und Geld',
        'description': 'Lernen Sie Einkaufs- und Geldvokabular auf Amharisch',
        'category': 'Einkaufen',
        'vocabulary': ['ገንዘብ', 'ዋጋ', 'ገዢ', 'ሻጭ', 'ሱቅ', 'መግዛት', 'መሸጥ', 'ቅናሽ'],
        'exerciseGenerator': _generateShoppingExercises,
      },
      {
        'title': 'Gesundheit und Medizin',
        'description': 'Lernen Sie Gesundheits- und medizinische Begriffe auf Amharisch',
        'category': 'Gesundheit',
        'vocabulary': ['ህመም', 'ዶክተር', 'ሆስፒታል', 'መድሃኒት', 'ጤና', 'ህመም', 'መፈወስ', 'መፈወስ'],
        'exerciseGenerator': _generateHealthExercises,
      },
      {
        'title': 'Arbeit und Berufe',
        'description': 'Lernen Sie Arbeits- und Berufsvokabular auf Amharisch',
        'category': 'Arbeit',
        'vocabulary': ['ስራ', 'ሰራተኛ', 'አስተዳዳሪ', 'መምህር', 'መምህር', 'መምህር', 'መምህር', 'መምህር'],
        'exerciseGenerator': _generateWorkExercises,
      },
      {
        'title': 'Bildung und Schule',
        'description': 'Lernen Sie bildungsbezogenes Vokabular auf Amharisch',
        'category': 'Bildung',
        'vocabulary': ['ትምህርት', 'ትምህርት ቤት', 'መጽሐፍ', 'መጽሐፍ', 'መጽሐፍ', 'መጽሐፍ', 'መጽሐፍ', 'መጽሐፍ'],
        'exerciseGenerator': _generateEducationExercises,
      },
    ];

    List<lesson_model.Lesson> lessons = [];
    
    for (int i = 0; i < 50; i++) {
      final template = intermediateTemplates[i % intermediateTemplates.length];
      final lessonNumber = i + 1;
      
      lessons.add(lesson_model.Lesson(
        id: 'de_intermediate_$lessonNumber',
        title: '${template['title']} ($lessonNumber)',
        description: template['description'],
        level: lesson_model.LanguageLevel.intermediate,
        languageCode: 'de',
        estimatedMinutes: 10,
        xpReward: 150,
        category: template['category'],
        exercises: (template['exerciseGenerator'] as Function)(),
        vocabulary: List<String>.from(template['vocabulary']),
      ));
    }
    
    return lessons;
  }

  List<lesson_model.Lesson> _generateGermanAdvancedLessons() {
    // Generate 30 advanced lessons efficiently in German
    final List<Map<String, dynamic>> advancedTemplates = [
      {
        'title': 'Geschäft und Wirtschaft',
        'description': 'Lernen Sie Geschäfts- und Wirtschaftsbegriffe auf Amharisch',
        'category': 'Geschäft',
        'vocabulary': ['ንግድ', 'ኢኮኖሚ', 'ገንዘብ', 'ገንዘብ', 'ገንዘብ', 'ገንዘብ', 'ገንዘብ', 'ገንዘብ'],
        'exerciseGenerator': _generateBusinessExercises,
      },
      {
        'title': 'Politik und Regierung',
        'description': 'Lernen Sie politisches und Regierungsvokabular auf Amharisch',
        'category': 'Politik',
        'vocabulary': ['ፖለቲካ', 'መንግስት', 'ፕሬዚዳንት', 'ፕሬዚዳንት', 'ፕሬዚዳንት', 'ፕሬዚዳንት', 'ፕሬዚዳንት', 'ፕሬዚዳንት'],
        'exerciseGenerator': _generatePoliticsExercises,
      },
    ];

    List<lesson_model.Lesson> lessons = [];
    
    for (int i = 0; i < 30; i++) {
      final template = advancedTemplates[i % advancedTemplates.length];
      final lessonNumber = i + 1;
      
      lessons.add(lesson_model.Lesson(
        id: 'de_advanced_$lessonNumber',
        title: '${template['title']} ($lessonNumber)',
        description: template['description'],
        level: lesson_model.LanguageLevel.advanced,
        languageCode: 'de',
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
        instruction: 'Übersetzen Sie "Rot" ins Amharische',
        amharicText: 'ቀይ',
        translation: 'Rot',
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
        instruction: 'Übersetzen Sie "Wasser" ins Amharische',
        amharicText: 'ውሃ',
        translation: 'Wasser',
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
        instruction: 'Übersetzen Sie "Hand" ins Amharische',
        amharicText: 'እጅ',
        translation: 'Hand',
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
        instruction: 'Übersetzen Sie "Hund" ins Amharische',
        amharicText: 'ውሻ',
        translation: 'Hund',
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
        instruction: 'Übersetzen Sie "Hemd" ins Amharische',
        amharicText: 'ሸሚዝ',
        translation: 'Hemd',
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
        instruction: 'Übersetzen Sie "Stunde" ins Amharische',
        amharicText: 'ሰአት',
        translation: 'Stunde',
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
        instruction: 'Übersetzen Sie "Sonne" ins Amharische',
        amharicText: 'ፀሐይ',
        translation: 'Sonne',
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
        instruction: 'Übersetzen Sie "Gehen" ins Amharische',
        amharicText: 'መሄድ',
        translation: 'Gehen',
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
        instruction: 'Übersetzen Sie "Groß" ins Amharische',
        amharicText: 'ትልቅ',
        translation: 'Groß',
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
        instruction: 'Übersetzen Sie "Reisen" ins Amharische',
        amharicText: 'ጉዞ',
        translation: 'Reisen',
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
        instruction: 'Übersetzen Sie "Einkaufen" ins Amharische',
        amharicText: 'ግዛት',
        translation: 'Einkaufen',
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
        instruction: 'Übersetzen Sie "Gesundheit" ins Amharische',
        amharicText: 'ጤና',
        translation: 'Gesundheit',
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
        instruction: 'Übersetzen Sie "Arbeit" ins Amharische',
        amharicText: 'ስራ',
        translation: 'Arbeit',
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
        instruction: 'Übersetzen Sie "Bildung" ins Amharische',
        amharicText: 'ትምህርት',
        translation: 'Bildung',
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
        instruction: 'Übersetzen Sie "Geschäft" ins Amharische',
        amharicText: 'ንግድ',
        translation: 'Geschäft',
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
        instruction: 'Übersetzen Sie "Politik" ins Amharische',
        amharicText: 'ፖለቲካ',
        translation: 'Politik',
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
        instruction: 'Wählen Sie das richtige Bild für "Hallo"',
        amharicText: 'ሰላም',
        translation: 'Hallo',
        imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&h=300&fit=crop',
        options: [
          lesson_model.ExerciseOption(
            text: 'Hallo',
            imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&h=300&fit=crop',
            isCorrect: true,
          ),
          lesson_model.ExerciseOption(
            text: 'Auf Wiedersehen',
            imageUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=300&h=300&fit=crop',
            isCorrect: false,
          ),
          lesson_model.ExerciseOption(
            text: 'Danke',
            imageUrl: 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=300&h=300&fit=crop',
            isCorrect: false,
          ),
          lesson_model.ExerciseOption(
            text: 'Bitte',
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
        instruction: 'Übersetzen Sie "Eins" ins Amharische',
        amharicText: 'አንድ',
        translation: 'Eins',
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
        instruction: 'Wählen Sie das Bild für "Vater"',
        amharicText: 'አባት',
        translation: 'Vater',
        imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&h=300&fit=crop',
        options: [
          lesson_model.ExerciseOption(
            text: 'Vater',
            imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&h=300&fit=crop',
            isCorrect: true,
          ),
          lesson_model.ExerciseOption(
            text: 'Mutter',
            imageUrl: 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=300&h=300&fit=crop',
            isCorrect: false,
          ),
          lesson_model.ExerciseOption(
            text: 'Bruder',
            imageUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=300&h=300&fit=crop',
            isCorrect: false,
          ),
          lesson_model.ExerciseOption(
            text: 'Schwester',
            imageUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=300&h=300&fit=crop',
            isCorrect: false,
          ),
        ],
      ),
    ];
  }
}
