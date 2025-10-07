import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

class LanguageSelectionScreen extends ConsumerStatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  ConsumerState<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends ConsumerState<LanguageSelectionScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;

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
    
    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 100),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 32),
                _buildLanguageGrid(),
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
        'Choose Your Language',
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
            '🌍 Learn Amharic',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontFamily: null,
            ),
          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0),
          const SizedBox(height: 8),
          const Text(
            'Choose your native language to start learning Amharic with personalized lessons designed for your language background.',
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
              _buildStatCard('10', 'Languages', Icons.language),
              const SizedBox(width: 16),
              _buildStatCard('180+', 'Lessons', Icons.school),
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

  Widget _buildLanguageGrid() {
    final languages = [
      {
        'code': 'en',
        'name': 'English',
        'native': 'English',
        'flag': '🇺🇸',
        'color': const Color(0xFF1CB0F6),
      },
      {
        'code': 'ar',
        'name': 'Arabic',
        'native': 'العربية',
        'flag': '🇸🇦',
        'color': const Color(0xFF58CC02),
      },
      {
        'code': 'fr',
        'name': 'French',
        'native': 'Français',
        'flag': '🇫🇷',
        'color': const Color(0xFF6BCF7F),
      },
      {
        'code': 'es',
        'name': 'Spanish',
        'native': 'Español',
        'flag': '🇪🇸',
        'color': const Color(0xFFFF6B6B),
      },
      {
        'code': 'de',
        'name': 'German',
        'native': 'Deutsch',
        'flag': '🇩🇪',
        'color': const Color(0xFFB4A7D6),
      },
      {
        'code': 'it',
        'name': 'Italian',
        'native': 'Italiano',
        'flag': '🇮🇹',
        'color': const Color(0xFF88D8C0),
      },
      {
        'code': 'pt',
        'name': 'Portuguese',
        'native': 'Português',
        'flag': '🇵🇹',
        'color': const Color(0xFFF7DC6F),
      },
      {
        'code': 'ru',
        'name': 'Russian',
        'native': 'Русский',
        'flag': '🇷🇺',
        'color': const Color(0xFFBB8FCE),
      },
      {
        'code': 'zh',
        'name': 'Chinese',
        'native': '中文',
        'flag': '🇨🇳',
        'color': const Color(0xFF85C1E9),
      },
      {
        'code': 'ja',
        'name': 'Japanese',
        'native': '日本語',
        'flag': '🇯🇵',
        'color': const Color(0xFFF8C471),
      },
      {
        'code': 'hi',
        'name': 'Hindi',
        'native': 'हिन्दी',
        'flag': '🇮🇳',
        'color': const Color(0xFFF1948A),
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      itemCount: languages.length,
      itemBuilder: (context, index) {
        final language = languages[index];
        return _buildLanguageCard(language);
      },
    );
  }

  Widget _buildLanguageCard(Map<String, dynamic> language) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF3A3A3A)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _selectLanguage(language['code']),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Flag
                Text(
                  language['flag'],
                  style: const TextStyle(fontSize: 32),
                ),
                const SizedBox(height: 12),
                // Language Name (English)
                Text(
                  language['name'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: null,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                // Native Name
                Text(
                  language['native'],
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                    fontFamily: null,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                // Progress Indicator
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: language['color'].withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: 0.3, // 30% progress
                    child: Container(
                      decoration: BoxDecoration(
                        color: language['color'],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _selectLanguage(String languageCode) {
    if (languageCode == 'en') {
      // Navigate to English lessons
      context.push('/language/english-amharic');
    } else {
      // Navigate to multilingual lessons
      context.push('/language/multilingual-amharic/$languageCode');
    }
  }
}
