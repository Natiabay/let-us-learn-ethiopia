import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tourist_assistive_app/features/language/data/amharic_lessons_data.dart';
import 'package:tourist_assistive_app/features/language/models/comprehensive_lesson_model.dart';
import 'package:tourist_assistive_app/features/language/services/amharic_voice_service.dart';
import 'package:tourist_assistive_app/features/language/services/amharic_image_service.dart';
import 'package:tourist_assistive_app/features/subscription/providers/subscription_provider.dart';

class MultilingualLearningDashboard extends ConsumerStatefulWidget {
  const MultilingualLearningDashboard({super.key});

  @override
  ConsumerState<MultilingualLearningDashboard> createState() => _MultilingualLearningDashboardState();
}

class _MultilingualLearningDashboardState extends ConsumerState<MultilingualLearningDashboard>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _pulseController;

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
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    
    _fadeController.forward();
    _slideController.forward();
    
    // Initialize Amharic voice service
    _initializeAmharicServices();
  }

  Future<void> _initializeAmharicServices() async {
    try {
      await AmharicVoiceService().initialize();
      debugPrint('✅ Amharic services initialized');
    } catch (e) {
      debugPrint('❌ Failed to initialize Amharic services: $e');
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A), // Dark theme like Duolingo
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 100), // Add bottom padding for navigation
          child: Column(
            children: [
              _buildTopBar(),
              _buildWelcomeSection(),
              _buildLanguageSelection(),
              _buildLessonsSection(),
              const SizedBox(height: 20), // Reduced space since we have padding
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: () => context.go('/home'),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Profile Avatar with Ethiopian flag
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF58CC02),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: const Icon(
              Icons.person,
              color: Colors.white,
              size: 24,
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Streak indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFFFE135),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.local_fire_department,
                  color: Color(0xFFFF4B4B),
                  size: 16,
                ),
                const SizedBox(width: 4),
                const Text(
                  '1',
                  style: TextStyle(
                    color: Color(0xFF1A1A1A),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          const Spacer(),
          
          // XP indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF1CB0F6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              '0 XP',
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
                  color: Color(0xFFFF4B4B),
                  size: 20,
                ),
              ),
            ),
          ),
          
          const SizedBox(width: 8),
          
          // Settings
          GestureDetector(
            onTap: () => _showSettings(),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A2A),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.settings,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      margin: const EdgeInsets.all(16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.school_rounded,
                color: Colors.white,
                size: 32,
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Learn Amharic',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Icon(
                Icons.flag,
                color: Colors.white,
                size: 24,
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Welcome to Ethiopia',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Icon(
                Icons.person,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Hello, Tourist! Ready to learn Amharic?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Icon(
                Icons.settings,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.credit_card,
                color: Colors.white,
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Level and Progress
          Row(
            children: [
              // Level indicator
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    '1',
                    style: TextStyle(
                      color: Color(0xFF58CC02),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Level 1',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '0 / 50 XP',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Progress bar
                    Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: 0.0, // 0% progress
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '50 XP to next level',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildLanguageSelection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Choose Your Learning Path',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Select your native language to start learning Amharic',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          
          // Language Selection Button
          _buildLanguageSelectionButton(),
          const SizedBox(height: 20),
          
          // Comprehensive Amharic Lessons Section
          _buildComprehensiveAmharicLessons(),
          const SizedBox(height: 20),
          
          _buildTrialAccessButton(),
        ],
      ),
    ).animate().fadeIn(duration: 1000.ms).slideY(begin: 0.3, end: 0);
  }
  
  Widget _buildLanguageSelectionButton() {
    return Container(
      width: double.infinity,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => context.push('/language/selection'),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF58CC02), Color(0xFF1CB0F6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.language,
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
                        '🌍 Choose Your Language',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: null,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        '12 languages supported • Personalized lessons',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: null,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageOptions() {
    final languages = [
      LanguageOption(
        name: 'Amharic',
        nativeName: 'አማርኛ',
        flag: '🇪🇹',
        color: Colors.green,
        description: 'Official language of Ethiopia',
        isAvailable: true,
        languageCode: 'am',
      ),
      LanguageOption(
        name: 'English',
        nativeName: 'English',
        flag: '🇺🇸',
        color: Colors.blue,
        description: 'International language',
        isAvailable: true,
        languageCode: 'en',
      ),
    ];

    return Column(
      children: languages.map((language) => _buildLanguageCard(language)).toList(),
    );
  }

  Widget _buildLanguageCard(LanguageOption language) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: language.isAvailable ? () => _selectLanguage(language) : null,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: language.isAvailable 
                ? language.color.withValues(alpha: 0.1)
                : const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: language.isAvailable 
                  ? language.color.withValues(alpha: 0.3)
                  : const Color(0xFF2A2A2A),
              width: 2,
            ),
          ),
          child: Row(
            children: [
              // Flag
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: language.isAvailable 
                      ? language.color.withValues(alpha: 0.2)
                      : const Color(0xFF2A2A2A),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: Text(
                    language.flag,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
              
              const SizedBox(width: 16),
              
              // Language info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      language.nativeName,
                      style: TextStyle(
                        color: language.isAvailable ? Colors.white : Colors.white54,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      language.description,
                      style: TextStyle(
                        color: language.isAvailable ? Colors.white70 : Colors.white38,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Arrow or status
              if (language.isAvailable)
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 20,
                )
              else
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'SOON',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 600.ms).slideX(begin: 0.3, end: 0);
  }

  Widget _buildLessonsSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Lessons',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
           // Translate Any Word section
           GestureDetector(
             onTap: () => _openDictionary(),
             child: Container(
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
                           'English → Amharic Dictionary',
                           style: TextStyle(
                             color: Colors.white,
                             fontSize: 18,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                         const SizedBox(height: 4),
                         const Text(
                           '10,000+ Words • Interactive Search',
                           style: TextStyle(
                             color: Colors.white,
                             fontSize: 14,
                           ),
                         ),
                       ],
                     ),
                   ),
                   const Icon(
                     Icons.arrow_forward_ios,
                     color: Colors.white,
                     size: 20,
                   ),
                 ],
               ),
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
          const SizedBox(height: 20),
          
          // Weekly Goal
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Weekly Goal',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: 0.0, // 0% complete
                  backgroundColor: const Color(0xFF1A1A1A),
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF58CC02)),
                  borderRadius: BorderRadius.circular(4),
                ),
                const SizedBox(height: 4),
                const Text(
                  '0% Complete',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 1200.ms).slideY(begin: 0.3, end: 0);
  }

  void _selectLanguage(LanguageOption language) {
    setState(() {
    });
    
    // Navigate to specific language lesson screen using GoRouter
    try {
      switch (language.languageCode) {
        case 'en':
          context.push('/language/english');
          break;
        case 'zh':
          context.push('/language/mandarin');
          break;
        case 'fr':
          context.push('/language/french');
          break;
        case 'de':
          context.push('/language/german');
          break;
        case 'es':
          context.push('/language/spanish');
          break;
        case 'ar':
          context.push('/language/arabic');
          break;
        case 'pt':
          context.push('/language/portuguese');
          break;
        case 'ru':
          context.push('/language/russian');
          break;
        case 'ja':
          context.push('/language/japanese');
          break;
        default:
          // Show a coming soon message for any other languages
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${language.name} lessons coming soon!'),
              backgroundColor: language.color,
            ),
          );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Navigation error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _openDictionary() {
    // Navigate to English-Amharic dictionary using GoRouter
    context.push('/language/dictionary');
  }

  Widget _buildComprehensiveAmharicLessons() {
    final allLessons = AmharicLessonsData.getAllAmharicLessons();
    final beginnerLessons = allLessons.where((lesson) => lesson.level == LanguageLevel.beginner).length;
    final intermediateLessons = allLessons.where((lesson) => lesson.level == LanguageLevel.intermediate).length;
    final advancedLessons = allLessons.where((lesson) => lesson.level == LanguageLevel.advanced).length;
    final totalEstimatedMinutes = allLessons.fold(0, (sum, lesson) => sum + lesson.estimatedMinutes);
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1CB0F6),
            Color(0xFFCE82FF),
            Color(0xFF58CC02),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
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
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.menu_book_rounded,
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
                      'Comprehensive Amharic Lessons',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                           Text(
                             '${allLessons.length} professional lessons with real images & voice',
                             style: TextStyle(
                               color: Colors.white.withValues(alpha: 0.9),
                               fontSize: 14,
                             ),
                           ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Lesson Statistics
          Row(
            children: [
                     Expanded(
                       child: _buildStatCard(
                         'Beginner',
                         '$beginnerLessons lessons',
                         Icons.play_circle_outline,
                       ),
                     ),
                     const SizedBox(width: 12),
                     Expanded(
                       child: _buildStatCard(
                         'Intermediate',
                         '$intermediateLessons lessons',
                         Icons.school_outlined,
                       ),
                     ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
                     Expanded(
                       child: _buildStatCard(
                         'Advanced',
                         '$advancedLessons lessons',
                         Icons.star_outline,
                       ),
                     ),
                     const SizedBox(width: 12),
                     Expanded(
                       child: _buildStatCard(
                         'Total Time',
                         '$totalEstimatedMinutes min',
                         Icons.access_time,
                       ),
                     ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Start Learning Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _startComprehensiveLessons(),
              icon: const Icon(Icons.rocket_launch, color: Colors.white),
              label: const Text(
                'Start Comprehensive Learning',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withValues(alpha: 0.2),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 1000.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  void _startComprehensiveLessons() {
    // Navigate to Amharic lessons
    context.push('/language/amharic');
  }

  Widget _buildTrialAccessButton() {
    // Remove access restrictions - show welcome message instead
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF58CC02).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF58CC02).withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.school,
            color: Color(0xFF58CC02),
            size: 32,
          ),
          const SizedBox(height: 8),
          const Text(
            'Welcome to Language Learning!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Start learning Amharic with our comprehensive lessons',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ).animate().fadeIn(duration: 1200.ms).slideY(begin: 0.3, end: 0);
  }

  Future<void> _startFreeTrial(WidgetRef ref) async {
    try {
      final subscriptionActions = ref.read(subscriptionActionsProvider);
      await subscriptionActions.startFreeTrial();
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('🎉 Free trial started! You now have 24 hours of full access.'),
          backgroundColor: Color(0xFF58CC02),
        ),
      );
    } catch (e) {
      print('Error starting free trial: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error starting trial: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
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
              'Settings',
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
              subtitle: 'Enable/disable sound effects',
              onTap: () {},
            ),
            
            _buildSettingItem(
              icon: Icons.notifications,
              title: 'Notifications',
              subtitle: 'Daily reminders',
              onTap: () {},
            ),
            
            _buildSettingItem(
              icon: Icons.help_outline,
              title: 'Help & Support',
              subtitle: 'Get help with the app',
              onTap: () {},
            ),
            
            _buildSettingItem(
              icon: Icons.info_outline,
              title: 'About',
              subtitle: 'App version and info',
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
      leading: Icon(icon, color: const Color(0xFF58CC02)),
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
}

