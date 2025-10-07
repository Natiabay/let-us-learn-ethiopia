import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ComprehensiveLanguageSelector extends ConsumerStatefulWidget {
  const ComprehensiveLanguageSelector({super.key});

  @override
  ConsumerState<ComprehensiveLanguageSelector> createState() => _ComprehensiveLanguageSelectorState();
}

class _ComprehensiveLanguageSelectorState extends ConsumerState<ComprehensiveLanguageSelector>
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
      backgroundColor: const Color(0xFF1A1A1A), // Dark theme
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                _buildHeader(),
                const SizedBox(height: 32),
                
                // Welcome section
                _buildWelcomeSection(),
                const SizedBox(height: 32),
                
                // Language selection
                _buildLanguageSelection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        // Profile icon
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF58CC02),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.person,
            color: Colors.white,
            size: 24,
          ),
        ),
        
        const Spacer(),
        
        // XP and hearts
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                '10 XP',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Hearts
            Row(
              children: List.generate(5, (index) => 
                Container(
                  margin: const EdgeInsets.only(left: 2),
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Settings
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
                size: 24,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF58CC02), Color(0xFF4CAF50)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF58CC02).withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Welcome to Amharic Learning!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'Learn Amharic with interactive lessons, just like Duolingo!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Start Learning',
              style: TextStyle(
                color: Color(0xFF58CC02),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageSelection() {
    final languages = [
      LanguageOption(
        name: 'English',
        nativeName: 'English',
        flag: '🇺🇸',
        color: const Color(0xFF1CB0F6),
        description: 'Learn Amharic from English',
      ),
      LanguageOption(
        name: 'Mandarin',
        nativeName: '中文',
        flag: '🇨🇳',
        color: const Color(0xFFCE82FF),
        description: 'Learn Amharic from Mandarin Chinese',
      ),
      LanguageOption(
        name: 'French',
        nativeName: 'Français',
        flag: '🇫🇷',
        color: const Color(0xFF1CB0F6),
        description: 'Learn Amharic from French',
      ),
      LanguageOption(
        name: 'German',
        nativeName: 'Deutsch',
        flag: '🇩🇪',
        color: const Color(0xFFCE82FF),
        description: 'Learn Amharic from German',
      ),
      LanguageOption(
        name: 'Italian',
        nativeName: 'Italiano',
        flag: '🇮🇹',
        color: const Color(0xFF1CB0F6),
        description: 'Learn Amharic from Italian',
      ),
      LanguageOption(
        name: 'Spanish',
        nativeName: 'Español',
        flag: '🇪🇸',
        color: const Color(0xFFCE82FF),
        description: 'Learn Amharic from Spanish',
      ),
      LanguageOption(
        name: 'Arabic',
        nativeName: 'العربية',
        flag: '🇸🇦',
        color: const Color(0xFF1CB0F6),
        description: 'Learn Amharic from Arabic',
      ),
      LanguageOption(
        name: 'Portuguese',
        nativeName: 'Português',
        flag: '🇵🇹',
        color: const Color(0xFFCE82FF),
        description: 'Learn Amharic from Portuguese',
      ),
      LanguageOption(
        name: 'Russian',
        nativeName: 'Русский',
        flag: '🇷🇺',
        color: const Color(0xFF1CB0F6),
        description: 'Learn Amharic from Russian',
      ),
      LanguageOption(
        name: 'Japanese',
        nativeName: '日本語',
        flag: '🇯🇵',
        color: const Color(0xFFCE82FF),
        description: 'Learn Amharic from Japanese',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Lessons',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        
        // Translate Any Word section
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF1CB0F6),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Icon(
                  Icons.translate,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Translate Any Word',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '40+ Lessons • 10,000+ Words',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        
        // Lesson cards
        Row(
          children: [
            Expanded(
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  color: const Color(0xFF1CB0F6),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Icon(
                          Icons.waving_hand,
                          color: Color(0xFF1CB0F6),
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  color: const Color(0xFF1CB0F6),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '12',
                              style: TextStyle(
                                color: Color(0xFF1CB0F6),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '34',
                              style: TextStyle(
                                color: Color(0xFF1CB0F6),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        
        // Language grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.1,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: languages.length,
          itemBuilder: (context, index) {
            final language = languages[index];
            return _buildLanguageCard(language, index);
          },
        ),
      ],
    );
  }

  Widget _buildLanguageCard(LanguageOption language, int index) {
    return GestureDetector(
      onTap: () => _selectLanguage(language),
      child: Container(
        decoration: BoxDecoration(
          color: language.color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: language.color.withValues(alpha: 0.3),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: language.color.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Flag
              Text(
                language.flag,
                style: const TextStyle(fontSize: 32),
              ),
              
              const SizedBox(height: 8),
              
              // Native name
              Text(
                language.nativeName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: language.color,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 4),
              
              // English name
              Text(
                language.name,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    ).animate(delay: (index * 100).ms)
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.3, end: 0);
  }

  void _selectLanguage(LanguageOption language) {
    // Store the selected native language
    // Navigate to proficiency assessment with language context
    context.push('/language/amharic/proficiency?native=${language.name}');
  }
}

class LanguageOption {
  final String name;
  final String nativeName;
  final String flag;
  final Color color;
  final String description;

  LanguageOption({
    required this.name,
    required this.nativeName,
    required this.flag,
    required this.color,
    required this.description,
  });
}
