import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_assistive_app/core/constants/app_colors.dart';

class LearningProgressScreen extends ConsumerStatefulWidget {
  const LearningProgressScreen({super.key});

  @override
  ConsumerState<LearningProgressScreen> createState() => _LearningProgressScreenState();
}

class _LearningProgressScreenState extends ConsumerState<LearningProgressScreen> {
  // Professional navy blue theme colors
  static const Color _navyBlue = Color(0xFF0A1929);
  static const Color _navyCard = Color(0xFF1A2F44);
  static const Color _turquoise = Color(0xFF00D9B8);
  static const Color _yellow = Color(0xFFFFD43B);
  static const Color _blue = Color(0xFF1CB0F6);
  static const Color _red = Color(0xFFFF4B4B);
  static const Color _textPrimary = Color(0xFFFFFFFF);
  static const Color _textSecondary = Color(0xFFB3B3B3);
  static const Color _textTertiary = Color(0xFF8B949E);

  // Sample learning progress data
  final Map<String, dynamic> _overallProgress = {
    'totalLessons': 45,
    'completedLessons': 32,
    'currentStreak': 12,
    'longestStreak': 28,
    'totalXP': 2450,
    'level': 8,
    'nextLevelXP': 500,
  };

  final List<Map<String, dynamic>> _languageProgress = [
    {
      'language': 'Amharic',
      'level': 6,
      'lessonsCompleted': 18,
      'totalLessons': 25,
      'xp': 1200,
      'streak': 8,
      'color': _turquoise,
    },
    {
      'language': 'English',
      'level': 4,
      'lessonsCompleted': 12,
      'totalLessons': 20,
      'xp': 800,
      'streak': 4,
      'color': _blue,
    },
    {
      'language': 'French',
      'level': 2,
      'lessonsCompleted': 6,
      'totalLessons': 15,
      'xp': 300,
      'streak': 2,
      'color': _yellow,
    },
  ];

  final List<Map<String, dynamic>> _recentAchievements = [
    {
      'title': 'First Lesson',
      'description': 'Completed your first Amharic lesson',
      'date': '2 days ago',
      'xp': 50,
      'icon': Icons.school,
      'color': _turquoise,
    },
    {
      'title': 'Week Warrior',
      'description': '7-day learning streak',
      'date': '1 week ago',
      'xp': 100,
      'icon': Icons.local_fire_department,
      'color': _red,
    },
    {
      'title': 'Vocabulary Master',
      'description': 'Learned 50 new words',
      'date': '3 days ago',
      'xp': 75,
      'icon': Icons.book,
      'color': _blue,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _navyBlue,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: _navyCard,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: _textPrimary),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        'Learning Progress',
        style: TextStyle(
          color: _textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.share, color: _textPrimary),
          onPressed: () => _shareProgress(),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOverallProgressCard(),
          const SizedBox(height: 24),
          _buildLanguageProgressSection(),
          const SizedBox(height: 24),
          _buildAchievementsSection(),
          const SizedBox(height: 24),
          _buildStatsSection(),
        ],
      ),
    );
  }

  Widget _buildOverallProgressCard() {
    final progress = _overallProgress['completedLessons'] / _overallProgress['totalLessons'];
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_turquoise.withValues(alpha: 0.1), _blue.withValues(alpha: 0.1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _turquoise.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: _turquoise.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: _turquoise.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.trending_up,
                  color: _turquoise,
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Overall Progress',
                      style: TextStyle(
                        color: _textPrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Level ${_overallProgress['level']} • ${_overallProgress['totalXP']} XP',
                      style: const TextStyle(
                        color: _textSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildProgressBar(progress),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_overallProgress['completedLessons']}/${_overallProgress['totalLessons']} lessons',
                style: const TextStyle(
                  color: _textSecondary,
                  fontSize: 14,
                ),
              ),
              Text(
                '${(progress * 100).toInt()}% complete',
                style: const TextStyle(
                  color: _turquoise,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: _textTertiary.withValues(alpha: 0.3),
            valueColor: const AlwaysStoppedAnimation<Color>(_turquoise),
            minHeight: 8,
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
            color: _textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        ..._languageProgress.map((language) => _buildLanguageCard(language)),
      ],
    );
  }

  Widget _buildLanguageCard(Map<String, dynamic> language) {
    final progress = language['lessonsCompleted'] / language['totalLessons'];
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _navyCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: language['color'].withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: language['color'].withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: language['color'].withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.language,
                  color: language['color'],
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      language['language'],
                      style: const TextStyle(
                        color: _textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Level ${language['level']} • ${language['xp']} XP',
                      style: const TextStyle(
                        color: _textSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              _buildStreakBadge(language['streak']),
            ],
          ),
          const SizedBox(height: 16),
          _buildProgressBar(progress),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${language['lessonsCompleted']}/${language['totalLessons']} lessons',
                style: const TextStyle(
                  color: _textSecondary,
                  fontSize: 14,
                ),
              ),
              Text(
                '${(progress * 100).toInt()}% complete',
                style: TextStyle(
                  color: language['color'],
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStreakBadge(int streak) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _red.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.local_fire_department, color: _red, size: 16),
          const SizedBox(width: 4),
          Text(
            '$streak',
            style: const TextStyle(
              color: _red,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Achievements',
              style: TextStyle(
                color: _textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: () => _viewAllAchievements(),
              child: const Text(
                'View All',
                style: TextStyle(color: _turquoise),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ..._recentAchievements.map((achievement) => _buildAchievementCard(achievement)),
      ],
    );
  }

  Widget _buildAchievementCard(Map<String, dynamic> achievement) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _navyCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: achievement['color'].withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: achievement['color'].withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              achievement['icon'],
              color: achievement['color'],
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  achievement['title'],
                  style: const TextStyle(
                    color: _textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  achievement['description'],
                  style: const TextStyle(
                    color: _textSecondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '+${achievement['xp']} XP',
                style: TextStyle(
                  color: achievement['color'],
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                achievement['date'],
                style: const TextStyle(
                  color: _textTertiary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _navyCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _turquoise.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: _turquoise.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Learning Statistics',
            style: TextStyle(
              color: _textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  icon: Icons.school,
                  label: 'Lessons',
                  value: '${_overallProgress['completedLessons']}',
                  color: _turquoise,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  icon: Icons.local_fire_department,
                  label: 'Streak',
                  value: '${_overallProgress['currentStreak']}',
                  color: _red,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  icon: Icons.star,
                  label: 'XP',
                  value: '${_overallProgress['totalXP']}',
                  color: _yellow,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: _textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: _textSecondary,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  void _shareProgress() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Sharing your learning progress...'),
        backgroundColor: _turquoise,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _viewAllAchievements() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Opening all achievements...'),
        backgroundColor: _blue,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
