import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:tourist_assistive_app/features/language/models/comprehensive_lesson_model.dart' as lesson_model;
import 'package:tourist_assistive_app/features/language/screens/enhanced_amharic_lesson_screen.dart';
import 'package:tourist_assistive_app/features/language/services/language_image_service.dart';

class FrenchAmharicLessonsScreen extends ConsumerStatefulWidget {
  const FrenchAmharicLessonsScreen({super.key});

  @override
  ConsumerState<FrenchAmharicLessonsScreen> createState() => _FrenchAmharicLessonsScreenState();
}

class _FrenchAmharicLessonsScreenState extends ConsumerState<FrenchAmharicLessonsScreen>
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
        _lessons = _generateFrenchLessons(_selectedLevel);
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
        '🇫🇷 Français → Amharic',
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
          'Apprendre l\'Amharique depuis le Français',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Learn Amharic from French',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${_selectedLevel.name.toUpperCase()} Level • ${_lessons.length} Leçons • 400+ Minutes',
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
          '$completedLessons sur $totalLessons leçons terminées',
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
              'Leçons',
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
              'Temps',
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
          'Leçons Français → Amharique',
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
                          '${lesson.exercises.length} exercices',
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
      '/language/amharic/lesson/${lesson.id}?native=French',
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
              'Paramètres',
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
              subtitle: 'Activer/désactiver les effets sonores',
              onTap: () {},
            ),
            
            _buildSettingItem(
              icon: Icons.notifications,
              title: 'Notifications',
              subtitle: 'Rappels quotidiens',
              onTap: () {},
            ),
            
            _buildSettingItem(
              icon: Icons.help_outline,
              title: 'Aide et Support',
              subtitle: 'Obtenir de l\'aide avec l\'application',
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

  List<lesson_model.Lesson> _generateFrenchLessons(lesson_model.LanguageLevel level) {
    switch (level) {
      case lesson_model.LanguageLevel.beginner:
        return _generateFrenchBeginnerLessons();
      case lesson_model.LanguageLevel.elementary:
        return _generateFrenchBeginnerLessons(); // Use beginner lessons for elementary
      case lesson_model.LanguageLevel.intermediate:
        return _generateFrenchIntermediateLessons();
      case lesson_model.LanguageLevel.advanced:
        return _generateFrenchAdvancedLessons();
    }
  }

  List<lesson_model.Lesson> _generateFrenchBeginnerLessons() {
    // Generate 100 beginner lessons efficiently in French
    final List<Map<String, dynamic>> lessonTemplates = [
      {
        'title': 'Salutations de base',
        'description': 'Apprenez les salutations essentielles en amharique',
        'category': 'Bases',
        'vocabulary': ['ሰላም', 'እንዴት ናችሁ', 'እንደምን አለ', 'ታዲያስ', 'እንደምን አለች', 'በጣም ደህና', 'አመሰግናለሁ', 'ይቅርታ'],
        'exerciseGenerator': _generateGreetingExercises,
      },
      {
        'title': 'Nombres 1-10',
        'description': 'Apprenez à compter de 1 à 10 en amharique',
        'category': 'Nombres',
        'vocabulary': ['አንድ', 'ሁለት', 'ሶስት', 'አራት', 'አምስት', 'ስድስት', 'ሰባት', 'ስምንት', 'ዘጠኝ', 'አስር'],
        'exerciseGenerator': _generateNumberExercises,
      },
      {
        'title': 'Membres de la famille',
        'description': 'Apprenez les noms des membres de la famille en amharique',
        'category': 'Famille',
        'vocabulary': ['አባት', 'እናት', 'ወንድም', 'እህት', 'ልጅ', 'ወላጅ', 'አያት', 'አያት'],
        'exerciseGenerator': _generateFamilyExercises,
      },
      {
        'title': 'Couleurs',
        'description': 'Apprenez les couleurs de base en amharique',
        'category': 'Couleurs',
        'vocabulary': ['ቀይ', 'ነጭ', 'ጥቁር', 'ቢጫ', 'አረንጓዴ', 'ሰማያዊ', 'ቀለም', 'ጥቁር'],
        'exerciseGenerator': _generateColorExercises,
      },
      {
        'title': 'Nourriture et boissons',
        'description': 'Apprenez les mots courants de nourriture et boissons en amharique',
        'category': 'Nourriture',
        'vocabulary': ['ውሃ', 'እንጀራ', 'ቡና', 'በርበሬ', 'ስጋ', 'ወተት', 'ቅመም', 'ጣዕም'],
        'exerciseGenerator': _generateFoodExercises,
      },
      {
        'title': 'Parties du corps',
        'description': 'Apprenez les noms des parties du corps en amharique',
        'category': 'Corps',
        'vocabulary': ['እጅ', 'እግር', 'አይን', 'አፍ', 'አዕምሮ', 'ልብ', 'ጆሮ', 'አፍንጫ'],
        'exerciseGenerator': _generateBodyPartExercises,
      },
      {
        'title': 'Animaux',
        'description': 'Apprenez les noms des animaux en amharique',
        'category': 'Animaux',
        'vocabulary': ['ውሻ', 'ድር', 'አህያ', 'ግምጃ', 'ኮረብታ', 'አይጥ', 'አሳ', 'አውሬ'],
        'exerciseGenerator': _generateAnimalExercises,
      },
      {
        'title': 'Vêtements',
        'description': 'Apprenez les articles de vêtements en amharique',
        'category': 'Vêtements',
        'vocabulary': ['ሸሚዝ', 'ጫማ', 'ቦታ', 'ካባ', 'ሱሪ', 'አልባሳት', 'አልባሳት', 'ጨርቅ'],
        'exerciseGenerator': _generateClothingExercises,
      },
      {
        'title': 'Temps et jours',
        'description': 'Apprenez les expressions temporelles et les jours en amharique',
        'category': 'Temps',
        'vocabulary': ['ሰአት', 'ቀን', 'ሳምንት', 'ወር', 'ዓመት', 'አሁን', 'አሁን', 'አሁን'],
        'exerciseGenerator': _generateTimeExercises,
      },
      {
        'title': 'Météo',
        'description': 'Apprenez les mots liés à la météo en amharique',
        'category': 'Météo',
        'vocabulary': ['ፀሐይ', 'ዝናብ', 'ንፋስ', 'በረዶ', 'ደመና', 'ሙቀት', 'ቀዝቃዛ', 'አየር'],
        'exerciseGenerator': _generateWeatherExercises,
      },
      {
        'title': 'Verbes courants',
        'description': 'Apprenez les verbes essentiels en amharique',
        'category': 'Verbes',
        'vocabulary': ['መሄድ', 'መምጣት', 'መብላት', 'መጠጣት', 'መተኛት', 'መነሳት', 'መስራት', 'መጫወት'],
        'exerciseGenerator': _generateVerbExercises,
      },
      {
        'title': 'Adjectifs courants',
        'description': 'Apprenez les mots descriptifs en amharique',
        'category': 'Adjectifs',
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
        id: 'fr_beginner_$lessonNumber',
        title: '${template['title']}${lessonNumber > 12 ? ' ($lessonNumber)' : ''}',
        description: template['description'],
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'fr',
        estimatedMinutes: 8,
        xpReward: 100,
        category: template['category'],
        exercises: (template['exerciseGenerator'] as Function)(),
        vocabulary: List<String>.from(template['vocabulary']),
      ));
    }
    
    return lessons;
  }

  List<lesson_model.Lesson> _generateFrenchBeginnerLessonsOld() {
    return [
      lesson_model.Lesson(
        id: 'fr_beginner_1',
        title: 'Salutations de base',
        description: 'Apprendre les salutations essentielles en amharique',
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'fr',
        estimatedMinutes: 6,
        xpReward: 100,
        category: 'Basics',
        exercises: _generateGreetingExercises(),
        vocabulary: ['ሰላም', 'እንዴት ናችሁ', 'እንደምን አለ', 'ታዲያስ', 'እንደምን አለች'],
      ),
      
      lesson_model.Lesson(
        id: 'fr_beginner_2',
        title: 'Nombres 1-10',
        description: 'Apprendre à compter de 1 à 10 en amharique',
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'fr',
        estimatedMinutes: 6,
        xpReward: 100,
        category: 'Numbers',
        exercises: _generateNumberExercises(),
        vocabulary: ['አንድ', 'ሁለት', 'ሶስት', 'አራት', 'አምስት', 'ስድስት', 'ሰባት', 'ስምንት', 'ዘጠኝ', 'አስር'],
      ),
      
      lesson_model.Lesson(
        id: 'fr_beginner_3',
        title: 'Membres de la famille',
        description: 'Apprendre les noms des membres de la famille en amharique',
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'fr',
        estimatedMinutes: 8,
        xpReward: 100,
        category: 'Family',
        exercises: _generateFamilyExercises(),
        vocabulary: ['አባት', 'እናት', 'ወንድም', 'እህት', 'ልጅ', 'ወላጅ', 'አያት', 'አያት'],
      ),
      
      // Lesson 4: Colors
      lesson_model.Lesson(
        id: 'fr_beginner_4',
        title: 'Couleurs',
        description: 'Apprendre les couleurs de base en amharique',
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'fr',
        estimatedMinutes: 8,
        xpReward: 100,
        category: 'Colors',
        exercises: _generateColorExercises(),
        vocabulary: ['ቀይ', 'ነጭ', 'ጥቁር', 'ቢጫ', 'አረንጓዴ', 'ሰማያዊ', 'ቀለም', 'ጥቁር'],
      ),
      
      // Lesson 5: Food and Drinks
      lesson_model.Lesson(
        id: 'fr_beginner_5',
        title: 'Nourriture et boissons',
        description: 'Apprendre les mots courants de nourriture et boissons en amharique',
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'fr',
        estimatedMinutes: 8,
        xpReward: 100,
        category: 'Food',
        exercises: _generateFoodExercises(),
        vocabulary: ['ውሃ', 'እንጀራ', 'ቡና', 'በርበሬ', 'ስጋ', 'ወተት', 'ቅመም', 'ጣዕም'],
      ),
      
      // Lesson 6: Body Parts
      lesson_model.Lesson(
        id: 'fr_beginner_6',
        title: 'Parties du corps',
        description: 'Apprendre les noms des parties du corps en amharique',
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'fr',
        estimatedMinutes: 8,
        xpReward: 100,
        category: 'Body',
        exercises: _generateBodyPartExercises(),
        vocabulary: ['እጅ', 'እግር', 'አይን', 'አፍ', 'አዕምሮ', 'ልብ', 'ጆሮ', 'አፍንጫ'],
      ),
      
      // Lesson 7: Animals
      lesson_model.Lesson(
        id: 'fr_beginner_7',
        title: 'Animaux',
        description: 'Apprendre les noms des animaux en amharique',
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'fr',
        estimatedMinutes: 8,
        xpReward: 100,
        category: 'Animals',
        exercises: _generateAnimalExercises(),
        vocabulary: ['ውሻ', 'ድር', 'አህያ', 'ግምጃ', 'ኮረብታ', 'አይጥ', 'አሳ', 'አውሬ'],
      ),
      
      // Lesson 8: Clothing
      lesson_model.Lesson(
        id: 'fr_beginner_8',
        title: 'Vêtements',
        description: 'Apprendre les mots de vêtements en amharique',
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'fr',
        estimatedMinutes: 8,
        xpReward: 100,
        category: 'Clothing',
        exercises: _generateClothingExercises(),
        vocabulary: ['ሸሚዝ', 'ጫማ', 'ቦታ', 'ካባ', 'ሱሪ', 'አልባሳት', 'አልባሳት', 'ጨርቅ'],
      ),
      
      // Lesson 9: Time and Days
      lesson_model.Lesson(
        id: 'fr_beginner_9',
        title: 'Temps et jours',
        description: 'Apprendre les expressions de temps et jours en amharique',
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'fr',
        estimatedMinutes: 8,
        xpReward: 100,
        category: 'Time',
        exercises: _generateTimeExercises(),
        vocabulary: ['ሰአት', 'ቀን', 'ሳምንት', 'ወር', 'ዓመት', 'አሁን', 'አሁን', 'አሁን'],
      ),
      
      // Lesson 10: Weather
      lesson_model.Lesson(
        id: 'fr_beginner_10',
        title: 'Météo',
        description: 'Apprendre les mots liés à la météo en amharique',
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'fr',
        estimatedMinutes: 8,
        xpReward: 100,
        category: 'Weather',
        exercises: _generateWeatherExercises(),
        vocabulary: ['ፀሐይ', 'ዝናብ', 'ንፋስ', 'በረዶ', 'ደመና', 'ሙቀት', 'ቀዝቃዛ', 'አየር'],
      ),
      
      // Lesson 11: Common Verbs
      lesson_model.Lesson(
        id: 'fr_beginner_11',
        title: 'Verbes courants',
        description: 'Apprendre les verbes essentiels en amharique',
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'fr',
        estimatedMinutes: 8,
        xpReward: 100,
        category: 'Verbs',
        exercises: _generateVerbExercises(),
        vocabulary: ['መሄድ', 'መምጣት', 'መብላት', 'መጠጣት', 'መተኛት', 'መነሳት', 'መስራት', 'መጫወት'],
      ),
      
      // Lesson 12: Common Adjectives
      lesson_model.Lesson(
        id: 'fr_beginner_12',
        title: 'Adjectifs courants',
        description: 'Apprendre les mots descriptifs en amharique',
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'fr',
        estimatedMinutes: 8,
        xpReward: 100,
        category: 'Adjectives',
        exercises: _generateAdjectiveExercises(),
        vocabulary: ['ትልቅ', 'ትንሽ', 'መልካም', 'መጥፎ', 'ፈጣን', 'ዝግተኛ', 'ቀላል', 'አስቸጋሪ'],
      ),
    ];
  }

  List<lesson_model.Lesson> _generateFrenchIntermediateLessons() {
    return [
      // Lesson 1: Travel and Transportation
      lesson_model.Lesson(
        id: 'fr_intermediate_1',
        title: 'Voyage et transport',
        description: 'Apprendre le vocabulaire lié aux voyages en amharique',
        level: lesson_model.LanguageLevel.intermediate,
        languageCode: 'fr',
        estimatedMinutes: 10,
        xpReward: 150,
        category: 'Travel',
        exercises: _generateTravelExercises(),
        vocabulary: ['መኪና', 'አውሮፕላን', 'ባቡር', 'አውቶቡስ', 'ታክሲ', 'መንገድ', 'መጠጣት', 'መጠጣት'],
      ),
      
      // Lesson 2: Shopping and Money
      lesson_model.Lesson(
        id: 'fr_intermediate_2',
        title: 'Shopping et argent',
        description: 'Apprendre le vocabulaire de shopping et d\'argent en amharique',
        level: lesson_model.LanguageLevel.intermediate,
        languageCode: 'fr',
        estimatedMinutes: 10,
        xpReward: 150,
        category: 'Shopping',
        exercises: _generateShoppingExercises(),
        vocabulary: ['ገንዘብ', 'ዋጋ', 'ገዢ', 'ሻጭ', 'ሱቅ', 'መግዛት', 'መሸጥ', 'ቅናሽ'],
      ),
      
      // Lesson 3: Health and Medical
      lesson_model.Lesson(
        id: 'fr_intermediate_3',
        title: 'Santé et médical',
        description: 'Apprendre les termes de santé et médicaux en amharique',
        level: lesson_model.LanguageLevel.intermediate,
        languageCode: 'fr',
        estimatedMinutes: 10,
        xpReward: 150,
        category: 'Health',
        exercises: _generateHealthExercises(),
        vocabulary: ['ህመም', 'ዶክተር', 'ሆስፒታል', 'መድሃኒት', 'ጤና', 'ህመም', 'መፈወስ', 'መፈወስ'],
      ),
      
      // Lesson 4: Work and Professions
      lesson_model.Lesson(
        id: 'fr_intermediate_4',
        title: 'Travail et professions',
        description: 'Apprendre le vocabulaire de travail et professions en amharique',
        level: lesson_model.LanguageLevel.intermediate,
        languageCode: 'fr',
        estimatedMinutes: 10,
        xpReward: 150,
        category: 'Work',
        exercises: _generateWorkExercises(),
        vocabulary: ['ስራ', 'ሰራተኛ', 'አስተዳዳሪ', 'መምህር', 'መምህር', 'መምህር', 'መምህር', 'መምህር'],
      ),
      
      // Lesson 5: Education and School
      lesson_model.Lesson(
        id: 'fr_intermediate_5',
        title: 'Éducation et école',
        description: 'Apprendre le vocabulaire lié à l\'éducation en amharique',
        level: lesson_model.LanguageLevel.intermediate,
        languageCode: 'fr',
        estimatedMinutes: 10,
        xpReward: 150,
        category: 'Education',
        exercises: _generateEducationExercises(),
        vocabulary: ['ትምህርት', 'ትምህርት ቤት', 'መጽሐፍ', 'መጽሐፍ', 'መጽሐፍ', 'መጽሐፍ', 'መጽሐፍ', 'መጽሐፍ'],
      ),
      
      // Generate 45 more intermediate lessons efficiently
      ...List.generate(45, (index) {
        final lessonNumber = index + 6;
        final templates = [
          {
            'title': 'Voyage et transport',
            'description': 'Apprendre le vocabulaire lié aux voyages en amharique',
            'category': 'Voyage',
            'vocabulary': ['መኪና', 'አውሮፕላን', 'ባቡር', 'አውቶቡስ', 'ታክሲ', 'መንገድ', 'መጠጣት', 'መጠጣት'],
            'exerciseGenerator': _generateTravelExercises,
          },
          {
            'title': 'Shopping et argent',
            'description': 'Apprendre le vocabulaire de shopping et d\'argent en amharique',
            'category': 'Shopping',
            'vocabulary': ['ገንዘብ', 'ዋጋ', 'ገዢ', 'ሻጭ', 'ሱቅ', 'መግዛት', 'መሸጥ', 'ቅናሽ'],
            'exerciseGenerator': _generateShoppingExercises,
          },
          {
            'title': 'Santé et médical',
            'description': 'Apprendre les termes de santé et médicaux en amharique',
            'category': 'Santé',
            'vocabulary': ['ህመም', 'ዶክተር', 'ሆስፒታል', 'መድሃኒት', 'ጤና', 'ህመም', 'መፈወስ', 'መፈወስ'],
            'exerciseGenerator': _generateHealthExercises,
          },
          {
            'title': 'Travail et professions',
            'description': 'Apprendre le vocabulaire de travail et professions en amharique',
            'category': 'Travail',
            'vocabulary': ['ስራ', 'ሰራተኛ', 'አስተዳዳሪ', 'መምህር', 'መምህር', 'መምህር', 'መምህር', 'መምህር'],
            'exerciseGenerator': _generateWorkExercises,
          },
          {
            'title': 'Éducation et école',
            'description': 'Apprendre le vocabulaire lié à l\'éducation en amharique',
            'category': 'Éducation',
            'vocabulary': ['ትምህርት', 'ትምህርት ቤት', 'መጽሐፍ', 'መጽሐፍ', 'መጽሐፍ', 'መጽሐፍ', 'መጽሐፍ', 'መጽሐፍ'],
            'exerciseGenerator': _generateEducationExercises,
          },
        ];
        
        final template = templates[index % templates.length];
        
        return lesson_model.Lesson(
          id: 'fr_intermediate_$lessonNumber',
          title: '${template['title'] as String} ($lessonNumber)',
          description: template['description'] as String,
          level: lesson_model.LanguageLevel.intermediate,
          languageCode: 'fr',
          estimatedMinutes: 10,
          xpReward: 150,
          category: template['category'] as String,
          exercises: (template['exerciseGenerator'] as Function)(),
          vocabulary: List<String>.from(template['vocabulary'] as List),
        );
      }),
    ];
  }

  List<lesson_model.Lesson> _generateFrenchAdvancedLessons() {
    return [
      // Lesson 1: Business and Economics
      lesson_model.Lesson(
        id: 'fr_advanced_1',
        title: 'Affaires et économie',
        description: 'Apprendre les termes d\'affaires et économiques en amharique',
        level: lesson_model.LanguageLevel.advanced,
        languageCode: 'fr',
        estimatedMinutes: 12,
        xpReward: 200,
        category: 'Business',
        exercises: _generateBusinessExercises(),
        vocabulary: ['ንግድ', 'ኢኮኖሚ', 'ገንዘብ', 'ገንዘብ', 'ገንዘብ', 'ገንዘብ', 'ገንዘብ', 'ገንዘብ'],
      ),
      
      // Lesson 2: Politics and Government
      lesson_model.Lesson(
        id: 'fr_advanced_2',
        title: 'Politique et gouvernement',
        description: 'Apprendre le vocabulaire politique et gouvernemental en amharique',
        level: lesson_model.LanguageLevel.advanced,
        languageCode: 'fr',
        estimatedMinutes: 12,
        xpReward: 200,
        category: 'Politics',
        exercises: _generatePoliticsExercises(),
        vocabulary: ['ፖለቲካ', 'መንግስት', 'ፕሬዚዳንት', 'ፕሬዚዳንት', 'ፕሬዚዳንት', 'ፕሬዚዳንት', 'ፕሬዚዳንት', 'ፕሬዚዳንት'],
      ),
      
      // Generate 28 more advanced lessons efficiently
      ...List.generate(28, (index) {
        final lessonNumber = index + 3;
        final templates = [
          {
            'title': 'Affaires et économie',
            'description': 'Apprendre les termes d\'affaires et économiques en amharique',
            'category': 'Affaires',
            'vocabulary': ['ንግድ', 'ኢኮኖሚ', 'ገንዘብ', 'ገንዘብ', 'ገንዘብ', 'ገንዘብ', 'ገንዘብ', 'ገንዘብ'],
            'exerciseGenerator': _generateBusinessExercises,
          },
          {
            'title': 'Politique et gouvernement',
            'description': 'Apprendre le vocabulaire politique et gouvernemental en amharique',
            'category': 'Politique',
            'vocabulary': ['ፖለቲካ', 'መንግስት', 'ፕሬዚዳንት', 'ፕሬዚዳንት', 'ፕሬዚዳንት', 'ፕሬዚዳንት', 'ፕሬዚዳንት', 'ፕሬዚዳንት'],
            'exerciseGenerator': _generatePoliticsExercises,
          },
        ];
        
        final template = templates[index % templates.length];
        
        return lesson_model.Lesson(
          id: 'fr_advanced_$lessonNumber',
          title: '${template['title'] as String} ($lessonNumber)',
          description: template['description'] as String,
          level: lesson_model.LanguageLevel.advanced,
          languageCode: 'fr',
          estimatedMinutes: 12,
          xpReward: 200,
          category: template['category'] as String,
          exercises: (template['exerciseGenerator'] as Function)(),
          vocabulary: List<String>.from(template['vocabulary'] as List),
        );
      }),
    ];
  }

  // Missing exercise generators
  List<lesson_model.Exercise> _generateColorExercises() {
    return [
      lesson_model.Exercise(
        id: 'color_1',
        type: lesson_model.ExerciseType.selectImage,
        instruction: 'Sélectionnez l\'image correcte pour "Rouge"',
        amharicText: 'ቀይ',
        translation: 'Rouge',
        imageUrl: LanguageImageService.getImageUrl('colors', 'red'),
        options: [
          lesson_model.ExerciseOption(
            text: 'Rouge',
            imageUrl: LanguageImageService.getImageUrl('colors', 'red'),
            isCorrect: true,
          ),
          lesson_model.ExerciseOption(
            text: 'Blanc',
            imageUrl: LanguageImageService.getImageUrl('colors', 'white'),
            isCorrect: false,
          ),
          lesson_model.ExerciseOption(
            text: 'Noir',
            imageUrl: LanguageImageService.getImageUrl('colors', 'black'),
            isCorrect: false,
          ),
        ],
      ),
    ];
  }

  List<lesson_model.Exercise> _generateFoodExercises() {
    return [
      lesson_model.Exercise(
        id: 'food_1',
        type: lesson_model.ExerciseType.translate,
        instruction: 'Traduisez "Eau" en amharique',
        amharicText: 'ውሃ',
        translation: 'Eau',
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
        instruction: 'Traduisez "Main" en amharique',
        amharicText: 'እጅ',
        translation: 'Main',
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
        instruction: 'Traduisez "Chien" en amharique',
        amharicText: 'ውሻ',
        translation: 'Chien',
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
        instruction: 'Traduisez "Chemise" en amharique',
        amharicText: 'ሸሚዝ',
        translation: 'Chemise',
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
        instruction: 'Traduisez "Heure" en amharique',
        amharicText: 'ሰአት',
        translation: 'Heure',
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
        instruction: 'Traduisez "Soleil" en amharique',
        amharicText: 'ፀሐይ',
        translation: 'Soleil',
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
        instruction: 'Traduisez "Aller" en amharique',
        amharicText: 'መሄድ',
        translation: 'Aller',
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
        instruction: 'Traduisez "Grand" en amharique',
        amharicText: 'ትልቅ',
        translation: 'Grand',
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
        instruction: 'Traduisez "Voyage" en amharique',
        amharicText: 'ጉዞ',
        translation: 'Voyage',
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
        instruction: 'Traduisez "Achat" en amharique',
        amharicText: 'ግዛት',
        translation: 'Achat',
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
        instruction: 'Traduisez "Santé" en amharique',
        amharicText: 'ጤና',
        translation: 'Santé',
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
        instruction: 'Traduisez "Travail" en amharique',
        amharicText: 'ስራ',
        translation: 'Travail',
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
        instruction: 'Traduisez "Éducation" en amharique',
        amharicText: 'ትምህርት',
        translation: 'Éducation',
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
        instruction: 'Traduisez "Business" en amharique',
        amharicText: 'ንግድ',
        translation: 'Business',
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
        instruction: 'Traduisez "Politique" en amharique',
        amharicText: 'ፖለቲካ',
        translation: 'Politique',
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
        instruction: 'Sélectionnez l\'image correcte pour "Bonjour"',
        amharicText: 'ሰላም',
        translation: 'Bonjour',
        imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&h=300&fit=crop',
        options: [
          lesson_model.ExerciseOption(
            text: 'Bonjour',
            imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&h=300&fit=crop',
            isCorrect: true,
          ),
          lesson_model.ExerciseOption(
            text: 'Au revoir',
            imageUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=300&h=300&fit=crop',
            isCorrect: false,
          ),
          lesson_model.ExerciseOption(
            text: 'Merci',
            imageUrl: 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=300&h=300&fit=crop',
            isCorrect: false,
          ),
          lesson_model.ExerciseOption(
            text: 'S\'il vous plaît',
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
        instruction: 'Traduisez "Un" en amharique',
        amharicText: 'አንድ',
        translation: 'Un',
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
        instruction: 'Sélectionnez l\'image pour "Père"',
        amharicText: 'አባት',
        translation: 'Père',
        imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&h=300&fit=crop',
        options: [
          lesson_model.ExerciseOption(
            text: 'Père',
            imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&h=300&fit=crop',
            isCorrect: true,
          ),
          lesson_model.ExerciseOption(
            text: 'Mère',
            imageUrl: 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=300&h=300&fit=crop',
            isCorrect: false,
          ),
          lesson_model.ExerciseOption(
            text: 'Frère',
            imageUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=300&h=300&fit=crop',
            isCorrect: false,
          ),
          lesson_model.ExerciseOption(
            text: 'Sœur',
            imageUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=300&h=300&fit=crop',
            isCorrect: false,
          ),
        ],
      ),
    ];
  }
}
