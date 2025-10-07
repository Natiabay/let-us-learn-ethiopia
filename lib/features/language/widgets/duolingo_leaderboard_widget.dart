import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tourist_assistive_app/core/theme/app_theme.dart';

class DuolingoLeaderboardWidget extends StatelessWidget {
  const DuolingoLeaderboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final leaderboardData = _generateLeaderboardData();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.grey200, width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(
                Icons.leaderboard_rounded,
                color: AppColors.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Weekly Leaderboard',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => _showFullLeaderboard(context),
                child: const Text('View All'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Leaderboard List
          ...leaderboardData.asMap().entries.map((entry) {
            final index = entry.key;
            final user = entry.value;
            return _buildLeaderboardItem(context, index + 1, user);
          }).toList(),
        ],
      ),
    ).animate().fadeIn(duration: 1000.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildLeaderboardItem(BuildContext context, int position, LeaderboardUser user) {
    final isCurrentUser = user.isCurrentUser;
    final rankColor = _getRankColor(position);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCurrentUser 
            ? AppColors.primary.withValues(alpha: 0.1)
            : AppColors.grey50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCurrentUser 
              ? AppColors.primary.withValues(alpha: 0.3)
              : AppColors.grey200,
          width: isCurrentUser ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          // Rank
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: rankColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                '$position',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.textOnPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          
          // Avatar
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.primary,
            backgroundImage: user.avatarUrl != null 
                ? NetworkImage(user.avatarUrl!)
                : null,
            child: user.avatarUrl == null
                ? Text(
                    user.name[0].toUpperCase(),
                    style: const TextStyle(
                      color: AppColors.textOnPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 12),
          
          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isCurrentUser ? AppColors.primary : AppColors.textPrimary,
                  ),
                ),
                Text(
                  '${user.xp} XP this week',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          
          // Streak
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.local_fire_department_rounded,
                  size: 16,
                  color: AppColors.accent,
                ),
                const SizedBox(width: 4),
                Text(
                  '${user.streak}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.accent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate(delay: Duration(milliseconds: position * 100))
      .fadeIn(duration: 300.ms)
      .slideX(begin: 0.3, end: 0);
  }

  Color _getRankColor(int position) {
    switch (position) {
      case 1:
        return AppColors.secondary; // Gold
      case 2:
        return AppColors.grey400; // Silver
      case 3:
        return AppColors.warning; // Bronze
      default:
        return AppColors.primary;
    }
  }

  void _showFullLeaderboard(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.grey300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Full Leaderboard',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: 50, // Show more users
                itemBuilder: (context, index) {
                  final user = _generateLeaderboardData()[index % 5];
                  return _buildLeaderboardItem(context, index + 1, user);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<LeaderboardUser> _generateLeaderboardData() {
    return [
      LeaderboardUser(
        name: 'Alex Johnson',
        xp: 1250,
        streak: 15,
        avatarUrl: null,
        isCurrentUser: false,
      ),
      LeaderboardUser(
        name: 'Sarah Wilson',
        xp: 1180,
        streak: 12,
        avatarUrl: null,
        isCurrentUser: false,
      ),
      LeaderboardUser(
        name: 'You',
        xp: 950,
        streak: 8,
        avatarUrl: null,
        isCurrentUser: true,
      ),
      LeaderboardUser(
        name: 'Mike Chen',
        xp: 820,
        streak: 6,
        avatarUrl: null,
        isCurrentUser: false,
      ),
      LeaderboardUser(
        name: 'Emma Davis',
        xp: 750,
        streak: 5,
        avatarUrl: null,
        isCurrentUser: false,
      ),
    ];
  }
}

class LeaderboardUser {
  final String name;
  final int xp;
  final int streak;
  final String? avatarUrl;
  final bool isCurrentUser;

  LeaderboardUser({
    required this.name,
    required this.xp,
    required this.streak,
    this.avatarUrl,
    required this.isCurrentUser,
  });
}

