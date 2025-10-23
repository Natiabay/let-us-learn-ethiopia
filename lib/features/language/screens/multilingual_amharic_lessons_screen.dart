import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:tourist_assistive_app/features/language/models/comprehensive_lesson_model.dart' as lesson_model;
import 'package:tourist_assistive_app/features/language/data/multilingual_amharic_lessons.dart';

class MultilingualAmharicLessonsScreen extends ConsumerStatefulWidget {
  final String sourceLanguage;
  
  const MultilingualAmharicLessonsScreen({
    super.key,
    required this.sourceLanguage,
  });

  @override
  ConsumerState<MultilingualAmharicLessonsScreen> createState() => _MultilingualAmharicLessonsScreenState();
}

class _MultilingualAmharicLessonsScreenState extends ConsumerState<MultilingualAmharicLessonsScreen>
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
        _lessons = _getMultilingualLessons(widget.sourceLanguage);
        _isLoading = false;
      });
    });
  }
  
  List<lesson_model.Lesson> _getMultilingualLessons(String sourceLanguage) {
    switch (sourceLanguage.toLowerCase()) {
      case 'ar':
        return MultilingualAmharicLessons.getArabicLessons();
      case 'fr':
        return MultilingualAmharicLessons.getFrenchLessons();
      case 'es':
        return MultilingualAmharicLessons.getSpanishLessons();
      case 'de':
        return MultilingualAmharicLessons.getGermanLessons();
      case 'it':
        return MultilingualAmharicLessons.getItalianLessons();
      case 'pt':
        return MultilingualAmharicLessons.getPortugueseLessons();
      case 'ru':
        return MultilingualAmharicLessons.getRussianLessons();
      case 'zh':
        return MultilingualAmharicLessons.getChineseLessons();
      case 'ja':
        return MultilingualAmharicLessons.getJapaneseLessons();
      case 'hi':
        return MultilingualAmharicLessons.getHindiLessons();
      default:
        return MultilingualAmharicLessons.getArabicLessons(); // Default to Arabic
    }
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
                  color: Color(0xFF00D9B8),
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
      title: Text(
        '${_getLanguageName(widget.sourceLanguage)} → አማርኛ',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: null,
        ),
      ),
      centerTitle: true,
    );
  }

  String _getLanguageName(String languageCode) {
    switch (languageCode.toLowerCase()) {
      case 'ar': return 'العربية';
      case 'fr': return 'Français';
      case 'es': return 'Español';
      case 'de': return 'Deutsch';
      case 'it': return 'Italiano';
      case 'pt': return 'Português';
      case 'ru': return 'Русский';
      case 'zh': return '中文';
      case 'ja': return '日本語';
      case 'hi': return 'हिन्दी';
      default: return 'العربية';
    }
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF00D9B8), Color(0xFF1CB0F6)],
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
          Text(
            '🇪🇹 ${_getLanguageName(widget.sourceLanguage)} → አማርኛ',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontFamily: null,
            ),
          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0),
          const SizedBox(height: 8),
          Text(
            _getHeaderDescription(widget.sourceLanguage),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              height: 1.5,
              fontFamily: null,
            ),
          ).animate(delay: 200.ms).fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildStatCard('${_lessons.length}', _getLessonsText(widget.sourceLanguage), Icons.school),
              const SizedBox(width: 16),
              _buildStatCard('${_lessons.where((l) => l.isCompleted).length}', _getCompletedText(widget.sourceLanguage), Icons.check_circle),
            ],
          ),
        ],
      ),
    );
  }

  String _getHeaderDescription(String languageCode) {
    switch (languageCode.toLowerCase()) {
      case 'ar': return 'تعلم اللغة الأمهرية الجميلة بإثيوبيا مع دروسنا الشاملة المصممة للناطقين بالعربية.';
      case 'fr': return 'Maîtrisez la belle langue de l\'Éthiopie avec nos leçons complètes conçues pour les francophones.';
      case 'es': return 'Domina el hermoso idioma de Etiopía con nuestras lecciones completas diseñadas para hispanohablantes.';
      case 'de': return 'Beherrschen Sie die schöne Sprache Äthiopiens mit unseren umfassenden Lektionen für Deutschsprachige.';
      case 'it': return 'Padroneggia la bella lingua dell\'Etiopia con le nostre lezioni complete progettate per italofoni.';
      case 'pt': return 'Domine a bela língua da Etiópia com nossas lições abrangentes projetadas para falantes de português.';
      case 'ru': return 'Освойте красивый язык Эфиопии с нашими комплексными уроками для русскоязычных.';
      case 'zh': return '通过我们为中文使用者设计的综合课程，掌握埃塞俄比亚美丽的语言。';
      case 'ja': return '日本語話者向けに設計された包括的なレッスンで、エチオピアの美しい言語をマスターしましょう。';
      case 'hi': return 'हिंदी भाषी लोगों के लिए डिज़ाइन किए गए हमारे व्यापक पाठों के साथ इथियोपिया की सुंदर भाषा में महारत हासिल करें।';
      default: return 'Learn the beautiful language of Ethiopia with our comprehensive lessons.';
    }
  }

  String _getLessonsText(String languageCode) {
    switch (languageCode.toLowerCase()) {
      case 'ar': return 'دروس';
      case 'fr': return 'Leçons';
      case 'es': return 'Lecciones';
      case 'de': return 'Lektionen';
      case 'it': return 'Lezioni';
      case 'pt': return 'Lições';
      case 'ru': return 'Уроки';
      case 'zh': return '课程';
      case 'ja': return 'レッスン';
      case 'hi': return 'पाठ';
      default: return 'Lessons';
    }
  }

  String _getCompletedText(String languageCode) {
    switch (languageCode.toLowerCase()) {
      case 'ar': return 'مكتمل';
      case 'fr': return 'Terminé';
      case 'es': return 'Completado';
      case 'de': return 'Abgeschlossen';
      case 'it': return 'Completato';
      case 'pt': return 'Concluído';
      case 'ru': return 'Завершено';
      case 'zh': return '已完成';
      case 'ja': return '完了';
      case 'hi': return 'पूर्ण';
      default: return 'Completed';
    }
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
          _buildLevelButton(_getBeginnerText(widget.sourceLanguage), lesson_model.LanguageLevel.beginner, 0),
          _buildLevelButton(_getIntermediateText(widget.sourceLanguage), lesson_model.LanguageLevel.intermediate, 1),
          _buildLevelButton(_getAdvancedText(widget.sourceLanguage), lesson_model.LanguageLevel.advanced, 2),
        ],
      ),
    );
  }

  String _getBeginnerText(String languageCode) {
    switch (languageCode.toLowerCase()) {
      case 'ar': return 'مبتدئ';
      case 'fr': return 'Débutant';
      case 'es': return 'Principiante';
      case 'de': return 'Anfänger';
      case 'it': return 'Principiante';
      case 'pt': return 'Iniciante';
      case 'ru': return 'Начинающий';
      case 'zh': return '初级';
      case 'ja': return '初級';
      case 'hi': return 'शुरुआती';
      default: return 'Beginner';
    }
  }

  String _getIntermediateText(String languageCode) {
    switch (languageCode.toLowerCase()) {
      case 'ar': return 'متوسط';
      case 'fr': return 'Intermédiaire';
      case 'es': return 'Intermedio';
      case 'de': return 'Mittelstufe';
      case 'it': return 'Intermedio';
      case 'pt': return 'Intermediário';
      case 'ru': return 'Средний';
      case 'zh': return '中级';
      case 'ja': return '中級';
      case 'hi': return 'मध्यम';
      default: return 'Intermediate';
    }
  }

  String _getAdvancedText(String languageCode) {
    switch (languageCode.toLowerCase()) {
      case 'ar': return 'متقدم';
      case 'fr': return 'Avancé';
      case 'es': return 'Avanzado';
      case 'de': return 'Fortgeschritten';
      case 'it': return 'Avanzato';
      case 'pt': return 'Avançado';
      case 'ru': return 'Продвинутый';
      case 'zh': return '高级';
      case 'ja': return '上級';
      case 'hi': return 'उन्नत';
      default: return 'Advanced';
    }
  }

  Widget _buildLevelButton(String label, lesson_model.LanguageLevel level, int index) {
    final isSelected = _selectedLevel == level;
    return Expanded(
      child: GestureDetector(
        onTap: () => _changeLevel(level),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF00D9B8) : Colors.transparent,
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
              Text(
                _getProgressText(widget.sourceLanguage),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: null,
                ),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: const TextStyle(
                  color: Color(0xFF00D9B8),
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
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF00D9B8)),
            minHeight: 8,
          ),
          const SizedBox(height: 8),
          Text(
            '$completedLessons ${_getOfText(widget.sourceLanguage)} $totalLessons ${_getLessonsText(widget.sourceLanguage)} ${_getCompletedText(widget.sourceLanguage)}',
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

  String _getProgressText(String languageCode) {
    switch (languageCode.toLowerCase()) {
      case 'ar': return 'التقدم';
      case 'fr': return 'Progrès';
      case 'es': return 'Progreso';
      case 'de': return 'Fortschritt';
      case 'it': return 'Progresso';
      case 'pt': return 'Progresso';
      case 'ru': return 'Прогресс';
      case 'zh': return '进度';
      case 'ja': return '進捗';
      case 'hi': return 'प्रगति';
      default: return 'Progress';
    }
  }

  String _getOfText(String languageCode) {
    switch (languageCode.toLowerCase()) {
      case 'ar': return 'من';
      case 'fr': return 'de';
      case 'es': return 'de';
      case 'de': return 'von';
      case 'it': return 'di';
      case 'pt': return 'de';
      case 'ru': return 'из';
      case 'zh': return '的';
      case 'ja': return 'の';
      case 'hi': return 'का';
      default: return 'of';
    }
  }

  Widget _buildLessonsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _getLessonsText(widget.sourceLanguage),
          style: const TextStyle(
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
                    ? const Color(0xFF00D9B8).withValues(alpha: 0.3)
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
                        ? const Color(0xFF00D9B8)
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
                                color: const Color(0xFF00D9B8),
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${lesson.xpReward} XP',
                                style: const TextStyle(
                                  color: Color(0xFF00D9B8),
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
      case 'التحيات':
      case 'salutations':
      case 'saludos':
      case 'grüße':
      case 'saluti':
      case 'cumprimentos':
      case 'приветствия':
      case '问候':
      case '挨拶':
      case '인사':
      case 'अभिवादन':
        return const Color(0xFF00D9B8);
      case 'الأرقام':
      case 'nombres':
      case 'números':
      case 'zahlen':
      case 'numeri':
      case 'números':
      case 'числа':
      case '数字':
      case '숫자':
      case 'संख्या':
        return const Color(0xFF1CB0F6);
      case 'العائلة':
      case 'famille':
      case 'familia':
      case 'familie':
      case 'famiglia':
      case 'família':
      case 'семья':
      case '家庭':
      case '家族':
      case '가족':
      case 'परिवार':
        return const Color(0xFFFF6B6B);
      default:
        return const Color(0xFF00D9B8);
    }
  }

  void _startLesson(lesson_model.Lesson lesson) {
    // Navigate to enhanced lesson screen
    context.push('/language/enhanced-lesson/${lesson.id}?native=${lesson.languageCode}');
  }
}
