import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:confetti/confetti.dart';
import 'package:go_router/go_router.dart';
import 'package:tourist_assistive_app/features/language/models/amharic_lesson_model.dart';
import 'package:tourist_assistive_app/features/language/providers/amharic_learning_provider.dart';

class DuolingoStyleDashboard extends ConsumerStatefulWidget {
  const DuolingoStyleDashboard({super.key});

  @override
  ConsumerState<DuolingoStyleDashboard> createState() => _DuolingoStyleDashboardState();
}

class _DuolingoStyleDashboardState extends ConsumerState<DuolingoStyleDashboard>
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
    final amharicProvider = ref.watch(amharicLearningProvider);
    final lessons = AmharicLessonsData.getLessons();

    return Scaffold(
      backgroundColor: const Color(0xFF58CC02), // Duolingo green background
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 100), // Add bottom padding for navigation
          child: Column(
            children: [
              // Duolingo-style header with Duo mascot
              _buildDuolingoHeader(amharicProvider),
              
              // Main content area with white background
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Duo mascot and welcome message
                      _buildDuoWelcome(),
                      const SizedBox(height: 24),
                      
                      // Lesson path (circular/linear like Duolingo)
                      _buildLessonPath(lessons, amharicProvider),
                      const SizedBox(height: 24),
                      
                      // Quick actions
                      _buildQuickActions(),
                      const SizedBox(height: 24),
                      
                      // Translation feature
                      _buildTranslationFeature(),
                      const SizedBox(height: 20), // Reduced space since we have padding
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDuolingoHeader(AmharicLearningState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          // Duo mascot (circular avatar)
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.pets, // Duo mascot icon
              color: Color(0xFF58CC02),
              size: 28,
            ),
          ),
          
          const SizedBox(width: 16),
          
          // User info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ready to learn Amharic?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${state.currentStreak} day streak!',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          
          // Hearts
          _buildHearts(state.hearts),
          
          const SizedBox(width: 12),
          
          // XP
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.white,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  '${state.totalXP}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHearts(int hearts) {
    return Row(
      children: List.generate(5, (index) {
        return Container(
          margin: const EdgeInsets.only(right: 4),
          child: Icon(
            index < hearts ? Icons.favorite : Icons.favorite_border,
            color: index < hearts ? const Color(0xFFFF4B4B) : Colors.white.withValues(alpha: 0.5),
            size: 20,
          ),
        );
      }),
    );
  }

  Widget _buildDuoWelcome() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF58CC02).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF58CC02).withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: Row(
        children: [
          // Duo mascot
          Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              color: Color(0xFF58CC02),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.pets,
              color: Colors.white,
              size: 32,
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Welcome message
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome to Amharic!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Learn Amharic with 40+ lessons and 10,000+ words',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonPath(List<AmharicLesson> lessons, AmharicLearningState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your Path',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 16),
        
        // Lesson path with connected nodes
        Container(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: lessons.length,
            itemBuilder: (context, index) {
              final lesson = lessons[index];
              final isCompleted = lesson.isCompleted;
              final isUnlocked = lesson.isUnlocked;
              final isCurrent = index == state.currentLessonIndex;
              
              return _buildLessonNode(
                lesson: lesson,
                isCompleted: isCompleted,
                isUnlocked: isUnlocked,
                isCurrent: isCurrent,
                index: index,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLessonNode({
    required AmharicLesson lesson,
    required bool isCompleted,
    required bool isUnlocked,
    required bool isCurrent,
    required int index,
  }) {
    Color nodeColor;
    IconData nodeIcon;
    
    if (isCompleted) {
      nodeColor = const Color(0xFF58CC02); // Green for completed
      nodeIcon = Icons.check;
    } else if (isCurrent) {
      nodeColor = const Color(0xFF1CB0F6); // Blue for current
      nodeIcon = Icons.play_arrow;
    } else if (isUnlocked) {
      nodeColor = const Color(0xFFCE82FF); // Purple for unlocked
      nodeIcon = Icons.lock_open;
    } else {
      nodeColor = Colors.grey[400]!; // Grey for locked
      nodeIcon = Icons.lock;
    }

    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          // Lesson node
          GestureDetector(
            onTap: isUnlocked ? () => _startLesson(lesson) : null,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: nodeColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: nodeColor.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                nodeIcon,
                color: Colors.white,
                size: 32,
              ),
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Lesson title
          Text(
            lesson.title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isUnlocked ? const Color(0xFF1A1A1A) : Colors.grey[400],
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          
          const SizedBox(height: 4),
          
          // XP reward
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: nodeColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${lesson.xpReward} XP',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: nodeColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 16),
        
        Row(
          children: [
            Expanded(
              child: _buildQuickActionCard(
                title: 'Practice',
                subtitle: 'Review words',
                icon: Icons.refresh,
                color: const Color(0xFF1CB0F6),
                onTap: () {
                  // Start practice session
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildQuickActionCard(
                title: 'Stories',
                subtitle: 'Read stories',
                icon: Icons.menu_book,
                color: const Color(0xFFCE82FF),
                onTap: () {
                  // Open stories
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withValues(alpha: 0.3),
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTranslationFeature() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
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
          const Icon(
            Icons.translate,
            color: Colors.white,
            size: 32,
          ),
          const SizedBox(height: 12),
          const Text(
            'Translate Any Word',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '10,000+ Amharic words available',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _openTranslationScreen,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF58CC02),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: const Text(
              'Start Translating',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _startLesson(AmharicLesson lesson) {
    context.push('/language/amharic/lesson/${lesson.id}');
  }

  void _openTranslationScreen() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Translation feature coming soon')),
    );
  }
}
