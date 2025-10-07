import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import 'package:go_router/go_router.dart';
import 'package:tourist_assistive_app/features/language/models/amharic_lesson_model.dart';
import 'package:tourist_assistive_app/features/language/providers/amharic_learning_provider.dart';

class AmharicLearningDashboard extends ConsumerStatefulWidget {
  const AmharicLearningDashboard({super.key});

  @override
  ConsumerState<AmharicLearningDashboard> createState() => _AmharicLearningDashboardState();
}

class _AmharicLearningDashboardState extends ConsumerState<AmharicLearningDashboard>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _slideController;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);
    
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _slideController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final learningState = ref.watch(amharicLearningProvider);
    final lessons = learningState.lessons;
    final currentStreak = learningState.currentStreak;
    final totalXP = learningState.totalXP;
    final hearts = learningState.hearts;

    if (learningState.isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFF1A1A1A),
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xFF58CC02),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 100), // Add bottom padding for navigation
          child: Column(
            children: [
              _buildTopBar(currentStreak, totalXP, hearts),
              _buildWelcomeSection(),
              _buildLessonsList(lessons),
              const SizedBox(height: 20), // Reduced space since we have padding
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(int currentStreak, int totalXP, int hearts) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Profile Avatar
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFF58CC02),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person,
              color: Colors.white,
              size: 24,
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Streak
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
                Text(
                  '$currentStreak',
                  style: const TextStyle(
                    color: Color(0xFF1A1A1A),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          const Spacer(),
          
          // XP
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF1CB0F6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$totalXP XP',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          const SizedBox(width: 8),
          
          // Hearts
          Row(
            children: List.generate(5, (index) {
              return Container(
                margin: const EdgeInsets.only(left: 2),
                child: Icon(
                  index < hearts ? Icons.favorite : Icons.favorite_border,
                  color: const Color(0xFFFF4B4B),
                  size: 20,
                ),
              );
            }),
          ),
          
          const SizedBox(width: 8),
          
          // Settings
          GestureDetector(
            onTap: () => _showSettings(),
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFF2A2A2A),
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF58CC02), Color(0xFF4CAF50)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome to Amharic Learning!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Learn Amharic with interactive lessons, just like Duolingo!',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _startDailyGoal(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Start Learning',
                    style: TextStyle(
                      color: Color(0xFF58CC02),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLessonsList(List<AmharicLesson> lessons) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
          
          // Translation Button
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 20),
            child: ElevatedButton.icon(
              onPressed: () => _openTranslationScreen(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1CB0F6),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.translate, color: Colors.white),
              label: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Translate Any Word',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '40+ Lessons • 10,000+ Words',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Lessons Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
            ),
            itemCount: lessons.length,
            itemBuilder: (context, index) {
              final lesson = lessons[index];
              return _buildLessonCard(lesson);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLessonCard(AmharicLesson lesson) {
    final isUnlocked = lesson.isUnlocked;
    final isCompleted = lesson.isCompleted;
    
    Color backgroundColor = const Color(0xFF2A2A2A);
    Color borderColor = const Color(0xFF2A2A2A);
    
    if (isCompleted) {
      backgroundColor = const Color(0xFF58CC02);
      borderColor = const Color(0xFF58CC02);
    } else if (isUnlocked) {
      backgroundColor = const Color(0xFF1CB0F6);
      borderColor = const Color(0xFF1CB0F6);
    } else {
      backgroundColor = const Color(0xFF1A1A1A);
      borderColor = const Color(0xFF2A2A2A);
    }

    return GestureDetector(
      onTap: isUnlocked ? () => _startLesson(lesson) : null,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lesson Icon
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: isUnlocked ? Colors.white : const Color(0xFF2A2A2A),
                shape: BoxShape.circle,
              ),
              child: isCompleted
                  ? const Icon(
                      Icons.check,
                      color: Color(0xFF58CC02),
                      size: 24,
                    )
                  : isUnlocked
                      ? Text(
                          lesson.icon,
                          style: const TextStyle(fontSize: 24),
                        )
                      : const Icon(
                          Icons.lock,
                          color: Colors.white54,
                          size: 24,
                        ),
            ),
            
            const SizedBox(height: 12),
            
            // Lesson Title
            Text(
              lesson.title,
              style: TextStyle(
                color: isUnlocked ? Colors.white : Colors.white54,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 4),
            
            // Lesson Info
            Text(
              '${lesson.words.length} words • ${lesson.estimatedTime} min',
              style: TextStyle(
                color: isUnlocked ? Colors.white70 : Colors.white38,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 8),
            
            // XP Reward
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isUnlocked ? const Color(0xFF1CB0F6) : const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${lesson.xpReward} XP',
                style: TextStyle(
                  color: isUnlocked ? Colors.white : Colors.white54,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: (100 * lesson.id).ms).slideY(
      begin: 0.3,
      end: 0,
      duration: 600.ms,
      curve: Curves.easeOut,
    );
  }

  void _startLesson(AmharicLesson lesson) {
    // For now, we'll navigate to a generic lesson route
    // In a real implementation, you'd pass the lesson data through the route
    context.push('/language/amharic/lesson/${lesson.id}');
  }

  void _openTranslationScreen() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Translation feature coming soon')),
    );
  }

  void _startDailyGoal() {
    // Find the first unlocked lesson
    final unlockedLessons = ref.read(amharicLearningProvider.notifier).getUnlockedLessons();
    if (unlockedLessons.isNotEmpty) {
      _startLesson(unlockedLessons.first);
    } else {
      _showUnlockDialog();
    }
  }

  void _showUnlockDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A2A),
        title: const Text(
          'Complete Previous Lessons',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Please complete the previous lessons to unlock new content.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'OK',
              style: TextStyle(color: Color(0xFF58CC02)),
            ),
          ),
        ],
      ),
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
            
            const SizedBox(height: 24),
            
            // Reset Progress Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _showResetDialog(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF4B4B),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Reset Progress',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
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

  void _showResetDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A2A),
        title: const Text(
          'Reset Progress',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Are you sure you want to reset all your progress? This action cannot be undone.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white70),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Reset progress logic here
              ref.read(amharicLearningProvider.notifier).refreshLessons();
            },
            child: const Text(
              'Reset',
              style: TextStyle(color: Color(0xFFFF4B4B)),
            ),
          ),
        ],
      ),
    );
  }
}
