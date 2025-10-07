import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tourist_assistive_app/features/language/models/comprehensive_lesson_model.dart' as lesson_model;

class JapaneseAmharicLessonsScreen extends ConsumerStatefulWidget {
  const JapaneseAmharicLessonsScreen({super.key});

  @override
  ConsumerState<JapaneseAmharicLessonsScreen> createState() => _JapaneseAmharicLessonsScreenState();
}

class _JapaneseAmharicLessonsScreenState extends ConsumerState<JapaneseAmharicLessonsScreen>
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
        _lessons = _generateJapaneseLessons(_selectedLevel);
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
        '🇯🇵 日本語 → Amharic',
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
          '日本語からアムハラ語を学ぶ',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Learn Amharic from Japanese',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${_selectedLevel.name.toUpperCase()} Level • ${_lessons.length} レッスン • 400+ 分',
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
          '$completedLessons / $totalLessons レッスン完了',
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
              'レッスン',
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
              '時間',
              '${totalMinutes}分',
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
          '日本語 → アムハラ語レッスン',
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
                          '${lesson.estimatedMinutes}分',
                          Icons.access_time,
                          isUnlocked,
                        ),
                        const SizedBox(width: 12),
                        _buildLessonStat(
                          '${lesson.exercises.length}練習',
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
      '/language/amharic/lesson/${lesson.id}?native=Japanese',
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
              '設定',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            
            _buildSettingItem(
              icon: Icons.volume_up,
              title: 'オーディオ',
              subtitle: 'サウンドエフェクトのオン/オフ',
              onTap: () {},
            ),
            
            _buildSettingItem(
              icon: Icons.notifications,
              title: '通知',
              subtitle: '毎日のリマインダー',
              onTap: () {},
            ),
            
            _buildSettingItem(
              icon: Icons.help_outline,
              title: 'ヘルプとサポート',
              subtitle: 'アプリのヘルプを取得',
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

  List<lesson_model.Lesson> _generateJapaneseLessons(lesson_model.LanguageLevel level) {
    switch (level) {
      case lesson_model.LanguageLevel.beginner:
        return _generateJapaneseBeginnerLessons();
      case lesson_model.LanguageLevel.elementary:
        return _generateJapaneseBeginnerLessons(); // Use beginner lessons for elementary
      case lesson_model.LanguageLevel.intermediate:
        return _generateJapaneseIntermediateLessons();
      case lesson_model.LanguageLevel.advanced:
        return _generateJapaneseAdvancedLessons();
    }
  }

  List<lesson_model.Lesson> _generateJapaneseBeginnerLessons() {
    // Generate 100 beginner lessons efficiently in Japanese
    final List<Map<String, dynamic>> lessonTemplates = [
      {
        'title': '基本的な挨拶',
        'description': 'アムハラ語の基本的な挨拶を学びましょう',
        'category': '基本',
        'vocabulary': ['ሰላም', 'እንዴት ናችሁ', 'እንደምን አለ', 'ታዲያስ', 'እንደምን አለች', 'በጣም ደህና', 'አመሰግናለሁ', 'ይቅርታ'],
        'exerciseGenerator': _generateGreetingExercises,
      },
      {
        'title': '数字1-10',
        'description': 'アムハラ語で1から10まで数えることを学びましょう',
        'category': '数字',
        'vocabulary': ['አንድ', 'ሁለት', 'ሶስት', 'አራት', 'አምስት', 'ስድስት', 'ሰባት', 'ስምንት', 'ዘጠኝ', 'አስር'],
        'exerciseGenerator': _generateNumberExercises,
      },
      {
        'title': '家族のメンバー',
        'description': 'アムハラ語の家族メンバーの名前を学びましょう',
        'category': '家族',
        'vocabulary': ['አባት', 'እናት', 'ወንድም', 'እህት', 'ልጅ', 'ወላጅ', 'አያት', 'አያት'],
        'exerciseGenerator': _generateFamilyExercises,
      },
      {
        'title': '色',
        'description': 'アムハラ語の基本的な色を学びましょう',
        'category': '色',
        'vocabulary': ['ቀይ', 'ነጭ', 'ጥቁር', 'ቢጫ', 'አረንጓዴ', 'ሰማያዊ', 'ቀለም', 'ጥቁር'],
        'exerciseGenerator': _generateColorExercises,
      },
      {
        'title': '食べ物と飲み物',
        'description': 'アムハラ語の一般的な食べ物と飲み物の単語を学びましょう',
        'category': '食べ物',
        'vocabulary': ['ውሃ', 'እንጀራ', 'ቡና', 'በርበሬ', 'ስጋ', 'ወተት', 'ቅመም', 'ጣዕም'],
        'exerciseGenerator': _generateFoodExercises,
      },
      {
        'title': '体の部分',
        'description': 'アムハラ語の体の部分の名前を学びましょう',
        'category': '体',
        'vocabulary': ['እጅ', 'እግር', 'አይን', 'አፍ', 'አዕምሮ', 'ልብ', 'ጆሮ', 'አፍንጫ'],
        'exerciseGenerator': _generateBodyPartExercises,
      },
      {
        'title': '動物',
        'description': 'アムハラ語の動物の名前を学びましょう',
        'category': '動物',
        'vocabulary': ['ውሻ', 'ድር', 'አህያ', 'ግምጃ', 'ኮረብታ', 'አይጥ', 'አሳ', 'አውሬ'],
        'exerciseGenerator': _generateAnimalExercises,
      },
      {
        'title': '服',
        'description': 'アムハラ語の服のアイテムを学びましょう',
        'category': '服',
        'vocabulary': ['ሸሚዝ', 'ጫማ', 'ቦታ', 'ካባ', 'ሱሪ', 'አልባሳት', 'አልባሳት', 'ጨርቅ'],
        'exerciseGenerator': _generateClothingExercises,
      },
      {
        'title': '時間と日',
        'description': 'アムハラ語の時間表現と日を学びましょう',
        'category': '時間',
        'vocabulary': ['ሰአት', 'ቀን', 'ሳምንት', 'ወር', 'ዓመት', 'አሁን', 'አሁን', 'አሁን'],
        'exerciseGenerator': _generateTimeExercises,
      },
      {
        'title': '天気',
        'description': 'アムハラ語の天気に関連する単語を学びましょう',
        'category': '天気',
        'vocabulary': ['ፀሐይ', 'ዝናብ', 'ንፋስ', 'በረዶ', 'ደመና', 'ሙቀት', 'ቀዝቃዛ', 'አየር'],
        'exerciseGenerator': _generateWeatherExercises,
      },
      {
        'title': '一般的な動詞',
        'description': 'アムハラ語の基本的な動詞を学びましょう',
        'category': '動詞',
        'vocabulary': ['መሄድ', 'መምጣት', 'መብላት', 'መጠጣት', 'መተኛት', 'መነሳት', 'መስራት', 'መጫወት'],
        'exerciseGenerator': _generateVerbExercises,
      },
      {
        'title': '一般的な形容詞',
        'description': 'アムハラ語の記述的な単語を学びましょう',
        'category': '形容詞',
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
        id: 'ja_beginner_$lessonNumber',
        title: '${template['title']}${lessonNumber > 12 ? ' ($lessonNumber)' : ''}',
        description: template['description'],
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'ja',
        estimatedMinutes: 8,
        xpReward: 100,
        category: template['category'],
        exercises: (template['exerciseGenerator'] as Function)(),
        vocabulary: List<String>.from(template['vocabulary']),
      ));
    }
    
    return lessons;
  }

  List<lesson_model.Lesson> _generateJapaneseBeginnerLessonsOld() {
    return [
      lesson_model.Lesson(
        id: 'ja_beginner_1',
        title: '基本的な挨拶',
        description: 'アムハラ語の基本的な挨拶を学ぶ',
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'ja',
        estimatedMinutes: 6,
        xpReward: 100,
        category: 'Basics',
        exercises: _generateGreetingExercises(),
        vocabulary: ['ሰላም', 'እንዴት ናችሁ', 'እንደምን አለ', 'ታዲያስ', 'እንደምን አለች'],
      ),
      
      lesson_model.Lesson(
        id: 'ja_beginner_2',
        title: '数字1-10',
        description: 'アムハラ語で1から10まで数えることを学ぶ',
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'ja',
        estimatedMinutes: 6,
        xpReward: 100,
        category: 'Numbers',
        exercises: _generateNumberExercises(),
        vocabulary: ['አንድ', 'ሁለት', 'ሶስት', 'አራት', 'አምስት', 'ስድስት', 'ሰባት', 'ስምንት', 'ዘጠኝ', 'አስር'],
      ),
      
      lesson_model.Lesson(
        id: 'ja_beginner_3',
        title: '家族のメンバー',
        description: 'アムハラ語の家族メンバーの名前を学ぶ',
        level: lesson_model.LanguageLevel.beginner,
        languageCode: 'ja',
        estimatedMinutes: 6,
        xpReward: 100,
        category: 'Family',
        exercises: _generateFamilyExercises(),
        vocabulary: ['አባት', 'እናት', 'ወንድም', 'እህት', 'ልጅ', 'ወላጅ'],
      ),
    ];
  }

  List<lesson_model.Lesson> _generateJapaneseIntermediateLessons() {
    // Generate 50 intermediate lessons efficiently in Japanese
    final List<Map<String, dynamic>> intermediateTemplates = [
      {
        'title': '旅行と交通',
        'description': 'アムハラ語の旅行と交通に関する語彙を学びましょう',
        'category': '旅行',
        'vocabulary': ['መኪና', 'አውሮፕላን', 'ባቡር', 'አውቶቡስ', 'ታክሲ', 'መንገድ', 'መጠጣት', 'መጠጣት'],
        'exerciseGenerator': _generateTravelExercises,
      },
      {
        'title': '買い物とお金',
        'description': 'アムハラ語の買い物とお金の語彙を学びましょう',
        'category': '買い物',
        'vocabulary': ['ገንዘብ', 'ዋጋ', 'ገዢ', 'ሻጭ', 'ሱቅ', 'መግዛት', 'መሸጥ', 'ቅናሽ'],
        'exerciseGenerator': _generateShoppingExercises,
      },
      {
        'title': '健康と医療',
        'description': 'アムハラ語の健康と医療の用語を学びましょう',
        'category': '健康',
        'vocabulary': ['ህመም', 'ዶክተር', 'ሆስፒታል', 'መድሃኒት', 'ጤና', 'ህመም', 'መፈወስ', 'መፈወስ'],
        'exerciseGenerator': _generateHealthExercises,
      },
      {
        'title': '仕事と職業',
        'description': 'アムハラ語の仕事と職業の語彙を学びましょう',
        'category': '仕事',
        'vocabulary': ['ስራ', 'ሰራተኛ', 'አስተዳዳሪ', 'መምህር', 'መምህር', 'መምህር', 'መምህር', 'መምህር'],
        'exerciseGenerator': _generateWorkExercises,
      },
      {
        'title': '教育と学校',
        'description': 'アムハラ語の教育と学校に関する語彙を学びましょう',
        'category': '教育',
        'vocabulary': ['ትምህርት', 'ትምህርት ቤት', 'መጽሐፍ', 'መጽሐፍ', 'መጽሐፍ', 'መጽሐፍ', 'መጽሐፍ', 'መጽሐፍ'],
        'exerciseGenerator': _generateEducationExercises,
      },
    ];

    List<lesson_model.Lesson> lessons = [];
    
    for (int i = 0; i < 50; i++) {
      final template = intermediateTemplates[i % intermediateTemplates.length];
      final lessonNumber = i + 1;
      
      lessons.add(lesson_model.Lesson(
        id: 'ja_intermediate_$lessonNumber',
        title: '${template['title']} ($lessonNumber)',
        description: template['description'],
        level: lesson_model.LanguageLevel.intermediate,
        languageCode: 'ja',
        estimatedMinutes: 10,
        xpReward: 150,
        category: template['category'],
        exercises: (template['exerciseGenerator'] as Function)(),
        vocabulary: List<String>.from(template['vocabulary']),
      ));
    }
    
    return lessons;
  }

  List<lesson_model.Lesson> _generateJapaneseAdvancedLessons() {
    // Generate 30 advanced lessons efficiently in Japanese
    final List<Map<String, dynamic>> advancedTemplates = [
      {
        'title': 'ビジネスと経済',
        'description': 'アムハラ語のビジネスと経済の用語を学びましょう',
        'category': 'ビジネス',
        'vocabulary': ['ንግድ', 'ኢኮኖሚ', 'ገንዘብ', 'ገንዘብ', 'ገንዘብ', 'ገንዘብ', 'ገንዘብ', 'ገንዘብ'],
        'exerciseGenerator': _generateBusinessExercises,
      },
      {
        'title': '政治と政府',
        'description': 'アムハラ語の政治と政府の語彙を学びましょう',
        'category': '政治',
        'vocabulary': ['ፖለቲካ', 'መንግስት', 'ፕሬዚዳንት', 'ፕሬዚዳንት', 'ፕሬዚዳንት', 'ፕሬዚዳንት', 'ፕሬዚዳንት', 'ፕሬዚዳንት'],
        'exerciseGenerator': _generatePoliticsExercises,
      },
    ];

    List<lesson_model.Lesson> lessons = [];
    
    for (int i = 0; i < 30; i++) {
      final template = advancedTemplates[i % advancedTemplates.length];
      final lessonNumber = i + 1;
      
      lessons.add(lesson_model.Lesson(
        id: 'ja_advanced_$lessonNumber',
        title: '${template['title']} ($lessonNumber)',
        description: template['description'],
        level: lesson_model.LanguageLevel.advanced,
        languageCode: 'ja',
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
        instruction: '"赤"をアムハラ語に翻訳してください',
        amharicText: 'ቀይ',
        translation: '赤',
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
        instruction: '"水"をアムハラ語に翻訳してください',
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
        instruction: '"手"をアムハラ語に翻訳してください',
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
        instruction: '"犬"をアムハラ語に翻訳してください',
        amharicText: 'ውሻ',
        translation: '犬',
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
        instruction: '"シャツ"をアムハラ語に翻訳してください',
        amharicText: 'ሸሚዝ',
        translation: 'シャツ',
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
        instruction: '"時間"をアムハラ語に翻訳してください',
        amharicText: 'ሰአት',
        translation: '時間',
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
        instruction: '"太陽"をアムハラ語に翻訳してください',
        amharicText: 'ፀሐይ',
        translation: '太陽',
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
        instruction: '"行く"をアムハラ語に翻訳してください',
        amharicText: 'መሄድ',
        translation: '行く',
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
        instruction: '"大きい"をアムハラ語に翻訳してください',
        amharicText: 'ትልቅ',
        translation: '大きい',
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
        instruction: '"旅行"をアムハラ語に翻訳してください',
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
        instruction: '"買い物"をアムハラ語に翻訳してください',
        amharicText: 'ግዛት',
        translation: '買い物',
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
        instruction: '"健康"をアムハラ語に翻訳してください',
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
        instruction: '"仕事"をアムハラ語に翻訳してください',
        amharicText: 'ስራ',
        translation: '仕事',
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
        instruction: '"教育"をアムハラ語に翻訳してください',
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
        instruction: '"ビジネス"をアムハラ語に翻訳してください',
        amharicText: 'ንግድ',
        translation: 'ビジネス',
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
        instruction: '"政治"をアムハラ語に翻訳してください',
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
        instruction: '「こんにちは」の正しい画像を選択してください',
        amharicText: 'ሰላም',
        translation: 'こんにちは',
        imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&h=300&fit=crop',
        options: [
          lesson_model.ExerciseOption(
            text: 'こんにちは',
            imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&h=300&fit=crop',
            isCorrect: true,
          ),
          lesson_model.ExerciseOption(
            text: 'さようなら',
            imageUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=300&h=300&fit=crop',
            isCorrect: false,
          ),
          lesson_model.ExerciseOption(
            text: 'ありがとう',
            imageUrl: 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=300&h=300&fit=crop',
            isCorrect: false,
          ),
          lesson_model.ExerciseOption(
            text: 'お願いします',
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
        instruction: '「一」をアムハラ語に翻訳してください',
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
        instruction: '「父」の画像を選択してください',
        amharicText: 'አባት',
        translation: '父',
        imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&h=300&fit=crop',
        options: [
          lesson_model.ExerciseOption(
            text: '父',
            imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&h=300&fit=crop',
            isCorrect: true,
          ),
          lesson_model.ExerciseOption(
            text: '母',
            imageUrl: 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=300&h=300&fit=crop',
            isCorrect: false,
          ),
          lesson_model.ExerciseOption(
            text: '兄/弟',
            imageUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=300&h=300&fit=crop',
            isCorrect: false,
          ),
          lesson_model.ExerciseOption(
            text: '姉/妹',
            imageUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=300&h=300&fit=crop',
            isCorrect: false,
          ),
        ],
      ),
    ];
  }
}
