import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tourist_assistive_app/features/language/models/comprehensive_lesson_model.dart' as lesson_model;

class MandarinAmharicLessonsScreen extends ConsumerStatefulWidget {
  const MandarinAmharicLessonsScreen({super.key});

  @override
  ConsumerState<MandarinAmharicLessonsScreen> createState() => _MandarinAmharicLessonsScreenState();
}

class _MandarinAmharicLessonsScreenState extends ConsumerState<MandarinAmharicLessonsScreen>
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
        _lessons = _generateMandarinLessons(_selectedLevel);
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
                      const SizedBox(height: 100), // Space for bottom navigation
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
        '🇨🇳 中文 → Amharic',
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
          '从中文学习阿姆哈拉语',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Learn Amharic from Mandarin Chinese',
          style: TextStyle(
            color: Colors.white.withValues(alpha:0.7),
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${_selectedLevel.name.toUpperCase()} Level • ${_lessons.length} Lessons • 400+ Minutes',
          style: TextStyle(
            color: Colors.white.withValues(alpha:0.7),
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 16),
        // Progress bar
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
          '$completedLessons of $totalLessons lessons completed',
          style: TextStyle(
            color: Colors.white.withValues(alpha:0.7),
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
          color: const Color(0xFFCE82FF).withValues(alpha:0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(
              '课程',
              '$completedLessons/${_lessons.length}',
              Icons.school,
              const Color(0xFFCE82FF),
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: Colors.white.withValues(alpha:0.2),
          ),
          Expanded(
            child: _buildStatItem(
              '经验',
              '$earnedXP/$totalXP',
              Icons.star,
              const Color(0xFFFFD700),
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: Colors.white.withValues(alpha:0.2),
          ),
          Expanded(
            child: _buildStatItem(
              '时间',
              '${totalMinutes}分钟',
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
          '中文 → 阿姆哈拉语课程',
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
    } else if (isUnlocked) {
      backgroundColor = const Color(0xFFCE82FF).withValues(alpha:0.1);
      borderColor = const Color(0xFFCE82FF).withValues(alpha:0.3);
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
                color: borderColor.withValues(alpha:0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // Lesson icon
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
              
              // Lesson info
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
                          '${lesson.estimatedMinutes}分钟',
                          Icons.access_time,
                          isUnlocked,
                        ),
                        const SizedBox(width: 12),
                        _buildLessonStat(
                          '${lesson.exercises.length}练习',
                          Icons.quiz,
                          isUnlocked,
                        ),
                        const SizedBox(width: 12),
                        _buildLessonStat(
                          '${lesson.xpReward}经验',
                          Icons.star,
                          isUnlocked,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Progress indicator
              if (isUnlocked && !isCompleted)
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFCE82FF).withValues(alpha:0.2),
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
    // Navigate to the enhanced lesson screen
    context.push(
      '/language/amharic/lesson/${lesson.id}?native=Mandarin',
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
              '设置',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            
            _buildSettingItem(
              icon: Icons.volume_up,
              title: '音频',
              subtitle: '启用/禁用音效',
              onTap: () {},
            ),
            
            _buildSettingItem(
              icon: Icons.notifications,
              title: '通知',
              subtitle: '每日提醒',
              onTap: () {},
            ),
            
            _buildSettingItem(
              icon: Icons.help_outline,
              title: '帮助与支持',
              subtitle: '获取应用帮助',
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

  // Generate comprehensive Mandarin lessons
  List<lesson_model.Lesson> _generateMandarinLessons(lesson_model.LanguageLevel level) {
    switch (level) {
      case lesson_model.LanguageLevel.beginner:
        return _generateMandarinBeginnerLessons();
      case lesson_model.LanguageLevel.elementary:
        return _generateMandarinBeginnerLessons(); // Use beginner lessons for elementary
      case lesson_model.LanguageLevel.intermediate:
        return _generateMandarinIntermediateLessons();
      case lesson_model.LanguageLevel.advanced:
        return _generateMandarinAdvancedLessons();
    }
  }

  List<lesson_model.Lesson> _generateMandarinBeginnerLessons() {
    // Generate 100 beginner lessons efficiently in Chinese
    final List<Map<String, dynamic>> lessonTemplates = [
      {
        'title': '基本问候',
        'description': '学习阿姆哈拉语的基本问候语',
        'category': '基础',
        'vocabulary': ['ሰላም', 'እንዴት ናችሁ', 'እንደምን አለ', 'ታዲያስ', 'እንደምን አለች', 'በጣም ደህና', 'አመሰግናለሁ', 'ይቅርታ'],
        'exerciseGenerator': _generateGreetingExercises,
      },
      {
        'title': '数字1-10',
        'description': '学习用阿姆哈拉语数1到10',
        'category': '数字',
        'vocabulary': ['አንድ', 'ሁለት', 'ሶስት', 'አራት', 'አምስት', 'ስድስት', 'ሰባት', 'ስምንት', 'ዘጠኝ', 'አስር'],
        'exerciseGenerator': _generateNumberExercises,
      },
      {
        'title': '家庭成员',
        'description': '学习阿姆哈拉语的家庭成员名称',
        'category': '家庭',
        'vocabulary': ['አባት', 'እናት', 'ወንድም', 'እህት', 'ልጅ', 'ወላጅ', 'አያት', 'አያት'],
        'exerciseGenerator': _generateFamilyExercises,
      },
      {
        'title': '颜色',
        'description': '学习阿姆哈拉语的基本颜色',
        'category': '颜色',
        'vocabulary': ['ቀይ', 'ነጭ', 'ጥቁር', 'ቢጫ', 'አረንጓዴ', 'ሰማያዊ', 'ቀለም', 'ጥቁር'],
        'exerciseGenerator': _generateColorExercises,
      },
      {
        'title': '食物和饮料',
        'description': '学习阿姆哈拉语中常见的食物和饮料词汇',
        'category': '食物',
        'vocabulary': ['ውሃ', 'እንጀራ', 'ቡና', 'በርበሬ', 'ስጋ', 'ወተት', 'ቅመም', 'ጣዕም'],
        'exerciseGenerator': _generateFoodExercises,
      },
      {
        'title': '身体部位',
        'description': '学习阿姆哈拉语中身体部位的名称',
        'category': '身体',
        'vocabulary': ['እጅ', 'እግር', 'አይን', 'አፍ', 'አዕምሮ', 'ልብ', 'ጆሮ', 'አፍንጫ'],
        'exerciseGenerator': _generateBodyPartExercises,
      },
      {
        'title': '动物',
        'description': '学习阿姆哈拉语中动物的名称',
        'category': '动物',
        'vocabulary': ['ውሻ', 'ድር', 'አህያ', 'ግምጃ', 'ኮረብታ', 'አይጥ', 'አሳ', 'አውሬ'],
        'exerciseGenerator': _generateAnimalExercises,
      },
      {
        'title': '服装',
        'description': '学习阿姆哈拉语中服装物品的词汇',
        'category': '服装',
        'vocabulary': ['ሸሚዝ', 'ጫማ', 'ቦታ', 'ካባ', 'ሱሪ', 'አልባሳት', 'አልባሳት', 'ጨርቅ'],
        'exerciseGenerator': _generateClothingExercises,
      },
      {
        'title': '时间和日期',
        'description': '学习阿姆哈拉语中时间表达和日期的词汇',
        'category': '时间',
        'vocabulary': ['ሰአት', 'ቀን', 'ሳምንት', 'ወር', 'ዓመት', 'አሁን', 'አሁን', 'አሁን'],
        'exerciseGenerator': _generateTimeExercises,
      },
      {
        'title': '天气',
        'description': '学习阿姆哈拉语中天气相关的词汇',
        'category': '天气',
        'vocabulary': ['ፀሐይ', 'ዝናብ', 'ንፋስ', 'በረዶ', 'ደመና', 'ሙቀት', 'ቀዝቃዛ', 'አየር'],
        'exerciseGenerator': _generateWeatherExercises,
      },
      {
        'title': '常用动词',
        'description': '学习阿姆哈拉语中的基本动词',
        'category': '动词',
        'vocabulary': ['መሄድ', 'መምጣት', 'መብላት', 'መጠጣት', 'መተኛት', 'መነሳት', 'መስራት', 'መጫወት'],
        'exerciseGenerator': _generateVerbExercises,
      },
      {
        'title': '常用形容词',
        'description': '学习阿姆哈拉语中的描述性词汇',
        'category': '形容词',
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
        id: 'zh_beginner_$lessonNumber',
        title: '${template['title']}${lessonNumber > 12 ? ' ($lessonNumber)' : ''}',
        description: template['description'],
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'zh',
        estimatedMinutes: 8,
        xpReward: 100,
        category: template['category'],
        exercises: (template['exerciseGenerator'] as Function)(),
        vocabulary: List<String>.from(template['vocabulary']),
      ));
    }
    
    return lessons;
  }

  List<lesson_model.Lesson> _generateMandarinBeginnerLessonsOld() {
    return [
      // Lesson 1: Basic Greetings
      lesson_model.Lesson(
        id: 'zh_beginner_1',
        title: '基本问候',
        description: '学习阿姆哈拉语的基本问候语',
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'zh',
        estimatedMinutes: 8,
        xpReward: 100,
        category: 'Basics',
        exercises: _generateGreetingExercises(),
        vocabulary: ['ሰላም', 'እንዴት ናችሁ', 'እንደምን አለ', 'ታዲያስ', 'እንደምን አለች', 'በጣም ደህና', 'አመሰግናለሁ', 'ይቅርታ'],
      ),
      
      // Lesson 2: Numbers 1-10
      lesson_model.Lesson(
        id: 'zh_beginner_2',
        title: '数字1-10',
        description: '学习用阿姆哈拉语数1到10',
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'zh',
        estimatedMinutes: 8,
        xpReward: 100,
        category: 'Numbers',
        exercises: _generateNumberExercises(),
        vocabulary: ['አንድ', 'ሁለት', 'ሶስት', 'አራት', 'አምስት', 'ስድስት', 'ሰባት', 'ስምንት', 'ዘጠኝ', 'አስር'],
      ),
      
      // Lesson 3: Family Members
      lesson_model.Lesson(
        id: 'zh_beginner_3',
        title: '家庭成员',
        description: '学习阿姆哈拉语的家庭成员名称',
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'zh',
        estimatedMinutes: 8,
        xpReward: 100,
        category: 'Family',
        exercises: _generateFamilyExercises(),
        vocabulary: ['አባት', 'እናት', 'ወንድም', 'እህት', 'ልጅ', 'ወላጅ', 'አያት', 'አያት'],
      ),
      
      // Lesson 4: Colors
      lesson_model.Lesson(
        id: 'zh_beginner_4',
        title: '颜色',
        description: '学习阿姆哈拉语的基本颜色',
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'zh',
        estimatedMinutes: 8,
        xpReward: 100,
        category: 'Colors',
        exercises: _generateColorExercises(),
        vocabulary: ['ቀይ', 'ነጭ', 'ጥቁር', 'ቢጫ', 'አረንጓዴ', 'ሰማያዊ', 'ቀለም', 'ጥቁር'],
      ),
      
      // Lesson 5: Food and Drinks
      lesson_model.Lesson(
        id: 'zh_beginner_5',
        title: '食物和饮料',
        description: '学习阿姆哈拉语中常见的食物和饮料词汇',
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'zh',
        estimatedMinutes: 8,
        xpReward: 100,
        category: 'Food',
        exercises: _generateFoodExercises(),
        vocabulary: ['ውሃ', 'እንጀራ', 'ቡና', 'በርበሬ', 'ስጋ', 'ወተት', 'ቅመም', 'ጣዕም'],
      ),
      
      // Lesson 6: Body Parts
      lesson_model.Lesson(
        id: 'zh_beginner_6',
        title: '身体部位',
        description: '学习阿姆哈拉语中身体部位的名称',
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'zh',
        estimatedMinutes: 8,
        xpReward: 100,
        category: 'Body',
        exercises: _generateBodyPartExercises(),
        vocabulary: ['እጅ', 'እግር', 'አይን', 'አፍ', 'አዕምሮ', 'ልብ', 'ጆሮ', 'አፍንጫ'],
      ),
      
      // Lesson 7: Animals
      lesson_model.Lesson(
        id: 'zh_beginner_7',
        title: '动物',
        description: '学习阿姆哈拉语中动物的名称',
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'zh',
        estimatedMinutes: 8,
        xpReward: 100,
        category: 'Animals',
        exercises: _generateAnimalExercises(),
        vocabulary: ['ውሻ', 'ድር', 'አህያ', 'ግምጃ', 'ኮረብታ', 'አይጥ', 'አሳ', 'አውሬ'],
      ),
      
      // Lesson 8: Clothing
      lesson_model.Lesson(
        id: 'zh_beginner_8',
        title: '服装',
        description: '学习阿姆哈拉语中服装物品的词汇',
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'zh',
        estimatedMinutes: 8,
        xpReward: 100,
        category: 'Clothing',
        exercises: _generateClothingExercises(),
        vocabulary: ['ሸሚዝ', 'ጫማ', 'ቦታ', 'ካባ', 'ሱሪ', 'አልባሳት', 'አልባሳት', 'ጨርቅ'],
      ),
      
      // Lesson 9: Time and Days
      lesson_model.Lesson(
        id: 'zh_beginner_9',
        title: '时间和日期',
        description: '学习阿姆哈拉语中时间表达和日期的词汇',
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'zh',
        estimatedMinutes: 8,
        xpReward: 100,
        category: 'Time',
        exercises: _generateTimeExercises(),
        vocabulary: ['ሰአት', 'ቀን', 'ሳምንት', 'ወር', 'ዓመት', 'አሁን', 'አሁን', 'አሁን'],
      ),
      
      // Lesson 10: Weather
      lesson_model.Lesson(
        id: 'zh_beginner_10',
        title: '天气',
        description: '学习阿姆哈拉语中天气相关的词汇',
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'zh',
        estimatedMinutes: 8,
        xpReward: 100,
        category: 'Weather',
        exercises: _generateWeatherExercises(),
        vocabulary: ['ፀሐይ', 'ዝናብ', 'ንፋስ', 'በረዶ', 'ደመና', 'ሙቀት', 'ቀዝቃዛ', 'አየር'],
      ),
      
      // Lesson 11: Common Verbs
      lesson_model.Lesson(
        id: 'zh_beginner_11',
        title: '常用动词',
        description: '学习阿姆哈拉语中的基本动词',
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'zh',
        estimatedMinutes: 8,
        xpReward: 100,
        category: 'Verbs',
        exercises: _generateVerbExercises(),
        vocabulary: ['መሄድ', 'መምጣት', 'መብላት', 'መጠጣት', 'መተኛት', 'መነሳት', 'መስራት', 'መጫወት'],
      ),
      
      // Lesson 12: Common Adjectives
      lesson_model.Lesson(
        id: 'zh_beginner_12',
        title: '常用形容词',
        description: '学习阿姆哈拉语中的描述性词汇',
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'zh',
        estimatedMinutes: 8,
        xpReward: 100,
        category: 'Adjectives',
        exercises: _generateAdjectiveExercises(),
        vocabulary: ['ትልቅ', 'ትንሽ', 'መልካም', 'መጥፎ', 'ፈጣን', 'ዝግተኛ', 'ቀላል', 'አስቸጋሪ'],
      ),
    ];
  }

  List<lesson_model.Lesson> _generateMandarinIntermediateLessons() {
    return [
      // Lesson 1: Travel and Transportation
      lesson_model.Lesson(
        id: 'zh_intermediate_1',
        title: '旅行和交通',
        description: '学习阿姆哈拉语中旅行相关的词汇',
        level: lesson_model.LanguageLevel.intermediate,
        languageCode: 'zh',
        estimatedMinutes: 10,
        xpReward: 150,
        category: 'Travel',
        exercises: _generateTravelExercises(),
        vocabulary: ['መኪና', 'አውሮፕላን', 'ባቡር', 'አውቶቡስ', 'ታክሲ', 'መንገድ', 'መጠጣት', 'መጠጣት'],
      ),
      
      // Lesson 2: Shopping and Money
      lesson_model.Lesson(
        id: 'zh_intermediate_2',
        title: '购物和金钱',
        description: '学习阿姆哈拉语中购物和金钱的词汇',
        level: lesson_model.LanguageLevel.intermediate,
        languageCode: 'zh',
        estimatedMinutes: 10,
        xpReward: 150,
        category: 'Shopping',
        exercises: _generateShoppingExercises(),
        vocabulary: ['ገንዘብ', 'ዋጋ', 'ገዢ', 'ሻጭ', 'ሱቅ', 'መግዛት', 'መሸጥ', 'ቅናሽ'],
      ),
      
      // Lesson 3: Health and Medical
      lesson_model.Lesson(
        id: 'zh_intermediate_3',
        title: '健康和医疗',
        description: '学习阿姆哈拉语中健康和医疗术语',
        level: lesson_model.LanguageLevel.intermediate,
        languageCode: 'zh',
        estimatedMinutes: 10,
        xpReward: 150,
        category: 'Health',
        exercises: _generateHealthExercises(),
        vocabulary: ['ህመም', 'ዶክተር', 'ሆስፒታል', 'መድሃኒት', 'ጤና', 'ህመም', 'መፈወስ', 'መፈወስ'],
      ),
      
      // Lesson 4: Work and Professions
      lesson_model.Lesson(
        id: 'zh_intermediate_4',
        title: '工作和职业',
        description: '学习阿姆哈拉语中工作和职业的词汇',
        level: lesson_model.LanguageLevel.intermediate,
        languageCode: 'zh',
        estimatedMinutes: 10,
        xpReward: 150,
        category: 'Work',
        exercises: _generateWorkExercises(),
        vocabulary: ['ስራ', 'ሰራተኛ', 'አስተዳዳሪ', 'መምህር', 'መምህር', 'መምህር', 'መምህር', 'መምህር'],
      ),
      
      // Lesson 5: Education and School
      lesson_model.Lesson(
        id: 'zh_intermediate_5',
        title: '教育和学校',
        description: '学习阿姆哈拉语中教育相关的词汇',
        level: lesson_model.LanguageLevel.intermediate,
        languageCode: 'zh',
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
            'title': '旅行和交通',
            'description': '学习阿姆哈拉语中旅行相关的词汇',
            'category': '旅行',
            'vocabulary': ['መኪና', 'አውሮፕላን', 'ባቡር', 'አውቶቡስ', 'ታክሲ', 'መንገድ', 'መጠጣት', 'መጠጣት'],
            'exerciseGenerator': _generateTravelExercises,
          },
          {
            'title': '购物和金钱',
            'description': '学习阿姆哈拉语中购物和金钱的词汇',
            'category': '购物',
            'vocabulary': ['ገንዘብ', 'ዋጋ', 'ገዢ', 'ሻጭ', 'ሱቅ', 'መግዛት', 'መሸጥ', 'ቅናሽ'],
            'exerciseGenerator': _generateShoppingExercises,
          },
          {
            'title': '健康和医疗',
            'description': '学习阿姆哈拉语中健康和医疗术语',
            'category': '健康',
            'vocabulary': ['ህመም', 'ዶክተር', 'ሆስፒታል', 'መድሃኒት', 'ጤና', 'ህመም', 'መፈወስ', 'መፈወስ'],
            'exerciseGenerator': _generateHealthExercises,
          },
          {
            'title': '工作和职业',
            'description': '学习阿姆哈拉语中工作和职业的词汇',
            'category': '工作',
            'vocabulary': ['ስራ', 'ሰራተኛ', 'አስተዳዳሪ', 'መምህር', 'መምህር', 'መምህር', 'መምህር', 'መምህር'],
            'exerciseGenerator': _generateWorkExercises,
          },
          {
            'title': '教育和学校',
            'description': '学习阿姆哈拉语中教育相关的词汇',
            'category': '教育',
            'vocabulary': ['ትምህርት', 'ትምህርት ቤት', 'መጽሐፍ', 'መጽሐፍ', 'መጽሐፍ', 'መጽሐፍ', 'መጽሐፍ', 'መጽሐፍ'],
            'exerciseGenerator': _generateEducationExercises,
          },
        ];
        
        final template = templates[index % templates.length];
        
        return lesson_model.Lesson(
          id: 'zh_intermediate_$lessonNumber',
          title: '${template['title'] as String} ($lessonNumber)',
          description: template['description'] as String,
          level: lesson_model.LanguageLevel.intermediate,
          languageCode: 'zh',
          estimatedMinutes: 10,
          xpReward: 150,
          category: template['category'] as String,
          exercises: (template['exerciseGenerator'] as Function)(),
          vocabulary: List<String>.from(template['vocabulary'] as List),
        );
      }),
    ];
  }

  List<lesson_model.Lesson> _generateMandarinAdvancedLessons() {
    return [
      // Lesson 1: Business and Economics
      lesson_model.Lesson(
        id: 'zh_advanced_1',
        title: '商业和经济',
        description: '学习阿姆哈拉语中商业和经济术语',
        level: lesson_model.LanguageLevel.advanced,
        languageCode: 'zh',
        estimatedMinutes: 12,
        xpReward: 200,
        category: 'Business',
        exercises: _generateBusinessExercises(),
        vocabulary: ['ንግድ', 'ኢኮኖሚ', 'ገንዘብ', 'ገንዘብ', 'ገንዘብ', 'ገንዘብ', 'ገንዘብ', 'ገንዘብ'],
      ),
      
      // Lesson 2: Politics and Government
      lesson_model.Lesson(
        id: 'zh_advanced_2',
        title: '政治和政府',
        description: '学习阿姆哈拉语中政治和政府的词汇',
        level: lesson_model.LanguageLevel.advanced,
        languageCode: 'zh',
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
            'title': '商业和经济',
            'description': '学习阿姆哈拉语中商业和经济术语',
            'category': '商业',
            'vocabulary': ['ንግድ', 'ኢኮኖሚ', 'ገንዘብ', 'ገንዘብ', 'ገንዘብ', 'ገንዘብ', 'ገንዘብ', 'ገንዘብ'],
            'exerciseGenerator': _generateBusinessExercises,
          },
          {
            'title': '政治和政府',
            'description': '学习阿姆哈拉语中政治和政府的词汇',
            'category': '政治',
            'vocabulary': ['ፖለቲካ', 'መንግስት', 'ፕሬዚዳንት', 'ፕሬዚዳንት', 'ፕሬዚዳንት', 'ፕሬዚዳንት', 'ፕሬዚዳንት', 'ፕሬዚዳንት'],
            'exerciseGenerator': _generatePoliticsExercises,
          },
        ];
        
        final template = templates[index % templates.length];
        
        return lesson_model.Lesson(
          id: 'zh_advanced_$lessonNumber',
          title: '${template['title'] as String} ($lessonNumber)',
          description: template['description'] as String,
          level: lesson_model.LanguageLevel.advanced,
          languageCode: 'zh',
          estimatedMinutes: 12,
          xpReward: 200,
          category: template['category'] as String,
          exercises: (template['exerciseGenerator'] as Function)(),
          vocabulary: List<String>.from(template['vocabulary'] as List),
        );
      }),
    ];
  }

  // Exercise generators
  // Missing exercise generators
  List<lesson_model.Exercise> _generateColorExercises() {
    return [
      lesson_model.Exercise(
        id: 'color_1',
        type: lesson_model.ExerciseType.translate,
        instruction: '将"红色"翻译成阿姆哈拉语',
        amharicText: 'ቀይ',
        translation: '红色',
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
        instruction: '将"水"翻译成阿姆哈拉语',
        amharicText: 'ውሃ',
        translation: '水',
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
        instruction: '将"手"翻译成阿姆哈拉语',
        amharicText: 'እጅ',
        translation: '手',
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
        instruction: '将"狗"翻译成阿姆哈拉语',
        amharicText: 'ውሻ',
        translation: '狗',
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
        instruction: '将"衬衫"翻译成阿姆哈拉语',
        amharicText: 'ሸሚዝ',
        translation: '衬衫',
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
        instruction: '将"小时"翻译成阿姆哈拉语',
        amharicText: 'ሰአት',
        translation: '小时',
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
        instruction: '将"太阳"翻译成阿姆哈拉语',
        amharicText: 'ፀሐይ',
        translation: '太阳',
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
        instruction: '将"去"翻译成阿姆哈拉语',
        amharicText: 'መሄድ',
        translation: '去',
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
        instruction: '将"大"翻译成阿姆哈拉语',
        amharicText: 'ትልቅ',
        translation: '大',
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
        instruction: '将"旅行"翻译成阿姆哈拉语',
        amharicText: 'ጉዞ',
        translation: '旅行',
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
        instruction: '将"购物"翻译成阿姆哈拉语',
        amharicText: 'ግዛት',
        translation: '购物',
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
        instruction: '将"健康"翻译成阿姆哈拉语',
        amharicText: 'ጤና',
        translation: '健康',
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
        instruction: '将"工作"翻译成阿姆哈拉语',
        amharicText: 'ስራ',
        translation: '工作',
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
        instruction: '将"教育"翻译成阿姆哈拉语',
        amharicText: 'ትምህርት',
        translation: '教育',
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
        instruction: '将"商业"翻译成阿姆哈拉语',
        amharicText: 'ንግድ',
        translation: '商业',
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
        instruction: '将"政治"翻译成阿姆哈拉语',
        amharicText: 'ፖለቲካ',
        translation: '政治',
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
        instruction: '选择"你好"的正确图片',
        amharicText: 'ሰላም',
        translation: '你好',
        imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&h=300&fit=crop',
        options: [
          lesson_model.ExerciseOption(
            text: '你好',
            imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&h=300&fit=crop',
            isCorrect: true,
          ),
          lesson_model.ExerciseOption(
            text: '再见',
            imageUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=300&h=300&fit=crop',
            isCorrect: false,
          ),
          lesson_model.ExerciseOption(
            text: '谢谢',
            imageUrl: 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=300&h=300&fit=crop',
            isCorrect: false,
          ),
          lesson_model.ExerciseOption(
            text: '请',
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
        instruction: '将"一"翻译成阿姆哈拉语',
        amharicText: 'አንድ',
        translation: '一',
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
        instruction: '选择"父亲"的图片',
        amharicText: 'አባት',
        translation: '父亲',
        imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&h=300&fit=crop',
        options: [
          lesson_model.ExerciseOption(
            text: '父亲',
            imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&h=300&fit=crop',
            isCorrect: true,
          ),
          lesson_model.ExerciseOption(
            text: '母亲',
            imageUrl: 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=300&h=300&fit=crop',
            isCorrect: false,
          ),
          lesson_model.ExerciseOption(
            text: '兄弟',
            imageUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=300&h=300&fit=crop',
            isCorrect: false,
          ),
          lesson_model.ExerciseOption(
            text: '姐妹',
            imageUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=300&h=300&fit=crop',
            isCorrect: false,
          ),
        ],
      ),
    ];
  }
}
