import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tourist_assistive_app/core/theme/app_theme.dart';

class LearningProgressScreen extends ConsumerStatefulWidget {
  const LearningProgressScreen({super.key});

  @override
  ConsumerState<LearningProgressScreen> createState() => _LearningProgressScreenState();
}

class _LearningProgressScreenState extends ConsumerState<LearningProgressScreen> {
  String _selectedLanguage = 'English';
  String _selectedTimeframe = 'All Time';

  final List<Map<String, dynamic>> _languages = [
    {'name': 'English', 'flag': '🇺🇸', 'progress': 85, 'lessons': 24, 'streak': 7},
    {'name': 'Amharic', 'flag': '🇪🇹', 'progress': 45, 'lessons': 12, 'streak': 3},
    {'name': 'French', 'flag': '🇫🇷', 'progress': 20, 'lessons': 5, 'streak': 1},
  ];

  final List<Map<String, dynamic>> _achievements = [
    {
      'title': 'First Steps',
      'description': 'Complete your first lesson',
      'icon': Icons.school,
      'earned': true,
      'date': '2024-01-15',
    },
    {
      'title': 'Week Warrior',
      'description': 'Study for 7 days in a row',
      'icon': Icons.local_fire_department,
      'earned': true,
      'date': '2024-01-22',
    },
    {
      'title': 'Vocabulary Master',
      'description': 'Learn 100 new words',
      'icon': Icons.psychology,
      'earned': false,
      'date': null,
    },
    {
      'title': 'Perfect Score',
      'description': 'Get 100% on 10 quizzes',
      'icon': Icons.emoji_events,
      'earned': false,
      'date': null,
    },
  ];

  final List<Map<String, dynamic>> _recentActivity = [
    {
      'type': 'lesson',
      'title': 'Greetings in Amharic',
      'time': '2 hours ago',
      'score': 95,
    },
    {
      'type': 'quiz',
      'title': 'Numbers Quiz',
      'time': '1 day ago',
      'score': 88,
    },
    {
      'type': 'lesson',
      'title': 'Family Members',
      'time': '2 days ago',
      'score': 92,
    },
    {
      'type': 'practice',
      'title': 'Speaking Practice',
      'time': '3 days ago',
      'score': 78,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text('Learning Progress'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                _selectedTimeframe = value;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'All Time', child: Text('All Time')),
              const PopupMenuItem(value: 'This Month', child: Text('This Month')),
              const PopupMenuItem(value: 'This Week', child: Text('This Week')),
            ],
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _selectedTimeframe,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overall Progress Card
            _buildOverallProgressCard(),
            const SizedBox(height: 24),
            
            // Language Progress
            _buildLanguageProgressSection(),
            const SizedBox(height: 24),
            
            // Achievements
            _buildAchievementsSection(),
            const SizedBox(height: 24),
            
            // Recent Activity
            _buildRecentActivitySection(),
          ],
        ),
      ),
    );
  }

  Widget _buildOverallProgressCard() {
    final totalLessons = _languages.fold<int>(0, (sum, lang) => sum + (lang['lessons'] as int));
    final averageProgress = _languages.fold<double>(0, (sum, lang) => sum + (lang['progress'] as double)) / _languages.length;
    final totalStreak = _languages.fold<int>(0, (sum, lang) => sum + (lang['streak'] as int));

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, Color(0xFF1CB0F6)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Overall Progress',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          // Progress Bar
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Completion Rate',
                    style: TextStyle(color: Colors.white70),
                  ),
                  Text(
                    '${averageProgress.toInt()}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: averageProgress / 100,
                backgroundColor: Colors.white.withValues(alpha: 0.3),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                minHeight: 8,
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Stats Row
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  icon: Icons.school,
                  label: 'Lessons',
                  value: totalLessons.toString(),
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  icon: Icons.local_fire_department,
                  label: 'Streak',
                  value: '${totalStreak} days',
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  icon: Icons.emoji_events,
                  label: 'Achievements',
                  value: '${_achievements.where((a) => a['earned']).length}',
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
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

  Widget _buildLanguageProgressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Language Progress',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        ..._languages.map((language) => _buildLanguageCard(language)).toList(),
      ],
    );
  }

  Widget _buildLanguageCard(Map<String, dynamic> language) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          // Flag
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.grey100,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Text(
                language['flag'],
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
          const SizedBox(width: 16),
          
          // Language Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  language['name'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${language['lessons']} lessons completed',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: language['progress'] / 100,
                  backgroundColor: AppColors.grey200,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  minHeight: 6,
                ),
                const SizedBox(height: 4),
                Text(
                  '${language['progress']}% complete',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // Streak
          Column(
            children: [
              Icon(
                Icons.local_fire_department,
                color: Colors.orange,
                size: 20,
              ),
              Text(
                '${language['streak']}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideX(begin: 0.3, end: 0);
  }

  Widget _buildAchievementsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Achievements',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.2,
          ),
          itemCount: _achievements.length,
          itemBuilder: (context, index) {
            final achievement = _achievements[index];
            return _buildAchievementCard(achievement, index);
          },
        ),
      ],
    );
  }

  Widget _buildAchievementCard(Map<String, dynamic> achievement, int index) {
    final isEarned = achievement['earned'] as bool;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isEarned ? AppColors.primary.withValues(alpha: 0.1) : AppColors.grey100,
        borderRadius: BorderRadius.circular(12),
        border: isEarned ? Border.all(color: AppColors.primary, width: 2) : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            achievement['icon'],
            size: 32,
            color: isEarned ? AppColors.primary : AppColors.grey400,
          ),
          const SizedBox(height: 8),
          Text(
            achievement['title'],
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isEarned ? AppColors.primary : AppColors.grey600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            achievement['description'],
            style: TextStyle(
              fontSize: 12,
              color: isEarned ? AppColors.textSecondary : AppColors.grey500,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (isEarned && achievement['date'] != null) ...[
            const SizedBox(height: 4),
            Text(
              'Earned ${achievement['date']}',
              style: const TextStyle(
                fontSize: 10,
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ],
      ),
    ).animate(delay: Duration(milliseconds: index * 100)).fadeIn(duration: 600.ms).scale();
  }

  Widget _buildRecentActivitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Activity',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        ..._recentActivity.map((activity) => _buildActivityItem(activity)).toList(),
      ],
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
    IconData icon;
    Color color;
    
    switch (activity['type']) {
      case 'lesson':
        icon = Icons.school;
        color = AppColors.primary;
        break;
      case 'quiz':
        icon = Icons.quiz;
        color = Colors.orange;
        break;
      case 'practice':
        icon = Icons.mic;
        color = Colors.green;
        break;
      default:
        icon = Icons.check_circle;
        color = AppColors.grey400;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity['title'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  activity['time'],
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${activity['score']}%',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideX(begin: 0.3, end: 0);
  }
}
